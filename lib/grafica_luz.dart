import 'package:flutter/material.dart';
import 'package:greeninhouse2/planta_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'api_service.dart';

class LightGraph extends StatefulWidget {
  const LightGraph({super.key});

  @override
  LightGraphState createState() => LightGraphState();
}

class LightGraphState extends State<LightGraph> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');
  List<LightData> lightData = [];
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

  Future<void> fetchSensorData() async {
    setState(() {
      isLoading = true;
    });

    String endDateStr = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    String endpoint =
        'RegistrosSensores/Avg/FromPlant/AgroupByIntervals/ToGraph?np=$plantName&d=$daysBack&ff=$endDateStr';

    final data = await apiService.get(endpoint);
    if (!mounted) return;

    if (data != null && data['AMBIENTE'] != null && data['AMBIENTE']['LUMINOSIDAD'] != null) {
      List<dynamic> fechas = data['AMBIENTE']['LUMINOSIDAD']['lista_fechas_largas'];
      List<dynamic> valores = data['AMBIENTE']['LUMINOSIDAD']['lista_valores_medios'];

      setState(() {
        lightData = List.generate(fechas.length, (index) {
          double rawValue = valores[index].toDouble();
          double clampedValue = rawValue.clamp(0.0, 120.0);
          return LightData(
            dateTime: DateTime.parse(fechas[index]),
            value: clampedValue,
          );
        });

        lightData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchOptimalRanges() async {
    String endpoint = 'Consejos/Plantas/All/FromPlant?np=$plantName';
    final data = await apiService.get(endpoint);
    if (!mounted) return;

    if (data != null && data is List) {
      for (var item in data) {
        if (item['descripcion'] == 'Luminosidad de ambiente optima.' &&
            item['tipo_medida']['tipo'] == 'LUMINOSIDAD') {
          setState(() {
            optimalMin = double.tryParse(item['valor_minimo']) ?? 15.0;
            optimalMax = double.tryParse(item['valor_maximo']) ?? 30.0;
          });
        }
      }
    }
  }

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
              const Text("Selecciona los días", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                      return Center(child: Text("${index + 1} días", style: const TextStyle(fontSize: 16)));
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
                child: const Text("Aceptar"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("SENSOR LUZ"),
              getFaceImage(lightData.isNotEmpty ? lightData.last.value : 0),
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
                        const Text("Días atrás: "),
                        TextButton(
                          onPressed: () => _showDayPicker(context),
                          child: Text("$daysBack días",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: isLoading ? null : fetchSensorData,
                      child: const Text("Actualizar Gráfica"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : lightData.isEmpty
                    ? const Center(child: Text("No hay datos disponibles"))
                    : SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    title: AxisTitle(text: 'Fecha y Hora'),
                    dateFormat: DateFormat('EEE dd/MM HH:mm'),
                    intervalType: DateTimeIntervalType.hours,
                    labelRotation: -45,
                    labelIntersectAction: AxisLabelIntersectAction.rotate45,
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Lux'),
                    minimum: 0,
                    maximum: 120,
                    interval: 10,
                    plotBands: <PlotBand>[
                      PlotBand(start: 0, end: optimalMin - 12, color: const Color(0xFFFCBBBB).withOpacity(0.3)),
                      PlotBand(start: optimalMin - 12, end: optimalMin, color: const Color(0xFFFFF59D).withOpacity(0.3)),
                      PlotBand(start: optimalMin, end: optimalMax, color: const Color(0xFFB9F6CA).withOpacity(0.3)),
                      PlotBand(start: optimalMax, end: optimalMax + 12, color: const Color(0xFFFFF59D).withOpacity(0.3)),
                      PlotBand(start: optimalMax + 12, end: 120, color: const Color(0xFFFCBBBB).withOpacity(0.3)),
                    ],
                  ),
                  series: <ChartSeries>[
                    LineSeries<LightData, DateTime>(
                      dataSource: lightData,
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

class LightData {
  final DateTime dateTime;
  final double value;
  LightData({required this.dateTime, required this.value});
}
