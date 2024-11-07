import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pantalla_inicio.dart';
import 'generated/l10n.dart';
import 'api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Instancia de ApiService con la URL de la API
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1/ui/');
  // Verificar la conexión y mostrar el resultado en la consola
  apiService.testConnection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenInHouse2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const PantallaInicio(),
      locale: const Locale('es', ''),
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
    );
  }
}
