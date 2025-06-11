import 'package:flutter/material.dart';
import 'package:greeninhouse2/dialogos_excepciones.dart';
import 'package:greeninhouse2/planta_service.dart';
import 'generated/l10n.dart';
import 'api_service.dart';


/// Widget que representa la pantalla donde se muestran los consejos para el
/// cuidado de la planta activa. Esta clase solo crea el estado asociado (`ConsejosPlantasScreenState`)
class ConsejosPlantasScreen extends StatefulWidget {
  const ConsejosPlantasScreen({super.key});

  @override
  ConsejosPlantasScreenState createState() => ConsejosPlantasScreenState();
}

/// Estado del widget `ConsejosPlantasScreen`, encargado de obtener los consejos
/// de cuidado de la planta activa desde una API y mostrarlos al usuario.
///
/// Gestiona la carga de datos, el manejo de errores y la visualización de la lista de consejos.
///
/// Atributos creados:
/// - `apiService`: Servicio para conectarse con la API REST.
/// - `consejos`: Lista de consejos obtenidos desde la API.
/// - `isLoading`: Booleano que indica si se están cargando los datos.
/// - `errorMessage`: Mensaje de error a mostrar si la carga falla.
/// - `plantName`: Nombre de la planta activa para la cual se obtendrán los consejos.
///
class ConsejosPlantasScreenState extends State<ConsejosPlantasScreen> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');
  List<Map<String, dynamic>> consejos = [];
  bool isLoading = true;
  String errorMessage = '';
  String plantName = '';


  /// Método `initState`
  ///
  /// Se ejecuta al iniciar el estado del widget. Carga el nombre de la planta activa.
  @override
  void initState() {
    super.initState();
    cargarNombre();
  }

  /// Método `cargarNombre`
  ///
  /// Obtiene el nombre de la planta activa desde `SharedPreferences` mediante `PlantaService`
  /// y, una vez obtenido, llama al método `fetchSensores` para cargar los consejos.
  ///
  /// @return Future<void>
  Future<void> cargarNombre() async {
    final nombre = await PlantaService.obtenerNombrePlantaActiva();
    if (!mounted) return;

    setState(() {
      plantName = nombre ?? '';
    });

    fetchSensores();
  }

  /// Método `fetchSensores`
  ///
  /// Realiza una petición GET a la API para obtener los consejos relacionados
  /// con la planta activa.
  /// Los consejos incluyen datos como descripción, zona, tipo de medida,
  /// valores máximos y mínimos y horas recomendadas.
  ///
  /// @return Future<void>
  Future<void> fetchSensores() async {
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
        throw Exception('Datos nulos o incompletos'); // Forzamos la excepción para ir al catch
      }
    } catch (e) {
      if (!mounted) return;
      await mostrarDialogoErrorConexion(context);
    }
  }

  /// Método `build`
  ///
  /// Construye la interfaz gráfica de la pantalla.
  /// Muestra un `CircularProgressIndicator` mientras se cargan los datos,
  /// un mensaje de error si falla, o una lista de consejos si la carga es exitosa.
  ///
  /// @param context Representa la ubicación del widget en el árbol de widgets.
  /// Se utiliza para acceder a recursos como traducciones, temas o navegación.
  /// @return Widget
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
                                S.of(context).plantTipDescription(consejo['descripcion']),
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
