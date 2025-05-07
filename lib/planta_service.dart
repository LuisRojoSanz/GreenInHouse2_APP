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

  static Future<void> guardarFechaPlantacion(DateTime fecha) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fechaPlantacion', fecha.toIso8601String());
  }

  static Future<DateTime?> obtenerFechaPlantacion() async {
    final prefs = await SharedPreferences.getInstance();
    final fechaStr = prefs.getString('fechaPlantacion');
    if (fechaStr != null) {
      return DateTime.parse(fechaStr);
    }
    return null;
  }

  static Future<void> eliminarFechaPlantacion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('fechaPlantacion');
  }

}