abstract class Exceptions implements Exception {}

class DatabaseException implements Exceptions {
  final String message;
  DatabaseException(this.message);
}

class ValidationException implements Exceptions {
  final String message;
  ValidationException(this.message);
}
