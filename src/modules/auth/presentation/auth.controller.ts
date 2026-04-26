import { Response } from 'express';
import { container } from 'tsyringe';
import { LoginUseCase } from '@modules/auth/application/login.usecase';
import { BaseController } from '@shared/core/base-controller';
import { LoginDTOType } from '../application/dto/login.dto';
import { TypedRequest } from '@shared/types/typed-request.type';

export class AuthController extends BaseController {
  async login(req: TypedRequest<LoginDTOType>, res: Response) {
    const { email, password } = req.body;

    const useCase = container.resolve(LoginUseCase);
    const result = await useCase.execute(email, password);

    if (result.isFailure) {
      return this.unauthorized(res, result.error!);
    }

    return this.ok(res, {
      token: result.value,
    });
  }
}
