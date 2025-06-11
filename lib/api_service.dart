import 'dart:async';
import 'dart:convert';
import 'dart:io'; // Para SocketException
import 'package:http/http.dart' as http; // Para http requests

/// Clase que gestiona la comunicación con la API mediante peticiones HTTP.
/// Esta clase encapsula los métodos  GET, POST, PUT y DELETE,
/// e incluye gestión de errores como timeouts o falta de conexión.
class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  /// Método para realizar una petición GET a un endpoint determinado.
  ///
  /// [endpoint]: Ruta específica dentro de la API.
  ///
  /// Devuelve el cuerpo de la respuesta en formato JSON si la respuesta es
  /// exitosa (código 200), o `null` si ocurre un error o si la conexión falla.
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error en GET $endpoint: ${response.statusCode}');
        print('Respuesta: ${response.body}');
        return null;
      }
    } on TimeoutException {
      print('Timeout al hacer GET $endpoint');
      return null;
    } on SocketException {
      print('Sin conexión al hacer GET $endpoint');
      return null;
    } catch (e) {
      print('Error inesperado en GET $endpoint: $e');
      return null;
    }
  }

  /// Método para realizar una petición POST a un endpoint determinado.
  ///
  /// [endpoint]: Ruta específica dentro de la API.
  /// [body]: Mapa con los datos que se enviarán en el cuerpo de la petición.
  ///
  /// Devuelve la respuesta si es exitosa (código 200 o 201),
  /// o `null` si hay un error o la conexión falla.
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http
          .post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print('Error en POST $endpoint: ${response.statusCode}');
        print('Respuesta: ${response.body}');
        return null;
      }
    } on TimeoutException {
      print('Timeout en POST $endpoint');
      return null;
    } on SocketException {
      print('Sin conexión en POST $endpoint');
      return null;
    } catch (e) {
      print('Error inesperado en POST $endpoint: $e');
      return null;
    }
  }

  /// Método para verificar si la aplicación puede conectarse correctamente
  /// a la API.
  ///
  /// Retorna `true` si la respuesta al GET básico devuelve código 200,
  /// o `false` si falla por timeout, conexión o error inesperado.
  Future<bool> testConnection() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 20));
      return response.statusCode == 200;
    } on TimeoutException {
      print('Timeout al verificar conexión con $baseUrl');
      return false;
    } on SocketException {
      print('Sin conexión al verificar $baseUrl');
      return false;
    } catch (e) {
      print('Error inesperado en testConnection: $e');
      return false;
    }
  }

  /// Método para realizar una petición DELETE a un endpoint.
  ///
  /// [endpoint]: Ruta específica dentro de la API.
  ///
  /// Devuelve el cuerpo de la respuesta en formato JSON,
  /// o `null` si no hay contenido o hay error.
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await http
          .delete(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body.isNotEmpty ? jsonDecode(response.body) : null;
      } else {
        print('Error en DELETE $endpoint: ${response.statusCode}');
        print('Respuesta: ${response.body}');
        return null;
      }
    } on TimeoutException {
      print('Timeout en DELETE $endpoint');
      return null;
    } on SocketException {
      print('Sin conexión en DELETE $endpoint');
      return null;
    } catch (e) {
      print('Error inesperado en DELETE $endpoint: $e');
      return null;
    }
  }

  /// Método para realizar una petición PUT a un endpoint determinado.
  ///
  /// [endpoint]: Ruta específica dentro de la API.
  /// [body]: Mapa con los datos que se enviarán en el cuerpo de la petición.
  ///
  /// Devuelve la respuesta en formato JSON si es exitosa (200 o 204),
  /// o `null` si ocurre un error o si no hay respuesta útil.
  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http
          .put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body.isNotEmpty ? jsonDecode(response.body) : null;
      } else {
        print('Error en PUT $endpoint: ${response.statusCode}');
        print('Respuesta: ${response.body}');
        return null;
      }
    } on TimeoutException {
      print('Timeout en PUT $endpoint');
      return null;
    } on SocketException {
      print('Sin conexión en PUT $endpoint');
      return null;
    } catch (e) {
      print('Error inesperado en PUT $endpoint: $e');
      return null;
    }
  }
}
