import 'package:flutter/material.dart';
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
              language: (S.of(context).english),
            ),
            _buildLanguageTile(
              locale: const Locale('es', ''),
              language: (S.of(context).spanish),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile({required Locale locale, required String language}) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(language),
      trailing: _selectedLocale == locale
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () {
        setState(() {
          _selectedLocale = locale;
        });
        widget.onLocaleChange(locale); // Cambia el idioma de toda la app
      },
    );
  }
}
