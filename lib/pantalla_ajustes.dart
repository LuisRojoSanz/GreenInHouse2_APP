import 'package:flutter/material.dart';
import 'package:greeninhouse2/botones_inicio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ajustes extends StatefulWidget {
  const Ajustes({super.key});

  @override
  State<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  int frecuenciaCambioTierra = 90;
  bool mostrarGraficaHumedad = true;
  bool mostrarGraficaHumedadAmbiente = true;
  bool mostrarGraficaLuz = true;
  bool mostrarGraficaTemperatura = true;

  bool mostrarHitoHumedadSuelo = true;
  bool mostrarHitoHumedadAmbiente = true;
  bool mostrarHitoLuz = true;
  bool mostrarHitoTemperatura = true;
  bool mostrarHitoCambioTierra = true;

  int _currentIndex = 3;

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
      frecuenciaCambioTierra = prefs.getInt('frecuenciaCambioTierra') ?? 90;

      mostrarGraficaHumedad = prefs.getBool('mostrarGraficaHumedad') ?? true;
      mostrarGraficaHumedadAmbiente = prefs.getBool('mostrarGraficaHumedadAmbiente') ?? true;
      mostrarGraficaLuz = prefs.getBool('mostrarGraficaLuz') ?? true;
      mostrarGraficaTemperatura = prefs.getBool('mostrarGraficaTemperatura') ?? true;

      mostrarHitoHumedadSuelo = prefs.getBool('mostrarHitoHumedadSuelo') ?? true;
      mostrarHitoHumedadAmbiente = prefs.getBool('mostrarHitoHumedadAmbiente') ?? true;
      mostrarHitoLuz = prefs.getBool('mostrarHitoLuz') ?? true;
      mostrarHitoTemperatura = prefs.getBool('mostrarHitoTemperatura') ?? true;
      mostrarHitoCambioTierra = prefs.getBool('mostrarHitoCambioTierra') ?? true;
    });
  }

  Future<void> guardarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('frecuenciaCambioTierra', frecuenciaCambioTierra);

    await prefs.setBool('mostrarGraficaHumedad', mostrarGraficaHumedad);
    await prefs.setBool('mostrarGraficaHumedadAmbiente', mostrarGraficaHumedadAmbiente);
    await prefs.setBool('mostrarGraficaLuz', mostrarGraficaLuz);
    await prefs.setBool('mostrarGraficaTemperatura', mostrarGraficaTemperatura);

    await prefs.setBool('mostrarHitoHumedadSuelo', mostrarHitoHumedadSuelo);
    await prefs.setBool('mostrarHitoHumedadAmbiente', mostrarHitoHumedadAmbiente);
    await prefs.setBool('mostrarHitoLuz', mostrarHitoLuz);
    await prefs.setBool('mostrarHitoTemperatura', mostrarHitoTemperatura);
    await prefs.setBool('mostrarHitoCambioTierra', mostrarHitoCambioTierra);
  }

  @override
  void dispose() {
    guardarPreferencias();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajustes"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("📊 Mostrar gráficas", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text("Gráfica de Humedad"),
            value: mostrarGraficaHumedad,
            onChanged: (value) {
              setState(() => mostrarGraficaHumedad = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: const Text("Gráfica de Humedad Ambiente"),
            value: mostrarGraficaHumedadAmbiente,
            onChanged: (value) {
              setState(() => mostrarGraficaHumedadAmbiente = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: const Text("Gráfica de Luz"),
            value: mostrarGraficaLuz,
            onChanged: (value) {
              setState(() => mostrarGraficaLuz = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: const Text("Gráfica de Temperatura"),
            value: mostrarGraficaTemperatura,
            onChanged: (value) {
              setState(() => mostrarGraficaTemperatura = value);
              guardarPreferencias();
            },
          ),
          const Divider(height: 30),

          const Text("✨ Mostrar Hitos", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text("Humedad del Suelo"),
            value: mostrarHitoHumedadSuelo,
            onChanged: (value) {
              setState(() => mostrarHitoHumedadSuelo = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: const Text("Humedad Ambiente"),
            value: mostrarHitoHumedadAmbiente,
            onChanged: (value) {
              setState(() => mostrarHitoHumedadAmbiente = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: const Text("Luz"),
            value: mostrarHitoLuz,
            onChanged: (value) {
              setState(() => mostrarHitoLuz = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: const Text("Temperatura"),
            value: mostrarHitoTemperatura,
            onChanged: (value) {
              setState(() => mostrarHitoTemperatura = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: const Text("Cambio de Tierra"),
            value: mostrarHitoCambioTierra,
            onChanged: (value) {
              setState(() => mostrarHitoCambioTierra = value);
              guardarPreferencias();
            },
          ),
          const Divider(height: 30),

          const Text("⏳ Frecuencia del cambio de tierra (días)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Slider(
            value: frecuenciaCambioTierra.toDouble(),
            min: 30,
            max: 180,
            divisions: 10,
            label: "$frecuenciaCambioTierra días",
            onChanged: (value) {
              setState(() {
                frecuenciaCambioTierra = value.toInt();
              });
              guardarPreferencias();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationCustom(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
