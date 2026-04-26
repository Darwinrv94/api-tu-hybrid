import { AuthRepository } from '@modules/auth/domain/auth.repository';
import prisma from '@config/prisma';

export class AuthRepositoryImpl implements AuthRepository {
  async findByEmail(email: string) {
    const user = await prisma.usuarios.findFirst({
      where: { correo: email },
    });

    if (!user) return null;

    return {
      id: user.id_usuario,
      email: user.correo,
      password: user.password_hash ?? '',
    };
  }
}
