import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'generated/l10n.dart'; // Asegúrate de que este archivo esté importado

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
        SnackBar(content: Text(S.of(context).pleaseEnterName)),
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
              decoration: InputDecoration(labelText: S.of(context).nameLabel),
            ),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: S.of(context).typeLabel),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: S.of(context).plantDateLabel,
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectPlantDate(context),
            ),
            TextField(
              controller: _maxTempController,
              decoration: InputDecoration(labelText: S.of(context).maxTempLabel),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
            ),
            TextField(
              controller: _minTempController,
              decoration: InputDecoration(labelText: S.of(context).minTempLabel),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
            ),
            TextField(
              controller: _maxHumidityController,
              decoration: InputDecoration(labelText: S.of(context).maxHumidityLabel),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: _minHumidityController,
              decoration: InputDecoration(labelText: S.of(context).minHumidityLabel),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: _maxLightController,
              decoration: InputDecoration(labelText: S.of(context).maxLightLabel),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
            ),
            TextField(
              controller: _minLightController,
              decoration: InputDecoration(labelText: S.of(context).minLightLabel),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
            ),
            TextField(
              controller: _waterController,
              decoration: InputDecoration(labelText: S.of(context).waterLabel),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _addPlant,
                child: Text(S.of(context).addPlantButton),
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
                    children: [
                      ListTile(title: Text('${S.of(context).maxTempLabel}: ${_plants[index]['maxTemp']}')),
                      ListTile(title: Text('${S.of(context).minTempLabel}: ${_plants[index]['minTemp']}')),
                      ListTile(title: Text('${S.of(context).maxHumidityLabel}: ${_plants[index]['maxHumidity']}')),
                      ListTile(title: Text('${S.of(context).minHumidityLabel}: ${_plants[index]['minHumidity']}')),
                      ListTile(title: Text('${S.of(context).maxLightLabel}: ${_plants[index]['maxLight']}')),
                      ListTile(title: Text('${S.of(context).minLightLabel}: ${_plants[index]['minLight']}')),
                      ListTile(title: Text('${S.of(context).waterLabel}: ${_plants[index]['water']}')),
                      ListTile(title: Text('${S.of(context).plantDateLabel}: ${_plants[index]['plantDate']}')),
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
