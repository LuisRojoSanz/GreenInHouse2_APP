import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greeninhouse2/locale_provider.dart';
import 'generated/l10n.dart';

/// Pantalla para cambiar el idioma de la aplicación.
/// Permite al usuario seleccionar entre los idiomas disponibles (inglés y español).
/// El idioma seleccionado se guarda y aplica en toda la aplicación mediante el proveedor `LocaleProvider`.
///
/// Atributos:
/// - `build`: Método que construye la UI de la pantalla.
/// - `provider`: Instancia de `LocaleProvider` que maneja la configuración del idioma.
/// - `currentLocale`: Idioma actualmente seleccionado.
class PantallaCambioIdioma extends StatelessWidget {
  const PantallaCambioIdioma({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final currentLocale = provider.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).change_language),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTile(
              context,
              locale: const Locale('en'),
              language: S.of(context).english,
              flag: 'assets/flags/uk.png',
              isSelected: currentLocale.languageCode == 'en',
            ),
            _buildTile(
              context,
              locale: const Locale('es'),
              language: S.of(context).spanish,
              flag: 'assets/flags/spain.png',
              isSelected: currentLocale.languageCode == 'es',
            ),
          ],
        ),
      ),
    );
  }

  /// Crea una fila de lista con el idioma, su bandera y un ícono de selección.
  /// Permite al usuario seleccionar un idioma y actualizar la configuración.
  ///
  /// Atributos:
  /// - `context`: Contexto de la aplicación.
  /// - `locale`: El código de idioma asociado al `ListTile`.
  /// - `language`: El nombre del idioma a mostrar.
  /// - `flag`: Ruta del archivo de la bandera del país.
  /// - `isSelected`: Booleano que indica si este idioma está seleccionado.
  Widget _buildTile(BuildContext context, {
    required Locale locale,
    required String language,
    required String flag,
    required bool isSelected,
  }) {
    final provider = Provider.of<LocaleProvider>(context, listen: false);

    return ListTile(
      leading: Image.asset(flag, width: 30, height: 30),
      title: Text(language),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: () {
        provider.setLocale(locale);
        Navigator.pop(context); // Vuelve al inicio con idioma cambiado
      },
    );
  }
}
