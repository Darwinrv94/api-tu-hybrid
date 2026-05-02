import 'reflect-metadata';
import 'dotenv/config';
import '@shared/bootstrap/openapi.bootstrap';
import '@shared/container';

// TODO: queda pendiente modificar fecha del servidor para que tome hora local y evitar conflictos con el backend de PHP de tuhybrid

import app from './app';
import { env } from '@config/env';

const PORT = env.PORT ?? 3000;

app.set('trust proxy', true);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
