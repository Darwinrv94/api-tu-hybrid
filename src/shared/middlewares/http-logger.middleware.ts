import pinoHttp from 'pino-http';
import { logger } from '../logger/logger';
import { Request, Response } from 'express';
import { sanitizeObject } from '@shared/utils/sanitize-request.util';

export const httpLogger = pinoHttp({
  logger,
  genReqId: (req: Request) => req.requestId,
  customProps: (req: Request, res: Response) => ({
    requestId: req.requestId,
    body:
      res.statusCode >= 400 && !req.originalUrl.includes('/auth/login')
        ? sanitizeObject(req.body)
        : undefined,
    params: sanitizeObject(req.params),
    query: sanitizeObject(req.query),
    ip: req.ip,
  }),
  customLogLevel: (_req: Request, res: Response, err?: unknown) => {
    if (err || res.statusCode >= 500) {
      return 'error';
    }

    if (res.statusCode >= 400) {
      return 'warn';
    }

    return 'info';
  },
  customSuccessMessage: (req: Request, res: Response) =>
    `${req.method} ${req.originalUrl} ${res.statusCode}`,
  customErrorMessage: (req: Request, res: Response, err?: unknown) =>
    `${req.method} ${req.originalUrl} ${res.statusCode} - ${
      err instanceof Error ? err.message : 'unknown error'
    }`,
  serializers: {
    req: (req: Request) => ({
      method: req.method,
      url: req.originalUrl,
      ip: req.ip,
      userAgent: req.headers['user-agent'],
      query: req.query,
      params: req.params,
    }),
    res: (res: Response) => ({
      statusCode: res.statusCode,
    }),
  },
  redact: {
    paths: [
      'req.headers.authorization',
      'req.headers.Authorization',
      'req.body.password',
      'req.body.oldPassword',
      'req.body.newPassword',
      'req.body.refreshToken',
      'req.body.token',
      'req.body.accessToken',
      'req.body.apiKey',
    ],
    censor: '[REDACTED]',
  },
});
