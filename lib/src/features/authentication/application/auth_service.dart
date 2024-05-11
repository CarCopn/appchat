import 'package:chatapp/src/errors/failure.dart';
import 'package:chatapp/src/features/authentication/domain/entities/chats_list_resp.dart';
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

  Future<Either<Failure, List<ChatsUserResp>?>> listChats() async {
    return await repository.listChats();
  }

  Future<Either<Failure, dynamic>> getChatWithIDUser(
      {required String idOtherPerson}) async {
    return await repository.getChatWithIDUser(idOtherPerson: idOtherPerson);
  }

  //   Future<Either<Failure, dynamic>> sendMessage(
  //  {required String id,
  //     required String otherPersonId,
  //     required String message,
  //     String? archivo,
  //     String? extension}) async {
  //   return await repository.sendMessage(idOtherPerson: idOtherPerson);

  //     Future<dynamic> sendMessage(
  //     {required String id,
  //     required String otherPersonId,
  //     required String message,
  //     String? archivo,
  //     String? extension});

  // Future<dynamic> updateDataUser({
  //   required String name,
  //   required String clave,
  //   required String claveExtra,
  //   String? archivo,
  // });

  // Future<dynamic> liberarDatos({required String codigo});
  // Future<dynamic> archivarDatos({required String otherPersonId});
  // Future<dynamic> buscarUsuarios({required String usuario});
}
