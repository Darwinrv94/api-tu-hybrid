import { Request } from 'express';

export type TypedRequest<T> = Request<unknown, unknown, T>;
