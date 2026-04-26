import { User } from '@modules/users/domain/user.entity';
import { Result } from '@shared/core/result';
import { AuthAccessState } from './enums/auth-access-state.enum';

export interface AuthRepository {
  findByEmail(email: string): Promise<User | null>;
  ensureUserCanAuthenticate(user: User): Promise<Result<AuthAccessState>>;
}
