import 'package:flutter/material.dart';
import 'package:greeninhouse2/dialogos_excepciones.dart';
import 'package:greeninhouse2/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'botones_inicio.dart';
import 'api_service.dart';
import 'hitos_mensuales.dart';
import 'hitos_diarios.dart';
import 'planta_service.dart';


class Hitos extends StatefulWidget {
  const Hitos({super.key});

  @override
  State<Hitos> createState() => _HitosState();
}

class _HitosState extends State<Hitos> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');

  bool? humedadSueloCumplida;
  String mensajeHumedadSuelo = "";

  bool? humedadAmbienteCumplida;
  String mensajeHumedadAmbiente = "";

  bool? luzCumplida;
  String mensajeLuz = "";

  bool? temperaturaCumplida;
  String mensajeTemperatura = "";

  bool? cambioTierraCumplida;
  String mensajeCambioTierra = "";

  bool? fertilizanteCumplido;
  String mensajeFertilizante = "";

  int _currentIndex = 1;

  String plantName = '';

  bool mostrarHitoHumedadSuelo = true;
  bool mostrarHitoHumedadAmbiente = true;
  bool mostrarHitoLuz = true;
  bool mostrarHitoTemperatura = true;
  bool mostrarHitoCambioTierra = true;
  bool mostrarHitoFertilizante = true;

  @override
  void initState() {
    super.initState();
    _verificarConexionInicial();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        mensajeHumedadSuelo = S.of(context).loadingMessage;
        mensajeHumedadAmbiente = S.of(context).loadingMessage;
        mensajeLuz = S.of(context).loadingMessage;
        mensajeTemperatura = S.of(context).loadingMessage;
        mensajeCambioTierra = S.of(context).loadingMessage;
        mensajeFertilizante = S.of(context).loadingMessage;
      });
    });
  }

  Future<void> _verificarConexionInicial() async {
    try {
      final response = await apiService.get('Plantas/All/Active');

      if (!mounted) return;

      if (response != null) {
        await cargarPreferenciasHitos();
        await cargarNombreYDatos();
      } else {
        await mostrarDialogoErrorConexion(context);
      }
    } catch (e) {
      if (!mounted) return;
      await mostrarDialogoErrorConexion(context);
    }
  }

  Future<void> cargarNombreYDatos() async {
    final nombre = await PlantaService.obtenerNombrePlantaActiva();

    if (!mounted) return;

    if (nombre != null && nombre.isNotEmpty) {
      setState(() {
        plantName = nombre;
      });
      await fetchHitos();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> cargarPreferenciasHitos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      mostrarHitoHumedadSuelo = prefs.getBool('mostrarHitoHumedadSuelo') ?? true;
      mostrarHitoHumedadAmbiente = prefs.getBool('mostrarHitoHumedadAmbiente') ?? true;
      mostrarHitoLuz = prefs.getBool('mostrarHitoLuz') ?? true;
      mostrarHitoTemperatura = prefs.getBool('mostrarHitoTemperatura') ?? true;
      mostrarHitoCambioTierra = prefs.getBool('mostrarHitoCambioTierra') ?? true;
      mostrarHitoFertilizante = prefs.getBool('mostrarHitoFertilizante') ?? true;
    });
  }

  Future<void> fetchHitos() async {
    try {
      String endpointSensores =
          'RegistrosSensores/Avg/FromPlant/AgroupByIntervals/ToGraph?np=$plantName&d=1&ff=${DateTime.now()}';
      String endpointRangos = 'Consejos/Plantas/All/FromPlant?np=$plantName';

      final datosSensores = await apiService.get(endpointSensores);
      final datosRangos = await apiService.get(endpointRangos);

      if (!mounted) return;

      if (datosSensores != null && datosRangos != null) {
        setState(() {
          double humedadSuelo = datosSensores['MACETA']['HUMEDAD']['lista_valores_medios'].last.toDouble();
          double humedadAmbiente = datosSensores['AMBIENTE']['HUMEDAD']['lista_valores_medios'].last.toDouble();
          double luz = datosSensores['AMBIENTE']['LUMINOSIDAD']['lista_valores_medios'].last.toDouble();
          double temperatura = datosSensores['AMBIENTE']['TEMPERATURA']['lista_valores_medios'].last.toDouble();

          double minHumedadSuelo = 40.0, maxHumedadSuelo = 70.0;
          double minHumedadAmbiente = 30.0, maxHumedadAmbiente = 60.0;
          double minLuz = 60.0, maxLuz = 90.0;
          double minTemperatura = 10.0, maxTemperatura = 25.0;

          for (var item in datosRangos) {
            if (item['tipo_medida']['tipo'] == 'HUMEDAD' && item['zona_consejo']['tipo'] == 'SUELO') {
              minHumedadSuelo = double.tryParse(item['valor_minimo']) ?? minHumedadSuelo;
              maxHumedadSuelo = double.tryParse(item['valor_maximo']) ?? maxHumedadSuelo;
            }
            if (item['tipo_medida']['tipo'] == 'HUMEDAD' && item['zona_consejo']['tipo'] == 'AMBIENTE') {
              minHumedadAmbiente = double.tryParse(item['valor_minimo']) ?? minHumedadAmbiente;
              maxHumedadAmbiente = double.tryParse(item['valor_maximo']) ?? maxHumedadAmbiente;
            }
            if (item['tipo_medida']['tipo'] == 'LUMINOSIDAD') {
              minLuz = double.tryParse(item['valor_minimo']) ?? minLuz;
              maxLuz = double.tryParse(item['valor_maximo']) ?? maxLuz;
            }
            if (item['tipo_medida']['tipo'] == 'TEMPERATURA') {
              minTemperatura = double.tryParse(item['valor_minimo']) ?? minTemperatura;
              maxTemperatura = double.tryParse(item['valor_maximo']) ?? maxTemperatura;
            }
          }

          // HUMEDAD SUELO
          if (humedadSuelo < minHumedadSuelo) {
            humedadSueloCumplida = false;
            mensajeHumedadSuelo = S.of(context).soilMoistureLow;
          } else if (humedadSuelo > maxHumedadSuelo) {
            humedadSueloCumplida = false;
            mensajeHumedadSuelo = S.of(context).soilMoistureHigh;
          } else {
            humedadSueloCumplida = true;
            mensajeHumedadSuelo = S.of(context).soilMoistureOptimal;
          }

          // HUMEDAD AMBIENTE
          if (humedadAmbiente < minHumedadAmbiente) {
            humedadAmbienteCumplida = false;
            mensajeHumedadAmbiente = S.of(context).airHumidityLow;
          } else if (humedadAmbiente > maxHumedadAmbiente) {
            humedadAmbienteCumplida = false;
            mensajeHumedadAmbiente = S.of(context).airHumidityHigh;
          } else {
            humedadAmbienteCumplida = true;
            mensajeHumedadAmbiente = S.of(context).airHumidityOptimal;
          }

          // LUMINOSIDAD
          if (luz < minLuz) {
            luzCumplida = false;
            mensajeLuz = S.of(context).lightLow;
          } else if (luz > maxLuz) {
            luzCumplida = false;
            mensajeLuz = S.of(context).lightHigh;
          } else {
            luzCumplida = true;
            mensajeLuz = S.of(context).lightOptimal;
          }

          // TEMPERATURA
          if (temperatura < minTemperatura) {
            temperaturaCumplida = false;
            mensajeTemperatura = S.of(context).temperatureLow;
          } else if (temperatura > maxTemperatura) {
            temperaturaCumplida = false;
            mensajeTemperatura = S.of(context).temperatureHigh;
          } else {
            temperaturaCumplida = true;
            mensajeTemperatura = S.of(context).temperatureOptimal;
          }
        });
      } else {
        throw Exception('Datos nulos o incompletos'); // Forzamos la excepción para ir al catch
      }
    } catch (e) {
      if (!mounted) return;
      await mostrarDialogoErrorConexion(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).milestonesTitle),
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView( // Permite hacer scroll si hay muchos hitos
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                S.of(context).milestonesProgress,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              ExpansionTile(
                title: Text(
                  S.of(context).dailyMilestones,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                children: [
                  if (mostrarHitoHumedadSuelo)
                    buildHitoCard(context, mensajeHumedadSuelo, humedadSueloCumplida, Icons.water_drop),
                  if (mostrarHitoHumedadAmbiente)
                    buildHitoCard(context, mensajeHumedadAmbiente, humedadAmbienteCumplida, Icons.water_drop),
                  if (mostrarHitoLuz)
                    buildHitoCard(context, mensajeLuz, luzCumplida, Icons.wb_sunny),
                  if (mostrarHitoTemperatura)
                    buildHitoCard(context, mensajeTemperatura, temperaturaCumplida, Icons.thermostat),
                ],
              ),

              ExpansionTile(
                title: Text(
                  S.of(context).monthlyMilestones,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                children: [
                  if (mostrarHitoCambioTierra)
                    buildHitoCardTierra(
                      cumplido: cambioTierraCumplida,
                      icono: Icons.grass,
                      isCambioTierra: true,
                      onEstadoCambioTierraActualizado: (cumplido) {
                        setState(() {
                          cambioTierraCumplida = cumplido;
                        });
                      },
                    ),
                  if (mostrarHitoFertilizante)
                    buildHitoCardFertilizante(
                      cumplido: fertilizanteCumplido,
                      icono: Icons.local_florist,
                      isFertilizante: true,
                      onEstadoFertilizanteActualizado: (cumplido) {
                        setState(() {
                          fertilizanteCumplido = cumplido;
                        });
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationCustom(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
