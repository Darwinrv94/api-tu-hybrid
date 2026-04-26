import express from 'express';
import { Request, Response } from 'express';
import helmet from 'helmet';
import cors from 'cors';
import morgan from 'morgan';
import { errorHandler } from '@shared/middlewares/error.middleware';
import authRoutes from '@modules/auth/presentation/auth.routes';
import { NOT_FOUND_ERROR_MESSAGE } from '@shared/constants/error-messages';

const   test   =   "hola";

const app = express();

app.use(helmet());
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());

app.use('/auth', authRoutes);

app.use((_: Request, res: Response) => {
  res.status(404).json({
    success: false,
    message: NOT_FOUND_ERROR_MESSAGE,
  });
});

app.use(errorHandler);

export default app;
