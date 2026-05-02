import { RefreshTokenRepository } from '@modules/auth/domain/repositories/refresh-token.repository';
import prisma from '@config/prisma';

export class RefreshTokenRepositoryImpl implements RefreshTokenRepository {
  async save(data: { userId: number; tokenHash: string; expiresAt: Date }): Promise<void> {
    await prisma.refresh_token.create({
      data,
    });
  }
}
