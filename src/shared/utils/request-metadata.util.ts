import { Request } from 'express';

export const getRequestContext = <
  P = unknown,
  ResBody = unknown,
  ReqBody = unknown,
  ReqQuery = unknown,
>(
  req: Request<P, ResBody, ReqBody, ReqQuery>,
) => ({
  ip: req.ip,
  userAgent: req.headers['user-agent'],
  deviceId: req.headers['x-device-id']?.toString(),
  headers: req.headers,
});
