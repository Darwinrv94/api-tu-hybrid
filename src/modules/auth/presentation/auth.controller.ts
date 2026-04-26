import { Response } from 'express';
import { container } from 'tsyringe';
import { LoginUseCase } from '@modules/auth/application/login.usecase';
import { BaseController } from '@shared/core/base-controller';
import { LoginDTOType } from '../application/dto/login.dto';
import { TypedRequest } from '@shared/types/typed-request.type';
import { LoginResult } from '../domain/enums/login-result.enum';

export class AuthController extends BaseController {
  async login(req: TypedRequest<LoginDTOType>, res: Response) {
    const { email, password } = req.body;

    const useCase = container.resolve(LoginUseCase);
    const result = await useCase.execute(email, password);

    if (result.isFailure) {
      if (
        result.error === LoginResult.INVALID_CREDENTIALS ||
        result.error === LoginResult.USER_INACTIVE
      ) {
        return this.unauthorized(res, result.error!);
      }

      if (result.error === LoginResult.USER_BLOCKED) {
        return this.forbidden(res, result.error!);
      }
    }

    return this.ok(res, {
      token: result.value,
    });
  }
}
