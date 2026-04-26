import { Request, Response } from 'express';
import { container } from 'tsyringe';
import { LoginUseCase } from '@modules/auth/application/login.usecase';
import { BaseController } from '@shared/core/base-controller';

export class AuthController extends BaseController {
  async login(req: Request, res: Response) {
    const { email, password } = req.body;

    const useCase = container.resolve(LoginUseCase);
    const result = await useCase.execute(email, password);

    if (result.isFailure) return this.unauthorized(res, result.error!);

    return this.ok(res, {
      token: result.value,
    });
  }
}
