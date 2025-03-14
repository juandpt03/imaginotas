class AppException<T extends Exception> implements Exception {
  final String message;
  final bool error;
  final T exception;

  AppException(this.message, this.error, this.exception);

  factory AppException.fromException(T exception) {
    return AppException(exception.toString(), true, exception);
  }
}
