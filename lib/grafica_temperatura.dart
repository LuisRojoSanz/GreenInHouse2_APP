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
  final TextEditingController daysController = TextEditingController(text: "1");

  @override
  void initState() {
    super.initState();
    fetchSensorData();
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

        temperatureData = List.generate(fechas.length, (index) {
          return TemperatureData(
            dateTime: DateTime.parse(fechas[index]),
            value: valores[index].toDouble(),
          );
        });

        temperatureData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      });
    }
  }

  Widget getFaceImage(double value) {
    if (value <= 10) {
      return Image.asset('assets/cara_enfadada.png', width: 32, height: 32);
    } else if (value > 10 && value <= 15) {
      return Image.asset('assets/cara_seria.png', width: 32, height: 32);
    } else if (value > 15 && value <= 25) {
      return Image.asset('assets/cara_sonriente.png', width: 32, height: 32);
    } else if (value > 25 && value <= 30) {
      return Image.asset('assets/cara_seria.png', width: 32, height: 32);
    } else {
      return Image.asset('assets/cara_enfadada.png', width: 32, height: 32);
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
                        const Text("Seleccionar Hora: "),
                        TextButton(
                          onPressed: pickTime,
                          child: Text(
                            DateFormat('HH:mm').format(selectedTime),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Días atrás: "),
                        SizedBox(
                          width: 60,
                          child: TextField(
                            controller: daysController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(border: OutlineInputBorder()),
                            onChanged: (value) {
                              setState(() {
                                daysBack = int.tryParse(value) ?? 1;
                              });
                            },
                          ),
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
                child: temperatureData.isEmpty
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
                    title: AxisTitle(text: 'Temperatura (ºC)'),
                    minimum: 0,
                    maximum: 40,
                    interval: 5,
                    plotBands: <PlotBand>[
                      PlotBand(start: 0, end: 10, color: const Color(0xFFFCBBBB).withOpacity(0.3)),
                      PlotBand(start: 10, end: 15, color: const Color(0xFFFFF59D).withOpacity(0.3)),
                      PlotBand(start: 15, end: 25, color: const Color(0xFFB9F6CA).withOpacity(0.3)),
                      PlotBand(start: 25, end: 30, color: const Color(0xFFFFF59D).withOpacity(0.3)),
                      PlotBand(start: 30, end: 40, color: const Color(0xFFFCBBBB).withOpacity(0.3)),
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
