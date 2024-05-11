abstract class AuthDatasource {
  Future<dynamic> login({required String email, required String password});
  Future<dynamic> listChats();
  Future<dynamic> getChatWithIDUser({required String idOtherPerson});
  Future<dynamic> sendMessage(
      {required String id,
      required String otherPersonId,
      required String message,
      String? archivo,
      String? extension});

  Future<dynamic> updateDataUser({
    required String name,
    required String clave,
    required String claveExtra,
    String? archivo,
  });

  Future<dynamic> liberarDatos({required String codigo});
  Future<dynamic> archivarDatos({required String otherPersonId});
  Future<dynamic> buscarUsuarios({required String usuario});
}
