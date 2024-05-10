import 'dart:convert';

import 'package:chatapp/src/config/enviroment.dart';
import 'package:chatapp/src/features/authentication/domain/datasources/auth_datasource.dart';
import 'package:chatapp/src/features/authentication/domain/entities/chat_messages_resp.dart';
import 'package:chatapp/src/features/authentication/domain/entities/chats_list_resp.dart';
import 'package:chatapp/src/features/authentication/infraestructure/errors/errors.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final http.Client httpClient = http.Client();

  @override
  Future<dynamic> login(
      {required String email, required String password}) async {
    var prefs = await SharedPreferences.getInstance();

    try {
      final response = await httpClient
          .post(Uri.parse('${Enviroment.apiUrl}/logear.php'), body: {
        'email_user': email,
        'password': password,
      });

      var responseInfo = jsonDecode(response.body);

      if (responseInfo['status'] == 'Error') {
        throw CustomError(responseInfo['mensaje']);
      } else if (responseInfo['status'] == 'Ok') {
        {
          await prefs.setString('token', responseInfo['token']);
          await prefs.setString('usuario', responseInfo['usuario']);
          return 'LogeoCorrecto';
        }
      } else {
        // return UserNew();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisa tu conexiòn a internet.');
      }
      throw WrongCredentials();
    } catch (e) {
      if (e is CustomError) {
        throw CustomError(e.message);
      }
      throw CustomError('Algo salió mal.');

      // throw Exception();
    }
  }

  @override
  Future<List<ChatsUserResp>?> listChats() async {
    var prefs = await SharedPreferences.getInstance();

    try {
      String token = prefs.getString('token') ?? '';
      final response = await httpClient
          .post(Uri.parse('${Enviroment.apiUrl}/listaMensajes.php'), body: {
        'token': token,
      });

      var responseInfo = jsonDecode(response.body);

      if (responseInfo['status'] == 'Error') {
        throw CustomError(responseInfo['mensaje']);
      } else if (responseInfo['status'] == 'Ok') {
        {
          var resp = chatsUserRespFromJson(jsonEncode(responseInfo['data']));
          return resp;
        }
      } else {
        // return UserNew();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisa tu conexiòn a internet.');
      }
      throw WrongCredentials();
    } catch (e) {
      if (e is CustomError) {
        throw CustomError(e.message);
      }
      throw CustomError('Algo salió mal.');

      // throw Exception();
    }
    return null;
  }

  @override
  Future<dynamic> getChatWithIDUser({required String idOtherPerson}) async {
    var prefs = await SharedPreferences.getInstance();

    try {
      String token = prefs.getString('token') ?? '';
      String usuarioId = prefs.getString('usuario') ?? '';
      final response = await httpClient.post(
          Uri.parse('${Enviroment.apiUrl}/listarConversacion.php'),
          body: {
            'token': token,
            'id': usuarioId,
            'other_person_id': idOtherPerson,
          });

      var responseInfo = jsonDecode(response.body);

      if (responseInfo['status'] == 'Error') {
        throw CustomError(responseInfo['mensaje']);
      } else if (responseInfo['status'] == 'Ok') {
        {
          var resp =
              chatDetailsWithUserRespFromJson(jsonEncode(responseInfo['data']));

          return resp;
        }
      } else {
        // return UserNew();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisa tu conexiòn a internet.');
      }
      throw WrongCredentials();
    } catch (e) {
      if (e is CustomError) {
        throw CustomError(e.message);
      }
      throw CustomError('Algo salió mal.');

      // throw Exception();
    }
    return null;
  }
}
