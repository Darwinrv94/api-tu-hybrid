const SENSITIVE_KEYS = [
  'password',
  'refreshToken',
  'accessToken',
  'apiKey',
  'authorization',
  'Authorization',
] as const;

type Sanitizable = Record<string, unknown>;

export function sanitizeObject<T extends Sanitizable>(
  obj: T | null | undefined,
): T | null | undefined {
  if (!obj) {
    return obj;
  }

  const clone: T = { ...obj };

  Object.keys(clone).forEach((key) => {
    if ((SENSITIVE_KEYS as readonly string[]).includes(key)) {
      (clone as Record<string, unknown>)[key] = '[REDACTED]';
    }
  });

  return clone;
}
