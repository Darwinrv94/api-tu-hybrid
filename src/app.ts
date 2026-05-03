import express from 'express';
import { Request, Response } from 'express';
import helmet from 'helmet';
import cors from 'cors';
import { errorHandler } from '@shared/middlewares/error.middleware';
import authRoutes from '@modules/auth/presentation/auth.routes';
import { NOT_FOUND_ERROR_MESSAGE } from '@shared/constants/error-messages';
import '@modules/auth/docs/auth.docs';
import swaggerUi from 'swagger-ui-express';
import { generateOpenAPIDocument } from '@config/openapi.config';
import { env } from '@config/env';
import { requestIdMiddleware } from '@shared/middlewares/request-id.middleware';
import { httpLogger } from '@shared/middlewares/http-logger.middleware';

const app = express();
const apiRouter = express.Router();

app.use(helmet());
app.use(cors());
app.use(express.json());

app.use(requestIdMiddleware);
app.use(httpLogger);

if (env.NODE_ENV !== 'production') {
  apiRouter.use('/docs', swaggerUi.serve, swaggerUi.setup(generateOpenAPIDocument()));
}

apiRouter.use('/auth', authRoutes);

app.use('/api/v1', apiRouter);

app.use((_: Request, res: Response) => {
  res.status(404).json({
    success: false,
    message: NOT_FOUND_ERROR_MESSAGE,
  });
});

app.use(errorHandler);

export default app;
