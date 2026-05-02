class ExceptionHandler implements Exception {
  final String message;

  ExceptionHandler(this.message);

  @override
  String toString() => message;

  static ExceptionHandler handle(dynamic error) {
    return ExceptionHandler("Something went wrong. Please try again.");
  }
}