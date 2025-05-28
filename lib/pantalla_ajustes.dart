import 'package:flutter/material.dart';
import 'package:greeninhouse2/botones_inicio.dart';
import 'package:greeninhouse2/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ajustes extends StatefulWidget {
  const Ajustes({super.key});

  @override
  State<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  int frecuenciaCambioTierra = 90;
  int frecuenciaFertilizante = 90;

  bool mostrarGraficaHumedad = true;
  bool mostrarGraficaHumedadAmbiente = true;
  bool mostrarGraficaLuz = true;
  bool mostrarGraficaTemperatura = true;

  bool mostrarHitoHumedadSuelo = true;
  bool mostrarHitoHumedadAmbiente = true;
  bool mostrarHitoLuz = true;
  bool mostrarHitoTemperatura = true;
  bool mostrarHitoCambioTierra = true;
  bool mostrarHitoFertilizante = true;

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
      frecuenciaFertilizante = prefs.getInt('frecuenciaFertilizante') ?? 90;

      mostrarGraficaHumedad = prefs.getBool('mostrarGraficaHumedad') ?? true;
      mostrarGraficaHumedadAmbiente = prefs.getBool('mostrarGraficaHumedadAmbiente') ?? true;
      mostrarGraficaLuz = prefs.getBool('mostrarGraficaLuz') ?? true;
      mostrarGraficaTemperatura = prefs.getBool('mostrarGraficaTemperatura') ?? true;

      mostrarHitoHumedadSuelo = prefs.getBool('mostrarHitoHumedadSuelo') ?? true;
      mostrarHitoHumedadAmbiente = prefs.getBool('mostrarHitoHumedadAmbiente') ?? true;
      mostrarHitoLuz = prefs.getBool('mostrarHitoLuz') ?? true;
      mostrarHitoTemperatura = prefs.getBool('mostrarHitoTemperatura') ?? true;
      mostrarHitoCambioTierra = prefs.getBool('mostrarHitoCambioTierra') ?? true;
      mostrarHitoFertilizante = prefs.getBool('mostrarHitoFertilizante') ?? true;
    });
  }

  Future<void> guardarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('frecuenciaCambioTierra', frecuenciaCambioTierra);
    await prefs.setInt('frecuenciaFertilizante', frecuenciaFertilizante);

    await prefs.setBool('mostrarGraficaHumedad', mostrarGraficaHumedad);
    await prefs.setBool('mostrarGraficaHumedadAmbiente', mostrarGraficaHumedadAmbiente);
    await prefs.setBool('mostrarGraficaLuz', mostrarGraficaLuz);
    await prefs.setBool('mostrarGraficaTemperatura', mostrarGraficaTemperatura);

    await prefs.setBool('mostrarHitoHumedadSuelo', mostrarHitoHumedadSuelo);
    await prefs.setBool('mostrarHitoHumedadAmbiente', mostrarHitoHumedadAmbiente);
    await prefs.setBool('mostrarHitoLuz', mostrarHitoLuz);
    await prefs.setBool('mostrarHitoTemperatura', mostrarHitoTemperatura);
    await prefs.setBool('mostrarHitoCambioTierra', mostrarHitoCambioTierra);
    await prefs.setBool('mostrarHitoFertilizante', mostrarHitoFertilizante);
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
        title: Text(S.of(context).settingsTitle),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(S.of(context).showCharts, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: Text(S.of(context).chartSoilMoisture),
            value: mostrarGraficaHumedad,
            onChanged: (value) {
              setState(() => mostrarGraficaHumedad = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: Text(S.of(context).chartAmbientHumidity),
            value: mostrarGraficaHumedadAmbiente,
            onChanged: (value) {
              setState(() => mostrarGraficaHumedadAmbiente = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: Text(S.of(context).chartLight),
            value: mostrarGraficaLuz,
            onChanged: (value) {
              setState(() => mostrarGraficaLuz = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: Text(S.of(context).chartTemperature),
            value: mostrarGraficaTemperatura,
            onChanged: (value) {
              setState(() => mostrarGraficaTemperatura = value);
              guardarPreferencias();
            },
          ),
          const Divider(height: 30),

          Text(S.of(context).showMilestones, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: Text(S.of(context).milestoneSoilMoisture),
            value: mostrarHitoHumedadSuelo,
            onChanged: (value) {
              setState(() => mostrarHitoHumedadSuelo = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: Text(S.of(context).milestoneAmbientHumidity),
            value: mostrarHitoHumedadAmbiente,
            onChanged: (value) {
              setState(() => mostrarHitoHumedadAmbiente = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: Text(S.of(context).milestoneLight),
            value: mostrarHitoLuz,
            onChanged: (value) {
              setState(() => mostrarHitoLuz = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: Text(S.of(context).milestoneTemperature),
            value: mostrarHitoTemperatura,
            onChanged: (value) {
              setState(() => mostrarHitoTemperatura = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: Text(S.of(context).milestoneSoilChange),
            value: mostrarHitoCambioTierra,
            onChanged: (value) {
              setState(() => mostrarHitoCambioTierra = value);
              guardarPreferencias();
            },
          ),
          SwitchListTile(
            title: Text(S.of(context).milestoneFertilizer),
            value: mostrarHitoFertilizante,
            onChanged: (value) {
              setState(() => mostrarHitoFertilizante = value);
              guardarPreferencias();
            },
          ),

          const Divider(height: 30),
          Text(S.of(context).soilChangeFrequency, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Slider(
            value: frecuenciaCambioTierra.toDouble(),
            min: 60,
            max: 180,
            divisions: 12,
            label: S.of(context).daysCount(frecuenciaCambioTierra),
            onChanged: (value) {
              setState(() {
                frecuenciaCambioTierra = value.toInt();
              });
              guardarPreferencias();
            },
          ),

          const SizedBox(height: 20),
          Text(S.of(context).fertilizerFrequency, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Slider(
            value: frecuenciaFertilizante.toDouble(),
            min: 60,
            max: 180,
            divisions: 12,
            label: S.of(context).daysCount(frecuenciaFertilizante),
            onChanged: (value) {
              setState(() {
                frecuenciaFertilizante = value.toInt();
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
