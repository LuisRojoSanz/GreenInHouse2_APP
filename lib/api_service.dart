import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  // Método para probar la conexión con la API
  Future<bool> testConnection() async {
    try {
      // Envuelve la URL en un objeto Uri con Uri.parse
      final response = await http.get(Uri.parse(baseUrl));

      // Verifica si la respuesta fue exitosa (código 200)
      if (response.statusCode == 200) {
        print("Conexión exitosa con la API");
        return true;
      } else {
        print("Error al conectar con la API: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Excepción al conectar con la API: $e");
      return false;
    }
  }
}
