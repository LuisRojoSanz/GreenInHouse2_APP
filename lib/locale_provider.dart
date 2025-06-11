import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Gestiona la configuración de idioma de la aplicación.
/// Permite cargar el idioma guardado en `SharedPreferences` y actualizarlo si el usuario lo cambia.
///
/// Atributos:
/// - `_locale`: La configuración de idioma actual de la aplicación.
///
/// Métodos:
/// - `locale`: devuelve el idioma actual.
/// - `LocaleProvider`: Constructor que inicializa la carga del idioma guardado.
/// - `_loadSavedLocale`: Método privado que carga el idioma guardado en `SharedPreferences`.
/// - `setLocale`: Método público para establecer un nuevo idioma y guardarlo en `SharedPreferences`.
class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('es');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadSavedLocale();
  }

  /// Carga el idioma guardado en `SharedPreferences` y actualiza el estado.
  void _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('idiomaSeleccionado');
    if (langCode != null) {
      _locale = Locale(langCode);
      notifyListeners();
    }
  }

  /// Establece un nuevo idioma y lo guarda en `SharedPreferences`.
  ///
  /// Atributos:
  /// - `newLocale`: El nuevo idioma a establecer.
  void setLocale(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idiomaSeleccionado', newLocale.languageCode);
    _locale = newLocale;
    notifyListeners();
  }
}
