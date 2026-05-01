import { User } from '@modules/users/domain/user.entity';

export interface AuthRepository {
  findByEmail(email: string): Promise<User | null>;
  incrementFailedAttempts(userId: number): Promise<number>;
  resetFailedAttempts(userId: number): Promise<void>;
}
