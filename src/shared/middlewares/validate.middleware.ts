import { Request, Response, NextFunction } from 'express';
import { ZodType } from 'zod';
import { ValidationError } from '@shared/types/validation-error.type';
import { VALIDATION_ERROR_MESSAGE } from '@shared/constants/error-messages';

export const validate =
  (schema: ZodType, source: 'body' | 'params' | 'query' = 'body') =>
  (req: Request, res: Response, next: NextFunction) => {
    const result = schema.safeParse(req[source]);

    if (!result.success) {
      const errors: ValidationError[] = result.error.issues.map((issue) => ({
        field: issue.path.join('.'),
        message: issue.message,
      }));

      return res.status(400).json({
        success: false,
        message: VALIDATION_ERROR_MESSAGE,
        errors,
      });
    }

    req[source] = result.data;

    next();
  };
