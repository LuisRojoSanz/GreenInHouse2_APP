import 'package:shared_preferences/shared_preferences.dart';

/// Servicio que gestiona el acceso a los datos relacionados con la planta activa,
/// como el nombre de la planta y la fecha de plantación, utilizando `SharedPreferences`
/// para almacenar y recuperar estos valores.
class PlantaService {

  /// Obtiene el nombre de la planta activa desde `SharedPreferences`.
  ///
  /// @return Future<String?> Nombre de la planta activa o null si no está disponible.
  static Future<String?> obtenerNombrePlantaActiva() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombrePlantaActiva');
  }

  /// Guarda el nombre de la planta activa en `SharedPreferences`.
  ///
  /// @param nombre Nombre de la planta activa a guardar.
  /// @return Future<void>
  static Future<void> guardarNombrePlantaActiva(String nombre) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombrePlantaActiva', nombre);
  }

  /// Elimina el nombre de la planta activa de `SharedPreferences`.
  ///
  /// @return Future<void>
  static Future<void> eliminarNombrePlantaActiva() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('nombrePlantaActiva');
  }

  /// Guarda la fecha de plantación en `SharedPreferences`.
  ///
  /// @param fecha Fecha de plantación a guardar.
  /// @return Future<void>
  static Future<void> guardarFechaPlantacion(DateTime fecha) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fechaPlantacion', fecha.toIso8601String());
  }

  /// Obtiene la fecha de plantación desde `SharedPreferences`.
  ///
  /// @return Future<DateTime?> Fecha de plantación o null si no está disponible.
  static Future<DateTime?> obtenerFechaPlantacion() async {
    final prefs = await SharedPreferences.getInstance();
    final fechaStr = prefs.getString('fechaPlantacion');
    if (fechaStr != null) {
      return DateTime.parse(fechaStr);
    }
    return null;
  }

  /// Elimina la fecha de plantación de `SharedPreferences`.
  ///
  /// @return Future<void>
  static Future<void> eliminarFechaPlantacion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('fechaPlantacion');
  }

}