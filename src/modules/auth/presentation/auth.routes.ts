import { Router } from 'express';
import { AuthController } from './auth.controller';
import { LoginDTO } from '../application/dto/login.dto';
import { validate } from '@shared/middlewares/validate.middleware';

const router = Router();
const controller = new AuthController();

router.post('/login', validate(LoginDTO), controller.login.bind(controller));

export default router;
