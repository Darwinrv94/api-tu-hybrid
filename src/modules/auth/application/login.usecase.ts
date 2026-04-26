import { inject, injectable } from 'tsyringe';
import { AuthRepository } from '@modules/auth/domain/auth.repository';
import { Result } from '@shared/core/result';
import bcrypt from 'bcrypt';
import { LoginResult } from '../domain/enums/login-result.enum';
import { UserStatus } from '@modules/users/domain/enums/user-status.enum';
//import jwt from 'jsonwebtoken';

@injectable()
export class LoginUseCase {
  constructor(
    @inject('AuthRepository')
    private repository: AuthRepository,
  ) {}

  async execute(email: string, password: string): Promise<Result<LoginResult | string>> {
    const user = await this.repository.findByEmail(email);

    if (!user) {
      return Result.fail(LoginResult.INVALID_CREDENTIALS);
    }

    const accessState = await this.repository.ensureUserCanAuthenticate(user);

    if (accessState.value === UserStatus.INACTIVE) {
      return Result.fail(LoginResult.USER_INACTIVE);
    }

    if (accessState.value === UserStatus.BLOCKED) {
      return Result.fail(LoginResult.USER_BLOCKED);
    }

    const normalizedHash = user.password.replace('$2y$', '$2b$');
    const valid = await bcrypt.compare(password, normalizedHash);

    if (!valid) {
      // TODO: incrementar intentos fallidos y bloquear si se alcanza el límite

      return Result.fail(LoginResult.INVALID_CREDENTIALS);
    }

    return Result.ok(user.email);
  }
}
