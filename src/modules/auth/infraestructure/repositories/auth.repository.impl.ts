import { AuthRepository } from '@modules/auth/domain/repositories/auth.repository';
import prisma from '@config/prisma';
import { User } from '@modules/users/domain/user.entity';
import { env } from '@config/env';
import { loginSelect, LoginSelect } from '../prisma/login.prisma-select';

export class AuthRepositoryImpl implements AuthRepository {
  async findByEmail(email: string): Promise<User | null> {
    const user: LoginSelect | null = await prisma.usuarios.findFirst({
      where: { correo: email },
      select: loginSelect,
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

  async incrementFailedAttempts(userId: number): Promise<number> {
    const maxAttempts = Number(env.INTENTOS_LOGIN);

    const updated = await prisma.usuarios.updateMany({
      where: {
        id_usuario: userId,
        intentos_login: { lt: maxAttempts },
      },
      data: {
        intentos_login: { increment: 1 },
      },
    });

    if (!updated.count) {
      return maxAttempts;
    }

    const user = await prisma.usuarios.findUnique({
      where: { id_usuario: userId },
      select: { intentos_login: true },
    });

    if (!user) {
      return 0;
    }

    if (user.intentos_login === maxAttempts) {
      await prisma.usuarios.update({
        where: { id_usuario: userId },
        data: { fecha_bloqueo: new Date() },
      });
    }

    return user.intentos_login;
  }

  async resetFailedAttempts(userId: number): Promise<void> {
    await prisma.usuarios.update({
      where: { id_usuario: userId },
      data: {
        intentos_login: 0,
        fecha_bloqueo: null,
      },
    });
  }
}
