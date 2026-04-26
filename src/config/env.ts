export const env = {
  PORT: Number(process.env.PORT ?? 3000),
  NODE_ENV: process.env.NODE_ENV ?? 'development',
  DATABASE_URL: process.env.DATABASE_URL ?? 'mysql://root:@localhost:3306/hybrid',
  INTENTOS_LOGIN: Number(process.env.INTENTOS_LOGIN ?? 3),
  TIEMPO_BLOQUEO_LOGIN: Number(process.env.TIEMPO_BLOQUEO_LOGIN ?? 5),
};
