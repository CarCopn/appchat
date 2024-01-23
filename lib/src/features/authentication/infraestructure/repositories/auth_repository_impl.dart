import 'package:chatapp/src/errors/exception.dart';
import 'package:chatapp/src/errors/failure.dart';
import 'package:chatapp/src/features/authentication/domain/datasources/auth_datasource.dart';
import 'package:chatapp/src/features/authentication/domain/repositories/auth_respository.dart';
import 'package:chatapp/src/features/authentication/infraestructure/errors/errors.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      var result = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(result);
    } on CustomError catch (e) {
      return Left(CustomFailure(message: e.message, codeStatus: 1));
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    }
  }
}
