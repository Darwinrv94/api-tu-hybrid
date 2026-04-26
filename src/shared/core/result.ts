export class Result<T> {
  public isSuccess: boolean;
  public isFailure: boolean;
  public error?: T;
  public value?: T;

  private constructor(isSuccess: boolean, error?: T, value?: T) {
    this.isSuccess = isSuccess;
    this.isFailure = !isSuccess;
    this.error = error;
    this.value = value;
  }

  static ok<T>(value: T) {
    return new Result<T>(true, undefined, value);
  }

  static fail<T>(error: T) {
    return new Result<T>(false, error);
  }
}
