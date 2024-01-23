// ignore_for_file: must_be_immutable

part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoginSuccesState extends AuthState {}

class AuthGetListChatSuccessState extends AuthState {
  List<ChatsUserResp>? chatsUserList;
  AuthGetListChatSuccessState({this.chatsUserList});
}

class AuthErrorState extends AuthState {
  String? message;
  AuthErrorState({this.message});
}
