import 'package:flutter/material.dart';
import 'package:greeninhouse2/dialogos_excepciones.dart';
import 'api_service.dart';

class ModificarPlantaScreen extends StatefulWidget {
  const ModificarPlantaScreen({super.key});

  @override
  State<ModificarPlantaScreen> createState() => _ModificarPlantaScreenState();
}

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

  Future<void> modificarPlanta() async {
    if (plantaSeleccionada == null || tipoSeleccionado == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecciona una planta y un nuevo tipo')),
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
            const SnackBar(content: Text('Tipo de planta modificado correctamente')),
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
        title: const Text('Modificar Planta'),
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
            const Text(
              'Selecciona una planta activa para modificar:',
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
              decoration: const InputDecoration(labelText: 'Nombre de la Planta'),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Nuevo Tipo de Planta'),
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
              child: const Text('Modificar Planta', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
