import 'package:flutter/material.dart';
import 'package:greeninhouse2/dialogos_excepciones.dart';
import 'package:greeninhouse2/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'botones_inicio.dart';
import 'api_service.dart';
import 'hitos_mensuales.dart';
import 'hitos_diarios.dart';
import 'planta_service.dart';

/// Widget `Hitos` que representa la pantalla que muestra los hitos diarios y mensuales
/// asociados al cuidado de la planta activa, como la humedad del suelo, la humedad del ambiente,
/// la luminosidad, la temperatura, el cambio de tierra y la fertilización.
/// Además, permite gestionar la visualización de estos hitos según las preferencias del usuario.
class Hitos extends StatefulWidget {
  const Hitos({super.key});

  @override
  State<Hitos> createState() => _HitosState();
}

/// Estado del widget `Hitos`, encargado de gestionar la obtención de datos y la visualización de hitos
/// diarios y mensuales relacionados con el cuidado de la planta. Los hitos incluyen mediciones como
/// la humedad del suelo, la humedad del ambiente, la luminosidad, la temperatura, el cambio de tierra
/// y la fertilización.
///
/// Atributos creados:
/// - `humedadSueloCumplida`: Indica si el hito de humedad del suelo se ha cumplido.
/// - `mensajeHumedadSuelo`: Mensaje asociado al estado del hito de humedad del suelo.
/// - `humedadAmbienteCumplida`: Indica si el hito de humedad ambiente se ha cumplido.
/// - `mensajeHumedadAmbiente`: Mensaje asociado al estado del hito de humedad ambiente.
/// - `luzCumplida`: Indica si el hito de luminosidad se ha cumplido.
/// - `mensajeLuz`: Mensaje asociado al estado del hito de luminosidad.
/// - `temperaturaCumplida`: Indica si el hito de temperatura se ha cumplido.
/// - `mensajeTemperatura`: Mensaje asociado al estado del hito de temperatura.
/// - `cambioTierraCumplida`: Indica si el hito de cambio de tierra se ha cumplido.
/// - `mensajeCambioTierra`: Mensaje asociado al estado del hito de cambio de tierra.
/// - `fertilizanteCumplido`: Indica si el hito de fertilizante se ha cumplido.
/// - `mensajeFertilizante`: Mensaje asociado al estado del hito de fertilizante.
/// - `_currentIndex`: Índice actual de la barra de navegación inferior.
/// - `plantName`: Nombre de la planta activa.
/// - `mostrarHitoHumedadSuelo`, `mostrarHitoHumedadAmbiente`, `mostrarHitoLuz`, `mostrarHitoTemperatura`,
///   `mostrarHitoCambioTierra`, `mostrarHitoFertilizante`: Controladores booleanos que indican si se deben mostrar o no los hitos en la interfaz.
///
/// La clase realiza varias peticiones a una API REST para obtener:
/// - Los datos de los sensores para cada tipo de hito (como humedad, temperatura, luz).
/// - Los rangos óptimos para cada tipo de medición, como la humedad del suelo,
/// humedad ambiente, luminosidad, etc.
///
/// Además, la clase maneja la carga de las preferencias del usuario para
/// determinar si los hitos deben mostrarse o no,
/// y si se han cumplido o no según los valores actuales obtenidos.
///
/// Los hitos se dividen en:
/// - Hitos diarios: Como humedad de suelo, humedad ambiente, luz y temperatura.
/// - Hitos mensuales: Como el cambio de tierra y fertilización.

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

  int _currentIndex = 2;

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

  /// Verifica la conexión inicial y carga las preferencias y datos si la conexión es exitosa.
  ///
  /// @return Future<void>
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

  /// Carga el nombre de la planta activa y obtiene los datos de los hitos.
  ///
  /// @return Future<void>
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

  /// Carga las preferencias de los hitos desde `SharedPreferences`.
  ///
  /// @return Future<void>
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

  /// Recupera los datos de los sensores y los rangos de los hitos para calcular el estado de cada hito.
  ///
  /// @return Future<void>
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


  /// Construye el widget principal que contiene la visualización de los hitos.
  ///
  /// @param context Contexto de la aplicación
  /// @return Widget
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
