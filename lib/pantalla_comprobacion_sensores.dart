import 'package:flutter/material.dart';
import 'api_service.dart';
import 'package:intl/intl.dart';

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
  final String planta = 'Mi tomatera';

  @override
  void initState() {
    super.initState();
    fetchSensores();
  }

  Future<void> fetchSensores() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final sensoresData = await apiService.get('Sensores/All');
      if (sensoresData != null) {
        final now = DateTime.now();
        final thirtyMinutesAgo = now.subtract(const Duration(minutes: 30));
        final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(thirtyMinutesAgo);

        final registrosData = await apiService.get(
          'RegistrosSensores/All/FromPlant/BetweenDates?np=$planta&fi=$formattedDate',
        );

        setState(() {
          sensores = List<Map<String, dynamic>>.from(sensoresData.map((sensor) {
            final registros = registrosData.where((registro) {
              return registro['numero_sensor'] == sensor['numero_sensor'];
            }).toList();

            bool isActive = registros.isNotEmpty;
            String lastLog = 'Sin datos';
            if (isActive) {
              final latestLog = registros.last;
              lastLog = latestLog['fecha'];
            }

            return {
              'nombre_sensor': sensor['nombre_sensor'] ?? 'Nombre desconocido',
              'modelo_sensor': sensor['modelo_sensor']['nombre'] ?? 'Modelo desconocido',
              'tipo_sensor': sensor['tipo_sensor']['nombre'] ?? 'Tipo desconocido',
              'zona_sensor': sensor['zona_sensor']['nombre'] ?? 'Zona no especificada',
              'lectura': sensor['patilla_0_lectura'] ?? 'Sin lectura',
              'unidad': sensor['unidad_medida_0']['nombre'] ?? 'Sin unidad',
              'activo': isActive,
              'ultima_fecha': lastLog,
            };
          }));
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'No se pudieron obtener los sensores.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error al obtener los sensores: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensores Activos'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
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
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: sensor['activo'] ? Colors.green.shade300 : Colors.red.shade300,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      sensor['activo'] ? Icons.check_circle : Icons.error,
                      size: 50,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sensor['nombre_sensor'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(Icons.precision_manufacturing, 'Modelo', sensor['modelo_sensor']),
                          _buildInfoRow(Icons.category, 'Tipo', sensor['tipo_sensor']),
                          _buildInfoRow(Icons.place, 'Zona', sensor['zona_sensor']),
                          _buildInfoRow(Icons.timer, 'Última lectura', sensor['ultima_fecha']),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.white70),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label: $value',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
