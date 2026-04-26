import { inject, injectable } from 'tsyringe';
import { AuthRepository } from '@modules/auth/domain/auth.repository';
import { Result } from '@shared/core/result';
import bcrypt from 'bcrypt';
import { AuthAccessState } from '../domain/enums/auth-access-state.enum';
//import jwt from 'jsonwebtoken';

@injectable()
export class LoginUseCase {
  constructor(
    @inject('AuthRepository')
    private repository: AuthRepository,
  ) {}

  async execute(email: string, password: string): Promise<Result<string>> {
    const user = await this.repository.findByEmail(email);

    if (!user) {
      return Result.fail('Credenciales inválidas');
    }

    const accessState = await this.repository.ensureUserCanAuthenticate(user);

    if (accessState.value !== AuthAccessState.VALID) {
      if (accessState.value === AuthAccessState.BLOCKED) {
        return Result.fail(
          'Usuario bloqueado por múltiples intentos fallidos. Intente nuevamente más tarde.',
        );
      }

      if (accessState.value === AuthAccessState.INACTIVE) {
        return Result.fail('Credenciales inválidas');
      }

      return Result.fail('Credenciales inválidas');
    }

    const normalizedHash = user.password.replace('$2y$', '$2b$');
    const valid = await bcrypt.compare(password, normalizedHash);

    if (!valid) {
      // TODO: incrementar contador de intentos fallidos y bloquear si excede el límite

      return Result.fail('Credenciales inválidas');
    }

    // TODO: resetear contador de intentos fallidos

    //const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET!, { expiresIn: '8h' });

    return Result.ok(user.email);
  }
}
