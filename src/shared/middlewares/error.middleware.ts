import { INTERNAL_SERVER_ERROR_MESSAGE } from '@shared/constants/error-messages';
import { HttpError } from '@shared/core/http-error';
import { Request, Response, NextFunction } from 'express';
import { Prisma } from '@prisma/client';

export const errorHandler = (err: Error, req: Request, res: Response, _next: NextFunction) => {
  const isHttpError = err instanceof HttpError;
  const statusCode = isHttpError ? err.statusCode : 500;

  req.log[isHttpError ? 'warn' : 'error']({
    err,
    statusCode,
    type: err.constructor.name,
    body: req.body,
    params: req.params,
    query: req.query,
  });

  if (isHttpError) {
    return res.status(statusCode).json({
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
    message: INTERNAL_SERVER_ERROR_MESSAGE,
  });
};
