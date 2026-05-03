import { Response } from 'express';
import { ValidationError } from '@shared/types/validation-error.type';
import {
  FORBIDDEN_ERROR_MESSAGE,
  INTERNAL_SERVER_ERROR_MESSAGE,
  NOT_FOUND_ERROR_MESSAGE,
  UNAUTHORIZED_ERROR_MESSAGE,
} from '@shared/constants/error-messages';

export abstract class BaseController {
  protected ok<T>(res: Response, message: string, data: T) {
    return res.status(200).json({
      success: true,
      message,
      data,
    });
  }

  protected created<T>(res: Response, message: string, data: T) {
    return res.status(201).json({
      success: true,
      message,
      data,
    });
  }

  protected noContent(res: Response) {
    return res.status(204).send();
  }

  protected fail(res: Response, message: string, status = 400, errors?: ValidationError[]) {
    return res.status(status).json({
      success: false,
      message,
      ...(errors && { errors }),
    });
  }

  protected unauthorized(res: Response, message = UNAUTHORIZED_ERROR_MESSAGE) {
    return res.status(401).json({
      success: false,
      message,
    });
  }

  protected forbidden(res: Response, message = FORBIDDEN_ERROR_MESSAGE) {
    return res.status(403).json({
      success: false,
      message,
    });
  }

  protected notFound(res: Response, message = NOT_FOUND_ERROR_MESSAGE) {
    return res.status(404).json({
      success: false,
      message,
    });
  }

  protected serverError(res: Response, message = INTERNAL_SERVER_ERROR_MESSAGE) {
    return res.status(500).json({
      success: false,
      message,
    });
  }
}
