import { container } from 'tsyringe';
import { AuthRepository } from '@modules/auth/domain/repositories/auth.repository';
import { AuthRepositoryImpl } from '@modules/auth/infraestructure/repositories/auth.repository.impl';
import { RefreshTokenRepository } from '@modules/auth/domain/repositories/refresh-token.repository';
import { RefreshTokenRepositoryImpl } from '@modules/auth/infraestructure/repositories/refresh-token.repository.impl';

container.registerSingleton<AuthRepository>('AuthRepository', AuthRepositoryImpl);
container.registerSingleton<RefreshTokenRepository>(
  'RefreshTokenRepository',
  RefreshTokenRepositoryImpl,
);
