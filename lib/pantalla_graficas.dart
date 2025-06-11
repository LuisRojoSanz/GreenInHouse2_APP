import 'package:flutter/material.dart';
import 'package:greeninhouse2/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'grafica_temperatura.dart';
import 'botones_inicio.dart';
import 'grafica_humedad.dart';
import 'grafica_luz.dart';
import 'grafica_humedad_ambiente.dart';
import 'api_service.dart';
import 'dialogos_excepciones.dart';


/// Pantalla que muestra las gráficas de temperatura, humedad, luz y humedad ambiente.
/// El usuario puede ver las gráficas de los sensores de la planta activa, con la
/// opción de habilitar o deshabilitar cada una de ellas según las preferencias
/// almacenadas en `SharedPreferences`.
class GraficasScreen extends StatefulWidget {
  const GraficasScreen({super.key});

  @override
  GraficasScreenState createState() => GraficasScreenState();
}

/// Estado de la pantalla `GraficasScreen`, encargado de gestionar las gráficas de temperatura,
/// humedad, luz y humedad ambiente. Controla la carga de preferencias almacenadas,
/// la verificación de la conexión con la base de datos, y la visualización de las gráficas
/// en función de las configuraciones del usuario.
/// Atributos creados:
/// - `_currentIndex`: Indica el índice de la pestaña actualmente seleccionada en la barra
///   de navegación inferior.
/// - `mostrarGraficaTemperatura`: Booleano que controla si la gráfica de temperatura se debe
///   mostrar o no.
/// - `mostrarGraficaHumedad`: Booleano que controla si la gráfica de humedad se debe mostrar
///   o no.
/// - `mostrarGraficaLuz`: Booleano que controla si la gráfica de luz se debe mostrar o no.
/// - `mostrarGraficaHumedadAmbiente`: Booleano que controla si la gráfica de humedad ambiente
///   se debe mostrar o no.
/// - `apiService`: Instancia de `ApiService` utilizada para interactuar con la API y obtener
///   los datos necesarios para las gráficas.
class GraficasScreenState extends State<GraficasScreen> {
  int _currentIndex = 1;

  bool mostrarGraficaTemperatura = true;
  bool mostrarGraficaHumedad = true;
  bool mostrarGraficaLuz = true;
  bool mostrarGraficaHumedadAmbiente = true;

  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _verificarConexionInicial();
    cargarPreferencias();
  }

  /// Verifica la conexión con el servidor y obtiene los datos iniciales.
  /// Si la conexión es exitosa, carga las preferencias del usuario desde `SharedPreferences`.
  Future<void> _verificarConexionInicial() async {
    try {
      final response = await apiService.get('Plantas/All/Active');

      if (!mounted) return;

      if (response != null) {
        await cargarPreferencias();
      } else {
        await mostrarDialogoErrorConexion(context);
      }
    } catch (e) {
      if (!mounted) return;
      await mostrarDialogoErrorConexion(context);
    }
  }

  /// Carga las preferencias del usuario relacionadas con las gráficas desde `SharedPreferences`.
  Future<void> cargarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      mostrarGraficaTemperatura = prefs.getBool('mostrarGraficaTemperatura') ?? true;
      mostrarGraficaHumedad = prefs.getBool('mostrarGraficaHumedad') ?? true;
      mostrarGraficaLuz = prefs.getBool('mostrarGraficaLuz') ?? true;
      mostrarGraficaHumedadAmbiente = prefs.getBool('mostrarGraficaHumedadAmbiente') ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).graphs),
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (mostrarGraficaHumedad) const HumidityGraph(),
            if (mostrarGraficaHumedadAmbiente) const HumidityGraphAM(),
            if (mostrarGraficaLuz) const LightGraph(),
            if (mostrarGraficaTemperatura) const TemperatureGraph(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationCustom(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
