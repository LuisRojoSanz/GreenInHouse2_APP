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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState(); // Usamos MyAppState sin el guion bajo
}

class MyAppState extends State<MyApp> {  // Renombramos la clase a MyAppState sin el guion bajo
  Locale _locale = const Locale('es', '');

  void _onLocaleChange(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenInHouse2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: PantallaInicio(onLocaleChange: _onLocaleChange), // Pasamos la función aquí
      locale: _locale,
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


