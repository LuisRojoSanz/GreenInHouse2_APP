import 'dart:async';
import 'dart:convert';
import 'dart:io'; // Para SocketException
import 'package:http/http.dart' as http; // Para http requests

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  // Método genérico para hacer peticiones GET
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint'), // Combina la base con el endpoint
        headers: {'Content-Type': 'application/json'}, // Encabezados opcionales
      ).timeout(const Duration(seconds: 5)); // Timeout de 5 segundos

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Decodifica la respuesta en JSON
      } else {
        print('Error en GET $endpoint: ${response.statusCode}');
        print('Respuesta: ${response.body}');
        return null;
      }
    } on TimeoutException {
      print('⏰ Timeout al hacer GET $endpoint');
      return null;
    } on SocketException {
      print('📡 Sin conexión al hacer GET $endpoint');
      return null;
    } catch (e) {
      print('💥 Error inesperado en GET $endpoint: $e');
      return null;
    }
  }

  // Método genérico para hacer peticiones POST
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http
          .post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print('❌ Error en POST $endpoint: ${response.statusCode}');
        print('Respuesta: ${response.body}');
        return null;
      }
    } on TimeoutException {
      print('⏰ Timeout en POST $endpoint');
      return null;
    } on SocketException {
      print('📡 Sin conexión en POST $endpoint');
      return null;
    } catch (e) {
      print('💥 Error inesperado en POST $endpoint: $e');
      return null;
    }
  }

  // Método para verificar la conexión
  Future<bool> testConnection() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } on TimeoutException {
      print('⏰ Timeout al verificar conexión con $baseUrl');
      return false;
    } on SocketException {
      print('📡 Sin conexión al verificar $baseUrl');
      return false;
    } catch (e) {
      print('💥 Error inesperado en testConnection: $e');
      return false;
    }
  }

  // Método genérico para hacer peticiones DELETE
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await http
          .delete(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body.isNotEmpty ? jsonDecode(response.body) : null;
      } else {
        print('❌ Error en DELETE $endpoint: ${response.statusCode}');
        print('Respuesta: ${response.body}');
        return null;
      }
    } on TimeoutException {
      print('⏰ Timeout en DELETE $endpoint');
      return null;
    } on SocketException {
      print('📡 Sin conexión en DELETE $endpoint');
      return null;
    } catch (e) {
      print('💥 Error inesperado en DELETE $endpoint: $e');
      return null;
    }
  }

  // Método genérico para hacer peticiones PUT
  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http
          .put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body.isNotEmpty ? jsonDecode(response.body) : null;
      } else {
        print('❌ Error en PUT $endpoint: ${response.statusCode}');
        print('Respuesta: ${response.body}');
        return null;
      }
    } on TimeoutException {
      print('⏰ Timeout en PUT $endpoint');
      return null;
    } on SocketException {
      print('📡 Sin conexión en PUT $endpoint');
      return null;
    } catch (e) {
      print('💥 Error inesperado en PUT $endpoint: $e');
      return null;
    }
  }
}
