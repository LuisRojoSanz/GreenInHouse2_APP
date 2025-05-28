import 'package:flutter/material.dart';
import 'package:greeninhouse2/dialogos_excepciones.dart';
import 'package:greeninhouse2/generated/l10n.dart';
import 'api_service.dart';
import 'package:intl/intl.dart';
import 'planta_service.dart';

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
  String plantName = '';

  @override
  void initState() {
    super.initState();
    cargarNombre();
  }

  Future<void> cargarNombre() async {
    final nombre = await PlantaService.obtenerNombrePlantaActiva();
    if (!mounted) return;

    setState(() {
      plantName = nombre ?? '';
    });

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
          'RegistrosSensores/All/FromPlant/BetweenDates?np=$plantName&fi=$formattedDate',
        );

        setState(() {
          sensores = List<Map<String, dynamic>>.from(sensoresData.map((sensor) {
            final registros = registrosData.where((registro) {
              return registro['numero_sensor'] == sensor['numero_sensor'];
            }).toList();

            bool isActive = registros.isNotEmpty;
            String lastLog = S.of(context).withOutData;
            if (isActive) {
              final latestLog = registros.last;
              lastLog = latestLog['fecha'];
            }

            return {
              'nombre_sensor': sensor['nombre_sensor'] ?? S.of(context).unknownName,
              'modelo_sensor': sensor['modelo_sensor']['nombre'] ?? S.of(context).unknownModel,
              'tipo_sensor': sensor['tipo_sensor']['nombre'] ?? S.of(context).unknownType,
              'zona_sensor': sensor['zona_sensor']['nombre'] ?? S.of(context).unknownZone,
              'lectura': sensor['patilla_0_lectura'] ?? S.of(context).noReading,
              'unidad': sensor['unidad_medida_0']['nombre'] ?? S.of(context).noUnit,
              'activo': isActive,
              'ultima_fecha': lastLog,
            };
          }));
          isLoading = false;
        });
      } else {
        throw Exception('Datos nulos o incompletos'); // Forzamos la excepción para ir al catch
      }
    } catch (e) {
      if (!mounted) return;
      await mostrarDialogoErrorConexion(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).activeSensors),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(
              child: Text(
                S.of(context).errorFetchingData,
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
                            _buildInfoRow(Icons.precision_manufacturing, S.of(context).model, sensor['modelo_sensor']),
                            _buildInfoRow(Icons.category, S.of(context).type, sensor['tipo_sensor']),
                            _buildInfoRow(Icons.place, S.of(context).zone, sensor['zona_sensor']),
                            _buildInfoRow(Icons.timer, S.of(context).lastReading, sensor['ultima_fecha']),
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
