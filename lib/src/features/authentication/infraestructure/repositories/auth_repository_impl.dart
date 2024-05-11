import 'package:chatapp/src/errors/exception.dart';
import 'package:chatapp/src/errors/failure.dart';
import 'package:chatapp/src/features/authentication/domain/datasources/auth_datasource.dart';
import 'package:chatapp/src/features/authentication/domain/entities/chats_list_resp.dart';
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

  @override
  Future<Either<Failure, List<ChatsUserResp>?>> listChats() async {
    try {
      var result = await remoteDataSource.listChats();
      return Right(result);
    } on CustomError catch (e) {
      return Left(CustomFailure(message: e.message, codeStatus: 1));
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getChatWithIDUser(
      {required String idOtherPerson}) async {
    try {
      var result = await remoteDataSource.getChatWithIDUser(
          idOtherPerson: idOtherPerson);
      return Right(result);
    } on CustomError catch (e) {
      return Left(CustomFailure(message: e.message, codeStatus: 1));
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> sendMessage(
      {required String id,
      required String otherPersonId,
      required String message,
      String? archivo,
      String? extension}) async {
    try {
      var result = await remoteDataSource.sendMessage(
          id: id,
          otherPersonId: otherPersonId,
          message: message,
          archivo: archivo,
          extension: extension);
      return Right(result);
    } on CustomError catch (e) {
      return Left(CustomFailure(message: e.message, codeStatus: 1));
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateDataUser({
    required String name,
    required String clave,
    required String claveExtra,
    String? archivo,
  }) async {
    try {
      var result = await remoteDataSource.updateDataUser(
        name: name,
        clave: clave,
        claveExtra: claveExtra,
        archivo: archivo,
      );
      return Right(result);
    } on CustomError catch (e) {
      return Left(CustomFailure(message: e.message, codeStatus: 1));
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> liberarDatos(
      {required String codigo}) async {
    try {
      var result = await remoteDataSource.liberarDatos(
        codigo: codigo,
      );
      return Right(result);
    } on CustomError catch (e) {
      return Left(CustomFailure(message: e.message, codeStatus: 1));
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> archivarDatos(
      {required String otherPersonId}) async {
    try {
      var result = await remoteDataSource.archivarDatos(
        otherPersonId: otherPersonId,
      );
      return Right(result);
    } on CustomError catch (e) {
      return Left(CustomFailure(message: e.message, codeStatus: 1));
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> buscarUsuarios(
      {required String usuario}) async {
    try {
      var result = await remoteDataSource.buscarUsuarios(
        usuario: usuario,
      );
      return Right(result);
    } on CustomError catch (e) {
      return Left(CustomFailure(message: e.message, codeStatus: 1));
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    }
  }
}
