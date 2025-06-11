import 'package:flutter/material.dart';
import 'package:greeninhouse2/dialogos_excepciones.dart';
import 'package:greeninhouse2/generated/l10n.dart';
import 'package:greeninhouse2/planta_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'api_service.dart';

/// Widget `TemperatureGraph` que representa la pantalla que muestra un gráfico interactivo
/// con la evolución de la temperatura de una planta, permitiendo al usuario visualizar
/// los datos históricos y ajustar el rango de días para los cuales se muestran los datos.
class TemperatureGraph extends StatefulWidget {
  const TemperatureGraph({super.key});

  @override
  TemperatureGraphState createState() => TemperatureGraphState();
}

/// Estado del widget `TemperatureGraph`, encargado de obtener los datos históricos de temperatura
/// desde una API y gestionar la visualización del gráfico interactivo.
///
/// Atributos creados:
/// - `temperatureData`: Lista de datos históricos de temperatura.
/// - `plantName`: Nombre de la planta activa.
/// - `daysBack`: Número de días para la visualización de datos.
/// - `selectedTime`: Fecha y hora seleccionadas.
/// - `daysController`: controlador de texto para el número de días atrás.
/// - `showGraph`: Controla la visibilidad del gráfico.
/// - `optimalMin`, `optimalMax`: valores de temperatura óptimos definidos por los consejos.
/// - `isLoading`: Estado de la carga de los datos.
///
/// Además, el gráfico utiliza colores para mostrar visualmente en qué zonas
/// se encuentran los valores.
///
/// Se incluye una representación visual con `SfCartesianChart` y una selección
/// de días mediante `ListWheelScrollView`.
class TemperatureGraphState extends State<TemperatureGraph> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');
  List<TemperatureData> temperatureData = [];
  String plantName = '';
  int daysBack = 1;
  DateTime selectedTime = DateTime.now();
  bool showGraph = false;
  bool isLoading = false;

  final TextEditingController daysController = TextEditingController(text: "1");

  double optimalMin = 10.0;
  double optimalMax = 35.0;

  @override
  void initState() {
    super.initState();
    cargarNombre();
  }

  /// Obtiene el nombre de la planta activa y carga los datos del sensor y los rangos óptimos.
  ///
  /// @return Future<void>
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

  /// Recupera los datos de temperatura ambiental desde la API y los filtra según la fecha de plantación.
  ///
  /// @return Future<void>
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

      if (data != null && data['AMBIENTE'] != null && data['AMBIENTE']['TEMPERATURA'] != null) {
        List<dynamic> fechas = data['AMBIENTE']['TEMPERATURA']['lista_fechas_largas'];
        List<dynamic> valores = data['AMBIENTE']['TEMPERATURA']['lista_valores_medios'];

        final List<TemperatureData> filtrados = [];

        for (int i = 0; i < fechas.length; i++) {
          final date = DateTime.parse(fechas[i]);

          if (fechaPlantacion == null || date.isAfter(fechaPlantacion)) {
            double rawValue = valores[i].toDouble();
            double clampedValue = rawValue.clamp(0.0, 40.0);
            filtrados.add(TemperatureData(dateTime: date, value: clampedValue));
          }
        }

        setState(() {
          temperatureData = filtrados..sort((a, b) => a.dateTime.compareTo(b.dateTime));
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


  /// Recupera los valores óptimos de temperatura ambiental definidos por los
  /// consejos de la planta.
  ///
  /// @return Future<void>
  Future<void> fetchOptimalRanges() async {
    try {
      String endpoint = 'Consejos/Plantas/All/FromPlant?np=$plantName';
      final data = await apiService.get(endpoint);
      if (!mounted) return;

      if (data != null && data is List) {
        for (var item in data) {
          if (item['descripcion'] == 'Temperatura de ambiente optima.' &&
              item['tipo_medida']['tipo'] == 'TEMPERATURA') {
            setState(() {
              optimalMin = double.tryParse(item['valor_minimo']) ?? 10.0;
              optimalMax = double.tryParse(item['valor_maximo']) ?? 35.0;
            });
          }
        }
      } else {
        throw Exception('Datos nulos o incompletos'); // Forzamos la excepción para ir al catch
      }
    } catch (e) {
      if (mounted) {
        await mostrarDialogoErrorConexion(context);
      }
    }
  }

  /// Devuelve la imagen correspondiente según el valor de temperatura actual.
  ///
  /// @param value Valor de temperatura
  /// @return Widget con la imagen (enfadado, serio o feliz)
  Widget getFaceImage(double value) {
    double lowerSeriousLimit = optimalMin - 5;
    double upperSeriousLimit = optimalMax + 5;

    if (value <= lowerSeriousLimit || value >= upperSeriousLimit) {
      return Image.asset('assets/cara_enfadada.png', width: 32, height: 32);
    } else if ((value > lowerSeriousLimit && value < optimalMin) ||
        (value > optimalMax && value < upperSeriousLimit)) {
      return Image.asset('assets/cara_seria.png', width: 32, height: 32);
    } else {
      return Image.asset('assets/cara_sonriente.png', width: 32, height: 32);
    }
  }

  /// Muestra un selector de días para elegir cuántos días atrás ver en el gráfico.
  ///
  /// @param context Contexto de la aplicación
  /// @return Future<void>
  Future<void> _showDayPicker(BuildContext context) async {
    int selectedDay = daysBack;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(S.of(context).selectDays, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 40,
                  perspective: 0.005,
                  physics: const FixedExtentScrollPhysics(),
                  controller: FixedExtentScrollController(initialItem: selectedDay - 1),
                  onSelectedItemChanged: (index) {
                    selectedDay = index + 1;
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return Center(
                        child: Text(
                          S.of(context).daysCount(index + 1),
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
                    childCount: 30,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    daysBack = selectedDay;
                  });
                  Navigator.pop(context);
                },
                child: Text(S.of(context).accept),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Construye el widget principal que contiene el gráfico interactivo y los controles.
  ///
  /// @param context Contexto de la aplicación
  /// @return Widget
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).temperatureSensor),
              getFaceImage(temperatureData.isNotEmpty ? temperatureData.last.value : 0),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(S.of(context).daysBack),
                        TextButton(
                          onPressed: () => _showDayPicker(context),
                          child: Text(
                            S.of(context).daysCount(daysBack),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    : temperatureData.isEmpty
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
                    title: AxisTitle(text: S.of(context).degrees),
                    minimum: 0,
                    maximum: 40,
                    interval: 5,
                    plotBands: <PlotBand>[
                      PlotBand(start: 0, end: optimalMin - 4, color: const Color(0xFFFCBBBB).withOpacity(0.3)),
                      PlotBand(start: optimalMin - 4, end: optimalMin, color: const Color(0xFFFFF59D).withOpacity(0.3)),
                      PlotBand(start: optimalMin, end: optimalMax, color: const Color(0xFFB9F6CA).withOpacity(0.3)),
                      PlotBand(start: optimalMax, end: optimalMax + 4, color: const Color(0xFFFFF59D).withOpacity(0.3)),
                      PlotBand(start: optimalMax + 4, end: 40, color: const Color(0xFFFCBBBB).withOpacity(0.3)),
                    ],
                  ),
                  series: <ChartSeries>[
                    LineSeries<TemperatureData, DateTime>(
                      dataSource: temperatureData,
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

/// Representa un punto de datos con la temperatura medida y su correspondiente fecha.
///
/// Atributos:
/// - `dateTime`: Fecha y hora del dato.
/// - `value`: Valor numérico de la temperatura.
class TemperatureData {
  final DateTime dateTime;
  final double value;
  TemperatureData({required this.dateTime, required this.value});
}
