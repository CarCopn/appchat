abstract class AuthDatasource {
  Future<dynamic> login({required String email, required String password});
  Future<dynamic> listChats();
  Future<dynamic> getChatWithIDUser({required String idOtherPerson});
}
