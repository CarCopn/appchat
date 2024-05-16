import 'package:bloc/bloc.dart';
import 'package:chatapp/src/errors/failure.dart';
import 'package:chatapp/src/features/authentication/domain/entities/chat_messages_resp.dart';
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

  Future<void> listChatsPeriodic() async {
    await Future.delayed(const Duration(seconds: 10));
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

  Future<void> listChats() async {
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

  Future<void> getChatWithIDUser({required String idOtherPerson}) async {
    emit(AuthLoadingGetMessagesState());
    final result =
        await authRepository.getChatWithIDUser(idOtherPerson: idOtherPerson);
    result.fold((error) {
      if (error is CustomFailure) {
        emit(AuthErrorState(message: error.message));
      }
    }, (result) async {
      List<ChatDetailsWithUserResp>? lista = [];
      if (result.isEmpty) {
        lista = null;
      } else {
        lista = result;
      }
      emit(AuthGetChatMessagesSuccessState(chatsToShow: lista));
    });
  }

  Future<void> getChatWithIDUserPeriodic(
      {required String idOtherPerson}) async {
    await Future.delayed(const Duration(seconds: 5));

    emit(AuthLoadingGetMessagesState());
    final result =
        await authRepository.getChatWithIDUser(idOtherPerson: idOtherPerson);
    result.fold((error) {
      if (error is CustomFailure) {
        emit(AuthErrorState(message: error.message));
      }
    }, (result) async {
      List<ChatDetailsWithUserResp>? lista = [];
      if (result.isEmpty) {
        lista = null;
      } else {
        lista = result;
      }
      emit(AuthGetChatMessagesSuccessState(chatsToShow: lista));
    });
  }

  Future<void> sendMessage(
      {required String otherPersonId,
      required String message,
      String? archivo,
      String? extensionFile}) async {
    emit(AuthLoadingGetMessagesState());
    final result = await authRepository.sendMessage(
        id: '',
        otherPersonId: otherPersonId,
        message: message,
        archivo: archivo,
        extension: extensionFile);
    result.fold((error) {
      if (error is CustomFailure) {
        emit(AuthErrorState(message: error.message));
      }
    }, (result) async {
      emit(AuthSendMessageSuccessState());
    });
  }

  Future<void> actualizarDatos({
    required String name,
    required String clave,
    required String claveExtra,
    String? archivo,
  }) async {
    emit(AuthLoadingGetMessagesState());
    final result = await authRepository.updateDataUser(
        name: name, clave: clave, claveExtra: claveExtra, archivo: archivo);
    result.fold((error) {
      if (error is CustomFailure) {
        emit(AuthErrorState(message: error.message));
      }
    }, (result) async {
      emit(AuthUpdateDataSuccessState());
    });
  }

  Future<void> liberarDatos({required String codeAccess}) async {
    emit(AuthLoadingGetMessagesState());
    final result = await authRepository.liberarDatos(codigo: codeAccess);
    result.fold((error) {
      if (error is CustomFailure) {
        emit(AuthErrorState(message: error.message));
      }
    }, (result) async {
      emit(AuthChatsGrantedAccessState());
    });
  }

  Future<void> archivarDatos({required String otherPersonId}) async {
    emit(AuthLoadingGetMessagesState());
    final result =
        await authRepository.archivarDatos(otherPersonId: otherPersonId);
    result.fold((error) {
      if (error is CustomFailure) {
        emit(AuthErrorState(message: error.message));
      }
    }, (result) async {
      emit(AuthArchiveDataSuccessState());
    });
  }

  Future<void> buscarUsuarios({required String usuario}) async {
    emit(AuthLoadingGetMessagesState());
    final result = await authRepository.buscarUsuarios(usuario: usuario);
    result.fold((error) {
      if (error is CustomFailure) {
        emit(AuthErrorState(message: error.message));
      }
    }, (result) async {
      emit(AuthGetDataUsersState(dataUser: result));
    });
  }
}
