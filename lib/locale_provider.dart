import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('es');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadSavedLocale();
  }

  void _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('idiomaSeleccionado');
    if (langCode != null) {
      _locale = Locale(langCode);
      notifyListeners();
    }
  }

  void setLocale(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idiomaSeleccionado', newLocale.languageCode);
    _locale = newLocale;
    notifyListeners();
  }
}
