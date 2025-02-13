import 'package:flutter/material.dart';
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
  String plantName = "Mi tomatera";
  int daysBack = 1; // Número de días hacia atrás ingresado por el usuario
  DateTime selectedTime = DateTime.now(); // Hora seleccionada manualmente
  bool showGraph = false;
  final TextEditingController daysController = TextEditingController(text: "1"); // Controlador para el input

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

    if (data != null && data['AMBIENTE'] != null && data['AMBIENTE']['LUMINOSIDAD'] != null) {
      setState(() {
        List<dynamic> fechas = data['AMBIENTE']['LUMINOSIDAD']['lista_fechas_cortas'];
        List<dynamic> valores = data['AMBIENTE']['LUMINOSIDAD']['lista_valores'];

        lightData = List.generate(fechas.length, (index) {
          return LightData(
            dateTime: DateTime.parse(fechas[index]),
            value: valores[index].toDouble(),
          );
        });

        lightData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
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
                child: lightData.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    title: AxisTitle(text: 'Fecha y Hora'),
                    dateFormat: DateFormat('EEE dd/MM HH:mm'), // Día + fecha + hora
                    intervalType: DateTimeIntervalType.hours, // Muestra cada ciertas horas
                    labelRotation: -45, // Rotación para evitar solapamientos
                    labelIntersectAction: AxisLabelIntersectAction.rotate45, // Manejo de etiquetas largas
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Porcentaje (%)'),
                    minimum: 0,
                    maximum: 60,
                    interval: 10,
                    plotBands: <PlotBand>[
                      PlotBand(start: 0, end: 10, color: const Color(0xFFFCBBBB).withOpacity(0.3)),
                      PlotBand(start: 10, end: 15, color: const Color(0xFFFFF59D).withOpacity(0.3)),
                      PlotBand(start: 15, end: 30, color: const Color(0xFFB9F6CA).withOpacity(0.3)),
                      PlotBand(start: 30, end: 35, color: const Color(0xFFFFF59D).withOpacity(0.3)),
                      PlotBand(start: 35, end: 60, color: const Color(0xFFFCBBBB).withOpacity(0.3)),
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
