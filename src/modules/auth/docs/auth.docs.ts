import { registry } from '@config/openapi.config';
import { LoginDTO } from '../application/dto/login.dto';

registry.registerPath({
  method: 'post',
  path: '/auth/login',
  tags: ['Auth'],
  request: {
    body: {
      content: {
        'application/json': {
          schema: LoginDTO,
        },
      },
    },
  },
  responses: {
    200: {
      description: 'Login exitoso',
    },
    401: {
      description: 'Credenciales inválidas o usuario inactivo',
    },
    403: {
      description: 'Usuario bloqueado',
    },
  },
});
