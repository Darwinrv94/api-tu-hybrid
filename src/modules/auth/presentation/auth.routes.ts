import { Router } from 'express';
import { AuthController } from './auth.controller';
import { LoginDTO } from '../application/dto/login.dto';
import { validate } from '@shared/middlewares/validate.middleware';
import { container } from 'tsyringe';

const router = Router();
const controller = container.resolve(AuthController);

router.post('/login', validate(LoginDTO), controller.login);

export default router;
