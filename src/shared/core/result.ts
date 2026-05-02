/*export class Result<T> {
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
}*/

export class Result<T, E = string> {
  public readonly isSuccess: boolean;
  public readonly isFailure: boolean;
  public readonly value?: T;
  public readonly error?: E;

  private constructor(isSuccess: boolean, value?: T, error?: E) {
    this.isSuccess = isSuccess;
    this.isFailure = !isSuccess;
    this.value = value;
    this.error = error;
  }

  static ok<T, E = never>(value: T): Result<T, E> {
    return new Result<T, E>(true, value);
  }

  static fail<T = never, E = string>(error: E): Result<T, E> {
    return new Result<T, E>(false, undefined, error);
  }
}
