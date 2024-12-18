import 'package:flutter/material.dart';
import 'api_service.dart';
import 'generated/l10n.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');

  final TextEditingController _nombrePlantaController = TextEditingController();
  final TextEditingController _tipoPlantaController = TextEditingController();
  final TextEditingController _descripcionPlantaController = TextEditingController();

  List<String> tiposPlantas = [];
  String? tipoSeleccionado;
  bool creandoTipo = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTiposPlantas();
  }

  Future<void> fetchTiposPlantas() async {
    setState(() => isLoading = true);
    final data = await apiService.get('TiposPlantas/All');
    if (data != null) {
      setState(() {
        tiposPlantas = List<String>.from(data.map((item) => item['tipo_planta']));
      });
    }
    setState(() => isLoading = false);
  }

  Future<void> createTipoPlanta() async {
    final localization = S.of(context); // Guarda la localización antes de 'await'

    if (_tipoPlantaController.text.isEmpty || _descripcionPlantaController.text.isEmpty) {
      _showMessage(localization.completeFieldsMessage);
      return;
    }

    final body = {
      "descripcion_planta": _descripcionPlantaController.text,
      "tipo_planta": _tipoPlantaController.text,
    };

    final response = await apiService.post('TiposPlantas/One', body);

    if (response != null) {
      _showMessage(localization.tipoPlantaCreatedMessage);
      setState(() {
        tiposPlantas.add(_tipoPlantaController.text);
        tipoSeleccionado = _tipoPlantaController.text;
        creandoTipo = false;
        _tipoPlantaController.clear();
        _descripcionPlantaController.clear();
      });
    }
  }

  Future<void> createPlanta() async {
    final localization = S.of(context); // Guarda la localización antes de 'await'

    if (_nombrePlantaController.text.isEmpty || tipoSeleccionado == null) {
      _showMessage(localization.completeFieldsMessage);
      return;
    }

    final body = {
      "nombre_planta": _nombrePlantaController.text,
      "tipo_planta": tipoSeleccionado,
    };

    final response = await apiService.post('Plantas/One', body);

    if (response != null) {
      _showMessage(localization.plantaCreatedMessage);
      _nombrePlantaController.clear();
      setState(() => tipoSeleccionado = null);
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
        title: Text(widget.title),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección para seleccionar o crear tipo de planta
            Text(S.of(context).step1Title,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),

            if (!creandoTipo)
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: S.of(context).tipoPlantaLabel),
                value: tipoSeleccionado,
                items: tiposPlantas.map((tipo) {
                  return DropdownMenuItem(value: tipo, child: Text(tipo));
                }).toList(),
                onChanged: (value) => setState(() => tipoSeleccionado = value),
              ),

            if (!creandoTipo)
              TextButton(
                onPressed: () => setState(() => creandoTipo = true),
                child: Text(S.of(context).createNewTipoPlanta),
              ),

            if (creandoTipo) ...[
              TextField(
                controller: _tipoPlantaController,
                decoration: InputDecoration(labelText: S.of(context).nombreTipoPlantaLabel),
              ),
              TextField(
                controller: _descripcionPlantaController,
                decoration: InputDecoration(labelText: S.of(context).descripcionPlantaLabel),
              ),
              ElevatedButton(
                onPressed: createTipoPlanta,
                child: Text(S.of(context).guardarTipoPlantaButton),
              ),
            ],

            const SizedBox(height: 20),
            Divider(color: Colors.grey.shade300),

            // Sección para crear planta
            Text(S.of(context).step2Title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            TextField(
              controller: _nombrePlantaController,
              decoration: InputDecoration(labelText: S.of(context).nombrePlantaLabel),
            ),
            ElevatedButton(
              onPressed: createPlanta,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(S.of(context).crearPlantaButton, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
