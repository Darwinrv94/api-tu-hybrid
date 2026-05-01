import { Prisma } from '@prisma/client';

export const loginSelect = Prisma.validator<Prisma.usuariosSelect>()({
  id_usuario: true,
  correo: true,
  password_hash: true,
  nivel: true,
  status: true,
  intentos_login: true,
  fecha_bloqueo: true,
});

export type LoginSelect = Prisma.usuariosGetPayload<{
  select: typeof loginSelect;
}>;
