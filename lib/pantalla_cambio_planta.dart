import 'package:flutter/material.dart';
import 'package:greeninhouse2/dialogos_excepciones.dart';
import 'package:greeninhouse2/generated/l10n.dart';
import 'api_service.dart';

/// Pantalla para visualizar todas las plantas creadas (activas) del sistema.
/// Posteriormente se añadirá la funcionalidad para cambiar entre plantas activas.
///
/// Atributos creados:
/// - `plantasActivas`: Lista de nombres de las plantas activas.
/// - `isLoading`: Indica si se está cargando la información.
class PantallaCambioPlanta extends StatefulWidget {
  const PantallaCambioPlanta({super.key});

  @override
  State<PantallaCambioPlanta> createState() => _PantallaCambioPlantaState();
}

class _PantallaCambioPlantaState extends State<PantallaCambioPlanta> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');
  List<String> plantasActivas = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _cargarPlantasActivas();
  }

  /// Carga todas las plantas activas desde la API y actualiza el estado del widget.
  ///
  /// @return Future<void>
  Future<void> _cargarPlantasActivas() async {
    setState(() => isLoading = true);

    try {
      final plantasData = await apiService.get('Plantas/All/Active');
      if (!mounted) return;

      if (plantasData != null) {
        setState(() {
          plantasActivas = List<String>.from(
            plantasData.map((item) => item['nombre_planta']),
          );
          isLoading = false;
        });
      } else {
        if (mounted) await mostrarDialogoErrorConexion(context);
      }
    } catch (e) {
      if (mounted) await mostrarDialogoErrorConexion(context);
    }
  }

  /// Construye la interfaz principal mostrando la lista de plantas activas.
  ///
  /// @param context Contexto de la aplicación
  /// @return Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).activePlantsLabel),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : plantasActivas.isEmpty
          ? Center(
        child: Text(
          S.of(context).noData,
          style: const TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: plantasActivas.length,
        itemBuilder: (context, index) {
          final planta = plantasActivas[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.local_florist, color: Colors.green),
              title: Text(planta, style: const TextStyle(fontSize: 18)),
              onTap: () {
                // Aquí más adelante se podrá cambiar la planta activa
              },
            ),
          );
        },
      ),
    );
  }
}
