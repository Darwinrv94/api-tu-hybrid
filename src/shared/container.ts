import { container } from 'tsyringe';
import { AuthRepository } from '@modules/auth/domain/auth.repository';
import { AuthRepositoryImpl } from '@modules/auth/infraestructure/auth.repository.impl';

container.registerSingleton<AuthRepository>('AuthRepository', AuthRepositoryImpl);
