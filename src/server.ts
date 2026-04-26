import 'dotenv/config';
import '@shared/bootstrap/openapi.bootstrap';
import 'reflect-metadata';
import '@shared/container';

import app from './app';

const PORT = process.env.PORT ?? 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
