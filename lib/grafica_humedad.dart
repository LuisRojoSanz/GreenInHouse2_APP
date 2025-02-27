import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'api_service.dart';

class HumidityGraph extends StatefulWidget {
  const HumidityGraph({super.key});

  @override
  HumidityGraphState createState() => HumidityGraphState();
}

class HumidityGraphState extends State<HumidityGraph> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');
  List<HumidityData> humidityData = [];
  String plantName = "Mi tomatera";
  int daysBack = 1;
  DateTime selectedTime = DateTime.now();
  bool showGraph = false;
  final TextEditingController daysController = TextEditingController(text: "1");

  double optimalMin = 15.0;
  double optimalMax = 30.0;

  @override
  void initState() {
    super.initState();
    fetchSensorData();
    fetchOptimalRanges();
  }

  Future<void> fetchSensorData() async {
    String endDateStr = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

    String endpoint =
        'RegistrosSensores/Avg/FromPlant/AgroupByIntervals/ToGraph?np=$plantName&d=$daysBack&ff=$endDateStr';

    final data = await apiService.get(endpoint);
    if (!mounted) return;

    if (data != null && data['MACETA'] != null && data['MACETA']['HUMEDAD'] != null) {
      setState(() {
        List<dynamic> fechas = data['MACETA']['HUMEDAD']['lista_fechas_cortas'];
        List<dynamic> valores = data['MACETA']['HUMEDAD']['lista_valores'];

        humidityData = List.generate(fechas.length, (index) {
          return HumidityData(
            dateTime: DateTime.parse(fechas[index]),
            value: valores[index].toDouble(),
          );
        });

        humidityData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      });
    }
  }

  Future<void> fetchOptimalRanges() async {
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

  Future<void> pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedTime),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = DateTime(
          selectedTime.year,
          selectedTime.month,
          selectedTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
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
              const Text("SENSOR HUMEDAD"),
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
                      onPressed: fetchSensorData,
                      child: const Text("Actualizar Gráfica"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: humidityData.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    title: AxisTitle(text: 'Fecha y Hora'),
                    dateFormat: DateFormat('EEE dd/MM HH:mm'),
                    intervalType: DateTimeIntervalType.hours,
                    labelRotation: -45,
                    labelIntersectAction: AxisLabelIntersectAction.rotate45,
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Porcentaje (%)'),
                    minimum: 0,
                    maximum: 100,
                    interval: 10,
                    plotBands: <PlotBand>[
                      PlotBand(start: 0, end: optimalMin - 15, color: const Color(0xFFFCBBBB).withOpacity(0.3),),
                      PlotBand(start: optimalMin - 15, end: optimalMin, color: const Color(0xFFFFF59D).withOpacity(0.3),),
                      PlotBand(start: optimalMin, end: optimalMax, color: const Color(0xFFB9F6CA).withOpacity(0.3),),
                      PlotBand(start: optimalMax, end: optimalMax + 15, color: const Color(0xFFFFF59D).withOpacity(0.3),),
                      PlotBand(start: optimalMax + 15, end: 100, color: const Color(0xFFFCBBBB).withOpacity(0.3),),
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

class HumidityData {
  final DateTime dateTime;
  final double value;
  HumidityData({required this.dateTime, required this.value});
}
