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

class GraficasScreen extends StatefulWidget {
  const GraficasScreen({super.key});

  @override
  GraficasScreenState createState() => GraficasScreenState();
}

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
