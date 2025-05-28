import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';

class PantallaCambioIdioma extends StatefulWidget {
  final void Function(Locale locale) onLocaleChange;

  const PantallaCambioIdioma({super.key, required this.onLocaleChange});

  @override
  PantallaCambioIdiomaState createState() => PantallaCambioIdiomaState();
}

class PantallaCambioIdiomaState extends State<PantallaCambioIdioma> {
  Locale? _selectedLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLocale ??= Localizations.localeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).change_language),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildLanguageTile(
              locale: const Locale('en', ''),
              language: S.of(context).english,
              flag: 'assets/flags/uk.png',
              flagWidth: 30,
              flagHeight: 30,
            ),
            _buildLanguageTile(
              locale: const Locale('es', ''),
              language: S.of(context).spanish,
              flag: 'assets/flags/spain.png',
              flagWidth: 30,
              flagHeight: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile({
    required Locale locale,
    required String language,
    required String flag,
    required double flagWidth,
    required double flagHeight,
  }) {
    return ListTile(
      leading: SizedBox(
        width: flagWidth,
        height: flagHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(flagWidth / 2),
          child: Image.asset(
            flag,
            fit: BoxFit.contain, // Ajusta la imagen dentro del contenedor
          ),
        ),
      ),
      title: Text(language),
      trailing: _selectedLocale == locale
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () async {
        setState(() {
          _selectedLocale = locale;
        });

        // Guardar el idioma elegido
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('idiomaSeleccionado', locale.languageCode);

        widget.onLocaleChange(locale);
      },
    );
  }
}
