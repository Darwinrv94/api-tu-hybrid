export interface RefreshTokenRepository {
  save(data: {
    userId: number;
    tokenHash: string;
    expiresAt: Date;
    ip?: string;
    userAgent?: string;
    deviceId?: string;
  }): Promise<void>;
}
