import pinoHttp from 'pino-http';
import { logger } from '../logger/logger';

export const httpLogger = pinoHttp({
  logger,
  customProps: (req) => ({
    requestId: req.id,
  }),
  redact: [
    'req.headers.authorization',
    'req.body.password',
    'req.body.oldPassword',
    'req.body.newPassword',
    'req.body.refreshToken',
  ],
});
