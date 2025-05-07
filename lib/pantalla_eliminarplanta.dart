import 'package:flutter/material.dart';
import 'package:greeninhouse2/pantalla_inicio.dart';
import 'api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EliminarPlantaScreen extends StatefulWidget {
  const EliminarPlantaScreen({super.key});

  @override
  State<EliminarPlantaScreen> createState() => _EliminarPlantaScreenState();
}

class _EliminarPlantaScreenState extends State<EliminarPlantaScreen> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');

  List<String> plantasActivas = [];
  String? plantaSeleccionada;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPlantasActivas();
  }

  Future<void> fetchPlantasActivas() async {
    setState(() => isLoading = true);
    final data = await apiService.get('Plantas/All/Active');
    if (data != null) {
      setState(() {
        plantasActivas = List<String>.from(data.map((item) => item['nombre_planta']));
      });
    }
    setState(() => isLoading = false);
  }

  Future<void> eliminarPlanta() async {
    if (plantaSeleccionada == null) {
      _showMessage('Por favor, selecciona una planta para eliminar');
      return;
    }

    final endpoint = 'Plantas/One?np=${Uri.encodeComponent(plantaSeleccionada!)}';
    final response = await apiService.delete(endpoint);

    if (response != null) {
      // Se borra el nombre guardado
      final prefs = await SharedPreferences.getInstance();
      final plantaGuardada = prefs.getString('nombrePlantaActiva');

      if (plantaGuardada == plantaSeleccionada) {
        await prefs.remove('nombrePlantaActiva');
        await prefs.remove('fechaPlantacion');
      }
      _showMessage('Planta eliminada correctamente');
      setState(() {
        plantasActivas.remove(plantaSeleccionada);
        plantaSeleccionada = null;
      });
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PantallaInicio()),
        );
      }
    } else {
      _showMessage('Error al eliminar la planta');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eliminar Planta'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selecciona una planta activa para eliminar:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Plantas Activas'),
                value: plantaSeleccionada,
                items: plantasActivas.map((planta) {
                  return DropdownMenuItem(
                    value: planta,
                    child: Text(planta),
                  );
                }).toList(),
                onChanged: (value) => setState(() => plantaSeleccionada = value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (plantaSeleccionada == null) {
                    _showMessage('Por favor, selecciona una planta para eliminar');
                    return;
                  }

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar eliminación'),
                      content: Text('¿Estás seguro de que quieres eliminar la planta "$plantaSeleccionada"?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            eliminarPlanta();
                          },
                          child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Eliminar Planta', style: TextStyle(color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }
}
