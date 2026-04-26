import { User } from '@modules/users/domain/user.entity';
import { Result } from '@shared/core/result';
import { UserStatus } from '@modules/users/domain/enums/user-status.enum';

export interface AuthRepository {
  findByEmail(email: string): Promise<User | null>;
  ensureUserCanAuthenticate(user: User): Promise<Result<UserStatus>>;
}
