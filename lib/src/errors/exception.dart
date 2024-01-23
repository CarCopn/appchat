class ServerException implements Exception {}

class CacheException implements Exception {}

class GeneralException implements Exception {
  final String message;

  GeneralException(
      {this.message = 'Ocurrió un problema, por favor intente nuevamente'});
}

class CustomException implements Exception {
  final String message;
  final int codeStatus;

  CustomException({required this.message, required this.codeStatus});
}

class ErrorByTokenException implements Exception {
  final String message;

  ErrorByTokenException(
      {this.message = 'Ocurrió un error al realizar tu transferencia.'});
}

class ErrorByUnauthorized implements Exception {
  final String message;

  ErrorByUnauthorized(
      {this.message = 'Ocurrió un error al realizar tu transferencia.'});
}
