import 'package:flutter/material.dart';
import 'generated/l10n.dart';
import 'api_service.dart';

class SensoresActivosScreen extends StatefulWidget {
  const SensoresActivosScreen({super.key});

  @override
  SensoresActivosScreenState createState() => SensoresActivosScreenState();
}

class SensoresActivosScreenState extends State<SensoresActivosScreen> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');
  List<Map<String, dynamic>> sensores = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchSensores();
  }

  Future<void> fetchSensores() async {
    setState(() {
      isLoading = true;
      errorMessage = ''; // Limpiamos cualquier mensaje de error anterior
    });

    try {
      final data = await apiService.get('Sensores/All'); // Llama al endpoint de sensores

      if (data != null) {
        setState(() {
          sensores = List<Map<String, dynamic>>.from(data.map((item) => {
            'nombre_sensor': item['nombre_sensor'] ?? S.of(context).errorMessagesensors,
            'modelo_sensor': item['modelo_sensor']['nombre'] ?? 'Modelo desconocido',
            'tipo_sensor': item['tipo_sensor']['nombre'] ?? 'Tipo desconocido',
            'zona_sensor': item['zona_sensor']['nombre'] ?? 'Zona no especificada',
            'lectura': item['patilla_0_lectura'] ?? 'Sin lectura',
            'unidad': item['unidad_medida_0']['nombre'] ?? 'Sin unidad',
          }));
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = S.of(context).errorMessagesensors;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error al obtener los sensores: $e');
      setState(() {
        errorMessage = S.of(context).errorMessagesensors;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).screenTitlesensors),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: Text(S.of(context).loadingMessage))
          : errorMessage.isNotEmpty
          ? Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: sensores.length,
        itemBuilder: (context, index) {
          final sensor = sensores[index];
          return Card(
            margin: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                sensor['nombre_sensor'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context)
                      .modelLabel(sensor['modelo_sensor'])),
                  Text(S.of(context).typeLabelsensors(sensor['tipo_sensor'])),
                  Text(S.of(context).zoneLabel(sensor['zona_sensor'])),
                  Text(S.of(context).readingLabel(sensor['lectura'],
                      sensor['unidad'])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
