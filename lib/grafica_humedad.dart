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

  Widget getFaceImage(double value) {
    if (value <= 10) {
      return Image.asset('assets/cara_enfadada.png', width: 32, height: 32);
    } else if (value > 10 && value <= 15) {
      return Image.asset('assets/cara_seria.png', width: 32, height: 32);
    } else if (value > 15 && value <= 30) {
      return Image.asset('assets/cara_sonriente.png', width: 32, height: 32);
    } else if (value > 30 && value <= 35) {
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
                    maximum: 60,
                    interval: 10,
                    plotBands: <PlotBand>[
                      PlotBand(start: 0, end: 10, color: const Color(0xFFFCBBBB).withOpacity(0.3)), // Rojo
                      PlotBand(start: 10, end: 15, color: const Color(0xFFFFF59D).withOpacity(0.3)), // Amarillo
                      PlotBand(start: 15, end: 30, color: const Color(0xFFB9F6CA).withOpacity(0.3)), // Verde
                      PlotBand(start: 30, end: 35, color: const Color(0xFFFFF59D).withOpacity(0.3)), // Amarillo
                      PlotBand(start: 35, end: 60, color: const Color(0xFFFCBBBB).withOpacity(0.3)), // Rojo
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
