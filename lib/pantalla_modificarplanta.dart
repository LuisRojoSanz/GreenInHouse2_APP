import 'package:flutter/material.dart';
import 'api_service.dart';

class ModificarPlantaScreen extends StatefulWidget {
  const ModificarPlantaScreen({super.key});

  @override
  State<ModificarPlantaScreen> createState() => _ModificarPlantaScreenState();
}

class _ModificarPlantaScreenState extends State<ModificarPlantaScreen> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');

  final TextEditingController _nombrePlantaController = TextEditingController();
  final TextEditingController _tipoPlantaController = TextEditingController();

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

  Future<void> modificarPlanta() async {
    if (plantaSeleccionada == null || _tipoPlantaController.text.isEmpty) {
      _showMessage('Por favor, selecciona una planta y escribe el nuevo tipo');
      return;
    }

    final body = {
      "nombre_planta": plantaSeleccionada,
      "tipo_planta": _tipoPlantaController.text,
    };

    final response = await apiService.put(
      'Plantas/One?np=${Uri.encodeComponent(plantaSeleccionada!)}',
      body,
    );

    if (response != null) {
      _showMessage('Tipo de planta modificado correctamente');
      setState(() {
        plantaSeleccionada = null;
        _nombrePlantaController.clear();
        _tipoPlantaController.clear();
      });
    } else {
      _showMessage('Error al modificar la planta');
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
              onChanged: (value) {
                setState(() {
                  plantaSeleccionada = value;
                  _nombrePlantaController.text = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nombrePlantaController,
              decoration: const InputDecoration(labelText: 'Nombre de la Planta'),
              readOnly: true,
            ),
            TextField(
              controller: _tipoPlantaController,
              decoration: const InputDecoration(labelText: 'Nuevo Tipo de Planta'),
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
