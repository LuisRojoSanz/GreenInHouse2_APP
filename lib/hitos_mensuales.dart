import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> confirmarCambioTierra(Function setStateCallback) async {
  final prefs = await SharedPreferences.getInstance();
  DateTime ahora = DateTime.now();
  await prefs.setString('fechaCambioTierra', ahora.toIso8601String());

  setStateCallback(true, "Cambio de tierra reciente, todo en orden.");
}

Future<void> confirmarFertilizante(Function setStateCallback) async {
  final prefs = await SharedPreferences.getInstance();
  DateTime ahora = DateTime.now();
  await prefs.setString('fechaFertilizante', ahora.toIso8601String());

  setStateCallback(true, "Fertilizante añadido recientemente, todo en orden.");
}

Future<void> verificarCambioTierra(Function setStateCallback) async {
  final prefs = await SharedPreferences.getInstance();
  String? fechaGuardada = prefs.getString('fechaCambioTierra');

  if (fechaGuardada != null) {
    DateTime ultimaFecha = DateTime.parse(fechaGuardada);
    DateTime ahora = DateTime.now();
    Duration diferencia = ahora.difference(ultimaFecha);

    int frecuencia = prefs.getInt('frecuenciaCambioTierra') ?? 90;
    if (diferencia.inDays >= frecuencia) {
      setStateCallback(false, "Cambia la tierra de la planta, ya han pasado 3 meses.");
    } else {
      setStateCallback(true, "Cambio de tierra reciente, todo en orden.");
    }
  } else {
    setStateCallback(false, "Cambia la tierra de la planta.");
  }
}

Future<void> verificarFertilizante(Function setStateCallback) async {
  final prefs = await SharedPreferences.getInstance();
  String? fechaGuardada = prefs.getString('fechaFertilizante');

  if (fechaGuardada != null) {
    DateTime ultimaFecha = DateTime.parse(fechaGuardada);
    DateTime ahora = DateTime.now();
    Duration diferencia = ahora.difference(ultimaFecha);

    int frecuencia = prefs.getInt('frecuenciaFertilizante') ?? 90;
    if (diferencia.inDays >= frecuencia) {
      setStateCallback(false, "Añade fertilizante, ya han pasado 3 meses.");
    } else {
      setStateCallback(true, "Fertilizante añadido recientemente.");
    }
  } else {
    setStateCallback(false, "Añade fertilizante a la planta.");
  }
}

Widget buildHitoCardTierra({
  required String mensaje,
  required bool? cumplido,
  required IconData icono,
  bool isCambioTierra = false,
  required Function(bool, String) onEstadoCambioTierraActualizado,
}) {
  return FutureBuilder<SharedPreferences>(
    future: SharedPreferences.getInstance(),
    builder: (context, snapshot) {
      Color cardColor = Colors.black12;
      Color iconColor = Colors.black;
      String estadoTexto = "Cargando...";
      IconData estadoIcono = Icons.hourglass_empty;

      if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
        final prefs = snapshot.data!;
        String? fechaStr = prefs.getString('fechaCambioTierra');
        int frecuencia = prefs.getInt('frecuenciaCambioTierra') ?? 90;

        if (fechaStr != null) {
          DateTime fechaCambio = DateTime.parse(fechaStr);
          DateTime proximoCambio = fechaCambio.add(Duration(days: frecuencia));
          int diasRestantes = proximoCambio.difference(DateTime.now()).inDays;

          if (diasRestantes > 30) {
            cardColor = Colors.green[100]!;
            iconColor = Colors.green;
            estadoTexto = "Completado";
            estadoIcono = Icons.check_circle;
          } else if (diasRestantes > 0 && diasRestantes <= 30) {
            cardColor = Colors.yellow[100]!;
            iconColor = Colors.orange;
            estadoTexto = "Pronto a cambiar";
            estadoIcono = Icons.warning_amber;
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
              title: Text(mensaje, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(estadoTexto, style: TextStyle(fontWeight: FontWeight.bold, color: iconColor)),
                  Text("Próximo cambio: ${proximoCambio.day.toString().padLeft(2, '0')}/${proximoCambio.month.toString().padLeft(2, '0')}/${proximoCambio.year}", style: const TextStyle(fontSize: 14)),
                ],
              ),
              onTap: (estadoTexto == "Completado") ? null : () {
                if (isCambioTierra) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Confirmar cambio de tierra"),
                      content: const Text("¿Has cambiado la tierra de la planta?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
                        TextButton(
                          onPressed: () {
                            confirmarCambioTierra((bool cumplido, String msg) {
                              onEstadoCambioTierraActualizado(cumplido, msg);
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("Sí, la cambié"),
                        ),
                      ],
                    ),
                  );
                }
              },
              trailing: Icon(estadoIcono, color: iconColor, size: 30),
            ),
          );
        } else {
          // Primer uso: no hay fecha registrada aún
          cardColor = Colors.red[100]!;
          iconColor = Colors.red;
          estadoTexto = "Pendiente";
          estadoIcono = Icons.warning;

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: cardColor,
            child: ListTile(
              leading: Icon(icono, size: 40, color: iconColor),
              title: Text(mensaje, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text(estadoTexto, style: TextStyle(fontWeight: FontWeight.bold, color: iconColor)),
              onTap: () {
                if (isCambioTierra) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Confirmar cambio de tierra"),
                      content: const Text("¿Has cambiado la tierra de la planta por primera vez?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
                        TextButton(
                          onPressed: () {
                            confirmarCambioTierra((bool cumplido, String msg) {
                              onEstadoCambioTierraActualizado(cumplido, msg);
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("Sí, la cambié"),
                        ),
                      ],
                    ),
                  );
                }
              },
              trailing: Icon(estadoIcono, color: iconColor, size: 30),
            ),
          );
        }
      }
      return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: cardColor,
        child: ListTile(
          leading: Icon(icono, size: 40, color: iconColor),
          title: Text(mensaje, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Text(estadoTexto, style: TextStyle(fontWeight: FontWeight.bold, color: iconColor)),
          trailing: Icon(estadoIcono, color: iconColor, size: 30),
        ),
      );
    },
  );
}

