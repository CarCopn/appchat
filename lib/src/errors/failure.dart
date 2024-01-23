import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List props = const []]);
}

class ServerFailure extends Failure {
  @override
  List<Object> get props => throw UnimplementedError();
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => throw UnimplementedError();
}

class GeneralFailure extends Failure {
  final String message;
  const GeneralFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class CustomFailure extends Failure {
  final String message;
  final int codeStatus;
  const CustomFailure({required this.message, required this.codeStatus});

  @override
  List<Object> get props => [message, codeStatus];
}

class ErrorByTokenFailure extends Failure {
  final String message;
  const ErrorByTokenFailure(
      {this.message = 'Ocurrió un error al realizar tu transferencia.'});

  @override
  List<Object> get props => [message];
}

class ErrorByUnauthorizedFailure extends Failure {
  final String message;
  const ErrorByUnauthorizedFailure(
      {this.message = 'Ocurrió un error al realizar tu transferencia.'});

  @override
  List<Object> get props => [message];
}
