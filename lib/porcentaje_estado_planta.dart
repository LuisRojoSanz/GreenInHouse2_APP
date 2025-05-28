import 'package:flutter/material.dart';
import 'package:greeninhouse2/generated/l10n.dart';
import 'api_service.dart';
import 'planta_service.dart';


class PorcentajeEstadoPlanta extends StatefulWidget {
  const PorcentajeEstadoPlanta({super.key});

  @override
  State<PorcentajeEstadoPlanta> createState() => _PorcentajeEstadoPlantaState();
}

class _PorcentajeEstadoPlantaState extends State<PorcentajeEstadoPlanta> {
  final ApiService apiService = ApiService('http://192.168.1.240:5000/api/v1');
  String plantName = '';
  double? progreso = 1;



  @override
  void initState() {
    super.initState();
    cargarNombreYCalcularProgreso();
  }

  Future<void> cargarNombreYCalcularProgreso() async {
    final nombre = await PlantaService.obtenerNombrePlantaActiva();
    if (!mounted) return;
    setState(() {
      plantName = nombre ?? '';
    });
    calcularProgreso();
  }

  Future<void> calcularProgreso() async {
    String endpointSensores =
        'RegistrosSensores/Avg/FromPlant/AgroupByIntervals/ToGraph?np=$plantName&d=1&ff=${DateTime
        .now()}';
    String endpointRangos = 'Consejos/Plantas/All/FromPlant?np=$plantName';

    final datosSensores = await apiService.get(endpointSensores);
    final datosRangos = await apiService.get(endpointRangos);

    if (!mounted || datosSensores == null || datosRangos == null) return;

    double humedadSuelo = datosSensores['MACETA']['HUMEDAD']['lista_valores_medios'].last.toDouble();
    double humedadAmbiente = datosSensores['AMBIENTE']['HUMEDAD']['lista_valores_medios'].last.toDouble();
    double luz = datosSensores['AMBIENTE']['LUMINOSIDAD']['lista_valores_medios'].last.toDouble();
    double temperatura = datosSensores['AMBIENTE']['TEMPERATURA']['lista_valores_medios'].last.toDouble();

    double minHumedadSuelo = 40.0, maxHumedadSuelo = 70.0;
    double minHumedadAmbiente = 30.0, maxHumedadAmbiente = 60.0;
    double minLuz = 60.0, maxLuz = 90.0;
    double minTemperatura = 10.0, maxTemperatura = 25.0;

    for (var item in datosRangos) {
      if (item['tipo_medida']['tipo'] == 'HUMEDAD' && item['zona_consejo']['tipo'] == 'SUELO') {
        minHumedadSuelo = double.tryParse(item['valor_minimo']) ?? minHumedadSuelo;
        maxHumedadSuelo = double.tryParse(item['valor_maximo']) ?? maxHumedadSuelo;
      }
      if (item['tipo_medida']['tipo'] == 'HUMEDAD' && item['zona_consejo']['tipo'] == 'AMBIENTE') {
        minHumedadAmbiente = double.tryParse(item['valor_minimo']) ?? minHumedadAmbiente;
        maxHumedadAmbiente = double.tryParse(item['valor_maximo']) ?? maxHumedadAmbiente;
      }
      if (item['tipo_medida']['tipo'] == 'LUMINOSIDAD') {
        minLuz = double.tryParse(item['valor_minimo']) ?? minLuz;
        maxLuz = double.tryParse(item['valor_maximo']) ?? maxLuz;
      }
      if (item['tipo_medida']['tipo'] == 'TEMPERATURA') {
        minTemperatura = double.tryParse(item['valor_minimo']) ?? minTemperatura;
        maxTemperatura = double.tryParse(item['valor_maximo']) ?? maxTemperatura;
      }
    }

    int hitosCorrectos = 0;
    if (humedadSuelo >= minHumedadSuelo && humedadSuelo <= maxHumedadSuelo) hitosCorrectos++;
    if (humedadAmbiente >= minHumedadAmbiente && humedadAmbiente <= maxHumedadAmbiente) hitosCorrectos++;
    if (luz >= minLuz && luz <= maxLuz) hitosCorrectos++;
    if (temperatura >= minTemperatura && temperatura <= maxTemperatura) hitosCorrectos++;

    setState(() {
      progreso = hitosCorrectos / 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double valorProgreso = progreso ?? 1.0;
    final int porcentaje = (valorProgreso * 100).toInt();

    final String estado = switch (porcentaje) {
      100 when progreso == 1.0 => S.of(context).loadingState,
      0 => S.of(context).veryBadState,
      25 => S.of(context).badState,
      50 => S.of(context).regularState,
      75 => S.of(context).goodState,
      100 => S.of(context).veryGoodState,
      _ => S.of(context).unknownState,
    };

    return Column(
      children: [
        Text(
          estado,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: valorProgreso,
          backgroundColor: Colors.grey.shade300,
          color: Colors.blue,
          minHeight: 8,
        ),
        const SizedBox(height: 10),
        Text(
          S.of(context).healthStatus(porcentaje),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}


