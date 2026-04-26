import { AuthRepository } from '@modules/auth/domain/auth.repository';
import prisma from '@config/prisma';
import { User } from '@modules/users/domain/user.entity';
import { UserStatus } from '@modules/users/domain/enums/user-status.enum';
import { Result } from '@shared/core/result';
import { env } from '@config/env';

export class AuthRepositoryImpl implements AuthRepository {
  async findByEmail(email: string): Promise<User | null> {
    const user = await prisma.usuarios.findFirst({
      where: { correo: email },
    });

    if (!user) {
      return null;
    }

    return {
      id: user.id_usuario,
      email: user.correo,
      password: user.password_hash ?? '',
      level: user.nivel,
      status: user.status,
      failedLoginAttempts: user.intentos_login,
      loginBlockDate: user.fecha_bloqueo,
    };
  }

  async ensureUserCanAuthenticate(user: User): Promise<Result<UserStatus>> {
    const maxAttempts = Number(env.INTENTOS_LOGIN);
    const blockMinutes = Number(env.TIEMPO_BLOQUEO_LOGIN);

    if (user.status !== UserStatus.ACTIVE) {
      return Result.ok(UserStatus.INACTIVE);
    }

    if (user.failedLoginAttempts >= maxAttempts) {
      const bloqueo = user.loginBlockDate;

      if (!bloqueo) {
        return Result.ok(UserStatus.BLOCKED);
      }

      const ahora = new Date();

      const minutosTranscurridos = (ahora.getTime() - bloqueo.getTime()) / 1000 / 60;

      if (minutosTranscurridos < blockMinutes) {
        return Result.ok(UserStatus.BLOCKED);
      }

      // bloqueo expiró → reset automático
      // await this.resetFailedAttempts(user.id);
    }

    return Result.ok(UserStatus.ACTIVE);
  }
}
