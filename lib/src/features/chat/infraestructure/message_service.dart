import 'package:http/http.dart' as http;
// import 'package:mime/mime.dart';

class MessageService {
  Future<bool> isValidImageUrl(String url) async {
    // Validar formato de URL
    // if (!RegExp(r'^https?://([\w\-\_]+\.){2,}([a-z]/)?').hasMatch(url)) {
    //   // if (!RegExp(r'^http?://(www\.)?([\w\-\_]+\.){2,}([a-z]/)?').hasMatch(url)) {
    //   return false;
    // }

    // Verificar si la URL apunta a una imagen
    try {
      final response = await http.head(Uri.parse(url));
      if (response.statusCode == 200) {
        // final contentType = lookupMimeType(response.headers['content-type']!);
        final contentType = response.headers['content-type'];
        if (contentType != null && contentType.startsWith('image/')) {
          return true;
        }
      }
    } catch (e) {
      // Manejar errores de red o de conexión
    }

    return false;
  }
}
