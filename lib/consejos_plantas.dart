import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    fetchConsejos();
  }

  Future<void> fetchConsejos() async {
    setState(() {
      isLoading = true;
      errorMessage = ''; // Limpiamos cualquier mensaje de error anterior
    });

    final data = await apiService.get('Consejos/Plantas/All');
    if (data != null) {
      setState(() {
        consejos = List<Map<String, dynamic>>.from(data.map((item) => {
          'descripcion': item['descripcion'] ?? 'Descripción no disponible',
          'tipo_medida':
          item['tipo_medida']['nombre'] ?? 'Tipo de medida no disponible',
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
      setState(() {
        errorMessage = S.of(context).errorMessage;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).screenTitleplants),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: Text(S.of(context).loadingMessage))
          : errorMessage.isNotEmpty
          ? Center(child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: consejos.length,
        itemBuilder: (context, index) {
          final consejo = consejos[index];
          return Card(
            margin: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                consejo['descripcion'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context)
                      .zoneLabel(consejo['zona_consejo'])),
                  Text(S.of(context).measurementTypeLabel(
                      consejo['tipo_medida'])),
                  Text(S.of(context).unitLabel(
                      consejo['unidad_medida'])),
                  Text(S.of(context).rangeLabel(
                      consejo['valor_minimo'],
                      consejo['valor_maximo'])),
                  Text(S.of(context).hoursLabel(
                      consejo['horas_minimas'],
                      consejo['horas_maximas'])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
