sealed class Result<T> {
  const Result();

  factory Result.success(T value) => Success(value);
  factory Result.error(Exception error) => Error(error);
  factory Result.loading(String message) => Loading(message);
}

final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

final class Error<T> extends Result<T> {
  const Error(this.error);
  final Exception error;
}

final class Loading<T> extends Result<T> {
  const Loading(this.message);
  final String message;
}
