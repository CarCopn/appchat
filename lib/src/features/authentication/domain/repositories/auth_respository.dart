import 'package:chatapp/src/errors/failure.dart';
import 'package:chatapp/src/features/authentication/domain/entities/chats_list_resp.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, dynamic>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, List<ChatsUserResp>?>> listChats();
}
