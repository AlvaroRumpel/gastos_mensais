import 'dart:developer';

class ExpenseException implements Exception {
  final String message;

  ExpenseException({
    this.message = 'Error',
    Object? error,
    StackTrace? stackTrace,
  }) {
    log('Erro no sqlite', error: error, stackTrace: stackTrace);
  }
}
