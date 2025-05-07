import 'package:flutter/material.dart';
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
  String mensajeHumedadSuelo = "Cargando...";

  bool? humedadAmbienteCumplida;
  String mensajeHumedadAmbiente = "Cargando...";

  bool? luzCumplida;
  String mensajeLuz = "Cargando...";

  bool? temperaturaCumplida;
  String mensajeTemperatura = "Cargando...";

  bool? cambioTierraCumplida;
  String mensajeCambioTierra = "Cargando...";

  bool? fertilizanteCumplido;
  String mensajeFertilizante = "Cargando...";

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
    cargarPreferenciasHitos();
    cargarNombreYDatos();
  }

  Future<void> cargarNombreYDatos() async {
    final nombre = await PlantaService.obtenerNombrePlantaActiva();
    if (!mounted) return;

    setState(() {
      plantName = nombre ?? '';
    });

    if (plantName.isNotEmpty) {
      await fetchHitos();
      verificarCambioTierra((cumplido, mensaje) {
        setState(() {
          cambioTierraCumplida = cumplido;
          mensajeCambioTierra = mensaje;
        });
      });
      verificarFertilizante((cumplido, mensaje) {
        setState(() {
          fertilizanteCumplido = cumplido;
          mensajeFertilizante = mensaje;
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchHitos();
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

    String endpointSensores =
        'RegistrosSensores/Avg/FromPlant/AgroupByIntervals/ToGraph?np=$plantName&d=1&ff=${DateTime
        .now()}';
    String endpointRangos = 'Consejos/Plantas/All/FromPlant?np=$plantName';

    final datosSensores = await apiService.get(endpointSensores);
    final datosRangos = await apiService.get(endpointRangos);

    if (!mounted) return;

    if (datosSensores != null && datosRangos != null) {
      setState(() {
        double humedadSuelo = datosSensores['MACETA']['HUMEDAD']['lista_valores_medios']
            .last.toDouble();
        double humedadAmbiente = datosSensores['AMBIENTE']['HUMEDAD']['lista_valores_medios']
            .last.toDouble();
        double luz = datosSensores['AMBIENTE']['LUMINOSIDAD']['lista_valores_medios']
            .last.toDouble();
        double temperatura = datosSensores['AMBIENTE']['TEMPERATURA']['lista_valores_medios']
            .last.toDouble();

        double minHumedadSuelo = 40.0,
            maxHumedadSuelo = 70.0;
        double minHumedadAmbiente = 30.0,
            maxHumedadAmbiente = 60.0;
        double minLuz = 60.0,
            maxLuz = 90.0;
        double minTemperatura = 10.0,
            maxTemperatura = 25.0;

        for (var item in datosRangos) {
          if (item['tipo_medida']['tipo'] == 'HUMEDAD' &&
              item['zona_consejo']['tipo'] == 'SUELO') {
            minHumedadSuelo =
                double.tryParse(item['valor_minimo']) ?? minHumedadSuelo;
            maxHumedadSuelo =
                double.tryParse(item['valor_maximo']) ?? maxHumedadSuelo;
          }
          if (item['tipo_medida']['tipo'] == 'HUMEDAD' &&
              item['zona_consejo']['tipo'] == 'AMBIENTE') {
            minHumedadAmbiente =
                double.tryParse(item['valor_minimo']) ?? minHumedadAmbiente;
            maxHumedadAmbiente =
                double.tryParse(item['valor_maximo']) ?? maxHumedadAmbiente;
          }
          if (item['tipo_medida']['tipo'] == 'LUMINOSIDAD') {
            minLuz = double.tryParse(item['valor_minimo']) ?? minLuz;
            maxLuz = double.tryParse(item['valor_maximo']) ?? maxLuz;
          }
          if (item['tipo_medida']['tipo'] == 'TEMPERATURA') {
            minTemperatura =
                double.tryParse(item['valor_minimo']) ?? minTemperatura;
            maxTemperatura =
                double.tryParse(item['valor_maximo']) ?? maxTemperatura;
          }
        }
        // HUMEDAD SUELO
        if (humedadSuelo < minHumedadSuelo) {
          humedadSueloCumplida = false;
          mensajeHumedadSuelo = "Riega la planta, necesita más agua.";
        } else if (humedadSuelo > maxHumedadSuelo) {
          humedadSueloCumplida = false;
          mensajeHumedadSuelo =
          "No riegues más, el suelo está demasiado húmedo.";
        } else {
          humedadSueloCumplida = true;
          mensajeHumedadSuelo = "Humedad del suelo en rango óptimo.";
        }

        // HUMEDAD AMBIENTE
        if (humedadAmbiente < minHumedadAmbiente) {
          humedadAmbienteCumplida = false;
          mensajeHumedadAmbiente =
          "Aumenta la humedad del aire, pon un humidificador cerca.";
        } else if (humedadAmbiente > maxHumedadAmbiente) {
          humedadAmbienteCumplida = false;
          mensajeHumedadAmbiente = "Reduce la humedad, ventila el espacio.";
        } else {
          humedadAmbienteCumplida = true;
          mensajeHumedadAmbiente = "Humedad del ambiente en rango óptimo.";
        }

        // LUMINOSIDAD
        if (luz < minLuz) {
          luzCumplida = false;
          mensajeLuz =
          "La planta necesita más luz, colócala en un lugar más iluminado.";
        } else if (luz > maxLuz) {
          luzCumplida = false;
          mensajeLuz = "La planta recibe demasiada luz, ponla en sombra.";
        } else {
          luzCumplida = true;
          mensajeLuz = "Luminosidad en rango óptimo.";
        }

        // TEMPERATURA
        if (temperatura < minTemperatura) {
          temperaturaCumplida = false;
          mensajeTemperatura =
          "Hace demasiado frío, acerca la planta a un lugar más cálido.";
        } else if (temperatura > maxTemperatura) {
          temperaturaCumplida = false;
          mensajeTemperatura = "Hace demasiado calor, aleja la planta del sol.";
        } else {
          temperaturaCumplida = true;
          mensajeTemperatura = "Temperatura en rango óptimo.";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitos'),
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView( // Permite hacer scroll si hay muchos hitos
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text(
                "Progreso de Hitos",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              ExpansionTile(
                title: const Text("Hitos Diarios", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
                children: [
                  if (mostrarHitoHumedadSuelo)
                    buildHitoCard(mensajeHumedadSuelo, humedadSueloCumplida, Icons.water_drop),
                  if (mostrarHitoHumedadAmbiente)
                    buildHitoCard(mensajeHumedadAmbiente, humedadAmbienteCumplida, Icons.water_drop),
                  if (mostrarHitoLuz)
                    buildHitoCard(mensajeLuz, luzCumplida, Icons.wb_sunny),
                  if (mostrarHitoTemperatura)
                    buildHitoCard(mensajeTemperatura, temperaturaCumplida, Icons.thermostat),
                ],
              ),

              ExpansionTile(
                title: const Text("Hitos Mensuales", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
                children: [
                  if (mostrarHitoCambioTierra)
                    buildHitoCardTierra(
                      mensaje: mensajeCambioTierra,
                      cumplido: cambioTierraCumplida,
                      icono: Icons.grass,
                      isCambioTierra: true,
                      onEstadoCambioTierraActualizado: (cumplido, mensaje) {
                        setState(() {
                          cambioTierraCumplida = cumplido;
                          mensajeCambioTierra = mensaje;
                        });
                      },
                    ),
                  if (mostrarHitoFertilizante)
                    buildHitoCardFertilizante(
                      mensaje: mensajeFertilizante,
                      cumplido: fertilizanteCumplido,
                      icono: Icons.local_florist,
                      isFertilizante: true,
                      onEstadoFertilizanteActualizado: (cumplido, mensaje) {
                        setState(() {
                          fertilizanteCumplido = cumplido;
                          mensajeFertilizante = mensaje;
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
