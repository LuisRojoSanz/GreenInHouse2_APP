import 'package:flutter/material.dart';
import 'package:greeninhouse2/dialogos_excepciones.dart';
import 'package:greeninhouse2/pantalla_inicio.dart';
import 'api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';


/// Pantalla que permite al usuario seleccionar una planta activa y eliminarla.
/// El proceso incluye la eliminación de la planta tanto en la base de datos como en los datos locales
/// (SharedPreferences).
///
/// Atributos:
/// - `plantasActivas`: Lista de plantas activas obtenidas de la base de datos.
/// - `plantaSeleccionada`: Planta seleccionada para ser eliminada.
/// - `isLoading`: Indica si se están cargando los datos.
/// - `apiService`: Instancia de `ApiService` para manejar las peticiones HTTP.
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
    _verificarConexionInicial();
  }

  /// Verifica la conexión inicial al servidor y obtiene la lista de plantas activas.
  /// Si hay un error de conexión o los datos son nulos, muestra un diálogo de error.
  Future<void> _verificarConexionInicial() async {
    setState(() => isLoading = true);

    try {
      final data = await apiService.get('Plantas/All/Active');

      if (!mounted) return;

      if (data != null) {
        setState(() {
          plantasActivas = List<String>.from(data.map((item) => item['nombre_planta']));
          isLoading = false;
        });
      } else {
        await mostrarDialogoErrorConexion(context);
      }
    } catch (e) {
      if (!mounted) return;
      await mostrarDialogoErrorConexion(context);
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  /// Elimina la planta seleccionada tanto en la base de datos como en los datos locales (SharedPreferences).
  Future<void> eliminarPlanta() async {
    if (plantaSeleccionada == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).selectPlantToDelete)),
        );
      }
      return;
    }

    try {
      final endpoint = 'Plantas/One?np=${Uri.encodeComponent(plantaSeleccionada!)}';
      final response = await apiService.delete(endpoint);

      if (response != null) {
        final prefs = await SharedPreferences.getInstance();
        final plantaGuardada = prefs.getString('nombrePlantaActiva');

        if (plantaGuardada == plantaSeleccionada) {
          await prefs.remove('nombrePlantaActiva');
          await prefs.remove('fechaPlantacion');
          await prefs.remove('fechaCambioTierra');
          await prefs.remove('fechaFertilizante');
          await prefs.remove('imagen_path');
          await prefs.remove('imagen_planta');
          await prefs.remove('frecuenciaCambioTierra');
          await prefs.remove('frecuenciaFertilizante');
          await prefs.setBool('dialogoPlantaMostrado', false);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).plantDeletedMessage)),
          );
          setState(() {
            plantasActivas.remove(plantaSeleccionada);
            plantaSeleccionada = null;
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PantallaInicio()),
          );
        }
      } else {
        if (mounted) {
          await mostrarDialogoErrorConexion(context);
        }
      }
    } catch (e) {
      if (mounted) {
        await mostrarDialogoErrorConexion(context);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).deletePlantTitle),
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
                Text(
                  S.of(context).selectActivePlantToDelete,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: S.of(context).activePlantsLabel),
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
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(S.of(context).selectPlantToDelete)),
                      );
                    }
                    return;
                  }

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(S.of(context).confirmDeleteTitle),
                      content: Text(S.of(context).confirmDeleteMessage(plantaSeleccionada!)),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(S.of(context).cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            eliminarPlanta();
                          },
                          child: Text(S.of(context).delete, style: const TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(S.of(context).deletePlantButton, style: const TextStyle(color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }
}
