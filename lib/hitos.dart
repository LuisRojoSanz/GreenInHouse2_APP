import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'botones_inicio.dart';
import 'api_service.dart';

class Hitos extends StatefulWidget {
  const Hitos({super.key});

  @override
  State<Hitos> createState() => _HitosState();
}

class _HitosState extends State<Hitos> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');

  bool? humedadSueloCumplida;
  String mensajeHumedadSuelo = "Cargando...";

  bool? humedadAmbienteCumplida;
  String mensajeHumedadAmbiente = "Cargando...";

  bool? luzCumplida;
  String mensajeLuz = "Cargando...";

  bool? temperaturaCumplida;
  String mensajeTemperatura = "Cargando...";

  bool? cambioTierraCumplida;
  String mensajeCambioTierra = "Cargando...";

  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    fetchHitos();
    verificarCambioTierra();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchHitos();
  }

  Future<void> fetchHitos() async {
    String plantName = "Mi tomatera";

    String endpointSensores =
        'RegistrosSensores/Avg/FromPlant/AgroupByIntervals/ToGraph?np=$plantName&d=1&ff=${DateTime
        .now()}';
    String endpointRangos = 'Consejos/Plantas/All/FromPlant?np=$plantName';

    final datosSensores = await apiService.get(endpointSensores);
    final datosRangos = await apiService.get(endpointRangos);

    if (!mounted) return;

    if (datosSensores != null && datosRangos != null) {
      setState(() {
        double humedadSuelo = datosSensores['MACETA']['HUMEDAD']['lista_valores']
            .last.toDouble();
        double humedadAmbiente = datosSensores['AMBIENTE']['HUMEDAD']['lista_valores']
            .last.toDouble();
        double luz = datosSensores['AMBIENTE']['LUMINOSIDAD']['lista_valores']
            .last.toDouble();
        double temperatura = datosSensores['AMBIENTE']['TEMPERATURA']['lista_valores']
            .last.toDouble();

        double minHumedadSuelo = 40.0,
            maxHumedadSuelo = 70.0;
        double minHumedadAmbiente = 30.0,
            maxHumedadAmbiente = 60.0;
        double minLuz = 60.0,
            maxLuz = 90.0;
        double minTemperatura = 10.0,
            maxTemperatura = 25.0;

        for (var item in datosRangos) {
          if (item['tipo_medida']['tipo'] == 'HUMEDAD' &&
              item['zona_consejo']['tipo'] == 'SUELO') {
            minHumedadSuelo =
                double.tryParse(item['valor_minimo']) ?? minHumedadSuelo;
            maxHumedadSuelo =
                double.tryParse(item['valor_maximo']) ?? maxHumedadSuelo;
          }
          if (item['tipo_medida']['tipo'] == 'HUMEDAD' &&
              item['zona_consejo']['tipo'] == 'AMBIENTE') {
            minHumedadAmbiente =
                double.tryParse(item['valor_minimo']) ?? minHumedadAmbiente;
            maxHumedadAmbiente =
                double.tryParse(item['valor_maximo']) ?? maxHumedadAmbiente;
          }
          if (item['tipo_medida']['tipo'] == 'LUMINOSIDAD') {
            minLuz = double.tryParse(item['valor_minimo']) ?? minLuz;
            maxLuz = double.tryParse(item['valor_maximo']) ?? maxLuz;
          }
          if (item['tipo_medida']['tipo'] == 'TEMPERATURA') {
            minTemperatura =
                double.tryParse(item['valor_minimo']) ?? minTemperatura;
            maxTemperatura =
                double.tryParse(item['valor_maximo']) ?? maxTemperatura;
          }
        }
        // HUMEDAD SUELO
        if (humedadSuelo < minHumedadSuelo) {
          humedadSueloCumplida = false;
          mensajeHumedadSuelo = "Riega la planta, necesita más agua.";
        } else if (humedadSuelo > maxHumedadSuelo) {
          humedadSueloCumplida = false;
          mensajeHumedadSuelo =
          "No riegues más, el suelo está demasiado húmedo.";
        } else {
          humedadSueloCumplida = true;
          mensajeHumedadSuelo = "Humedad del suelo en rango óptimo.";
        }

        // HUMEDAD AMBIENTE
        if (humedadAmbiente < minHumedadAmbiente) {
          humedadAmbienteCumplida = false;
          mensajeHumedadAmbiente =
          "Aumenta la humedad del aire, pon un humidificador cerca.";
        } else if (humedadAmbiente > maxHumedadAmbiente) {
          humedadAmbienteCumplida = false;
          mensajeHumedadAmbiente = "Reduce la humedad, ventila el espacio.";
        } else {
          humedadAmbienteCumplida = true;
          mensajeHumedadAmbiente = "Humedad del ambiente en rango óptimo.";
        }

        // LUMINOSIDAD
        if (luz < minLuz) {
          luzCumplida = false;
          mensajeLuz =
          "La planta necesita más luz, colócala en un lugar más iluminado.";
        } else if (luz > maxLuz) {
          luzCumplida = false;
          mensajeLuz = "La planta recibe demasiada luz, ponla en sombra.";
        } else {
          luzCumplida = true;
          mensajeLuz = "Luminosidad en rango óptimo.";
        }

        // TEMPERATURA
        if (temperatura < minTemperatura) {
          temperaturaCumplida = false;
          mensajeTemperatura =
          "Hace demasiado frío, acerca la planta a un lugar más cálido.";
        } else if (temperatura > maxTemperatura) {
          temperaturaCumplida = false;
          mensajeTemperatura = "Hace demasiado calor, aleja la planta del sol.";
        } else {
          temperaturaCumplida = true;
          mensajeTemperatura = "Temperatura en rango óptimo.";
        }
      });
    }
  }

  Future<void> verificarCambioTierra() async {
    final prefs = await SharedPreferences.getInstance();
    String? fechaGuardada = prefs.getString('fechaCambioTierra');

    if (fechaGuardada != null) {
      print("Fecha guardada en SharedPreferences: $fechaGuardada");
      DateTime ultimaFecha = DateTime.parse(fechaGuardada);
      DateTime ahora = DateTime.now();
      Duration diferencia = ahora.difference(ultimaFecha);

      if (diferencia.inDays >= 90) {
        setState(() {
          cambioTierraCumplida = false;
          mensajeCambioTierra =
          "Cambia la tierra de la planta, ya han pasado 3 meses.";
        });
      } else {
        setState(() {
          cambioTierraCumplida = true;
          mensajeCambioTierra = "Cambio de tierra reciente, todo en orden.";
        });
      }
    } else {
      print("No hay fecha guardada en SharedPreferences.");
      setState(() {
        cambioTierraCumplida = false;
        mensajeCambioTierra = "Cambia la tierra de la planta.";
      });
    }
  }

  Future<void> confirmarCambioTierra() async {
    final prefs = await SharedPreferences.getInstance();
    DateTime ahora = DateTime.now();
    await prefs.setString('fechaCambioTierra', ahora.toIso8601String());

    setState(() {
      cambioTierraCumplida = true;
      mensajeCambioTierra = "Cambio de tierra reciente, todo en orden.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitos'),
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView( // Permite hacer scroll si hay muchos hitos
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text(
                "Progreso de Hitos",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              ExpansionTile(
                title: const Text("Hitos Diarios", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
                children: [
                  buildHitoCard(mensajeHumedadSuelo, humedadSueloCumplida,
                      Icons.water_drop),
                  buildHitoCard(mensajeHumedadAmbiente, humedadAmbienteCumplida,
                      Icons.water_drop),
                  buildHitoCard(mensajeLuz, luzCumplida, Icons.wb_sunny),
                  buildHitoCard(mensajeTemperatura, temperaturaCumplida,
                      Icons.thermostat),
                ],
              ),

              ExpansionTile(
                title: const Text("Hitos Mensuales", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
                children: [
                  buildHitoCardTierra(
                      mensajeCambioTierra, cambioTierraCumplida, Icons.grass,
                      isCambioTierra: true),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationCustom(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }


  Widget buildHitoCard(String mensaje, bool? cumplido, IconData icono) {
    Color cardColor;
    Color iconColor;
    String estadoTexto;
    IconData estadoIcono;

    if (cumplido == null) {
      cardColor = Colors.black12;
      iconColor = Colors.black;
      estadoTexto = "Cargando...";
      estadoIcono = Icons.hourglass_empty;
    } else if (cumplido) {
      cardColor = Colors.green[100]!;
      iconColor = Colors.green;
      estadoTexto = "Completado";
      estadoIcono = Icons.check_circle;
    } else {
      cardColor = Colors.red[100]!;
      iconColor = Colors.red;
      estadoTexto = "Pendiente";
      estadoIcono = Icons.warning;
    }
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: cardColor,
      child: ListTile(
        leading: Icon(icono, size: 40, color: iconColor),
        title: Text(mensaje,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(
            estadoTexto, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(estadoIcono, color: iconColor, size: 30),
      ),
    );
  }

  Widget buildHitoCardTierra(String mensaje, bool? cumplido, IconData icono,
      {bool isCambioTierra = false}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: cumplido == true ? Colors.green[100] : Colors.red[100],
      child: ListTile(
        leading: Icon(icono, size: 40,
            color: cumplido == true ? Colors.green : Colors.red),
        title: Text(mensaje,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

        // Solo permite el clic si el hito no está cumplido
        onTap: (cumplido == true) ? null : () {
          if (isCambioTierra) {
            showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: const Text("Confirmar cambio de tierra"),
                    content: const Text(
                        "¿Has cambiado la tierra de la planta?"),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context),
                          child: const Text("Cancelar")),
                      TextButton(onPressed: () {
                        confirmarCambioTierra();
                        Navigator.pop(context);
                      }, child: const Text("Sí, la cambié")),
                    ],
                  ),
            );
          }
        },
      ),
    );
  }
}
