import 'dart:developer';

import 'package:chatapp/src/config/enviroment.dart';
import 'package:chatapp/src/features/authentication/domain/datasources/auth_datasource.dart';
import 'package:chatapp/src/features/authentication/infraestructure/errors/errors.dart';
import 'package:dio/dio.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Enviroment.apiUrl,
  ));

  @override
  Future<dynamic> login(
      {required String email, required String password}) async {
    try {
      final response = await dio.post('/logear.php', data: {
        'email_user': email,
        'password': password,
      });
      log('resp ${response.data}');
      if (response.data['status'] == 'Error') {
        throw CustomError(response.data['mensaje']);
      } else if (response.data['status'] == 'Ok' ||
          response.data['status'] is String) {
        // final respUse = SendWspResp(
        //   name: response.data["name"],
        //   status: response.data["status"],
        //   id: response.data["id"],
        //   idSocio: response.data["idSocio"],
        // );
        // // final user = UserMapper.userJsonToEntity(response.data);
        // final user = UserNew(
        //     userId: (respUse.id).toString(),
        //     idSocio: (respUse.idSocio).toString());
        // return user;
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
}
