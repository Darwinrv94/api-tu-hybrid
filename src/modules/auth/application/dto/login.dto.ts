import { z } from 'zod';

export const LoginDTO = z.object({
  /*email: z.email({
    message: 'Formato de email inválido',
  }).trim(),*/

  email: z
    .string({
      message: 'Formato de email inválido',
    })
    .trim(),

  password: z
    .string()
    .min(3, 'Password mínimo 3 caracteres')
    .max(50, { message: 'Password demasiado largo' })
    .trim(),
});

export type LoginDTOType = z.infer<typeof LoginDTO>;
