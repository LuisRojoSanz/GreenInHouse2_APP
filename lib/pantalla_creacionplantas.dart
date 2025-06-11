import 'package:flutter/material.dart';
import 'package:greeninhouse2/dialogos_excepciones.dart';
import 'package:greeninhouse2/pantalla_inicio.dart';
import 'api_service.dart';
import 'generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Pantalla principal para crear una nueva planta y seleccionar su tipo.
/// Permite al usuario crear una planta proporcionando su nombre y tipo,
/// y también ofrece la opción de crear un nuevo tipo de planta si no está
/// disponible en la lista.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');

  // Controladores de los campos de texto
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
    _verificarConexionInicial();
    fetchTiposPlantas();
  }

  /// Verifica si hay una conexión inicial con el servidor y obtiene los datos.
  Future<void> _verificarConexionInicial() async {
    try {
      final data = await apiService.get('TiposPlantas/All');

      if (!mounted) return;

      if (data != null) {
        setState(() {
          tiposPlantas = List<String>.from(data.map((item) => item['tipo_planta']));
          isLoading = false;
        });
      } else {
        // Si no devuelve datos, se considera un error de conexión o de respuesta
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

  /// Obtiene los tipos de plantas disponibles desde el servidor.
  Future<void> fetchTiposPlantas() async {
    setState(() => isLoading = true);

    try {
      final data = await apiService.get('TiposPlantas/All');
      if (data != null && mounted) {
        setState(() {
          tiposPlantas = List<String>.from(data.map((item) => item['tipo_planta']));
        });
      } else if (mounted) {
        await mostrarDialogoErrorConexion(context);
      }
    } catch (e) {
      if (mounted) {
        await mostrarDialogoErrorConexion(context);
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  /// Crea un nuevo tipo de planta y lo agrega a la lista.
  Future<void> createTipoPlanta() async {

    if (_tipoPlantaController.text.isEmpty || _descripcionPlantaController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).completeFieldsMessage)),
        );
      }
      return;
    }

    final body = {
      "descripcion_planta": _descripcionPlantaController.text,
      "tipo_planta": _tipoPlantaController.text,
    };

    try {
      final response = await apiService.post('TiposPlantas/One', body);
      if (response != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).tipoPlantaCreatedMessage)),
        );
        setState(() {
          tiposPlantas.add(_tipoPlantaController.text);
          tipoSeleccionado = _tipoPlantaController.text;
          creandoTipo = false;
          _tipoPlantaController.clear();
          _descripcionPlantaController.clear();
        });
      } else if (mounted) {
        await mostrarDialogoErrorConexion(context);
      }
    } catch (e) {
      if (mounted) {
        await mostrarDialogoErrorConexion(context);
      }
    }
  }

  /// Crea una nueva planta con el nombre y tipo seleccionado.
  Future<void> createPlanta() async {

    if (_nombrePlantaController.text.isEmpty || tipoSeleccionado == null) {
      _showMessage(S.of(context).completeFieldsMessage);
      return;
    }

    final body = {
      "nombre_planta": _nombrePlantaController.text,
      "tipo_planta": tipoSeleccionado,
    };

    try {
      final response = await apiService.post('Plantas/One', body);

      if (response != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nombrePlantaActiva', _nombrePlantaController.text);
        await prefs.setString('fechaPlantacion', DateTime.now().toIso8601String());

        if (!mounted) return;

        _showMessage(S.of(context).plantaCreatedMessage);
        _nombrePlantaController.clear();
        setState(() => tipoSeleccionado = null);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PantallaInicio()),
        );
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

  /// Muestra un mensaje en la parte inferior de la pantalla.
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
