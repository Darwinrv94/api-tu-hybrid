import { UserLevel } from '@modules/users/domain/enums/user-level.enum';

export interface AppJwtPayload {
  sub: number;
  email: string;
  level: UserLevel;
}
