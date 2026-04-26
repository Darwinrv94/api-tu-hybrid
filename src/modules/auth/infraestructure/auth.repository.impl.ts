import { AuthRepository } from '@modules/auth/domain/auth.repository';
import prisma from '@config/prisma';
import { User } from '@modules/users/domain/user.entity';
import { UserStatus } from '@modules/users/domain/enums/user-status.enum';
import { Result } from '@shared/core/result';
import { AuthAccessState } from '../domain/enums/auth-access-state.enum';

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

  async ensureUserCanAuthenticate(user: User): Promise<Result<AuthAccessState>> {
    const maxAttempts = Number(process.env.INTENTOS_LOGIN);
    const blockMinutes = Number(process.env.TIEMPO_BLOQUEO_LOGIN);

    if (user.status !== UserStatus.ACTIVE) {
      return Result.ok(AuthAccessState.INACTIVE);
    }

    if (user.failedLoginAttempts >= maxAttempts) {
      const bloqueo = user.loginBlockDate;

      if (!bloqueo) {
        return Result.ok(AuthAccessState.BLOCKED);
      }

      const ahora = new Date();

      const minutosTranscurridos = (ahora.getTime() - bloqueo.getTime()) / 1000 / 60;

      if (minutosTranscurridos < blockMinutes) {
        return Result.ok(AuthAccessState.BLOCKED);
      }

      // bloqueo expiró → reset automático
      // await this.resetFailedAttempts(user.id);
    }

    return Result.ok(AuthAccessState.VALID);
  }
}
