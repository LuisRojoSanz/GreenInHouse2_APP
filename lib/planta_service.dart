import 'package:shared_preferences/shared_preferences.dart';

class PlantaService {
  static Future<String?> obtenerNombrePlantaActiva() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombrePlantaActiva');
  }

  static Future<void> guardarNombrePlantaActiva(String nombre) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombrePlantaActiva', nombre);
  }

  static Future<void> eliminarNombrePlantaActiva() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('nombrePlantaActiva');
  }
}