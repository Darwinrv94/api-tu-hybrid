import { inject, injectable } from 'tsyringe';
import { AuthRepository } from '@modules/auth/domain/auth.repository';
import { Result } from '@shared/core/result';
import bcrypt from 'bcrypt';
import { LoginResult } from '../domain/enums/login-result.enum';
import { UserStatus } from '@modules/users/domain/enums/user-status.enum';
import { AuthPolicyService } from '../domain/services/auth-policy.service';
import { env } from '@config/env';
//import jwt from 'jsonwebtoken';

@injectable()
export class LoginUseCase {
  constructor(
    @inject('AuthRepository')
    private repository: AuthRepository,
    @inject(AuthPolicyService)
    private readonly authPolicy: AuthPolicyService,
  ) {}

  async execute(email: string, password: string): Promise<Result<LoginResult | string>> {
    const user = await this.repository.findByEmail(email);

    if (!user) {
      return Result.fail(LoginResult.INVALID_CREDENTIALS);
    }

    const accessState = await this.authPolicy.ensureUserCanAuthenticate(user);

    if (accessState.value === UserStatus.BLOCKED_LOGIN) {
      return Result.fail(LoginResult.BLOCKED_LOGIN);
    }

    if (accessState.value === UserStatus.INACTIVE) {
      return Result.fail(LoginResult.USER_INACTIVE);
    }

    if (accessState.value === UserStatus.BLOCKED) {
      return Result.fail(LoginResult.USER_BLOCKED);
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

    // TODO: generar jwt, crear estructura de dato para también guardar y generar el refresh token

    return Result.ok(user.email);
  }
}
