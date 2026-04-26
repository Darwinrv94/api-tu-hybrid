import 'dotenv/config';
import '@shared/bootstrap/openapi.bootstrap';
import 'reflect-metadata';
import '@shared/container';

import app from './app';
import { env } from '@config/env';

const PORT = env.PORT ?? 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
