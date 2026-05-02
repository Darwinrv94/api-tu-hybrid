# API Hybrid

API REST construida con **Node.js + Express + TypeScript + Prisma + Clean Architecture**.

El proyecto está diseñado para ser escalable, mantenible y listo para entornos productivos.

---

# 🚀 Tecnologías

* Node.js
* Express
* TypeScript
* Prisma ORM
* MySQL
* Zod (validación de DTOs)
* tsyringe (inyección de dependencias)
* Clean Architecture

---

# 📂 Estructura del proyecto

```
src
 ├─ config
 ├─ modules
 │   └─ auth
 │       ├─ domain
 │       ├─ application
 │       ├─ infrastructure
 │       └─ presentation
 │
 ├─ shared
 │   ├─ core
 │   └─ middlewares
 │
 ├─ app.ts
 └─ server.ts
```

### Capas

| Capa           | Responsabilidad          |
| -------------- | ------------------------ |
| domain         | entidades y contratos    |
| application    | casos de uso y DTOs      |
| infrastructure | acceso a base de datos   |
| presentation   | controllers y routes     |
| shared         | utilidades reutilizables |

---

# ⚙️ Instalación

Clonar repositorio:

```
git clone <repo-url>
```

Instalar dependencias:

```
npm install
```

Configurar variables de entorno:

```
cp .env.example .env
```

Ejemplo:

```
DATABASE_URL="mysql://user:password@localhost:3306/database"
JWT_SECRET="secret_key"
```

---

# ▶️ Ejecutar proyecto

Modo desarrollo:

```
npm run dev
```

Modo producción:

```
npm run build
npm start
```

---

# 🧪 Debug

Ejecutar desde VSCode:

```
F5
```

Configurado para TypeScript con soporte de aliases.

---

# 🧱 Arquitectura

Se implementa Clean Architecture:

```
Request
 ↓
Middleware (validation)
 ↓
Controller
 ↓
UseCase
 ↓
Repository
 ↓
Database
```

Beneficios:

* desacople entre capas
* testabilidad
* escalabilidad
* mantenimiento sencillo

---

# 📦 Validación de datos

Se usa **Zod** para validar DTOs.

Ejemplo:

```
const LoginDTO = z.object({
  email: z.email(),
  password: z.string().min(6)
});
```

Middleware:

```
validate(LoginDTO)
```

---

# 📚 Respuestas estándar

Formato success:

```
{
  "success": true,
  "data": {}
}
```

Formato error:

```
{
  "success": false,
  "message": "Validation failed",
  "errors": []
}
```

---

# 🔐 Autenticación

Implementada con:

* JWT
* Result pattern
* BaseController
* DTO validation

Ejemplo endpoint:

```
POST /auth/login
```

Body:

```
{
  "email": "user@email.com",
  "password": "123456"
}
```

---

# 🗄️ Uso de Prisma

Generar cliente:

```
npx prisma generate
```

Sincronizar schema con DB:

```
npx prisma db pull
```

Crear migración:

```
npx prisma migrate dev
```

Aplicar migraciones en producción:

```
npx prisma migrate deploy
```

Abrir Prisma Studio:

```
npx prisma studio
```

# Marcar migración como aplicada

```
npx prisma migrate resolve --applied <name_migration>
```

# Generar migración desde una base de datos existente (Prisma)

## 1. Crear carpeta de migraciones

Si no existe, crear la carpeta:

```
mkdir prisma/migrations
```

## 2. Generar el archivo de migración

Ejecutar:

```
npx prisma migrate diff --from-schema-datasource prisma/schema.prisma --to-schema-datamodel prisma/schema.prisma --script > prisma/migrations/add_refresh_token/migration.sql
```

Este comando **solo genera el script SQL** y no modifica la base de datos.

## 3. Registrar la migración como aplicada (sin afectar datos)

Si la base de datos ya contiene los cambios:

```
npx prisma migrate resolve --applied <name_migration>
```

Esto evita que Prisma intente ejecutar nuevamente la migración.

## 4. Aplicar migraciones pendientes (solo si corresponde)

```
npx prisma migrate deploy
```

Usar este paso únicamente cuando existan migraciones nuevas que sí deban ejecutarse en la base de datos.

```
npx prisma generate
```

---

# 📄 Ejemplo datasource

```
datasource db {
  provider = "mysql"
  url      = env("DATABASE_URL")
}
```

---

# 🧪 Scripts disponibles

```
npm run dev
npm run build
npm start
npm run prisma:generate
npm run prisma:migrate
```

---

# 📐 Convenciones del proyecto

| Tipo              | Ubicación          |
| ----------------- | ------------------ |
| DTO               | application/dto    |
| Entity            | domain             |
| Repository        | domain             |
| RepositoryImpl    | infrastructure     |
| Controller        | presentation       |
| Middleware global | shared/middlewares |

---

# 🛠️ Buenas prácticas implementadas

* Clean Architecture
* Dependency Injection
* Result Pattern
* DTO validation
* Response estándar
* Error handler global
* Path aliases

---

# 📬 Contacto

Proyecto mantenido por el equipo backend.
