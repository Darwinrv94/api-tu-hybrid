import { Response } from 'express';
import { inject, injectable } from 'tsyringe';
import { LoginUseCase } from '@modules/auth/application/login.usecase';
import { BaseController } from '@shared/core/base-controller';
import { LoginDTOType } from '../application/dto/login.dto';
import { TypedRequest } from '@shared/types/typed-request.type';
import { LoginResult } from '../domain/enums/login-result.enum';
import { getRequestContext } from '@shared/utils/request-metadata.util';

@injectable()
export class AuthController extends BaseController {
  private static readonly unauthorizedErrors = new Set<LoginResult>([
    LoginResult.INVALID_CREDENTIALS,
    LoginResult.USER_INACTIVE,
    LoginResult.BLOCKED_LOGIN,
  ]);

  constructor(
    @inject(LoginUseCase)
    private readonly loginUseCase: LoginUseCase,
  ) {
    super();
  }

  login = async (req: TypedRequest<LoginDTOType>, res: Response): Promise<Response> => {
    const { email, password } = req.body;
    const { ip, userAgent, deviceId } = getRequestContext(req);

    const result = await this.loginUseCase.execute(email, password, { ip, userAgent, deviceId });

    if (result.isFailure) {
      if (AuthController.unauthorizedErrors.has(result.error!)) {
        return this.unauthorized(res, result.error);
      }

      if (result.error === LoginResult.USER_BLOCKED) {
        return this.forbidden(res, result.error!);
      }
    }

    return this.ok(res, result.value);
  };
}
