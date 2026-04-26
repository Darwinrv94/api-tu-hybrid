import { INTERNAL_SERVER_ERROR_MESSAGE } from '@shared/constants/error-messages';
import { HttpError } from '@shared/core/http-error';
import { Request, Response, NextFunction } from 'express';

export const errorHandler = (err: Error, _: Request, res: Response, __: NextFunction) => {
  if (err instanceof HttpError) {
    return res.status(err.statusCode).json({
      success: false,
      message: err.message,
    });
  }

  res.status(500).json({
    success: false,
    message: err.message || INTERNAL_SERVER_ERROR_MESSAGE,
  });
};
