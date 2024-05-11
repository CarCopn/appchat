import 'package:chatapp/src/errors/failure.dart';
import 'package:chatapp/src/features/authentication/domain/entities/chats_list_resp.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, dynamic>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, List<ChatsUserResp>?>> listChats();

  Future<Either<Failure, dynamic>> getChatWithIDUser(
      {required String idOtherPerson});

  Future<Either<Failure, dynamic>> sendMessage(
      {required String id,
      required String otherPersonId,
      required String message,
      String? archivo,
      String? extension});

  Future<Either<Failure, dynamic>> updateDataUser({
    required String name,
    required String clave,
    required String claveExtra,
    String? archivo,
  });

  Future<Either<Failure, dynamic>> liberarDatos({required String codigo});
  Future<Either<Failure, dynamic>> archivarDatos(
      {required String otherPersonId});
  Future<Either<Failure, dynamic>> buscarUsuarios({required String usuario});
}
