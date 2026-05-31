import 'package:flutter/material.dart';
import 'package:greeninhouse2/dialogos_excepciones.dart';
import 'package:greeninhouse2/generated/l10n.dart';
import 'package:greeninhouse2/planta_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'api_service.dart';

/// Widget `HumidityGraphAM` que representa la pantalla que muestra un gráfico interactivo
/// con la evolución de la humedad ambiental de una planta, permitiendo al usuario
/// visualizar los datos históricos y ajustar el rango de días para los cuales se muestran los datos.
class HumidityGraphAM extends StatefulWidget {
  const HumidityGraphAM({super.key});

  @override
  HumidityGraphAMState createState() => HumidityGraphAMState();
}

/// Estado del widget `HumidityGraphAM`, encargado de obtener los datos históricos de humedad ambiental
/// desde una API y gestionar la visualización del gráfico interactivo.
///
class HumidityGraphAMState extends State<HumidityGraphAM> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');
  List<HumidityData> humidityData = [];
  String plantName = '';
  int daysBack = 1;
  DateTime selectedTime = DateTime.now();
  bool showGraph = false;
  bool isLoading = false;

  final TextEditingController daysController = TextEditingController(text: "1");

  double optimalMin = 15.0;
  double optimalMax = 30.0;

  @override
  void initState() {
    super.initState();
    cargarNombre();
  }

  /// Obtiene el nombre de la planta activa y carga los datos del sensor y los rangos óptimos.
  Future<void> cargarNombre() async {
    final nombre = await PlantaService.obtenerNombrePlantaActiva();
    setState(() {
      plantName = nombre ?? '';
      isLoading = true;
    });

    if (plantName.isNotEmpty) {
      await fetchSensorData();
      await fetchOptimalRanges();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Recupera los datos de humedad ambiental desde la API y los filtra según
  /// la fecha de plantación.
  Future<void> fetchSensorData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final DateTime? fechaPlantacion = await PlantaService.obtenerFechaPlantacion();

      String endDateStr = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      String endpoint =
          'RegistrosSensores/Avg/FromPlant/AgroupByIntervals/ToGraph?np=$plantName&d=$daysBack&ff=$endDateStr';

      final data = await apiService.get(endpoint);
      if (!mounted) return;

      if (data != null && data['HUMEDAD'] != null && data['HUMEDAD']['AMBIENTE'] != null) {
        List<dynamic> fechas = data['HUMEDAD']['AMBIENTE']['lista_fechas_largas'];
        List<dynamic> valores = data['HUMEDAD']['AMBIENTE']['lista_valores_medios'];

        final List<HumidityData> filtrados = [];

        for (int i = 0; i < fechas.length; i++) {
          final date = DateTime.parse(fechas[i]);

          if (fechaPlantacion == null || date.isAfter(fechaPlantacion)) {
            double rawValue = valores[i].toDouble();
            double clampedValue = rawValue.clamp(0.0, 100.0);
            filtrados.add(HumidityData(dateTime: date, value: clampedValue));
          }
        }

        setState(() {
          humidityData = filtrados..sort((a, b) => a.dateTime.compareTo(b.dateTime));
        });
      } else {
        throw Exception('Datos nulos o incompletos');
      }
    } catch (e) {
      if (mounted) {
        await mostrarDialogoErrorConexion(context);
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  /// Recupera los valores óptimos de humedad ambiental definidos por los consejos de la planta.
  Future<void> fetchOptimalRanges() async {
    try {
      String endpoint = 'Consejos/Plantas/All/FromPlant?np=$plantName';
      final data = await apiService.get(endpoint);
      if (!mounted) return;

      if (data != null && data is List) {
        for (var item in data) {
          if (item['descripcion'] == 'Humedad de ambiente optima.' &&
              item['tipo_medida']['tipo'] == 'HUMEDAD') {
            setState(() {
              optimalMin = double.tryParse(item['valor_minimo']) ?? 15.0;
              optimalMax = double.tryParse(item['valor_maximo']) ?? 30.0;
            });
          }
        }
      } else {
        throw Exception('Datos nulos o incompletos');
      }
    } catch (e) {
      if (mounted) {
        await mostrarDialogoErrorConexion(context);
      }
    }
  }

  /// Devuelve la imagen correspondiente según el valor de humedad actual.
  Widget getFaceImage(double value) {
    double lowerSeriousLimit = optimalMin - 15;
    double upperSeriousLimit = optimalMax + 15;

    if (value <= lowerSeriousLimit || value >= upperSeriousLimit) {
      return Image.asset('assets/cara_enfadada.png', width: 32, height: 32);
    } else if ((value > lowerSeriousLimit && value < optimalMin) ||
        (value > optimalMax && value < upperSeriousLimit)) {
      return Image.asset('assets/cara_seria.png', width: 32, height: 32);
    } else {
      return Image.asset('assets/cara_sonriente.png', width: 32, height: 32);
    }
  }

  /// Nuevo selector de fecha con calendario
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: daysBack)),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      helpText: S.of(context).selectDays,
      cancelText: S.of(context).cancel,
      confirmText: S.of(context).accept,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.green[50],),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && mounted) {
      setState(() {
        daysBack = DateTime.now().difference(picked).inDays + 1;
      });
    }
  }

  /// Construye el widget principal que contiene el gráfico interactivo y los controles.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).ambienthumiditySensor),
              getFaceImage(humidityData.isNotEmpty ? humidityData.last.value : 0),
            ],
          ),
          trailing: IconButton(
            icon: Icon(showGraph ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            onPressed: () {
              setState(() {
                showGraph = !showGraph;
              });
            },
          ),
        ),
        if (showGraph)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Row con selector de fecha usando calendario
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(S.of(context).selectDays),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () => _selectDate(context),
                          icon: const Icon(Icons.calendar_today, size: 18),
                          label: Text(
                            DateFormat('dd/MM/yyyy').format(
                              DateTime.now().subtract(Duration(days: daysBack - 1)),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade400,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: isLoading ? null : fetchSensorData,
                      child: Text(S.of(context).updateGraph),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : humidityData.isEmpty
                    ? Center(child: Text(S.of(context).noData))
                    : SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    title: AxisTitle(text: S.of(context).dateTimeAxis),
                    dateFormat: DateFormat('EEE dd/MM HH:mm'),
                    intervalType: DateTimeIntervalType.hours,
                    labelRotation: -45,
                    labelIntersectAction: AxisLabelIntersectAction.rotate45,
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: S.of(context).percentageAxis),
                    minimum: 0,
                    maximum: 100,
                    interval: 10,
                    plotBands: <PlotBand>[
                      PlotBand(start: 0, end: optimalMin - 10, color: const Color(0xFFFCBBBB).withAlpha((0.7 * 255).round())),
                      PlotBand(start: optimalMin - 10, end: optimalMin, color: const Color(0xFFFFF59D).withAlpha((0.7 * 255).round())),
                      PlotBand(start: optimalMin, end: optimalMax, color: const Color(0xFFB9F6CA).withAlpha((0.7 * 255).round())),
                      PlotBand(start: optimalMax, end: optimalMax + 10, color: const Color(0xFFFFF59D).withAlpha((0.7 * 255).round())),
                      PlotBand(start: optimalMax + 10, end: 100, color: const Color(0xFFFCBBBB).withAlpha((0.7 * 255).round())),

                    ],
                  ),
                  series: <CartesianSeries>[
                    LineSeries<HumidityData, DateTime>(
                      dataSource: humidityData,
                      xValueMapper: (data, _) => data.dateTime,
                      yValueMapper: (data, _) => data.value,
                      markerSettings: const MarkerSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}

/// Representa un punto de datos con la humedad medida y su correspondiente fecha.
class HumidityData {
  final DateTime dateTime;
  final double value;
  HumidityData({required this.dateTime, required this.value});
}
