export interface User {
  id: number;
  email: string;
  password: string;
  level: number;
  status: number;
  failedLoginAttempts: number;
  loginBlockDate: Date | null;
}
