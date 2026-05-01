import { INTERNAL_SERVER_ERROR_MESSAGE } from '@shared/constants/error-messages';
import { HttpError } from '@shared/core/http-error';
import { Request, Response, NextFunction } from 'express';
import { Prisma } from '@prisma/client';

export const errorHandler = (err: Error, _req: Request, res: Response, _next: NextFunction) => {
  if (err instanceof HttpError) {
    return res.status(err.statusCode).json({
      success: false,
      message: err.message,
    });
  }

  if (
    err instanceof Prisma.PrismaClientInitializationError ||
    err instanceof Prisma.PrismaClientKnownRequestError ||
    err instanceof Prisma.PrismaClientUnknownRequestError ||
    err instanceof Prisma.PrismaClientValidationError
  ) {
    return res.status(500).json({
      success: false,
      message: INTERNAL_SERVER_ERROR_MESSAGE,
    });
  }

  res.status(500).json({
    success: false,
    message: err.message || INTERNAL_SERVER_ERROR_MESSAGE,
  });
};
