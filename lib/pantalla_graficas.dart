import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'api_service.dart';
import 'package:intl/intl.dart';
import 'botones_inicio.dart'; // Importa la clase de botones

class GraficasScreen extends StatefulWidget {
  const GraficasScreen({super.key});

  @override
  GraficasScreenState createState() => GraficasScreenState();
}

class GraficasScreenState extends State<GraficasScreen> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');
  List<HumidityData> humidityData = [];
  String plantName = "Mi tomatera";

  // Fechas y horas seleccionadas
  DateTime startDateTime = DateTime.now().subtract(const Duration(hours: 1));
  DateTime endDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchSensorData();
  }

  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Obtener datos de la API
  Future<void> fetchSensorData() async {
    String startDateStr =
    DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(startDateTime);
    String endDateStr =
    DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(endDateTime);

    String endpoint =
        'RegistrosSensores/All/FromPlant/BetweenDates?np=$plantName&fi=$startDateStr&ff=$endDateStr';

    final data = await apiService.get(endpoint);
    if (!mounted) return;

    if (data != null) {
      setState(() {
        humidityData = data
            .where((item) =>
        item['tipo_sensor']['nombre'] == 'Humedad' &&
            item['unidad_medida']['nombre'] == '%')
            .map<HumidityData>((item) {
          String rawDate = item['fecha'];
          DateTime parsedDate = DateTime.parse(rawDate);

          return HumidityData(
            dateTime: parsedDate,
            value: (item['valor'] as double) * 100,
          );
        })
            .toList();

        humidityData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      });
    }
  }

  Future<DateTime?> pickDateTime(DateTime initialDate) async {
    if (!mounted) return null;

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate == null || !mounted) return null;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    if (pickedTime == null || !mounted) return null;

    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráficos'),
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Inicio: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () async {
                        DateTime? picked = await pickDateTime(startDateTime);
                        if (picked != null) {
                          setState(() {
                            startDateTime = picked;
                          });
                        }
                      },
                      child: Text(
                        DateFormat('dd/MM/yyyy HH:mm').format(startDateTime),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Fin: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () async {
                        DateTime? picked = await pickDateTime(endDateTime);
                        if (picked != null) {
                          setState(() {
                            endDateTime = picked;
                          });
                        }
                      },
                      child: Text(
                        DateFormat('dd/MM/yyyy HH:mm').format(endDateTime),
                        style: const TextStyle(fontSize: 16),
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Humedad (%)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 300,
            child: humidityData.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                title: AxisTitle(text: 'Hora'),
                dateFormat: DateFormat.Hm(),
                intervalType: DateTimeIntervalType.minutes,
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: 'Porcentaje (%)'),
                minimum: 0,
                maximum: 100,
                interval: 10,
              ),
              series: <ChartSeries>[
                LineSeries<HumidityData, DateTime>(
                  dataSource: humidityData,
                  xValueMapper: (data, _) => data.dateTime,
                  yValueMapper: (data, _) => data.value,
                  name: "Humedad",
                  color: Colors.blue,
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    shape: DataMarkerType.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationCustom(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class HumidityData {
  final DateTime dateTime;
  final double value;

  HumidityData({required this.dateTime, required this.value});
}
