import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'api_service.dart';

class TemperatureGraph extends StatefulWidget {
  const TemperatureGraph({super.key});

  @override
  TemperatureGraphState createState() => TemperatureGraphState();
}

class TemperatureGraphState extends State<TemperatureGraph> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');
  List<TemperatureData> temperatureData = [];
  String plantName = "Mi tomatera";
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
    fetchSensorData();
    fetchOptimalRanges();
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

    if (data != null && data['AMBIENTE'] != null && data['AMBIENTE']['TEMPERATURA'] != null) {
      List<dynamic> fechas = data['AMBIENTE']['TEMPERATURA']['lista_fechas_largas'];
      List<dynamic> valores = data['AMBIENTE']['TEMPERATURA']['lista_valores_medios'];

      setState(() {
        temperatureData = List.generate(fechas.length, (index) {
          double rawValue = valores[index].toDouble();
          double clampedValue = rawValue.clamp(0.0, 40.0);
          return TemperatureData(
            dateTime: DateTime.parse(fechas[index]),
            value: clampedValue,
          );
        });

        temperatureData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
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
        if (item['descripcion'] == 'Temperatura de ambiente optima.' &&
            item['tipo_medida']['tipo'] == 'TEMPERATURA') {
          setState(() {
            optimalMin = double.tryParse(item['valor_minimo']) ?? 10.0;
            optimalMax = double.tryParse(item['valor_maximo']) ?? 35.0;
          });
        }
      }
    }
  }

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
              const Text("SENSOR TEMPERATURA"),
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
                    : temperatureData.isEmpty
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
                    title: AxisTitle(text: 'Temperatura (ºC)'),
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

class TemperatureData {
  final DateTime dateTime;
  final double value;
  TemperatureData({required this.dateTime, required this.value});
}
