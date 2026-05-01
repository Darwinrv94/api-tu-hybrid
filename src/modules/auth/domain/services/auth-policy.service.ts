import { UserStatus } from '@modules/users/domain/enums/user-status.enum';
import { User } from '@modules/users/domain/user.entity';
import { Result } from '@shared/core/result';
import { env } from '@config/env';
import { inject, injectable } from 'tsyringe';
import { AuthRepository } from '../auth.repository';

@injectable()
export class AuthPolicyService {
  constructor(
    @inject('AuthRepository')
    private readonly repository: AuthRepository,
  ) {}

  async ensureUserCanAuthenticate(user: User): Promise<Result<UserStatus>> {
    const maxAttempts = Number(env.INTENTOS_LOGIN);
    const blockMinutes = Number(env.TIEMPO_BLOQUEO_LOGIN);

    if (user.status !== UserStatus.ACTIVE) {
      return Result.ok(UserStatus.INACTIVE);
    }

    // Si alcanzó el máximo de intentos
    if (user.failedLoginAttempts >= maxAttempts) {
      if (!user.loginBlockDate) {
        return Result.ok(UserStatus.BLOCKED_LOGIN);
      }

      const now = new Date();
      const minutesElapsed = (now.getTime() - user.loginBlockDate.getTime()) / 1000 / 60;

      // Sigue bloqueado ⛔
      if (minutesElapsed < blockMinutes) {
        return Result.ok(UserStatus.BLOCKED_LOGIN);
      }

      // Bloqueo expiró ✅ resetear contador
      await this.repository.resetFailedAttempts(user.id);

      return Result.ok(UserStatus.ACTIVE);
    }

    return Result.ok(UserStatus.ACTIVE);
  }
}
