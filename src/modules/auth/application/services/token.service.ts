import jwt from 'jsonwebtoken';
import crypto from 'crypto';
import { env } from '@config/env';
import { injectable } from 'tsyringe';
import { AppJwtPayload } from '@modules/auth/domain/interfaces/jwt-payload.interface';
import { UserLevel } from '@modules/users/domain/enums/user-level.enum';

@injectable()
export class TokenService {
  generateAccessToken(userId: number, email: string, level: UserLevel): string {
    if (!env.JWT_ACCESS_SECRET) {
      throw new Error('JWT_ACCESS_SECRET no definido');
    }

    if (!env.JWT_ACCESS_EXPIRES) {
      throw new Error('JWT_ACCESS_EXPIRES no definido');
    }

    const payload: AppJwtPayload = {
      sub: userId,
      email,
      level,
    };

    const options: jwt.SignOptions = {
      expiresIn: env.JWT_ACCESS_EXPIRES,
    };

    return jwt.sign(payload, env.JWT_ACCESS_SECRET, options);
  }

  generateRefreshToken(): string {
    return crypto.randomBytes(64).toString('hex');
  }

  hashToken(token: string): string {
    return crypto.createHash('sha256').update(token).digest('hex');
  }
}
