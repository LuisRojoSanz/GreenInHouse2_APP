import 'package:flutter/material.dart';
import 'package:greeninhouse2/planta_service.dart';
import 'generated/l10n.dart';
import 'api_service.dart';

class ConsejosPlantasScreen extends StatefulWidget {
  const ConsejosPlantasScreen({super.key});

  @override
  ConsejosPlantasScreenState createState() => ConsejosPlantasScreenState();
}

class ConsejosPlantasScreenState extends State<ConsejosPlantasScreen> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');
  List<Map<String, dynamic>> consejos = [];
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
    setState(() {
      plantName = nombre ?? '';
    });

    if (plantName.isNotEmpty) {
      fetchConsejos();
    } else {
      setState(() {
        errorMessage = 'No hay una planta activa configurada.';
        isLoading = false;
      });
    }
  }

  Future<void> fetchConsejos() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final data = await apiService.get('Consejos/Plantas/All/FromPlant?np=$plantName');

      if (data != null) {
        setState(() {
          consejos = List<Map<String, dynamic>>.from(data.map((item) => {
            'descripcion': item['descripcion'] ?? 'Descripción no disponible',
            'tipo_medida': item['tipo_medida']['nombre'] ?? 'Tipo de medida no disponible',
            'unidad_medida': item['unidad_medida']['nombre'] ?? '',
            'valor_maximo': item['valor_maximo'] ?? 'No especificado',
            'valor_minimo': item['valor_minimo'] ?? 'No especificado',
            'zona_consejo': item['zona_consejo']['nombre'] ?? 'Zona no especificada',
            'horas_minimas': item['horas_minimas'] ?? 'No especificadas',
            'horas_maximas': item['horas_maximas'] ?? 'No especificadas',
          }));
          isLoading = false;
        });
      } else {
        throw Exception('Sin datos del servidor');
      }
    } catch (e) {
      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: const [
              Icon(Icons.wifi_off, color: Colors.redAccent),
              SizedBox(width: 10),
              Text("Sin conexión"),
            ],
          ),
          content: const Text(
            "No se pudo contactar con el servidor.\n"
                "Por favor, revisa tu conexión a la red.",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Aceptar",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );

      if (mounted) {
        Navigator.of(context).pop(); // Salir de la pantalla de consejos
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).screenTitleplants),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? Center(
            child: CircularProgressIndicator(),
      )
          : errorMessage.isNotEmpty
          ? Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            )
          : ListView.builder(
            itemCount: consejos.length,
            itemBuilder: (context, index) {
              final consejo = consejos[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green.shade100,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.green.shade700),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                              consejo['descripcion'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      const Divider(thickness: 1),
                      Row(
                        children: [
                          Icon(Icons.place, color: Colors.green.shade700),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              S.of(context).zoneLabel(consejo['zona_consejo']),
                              style: const TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.category,
                            color: Colors.green.shade700),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            S.of(context).measurementTypeLabel(
                                consejo['tipo_medida']),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.speed, color: Colors.green.shade700),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            S.of(context).rangeLabel(
                              '${consejo['valor_minimo']}${consejo['unidad_medida']}',
                              '${consejo['valor_maximo']}${consejo['unidad_medida']}',
                            ),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            color: Colors.green.shade700),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            S.of(context).hoursLabel(
                                consejo['horas_minimas'],
                                consejo['horas_maximas']),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black54),
                          ),
                        ),
                      ],
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
}
