import 'package:flutter/material.dart';
import 'package:greeninhouse2/dialogos_excepciones.dart';
import 'package:greeninhouse2/generated/l10n.dart';
import 'api_service.dart';

/// Pantalla para modificar el tipo de una planta activa. Permite al usuario seleccionar una planta
/// de las activas y luego cambiar su tipo de planta.
class ModificarPlantaScreen extends StatefulWidget {
  const ModificarPlantaScreen({super.key});

  @override
  State<ModificarPlantaScreen> createState() => _ModificarPlantaScreenState();
}

/// Estado del widget `ModificarPlantaScreen`, responsable de cargar las plantas activas,
/// los tipos de planta disponibles y gestionar la modificación del tipo de planta de una planta activa.
///
/// Atributos creados:
/// - `plantasActivas`: Lista de nombres de las plantas activas que se pueden modificar.
/// - `tiposPlantaDisponibles`: Lista de tipos de planta disponibles para asignar a la planta seleccionada.
/// - `plantaSeleccionada`: Nombre de la planta seleccionada para modificar.
/// - `tipoSeleccionado`: Tipo de planta seleccionado para modificar.
/// - `tipoPlantaActual`: Tipo actual de la planta seleccionada.
/// - `isLoading`: Indica si se está cargando la información.
class _ModificarPlantaScreenState extends State<ModificarPlantaScreen> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');

  final TextEditingController _nombrePlantaController = TextEditingController();

  List<String> plantasActivas = [];
  List<String> tiposPlantaDisponibles = [];
  String? plantaSeleccionada;
  String? tipoSeleccionado;
  String? tipoPlantaActual;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _verificarConexionInicial();
  }

  /// Verifica la conexión inicial con el servidor y carga las plantas activas y tipos disponibles.
  Future<void> _verificarConexionInicial() async {
    setState(() => isLoading = true);

    try {
      final plantasData = await apiService.get('Plantas/All/Active');
      final tiposData = await apiService.get('TiposPlantas/All');

      if (!mounted) return;

      if (plantasData != null && tiposData != null) {
        setState(() {
          plantasActivas = List<String>.from(plantasData.map((item) => item['nombre_planta']));
          tiposPlantaDisponibles = List<String>.from(tiposData.map((item) => item['tipo_planta']));
          isLoading = false;
        });
      } else {
        if (mounted) {
          await mostrarDialogoErrorConexion(context);
        }
      }
    } catch (e) {
      if (!mounted) return;
      await mostrarDialogoErrorConexion(context);
    }
  }

  /// Modifica el tipo de planta de la planta seleccionada.
  Future<void> modificarPlanta() async {
    if (plantaSeleccionada == null || tipoSeleccionado == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).selectPlantAndTypeMessage)),
        );
      }
      return;
    }

    final body = {
      "nombre_planta": plantaSeleccionada,
      "tipo_planta": tipoSeleccionado,
    };

    try {
      final response = await apiService.put(
        'Plantas/One?np=${Uri.encodeComponent(plantaSeleccionada!)}',
        body,
      );

      if (response != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).plantTypeModifiedMessage)),
          );
        }
        setState(() {
          plantaSeleccionada = null;
          tipoSeleccionado = null;
          tipoPlantaActual = null;
          _nombrePlantaController.clear();
        });
      } else {
        if (mounted) await mostrarDialogoErrorConexion(context);
      }
    } catch (e) {
      if (mounted) await mostrarDialogoErrorConexion(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).modifyPlantTitle),
        backgroundColor: Colors.orange,
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
              S.of(context).selectPlantToModify,
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
              onChanged: (value) async {
                setState(() {
                  plantaSeleccionada = value;
                  _nombrePlantaController.text = value!;
                  tipoSeleccionado = null;
                  tipoPlantaActual = null;
                });

                final response = await apiService.get('Plantas/One?np=${Uri.encodeComponent(value!)}');
                if (response != null && mounted) {
                  setState(() {
                    tipoPlantaActual = response['tipo_planta'];
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nombrePlantaController,
              decoration: InputDecoration(labelText: S.of(context).plantNameLabel),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: S.of(context).newPlantTypeLabel),
              value: tipoSeleccionado,
              items: tiposPlantaDisponibles
                  .where((tipo) => tipo != tipoPlantaActual)
                  .map((tipo) => DropdownMenuItem(
                value: tipo,
                child: Text(tipo),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  tipoSeleccionado = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: modificarPlanta,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text(S.of(context).modifyPlantButton, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
