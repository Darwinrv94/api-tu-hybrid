import { inject, injectable } from 'tsyringe';
import { AuthRepository } from '@modules/auth/domain/repositories/auth.repository';
import { Result } from '@shared/core/result';
import bcrypt from 'bcrypt';
import { LoginResult } from '../domain/enums/login-result.enum';
import { UserStatus } from '@modules/users/domain/enums/user-status.enum';
import { AuthPolicyService } from '../domain/services/auth-policy.service';
import { env } from '@config/env';
import { TokenService } from './services/token.service';
import { LoginResponseDto } from './dto/login-response.dto';
import { RefreshTokenRepository } from '../domain/repositories/refresh-token.repository';

@injectable()
export class LoginUseCase {
  constructor(
    @inject('AuthRepository')
    private readonly repository: AuthRepository,
    @inject(AuthPolicyService)
    private readonly authPolicy: AuthPolicyService,
    @inject(TokenService)
    private readonly tokenService: TokenService,
    @inject('RefreshTokenRepository')
    private readonly refreshTokenRepository: RefreshTokenRepository,
  ) {}

  async execute(
    email: string,
    password: string,
    metadata?: {
      ip?: string;
      userAgent?: string;
      deviceId?: string;
    },
  ): Promise<Result<LoginResponseDto, LoginResult>> {
    const user = await this.repository.findByEmail(email);

    if (!user) {
      return Result.fail(LoginResult.INVALID_CREDENTIALS);
    }

    const accessState = await this.authPolicy.ensureUserCanAuthenticate(user);

    if (accessState.value !== UserStatus.ACTIVE) {
      return Result.fail(
        accessState.value === UserStatus.BLOCKED_LOGIN
          ? LoginResult.BLOCKED_LOGIN
          : accessState.value === UserStatus.BLOCKED
            ? LoginResult.USER_BLOCKED
            : LoginResult.USER_INACTIVE,
      );
    }

    const normalizedHash = user.password.replace('$2y$', '$2b$');
    const passwordMatch = await bcrypt.compare(password, normalizedHash);

    if (!passwordMatch) {
      const failedAttempts = await this.repository.incrementFailedAttempts(user.id);

      if (failedAttempts >= Number(env.INTENTOS_LOGIN)) {
        return Result.fail(LoginResult.BLOCKED_LOGIN);
      }

      return Result.fail(LoginResult.INVALID_CREDENTIALS);
    }

    await this.repository.resetFailedAttempts(user.id);

    const token = await this.tokenService.generateAccessToken(user.id, user.email, user.level);
    const refreshToken = this.tokenService.generateRefreshToken();
    const refreshTokenHash = this.tokenService.hashToken(refreshToken);
    const expiresAt = new Date(Date.now() + Number(env.JWT_REFRESH_EXPIRES_HOURS) * 60 * 60 * 1000);

    await this.refreshTokenRepository.save({
      userId: user.id,
      tokenHash: refreshTokenHash,
      expiresAt,
      ip: metadata?.ip,
      userAgent: metadata?.userAgent,
      deviceId: metadata?.deviceId,
    });

    return Result.ok({ token, refreshToken });
  }
}
