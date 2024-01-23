import 'package:chatapp/src/errors/failure.dart';
import 'package:chatapp/src/features/authentication/domain/repositories/auth_respository.dart';
import 'package:dartz/dartz.dart';

class AuthService {
  final AuthRepository repository;

  AuthService({required this.repository});

  Future<Either<Failure, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}
