import 'dart:convert';
import 'dart:developer';

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
          if (responseInfo['data'] == null) {
            return [];
          }
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
      log('error $e');
      if (e is CustomError) {
        throw CustomError(e.message);
      }
      throw CustomError('Algo salió mal.');

      // throw Exception();
    }
    return null;
  }

  @override
  Future<dynamic> sendMessage(
      {required String id,
      required String otherPersonId,
      required String message,
      String? archivo,
      String? extension}) async {
    var prefs = await SharedPreferences.getInstance();

    try {
      String token = prefs.getString('token') ?? '';
      String usuarioId = prefs.getString('usuario') ?? '';
      final response = await httpClient
          .post(Uri.parse('${Enviroment.apiUrl}/registroMensaje.php'), body: {
        'token': token,
        'id': usuarioId,
        'other_person_id': otherPersonId,
        'mensaje': message,
        'archivo': archivo ?? '',
        'extension_archivo': extension ?? '',
      });

      var responseInfo = jsonDecode(response.body);

      if (responseInfo['status'] == 'Error') {
        throw CustomError(responseInfo['mensaje']);
      } else if (responseInfo['status'] == 'Ok') {
        {
          return true;
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
      log('error $e');
      throw CustomError('Algo salió mal.');

      // throw Exception();
    }
    return null;
  }

  @override
  Future<dynamic> updateDataUser({
    required String name,
    required String clave,
    required String claveExtra,
    String? archivo,
  }) async {
    var prefs = await SharedPreferences.getInstance();

    try {
      String token = prefs.getString('token') ?? '';
      final response = await httpClient
          .post(Uri.parse('${Enviroment.apiUrl}/actualizarDatos.php'), body: {
        'token': token,
        'nombre': name,
        'clave': clave,
        'claveExtra': claveExtra,
        'archivo': archivo ?? '',
      });

      var responseInfo = jsonDecode(response.body);

      if (responseInfo['status'] == 'Error') {
        throw CustomError(responseInfo['mensaje']);
      } else if (responseInfo['status'] == 'Ok') {
        {
          return true;
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
  Future<dynamic> liberarDatos({required String codigo}) async {
    var prefs = await SharedPreferences.getInstance();

    try {
      String token = prefs.getString('token') ?? '';
      final response = await httpClient
          .post(Uri.parse('${Enviroment.apiUrl}/liberarDatos.php'), body: {
        'token': token,
        'codigo': codigo,
      });

      var responseInfo = jsonDecode(response.body);

      if (responseInfo['status'] == 'Error') {
        throw CustomError(responseInfo['mensaje']);
      } else if (responseInfo['status'] == 'Ok') {
        {
          return true;
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
  Future<dynamic> archivarDatos({required String otherPersonId}) async {
    var prefs = await SharedPreferences.getInstance();

    try {
      String token = prefs.getString('token') ?? '';
      final response = await httpClient
          .post(Uri.parse('${Enviroment.apiUrl}/archivarDatos.php'), body: {
        'token': token,
        'other_person_id': otherPersonId,
      });

      var responseInfo = jsonDecode(response.body);

      if (responseInfo['status'] == 'Error') {
        throw CustomError(responseInfo['mensaje']);
      } else if (responseInfo['status'] == 'Ok') {
        {
          return true;
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
  Future<dynamic> buscarUsuarios({required String usuario}) async {
    var prefs = await SharedPreferences.getInstance();

    try {
      String token = prefs.getString('token') ?? '';
      final response = await httpClient
          .post(Uri.parse('${Enviroment.apiUrl}/buscarUsuarios.php'), body: {
        'token': token,
        'usuario': usuario,
      });

      var responseInfo = jsonDecode(response.body);

      if (responseInfo['status'] == 'Error') {
        throw CustomError(responseInfo['mensaje']);
      } else if (responseInfo['status'] == 'Ok') {
        {
          if (responseInfo['cantidad'] == 0) {
            throw CustomError('No se encontrarón usuarios.');
          } else {
            return ChatsUserResp(
                id: responseInfo['data'][0]['id'],
                imagen: responseInfo['data'][0]['imagen'],
                nombre: responseInfo['data'][0]['nombre_apellido'],
                message: '',
                otherPersonId: responseInfo['data'][0]['other_person_id'],
                createdAt: DateTime.now());
          }
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
