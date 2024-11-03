// pantalla_creacionplantas.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _maxTempController = TextEditingController();
  final TextEditingController _minTempController = TextEditingController();
  final TextEditingController _maxHumidityController = TextEditingController();
  final TextEditingController _minHumidityController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _maxLightController = TextEditingController();
  final TextEditingController _minLightController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime? _plantDate;
  final List<Map<String, String>> _plants = [];

  Future<void> _selectPlantDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _plantDate) {
      setState(() {
        _plantDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(_plantDate!);
      });
    }
  }

  void _addPlant() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa el nombre de la planta.')),
      );
      return;
    }

    setState(() {
      _plants.add({
        'name': _nameController.text,
        'maxTemp': _maxTempController.text,
        'minTemp': _minTempController.text,
        'maxHumidity': _maxHumidityController.text,
        'minHumidity': _minHumidityController.text,
        'type': _typeController.text,
        'plantDate': _plantDate != null ? DateFormat('dd/MM/yyyy').format(_plantDate!) : 'No seleccionada',
        'maxLight': _maxLightController.text,
        'minLight': _minLightController.text,
        'water': _waterController.text,
      });
      _nameController.clear();
      _maxTempController.clear();
      _minTempController.clear();
      _maxHumidityController.clear();
      _minHumidityController.clear();
      _typeController.clear();
      _maxLightController.clear();
      _minLightController.clear();
      _waterController.clear();
      _dateController.clear();
      _plantDate = null;
    });
  }

  void _removePlant(int index) {
    setState(() {
      _plants.removeAt(index);
    });
  }

  void _validateLightHours() {
    final double? minLight = double.tryParse(_minLightController.text);
    final double? maxLight = double.tryParse(_maxLightController.text);

    if (minLight != null && maxLight != null) {
      if (minLight > maxLight) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La luz mínima no puede ser mayor que la luz máxima')),
        );
        _minLightController.clear();
      }
    }
  }

  void _validateTemperature() {
    final double? minTemp = double.tryParse(_minTempController.text);
    final double? maxTemp = double.tryParse(_maxTempController.text);

    if (minTemp != null && maxTemp != null) {
      if (minTemp > maxTemp) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La temperatura mínima no puede ser mayor que la máxima')),
        );
        _minTempController.clear();
      }
    }
  }

  void _validateHumidity() {
    final double? minHumidity = double.tryParse(_minHumidityController.text);
    final double? maxHumidity = double.tryParse(_maxHumidityController.text);

    if (minHumidity != null && maxHumidity != null) {
      if (minHumidity > maxHumidity) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La humedad mínima no puede ser mayor que la máxima')),
        );
        _minHumidityController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre de la planta'),
            ),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(labelText: 'Tipo de planta'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Fecha de Plantación',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectPlantDate(context),
            ),
            TextField(
              controller: _maxTempController,
              decoration: const InputDecoration(labelText: 'Temperatura Máxima (°C)'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              onChanged: (value) => _validateTemperature(),
            ),
            TextField(
              controller: _minTempController,
              decoration: const InputDecoration(labelText: 'Temperatura Mínima (°C)'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              onChanged: (value) => _validateTemperature(),
            ),
            TextField(
              controller: _maxHumidityController,
              decoration: const InputDecoration(labelText: 'Humedad Máxima (%)'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) => _validateHumidity(),
            ),
            TextField(
              controller: _minHumidityController,
              decoration: const InputDecoration(labelText: 'Humedad Mínima (%)'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) => _validateHumidity(),
            ),
            TextField(
              controller: _maxLightController,
              decoration: const InputDecoration(labelText: 'Horas Máximas de Luz (h)'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              onChanged: (value) => _validateLightHours(),
            ),
            TextField(
              controller: _minLightController,
              decoration: const InputDecoration(labelText: 'Horas Mínimas de Luz (h)'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              onChanged: (value) => _validateLightHours(),
            ),
            TextField(
              controller: _waterController,
              decoration: const InputDecoration(labelText: 'Agua Diaria (ml)'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _addPlant,
                child: const Text('Añadir Planta'),
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: _plants.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(_plants[index]['name'] ?? ''),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removePlant(index),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Tipo: ${_plants[index]['type']}\n'
                              'Fecha de Plantación: ${_plants[index]['plantDate']}\n'
                              'Temp Máx: ${_plants[index]['maxTemp']}°C\n'
                              'Temp Mín: ${_plants[index]['minTemp']}°C\n'
                              'Humedad Máx: ${_plants[index]['maxHumidity']}%\n'
                              'Humedad Mín: ${_plants[index]['minHumidity']}%\n'
                              'Luz: ${_plants[index]['minLight']}-${_plants[index]['maxLight']}h\n'
                              'Agua: ${_plants[index]['water']}ml/día',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