Widget buildHitoCardFertilizante({
  required String mensaje,
  required bool? cumplido,
  required IconData icono,
  bool isFertilizante = false,
  required Function(bool, String) onEstadoFertilizanteActualizado,
}) {
  return FutureBuilder<SharedPreferences>(
    future: SharedPreferences.getInstance(),
    builder: (context, snapshot) {
      Color cardColor = Colors.black12;
      Color iconColor = Colors.black;
      String estadoTexto = "Cargando...";
      IconData estadoIcono = Icons.hourglass_empty;

      if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
        final prefs = snapshot.data!;
        String? fechaStr = prefs.getString('fechaFertilizante');
        int frecuencia = prefs.getInt('frecuenciaFertilizante') ?? 90;

        if (fechaStr != null) {
          DateTime fechaCambio = DateTime.parse(fechaStr);
          DateTime proximoCambio = fechaCambio.add(Duration(days: frecuencia));
          int diasRestantes = proximoCambio.difference(DateTime.now()).inDays;

          if (diasRestantes > 30) {
            cardColor = Colors.green[100]!;
            iconColor = Colors.green;
            estadoTexto = "Completado";
            estadoIcono = Icons.check_circle;
          } else if (diasRestantes > 0 && diasRestantes <= 30) {
            cardColor = Colors.yellow[100]!;
            iconColor = Colors.orange;
            estadoTexto = "Pronto a añadir";
            estadoIcono = Icons.warning_amber;
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
              title: Text(mensaje, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(estadoTexto, style: TextStyle(fontWeight: FontWeight.bold, color: iconColor)),
                  Text("Próxima aplicación: ${proximoCambio.day.toString().padLeft(2, '0')}/${proximoCambio.month.toString().padLeft(2, '0')}/${proximoCambio.year}", style: const TextStyle(fontSize: 14)),
                ],
              ),
              onTap: (estadoTexto == "Completado") ? null : () {
                if (isFertilizante) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Confirmar fertilizante"),
                      content: const Text("¿Has añadido fertilizante a la planta?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
                        TextButton(
                          onPressed: () {
                            confirmarFertilizante((bool cumplido, String msg) {
                              onEstadoFertilizanteActualizado(cumplido, msg);
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("Sí, lo he hecho"),
                        ),
                      ],
                    ),
                  );
                }
              },
              trailing: Icon(estadoIcono, color: iconColor, size: 30),
            ),
          );
        }else {
          cardColor = Colors.red[100]!;
          iconColor = Colors.red;
          estadoTexto = "Pendiente";
          estadoIcono = Icons.warning;

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: cardColor,
            child: ListTile(
              leading: Icon(icono, size: 40, color: iconColor),
              title: Text(mensaje, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text(estadoTexto, style: TextStyle(fontWeight: FontWeight.bold, color: iconColor)),
              onTap: () {
                if (isFertilizante) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Confirmar fertilizante"),
                      content: const Text("¿Has añadido fertilizante a la planta por primera vez?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
                        TextButton(
                          onPressed: () {
                            confirmarFertilizante((bool cumplido, String msg) {
                              onEstadoFertilizanteActualizado(cumplido, msg);
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("Sí, lo he hecho"),
                        ),
                      ],
                    ),
                  );
                }
              },
              trailing: Icon(estadoIcono, color: iconColor, size: 30),
            ),
          );
        }
      }

      return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: cardColor,
        child: ListTile(
          leading: Icon(icono, size: 40, color: iconColor),
          title: Text(mensaje, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Text(estadoTexto, style: TextStyle(fontWeight: FontWeight.bold, color: iconColor)),
          trailing: Icon(estadoIcono, color: iconColor, size: 30),
        ),
      );
    },
  );
}
