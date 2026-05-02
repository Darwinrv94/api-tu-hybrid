import { z } from 'zod';
import type { StringValue } from 'ms';

const envSchema = z.object({
  PORT: z.coerce.number().default(3000),
  NODE_ENV: z.enum(['development', 'production', 'test']).default('development'),

  DATABASE_URL: z.string().default('mysql://root:@localhost:3306/hybrid'),

  INTENTOS_LOGIN: z.coerce.number().default(3),
  TIEMPO_BLOQUEO_LOGIN: z.coerce.number().default(5),

  JWT_ACCESS_SECRET: z.string().min(1),
  JWT_ACCESS_EXPIRES: z
    .string()
    .default('15m')
    .transform((val) => val as StringValue),
  JWT_REFRESH_EXPIRES_HOURS: z.coerce.number().default(5),
});

export const env = envSchema.parse(process.env);
