import 'package:bloc/bloc.dart';
import 'package:chatapp/src/errors/failure.dart';
import 'package:chatapp/src/features/authentication/domain/entities/chats_list_resp.dart';
import 'package:chatapp/src/features/authentication/domain/repositories/auth_respository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  void login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final result = await authRepository.login(email: email, password: password);
    result.fold((error) {
      if (error is CustomFailure) {
        emit(AuthErrorState(message: error.message));
      }
    }, (result) async {
      if (result == 'LogeoCorrecto') {
        emit(AuthLoginSuccesState());
      }
    });
  }

  void listChats() async {
    emit(AuthLoadingState());
    final result = await authRepository.listChats();
    result.fold((error) {
      if (error is CustomFailure) {
        emit(AuthErrorState(message: error.message));
      }
    }, (result) async {
      emit(AuthGetListChatSuccessState(chatsUserList: result));
    });
  }
}
