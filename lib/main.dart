import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pantalla_inicio.dart';
import 'generated/l10n.dart';
import 'api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Limpiar bandera para que el diálogo se muestre solo una vez por sesión
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('dialogoPlantaMostrado');

  // Leer idioma guardado
  String? langCode = prefs.getString('idiomaSeleccionado');
  Locale locale = langCode != null ? Locale(langCode) : const Locale('es');

  // Instancia de ApiService con la URL de la API
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1/ui/');
  // Verificar la conexión y mostrar el resultado en la consola
  apiService.testConnection();
  runApp(MyApp(localeInicial: locale));
}

class MyApp extends StatefulWidget {
  final Locale localeInicial;

  const MyApp({super.key, required this.localeInicial});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.localeInicial;
  }

  void _onLocaleChange(Locale locale) async {
    setState(() {
      _locale = locale;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idiomaSeleccionado', locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenInHouse2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      home: PantallaInicio(onLocaleChange: _onLocaleChange),
    );
  }
}


