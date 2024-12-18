import 'dart:convert'; // Para jsonDecode
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
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Decodifica la respuesta en JSON
      } else {
        print('Error en GET $endpoint: ${response.statusCode}');
        print('Respuesta: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error en GET $endpoint: $e');
      return null;
    }
  }

  // Método genérico para hacer peticiones POST
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'), // Combina la base con el endpoint
        headers: {'Content-Type': 'application/json'}, // Encabezado JSON
        body: jsonEncode(body), // Codifica el cuerpo en JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body); // Respuesta exitosa
      } else {
        print('Error en POST $endpoint: ${response.statusCode}');
        print('Respuesta: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error en POST $endpoint: $e');
      return null;
    }
  }

  // Método para verificar la conexión
  Future<bool> testConnection() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      return response.statusCode == 200;
    } catch (e) {
      print('Error al conectar: $e');
      return false;
    }
  }
}
