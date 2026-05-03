import pino from 'pino';
import { env } from '@config/env';

export const logger = pino({
  level: env.NODE_ENV === 'production' ? 'info' : 'debug',
  transport:
    env.NODE_ENV !== 'production'
      ? {
          target: 'pino-pretty',
          options: {
            colorize: true,
            translateTime: 'HH:MM:ss',
            singleLine: false,
            ignore: 'pid,hostname,req,res',
          },
        }
      : undefined,
});
