import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'pantalla_inicio.dart';
import 'generated/l10n.dart';
import 'locale_provider.dart';

/// Función principal que ejecuta la aplicación.
/// Inicia la app y establece el proveedor para el cambio de idioma.
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

/// Widget principal de la aplicación.
/// Configura el tema, la localización y el home de la app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'GreenInHouse2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],

      // Delegados de localización necesarios para que Flutter maneje la traducción de la app
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      home: const PantallaInicio(),
    );
  }
}
