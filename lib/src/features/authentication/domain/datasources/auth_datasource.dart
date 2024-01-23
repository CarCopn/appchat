abstract class AuthDatasource {
  Future<dynamic> login({required String email, required String password});
}
