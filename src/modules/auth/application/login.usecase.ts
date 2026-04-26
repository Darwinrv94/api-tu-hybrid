import { inject, injectable } from 'tsyringe';
import { AuthRepository } from '@modules/auth/domain/auth.repository';
import { Result } from '@shared/core/result';
import bcrypt from 'bcrypt';
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
      return Result.fail('Usuario no existe');
    }

    const normalizedHash = user.password.replace('$2y$', '$2b$');
    const valid = await bcrypt.compare(password, normalizedHash);

    if (!valid) {
      return Result.fail('Credenciales inválidas');
    }

    //const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET!, { expiresIn: '8h' });

    return Result.ok(user.email);
  }
}
