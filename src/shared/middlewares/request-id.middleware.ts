import { randomUUID } from 'crypto';
import { Request, Response, NextFunction } from 'express';

export const requestIdMiddleware = (req: Request, _: Response, next: NextFunction) => {
  req.requestId = randomUUID();
  next();
};
