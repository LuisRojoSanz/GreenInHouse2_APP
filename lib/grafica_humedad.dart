import 'package:flutter/material.dart';
import 'package:greeninhouse2/dialogos_excepciones.dart';
import 'package:greeninhouse2/planta_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'api_service.dart';
import 'generated/l10n.dart';

/// Widget `HumidityGraph` que representa la pantalla que muestra un gráfico interactivo
/// con la evolución de la humedad del suelo de una planta, permitiendo al usuario
/// visualizar datos históricos y ajustar el rango de días para los cuales se muestran los datos.
class HumidityGraph extends StatefulWidget {
  const HumidityGraph({super.key});

  @override
  HumidityGraphState createState() => HumidityGraphState();
}

/// Estado del widget `HumidityGraph`, responsable de obtener los datos históricos de humedad
/// desde una API y gestionar la visualización del gráfico interactivo.
///
/// Atributos creados:
/// - `humidityData`: lista de objetos `HumidityData` con fecha y valor de humedad.
/// - `plantName`: nombre de la planta activa obtenido desde SharedPreferences.
/// - `daysBack`: número de días atrás desde la fecha actual para obtener datos.
/// - `selectedTime`: hora actual utilizada para formatear la fecha final.
/// - `showGraph`: booleano que controla si el gráfico se muestra o no.
/// - `daysController`: controlador de texto para el número de días atrás.
/// - `optimalMin`, `optimalMax`: valores de humedad óptimos definidos por los consejos.
/// - `isLoading`: controla el estado de carga de la interfaz.
///
/// Además, el gráfico utiliza colores para mostrar visualmente en qué zonas
/// se encuentran los valores.
///
/// Se incluye una representación visual con `SfCartesianChart` y una selección
/// de días mediante `ListWheelScrollView`.
class HumidityGraphState extends State<HumidityGraph> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');
  List<HumidityData> humidityData = [];
  String plantName = '';
  int daysBack = 1;
  DateTime selectedTime = DateTime.now();
  bool showGraph = false;
  final TextEditingController daysController = TextEditingController(text: "1");

  double optimalMin = 15.0;
  double optimalMax = 30.0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    cargarNombre();
  }

  /// Obtiene el nombre de la planta activa y luego carga los datos del sensor
  /// y los rangos óptimos.
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

  /// Recupera los datos de humedad desde la API y los filtra por la fecha de plantación.
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

      if (data != null && data['MACETA'] != null && data['MACETA']['HUMEDAD'] != null) {
        List<dynamic> fechas = data['MACETA']['HUMEDAD']['lista_fechas_largas'];
        List<dynamic> valores = data['MACETA']['HUMEDAD']['lista_valores_medios'];

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
      if (!mounted) return;
      await mostrarDialogoErrorConexion(context);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  /// Recupera los valores óptimos de humedad definidos por los consejos.
  ///
  /// @return Future<void>
  Future<void> fetchOptimalRanges() async {
    try {
      String endpoint = 'Consejos/Plantas/All/FromPlant?np=$plantName';
      final data = await apiService.get(endpoint);
      if (!mounted) return;

      if (data != null && data is List) {
        for (var item in data) {
          if (item['descripcion'] == 'Humedad de suelo optima.' &&
              item['tipo_medida']['tipo'] == 'HUMEDAD') {
            setState(() {
              optimalMin = double.tryParse(item['valor_minimo']) ?? 15.0;
              optimalMax = double.tryParse(item['valor_maximo']) ?? 30.0;
            });
          }
        }
      } else {
        throw Exception('Datos nulos o incompletos'); // Forzamos la excepción para ir al catch
      }
    } catch (e) {
      if (!mounted) return;
      await mostrarDialogoErrorConexion(context);
    }
  }

  /// Devuelve la imagen correspondiente según el valor de humedad.
  ///
  /// @param value Valor de humedad actual
  /// @return Widget con la imagen que representa el estado (enfadado, serio o feliz)
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

  /// Construye el widget principal que contiene el gráfico interactivo y controles.
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
              Text(S.of(context).humiditySensor),
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
                      PlotBand(start: 0, end: optimalMin - 10, color: const Color(0xFFFCBBBB).withOpacity(0.3)),
                      PlotBand(start: optimalMin - 10, end: optimalMin, color: const Color(0xFFFFF59D).withOpacity(0.3)),
                      PlotBand(start: optimalMin, end: optimalMax, color: const Color(0xFFB9F6CA).withOpacity(0.3)),
                      PlotBand(start: optimalMax, end: optimalMax + 10, color: const Color(0xFFFFF59D).withOpacity(0.3)),
                      PlotBand(start: optimalMax + 10, end: 100, color: const Color(0xFFFCBBBB).withOpacity(0.3)),
                    ],
                  ),
                  series: <ChartSeries>[
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
///
/// Atributos:
/// - `dateTime`: fecha y hora del dato.
/// - `value`: valor numérico de la humedad.
class HumidityData {
  final DateTime dateTime;
  final double value;
  HumidityData({required this.dateTime, required this.value});
}
