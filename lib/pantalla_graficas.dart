import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'grafica_temperatura.dart';
import 'botones_inicio.dart';
import 'grafica_humedad.dart';
import 'grafica_luz.dart';
import 'grafica_humedad_ambiente.dart';

class GraficasScreen extends StatefulWidget {
  const GraficasScreen({super.key});

  @override
  GraficasScreenState createState() => GraficasScreenState();
}

class GraficasScreenState extends State<GraficasScreen> {
  int _currentIndex = 0;

  bool mostrarGraficaTemperatura = true;
  bool mostrarGraficaHumedad = true;
  bool mostrarGraficaLuz = true;
  bool mostrarGraficaHumedadAmbiente = true;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarPreferencias();
  }

  Future<void> cargarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      mostrarGraficaTemperatura = prefs.getBool('mostrarGraficaTemperatura') ?? true;
      mostrarGraficaHumedad = prefs.getBool('mostrarGraficaHumedad') ?? true;
      mostrarGraficaLuz = prefs.getBool('mostrarGraficaLuz') ?? true;
      // Agrega también una opción para humedad ambiente si la quieres controlar por separado
      mostrarGraficaHumedadAmbiente = prefs.getBool('mostrarGraficaHumedadAmbiente') ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráficos'),
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
