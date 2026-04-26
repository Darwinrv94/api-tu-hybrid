export interface AuthRepository {
  findByEmail(email: string): Promise<{
    id: number;
    email: string;
    password: string;
  } | null>;
}
