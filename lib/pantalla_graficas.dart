import 'package:flutter/material.dart';
import 'grafica_temperatura.dart';
import 'botones_inicio.dart';
import 'grafica_humedad.dart';
import 'grafica_luz.dart'; // Importar la nueva gráfica de luz

class GraficasScreen extends StatefulWidget {
  const GraficasScreen({super.key});

  @override
  GraficasScreenState createState() => GraficasScreenState();
}

class GraficasScreenState extends State<GraficasScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
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
          children: const [
            HumidityGraph(), // Gráfica de humedad
            LightGraph(), // Gráfica de luz agregada aquí
            TemperatureGraph(), // Agregamos la gráfica de temperatura
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
