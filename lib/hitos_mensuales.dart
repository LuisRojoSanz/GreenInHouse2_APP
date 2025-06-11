import 'package:flutter/material.dart';
import 'package:greeninhouse2/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Registra la fecha de cambio de tierra en `SharedPreferences` y actualiza el estado del hito.
///
/// Atributos:
/// - `setStateCallback`: Función de actualización del estado de la pantalla.
///
/// Este método guarda la fecha actual como la fecha de cambio de tierra y luego
/// llama a `setStateCallback` con `true` para indicar que el hito de cambio de tierra ha sido realizado.
Future<void> confirmarCambioTierra(Function setStateCallback) async {
  final prefs = await SharedPreferences.getInstance();
  DateTime ahora = DateTime.now();
  await prefs.setString('fechaCambioTierra', ahora.toIso8601String());

  setStateCallback(true);
}

/// Registra la fecha de fertilización en `SharedPreferences` y actualiza el estado del hito.
///
/// Atributos:
/// - `setStateCallback`: Función de actualización del estado de la pantalla.
///
/// Este método guarda la fecha actual como la fecha de fertilización y luego
/// llama a `setStateCallback` con `true` para indicar que el hito de fertilización ha sido realizado.
Future<void> confirmarFertilizante(Function setStateCallback) async {
  final prefs = await SharedPreferences.getInstance();
  DateTime ahora = DateTime.now();
  await prefs.setString('fechaFertilizante', ahora.toIso8601String());

  setStateCallback(true);
}

/// Construye un widget de tarjeta para representar el estado del hito de cambio de tierra,
/// mostrando su estado (pendiente, realizado, etc.) y detalles adicionales.
///
/// Atributos:
/// - `cumplido`: Indica si el hito de cambio de tierra ha sido completado.
/// - `icono`: El icono asociado al hito.
/// - `isCambioTierra`: Booleano que indica si el hito corresponde a un cambio de tierra.
/// - `onEstadoCambioTierraActualizado`: Callback que se ejecuta al actualizar el estado del hito.
///
/// Esta función muestra un `Card` con el estado del hito de cambio de tierra. Los colores y los
/// iconos cambian según el estado del hito, y si el hito no está cumplido, se presenta un diálogo
/// de confirmación al tocar la tarjeta.
Widget buildHitoCardTierra({
  required bool? cumplido,
  required IconData icono,
  bool isCambioTierra = false,
  required Function(bool) onEstadoCambioTierraActualizado,
}) {
  return FutureBuilder<SharedPreferences>(
    future: SharedPreferences.getInstance(),
    builder: (context, snapshot) {
      Color cardColor = Colors.black12;
      Color iconColor = Colors.black;
      String estadoTexto = S.of(context).loadingMessage;
      String mensaje = S.of(context).loadingMessage;
      bool isCompletado = false;
      IconData estadoIcono = Icons.hourglass_empty;

      // Lógica para manejar los estados de la tarjeta
      if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
        final prefs = snapshot.data!;
        String? nombrePlanta = prefs.getString('nombrePlantaActiva');
        if (nombrePlanta == null || nombrePlanta.isEmpty) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: cardColor,
            child: ListTile(
              leading: Icon(icono, size: 40, color: iconColor),
              title: Text(mensaje, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text(estadoTexto, style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(estadoIcono, color: iconColor, size: 30),
            ),
          );
        }
        String? fechaStr = prefs.getString('fechaCambioTierra');
        int frecuencia = prefs.getInt('frecuenciaCambioTierra') ?? 90;

        if (fechaStr != null) {
          DateTime fechaCambio = DateTime.parse(fechaStr);
          DateTime proximoCambio = fechaCambio.add(Duration(days: frecuencia));
          int diasRestantes = proximoCambio.difference(DateTime.now()).inDays;

          // Cambios en el estado de la tarjeta según la fecha de cambio de tierra
          if (diasRestantes > 30) {
            cardColor = Colors.green[100]!;
            iconColor = Colors.green;
            estadoTexto = S.of(context).completed;
            mensaje = S.of(context).recentSoilChange;
            estadoIcono = Icons.check_circle;
            isCompletado = true;
          } else if (diasRestantes > 0 && diasRestantes <= 30) {
            cardColor = Colors.yellow[100]!;
            iconColor = Colors.orange;
            estadoTexto = S.of(context).soonToChange;
            mensaje = S.of(context).soilChangeInLessThanMonth;
            estadoIcono = Icons.warning_amber;
          } else {
            cardColor = Colors.red[100]!;
            iconColor = Colors.red;
            estadoTexto = S.of(context).pending;
            mensaje = S.of(context).soilChangeOverdue;
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
                  Text("${S.of(context).nextChange}: ${proximoCambio.day.toString().padLeft(2, '0')}/${proximoCambio.month.toString().padLeft(2, '0')}/${proximoCambio.year}", style: const TextStyle(fontSize: 14)),
                ],
              ),
              onTap: (isCompletado) ? null : () {
                if (isCambioTierra) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(S.of(context).confirmSoilChangeTitle),
                      content: Text(S.of(context).confirmSoilChangeQuestion),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text(S.of(context).cancel),),
                        TextButton(
                          onPressed: () {
                            confirmarCambioTierra((bool cumplido) {
                              onEstadoCambioTierraActualizado(cumplido);
                            });
                            Navigator.pop(context);
                          },
                          child: Text(S.of(context).yesChanged),
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
          estadoTexto = S.of(context).pending;
          mensaje = S.of(context).newPlantSoilMessage;
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
                        title: Text(S.of(context).confirmSoilChangeTitle),
                        content: Text(S.of(context).confirmSoilChangeQuestion),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text(S.of(context).cancel),),
                        TextButton(
                          onPressed: () {
                            confirmarCambioTierra((bool cumplido) {
                              onEstadoCambioTierraActualizado(cumplido);
                            });
                            Navigator.pop(context);
                          },
                          child: Text(S.of(context).yesChanged),
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

/// Construye un widget de tarjeta para representar el estado del hito de fertilización,
/// mostrando su estado (pendiente, realizado, etc.) y detalles adicionales.
///
/// Atributos:
/// - `cumplido`: Indica si el hito de fertilización ha sido completado.
/// - `icono`: El icono asociado al hito.
/// - `isFertilizante`: Booleano que indica si el hito corresponde a un fertilizante.
/// - `onEstadoFertilizanteActualizado`: Callback que se ejecuta al actualizar el estado del hito.
///
/// Esta función muestra un `Card` con el estado del hito de fertilización. Los colores y los
/// iconos cambian según el estado del hito, y si el hito no está cumplido, se presenta un diálogo
/// de confirmación al tocar la tarjeta.
Widget buildHitoCardFertilizante({
  required bool? cumplido,
  required IconData icono,
  bool isFertilizante = false,
  required Function(bool) onEstadoFertilizanteActualizado,
}) {
  return FutureBuilder<SharedPreferences>(
    future: SharedPreferences.getInstance(),
    builder: (context, snapshot) {
      Color cardColor = Colors.black12;
      Color iconColor = Colors.black;
      String estadoTexto = S.of(context).loadingMessage;
      String mensaje = S.of(context).loadingMessage;
      bool isCompletado = false;
      IconData estadoIcono = Icons.hourglass_empty;

      if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
        final prefs = snapshot.data!;
        String? nombrePlanta = prefs.getString('nombrePlantaActiva');
        if (nombrePlanta == null || nombrePlanta.isEmpty) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: cardColor,
            child: ListTile(
              leading: Icon(icono, size: 40, color: iconColor),
              title: Text(mensaje, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text(estadoTexto, style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(estadoIcono, color: iconColor, size: 30),
            ),
          );
        }
        String? fechaStr = prefs.getString('fechaFertilizante');
        int frecuencia = prefs.getInt('frecuenciaFertilizante') ?? 90;

        if (fechaStr != null) {
          DateTime fechaCambio = DateTime.parse(fechaStr);
          DateTime proximoCambio = fechaCambio.add(Duration(days: frecuencia));
          int diasRestantes = proximoCambio.difference(DateTime.now()).inDays;

          if (diasRestantes > 30) {
            cardColor = Colors.green[100]!;
            iconColor = Colors.green;
            estadoTexto = S.of(context).completed;
            mensaje = S.of(context).fertilizerRecentlyAdded;
            estadoIcono = Icons.check_circle;
            isCompletado = true;
          } else if (diasRestantes > 0 && diasRestantes <= 30) {
            cardColor = Colors.yellow[100]!;
            iconColor = Colors.orange;
            estadoTexto = S.of(context).soonToAdd;
            mensaje = S.of(context).fertilizerInLessThanMonth;
            estadoIcono = Icons.warning_amber;
          } else {
            cardColor = Colors.red[100]!;
            iconColor = Colors.red;
            estadoTexto = S.of(context).pending;
            mensaje = S.of(context).fertilizerOverdue;
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
                  Text("${S.of(context).nextChange}: ${proximoCambio.day.toString().padLeft(2, '0')}/${proximoCambio.month.toString().padLeft(2, '0')}/${proximoCambio.year}", style: const TextStyle(fontSize: 14)),
                ],
              ),
              onTap: (isCompletado) ? null : () {
                if (isFertilizante) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(S.of(context).confirmSoilChangeTitle),
                      content: Text(S.of(context).confirmSoilChangeQuestion),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text(S.of(context).cancel),),
                        TextButton(
                          onPressed: () {
                            confirmarFertilizante((bool cumplido) {
                              onEstadoFertilizanteActualizado(cumplido);
                            });
                            Navigator.pop(context);
                          },
                          child: Text(S.of(context).yesChanged),
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
          estadoTexto = S.of(context).pending;
          mensaje = S.of(context).newPlantFertilizerMessage;
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
                      title: Text(S.of(context).confirmFertilizerTitle),
                      content: Text(S.of(context).confirmFertilizerQuestion),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text(S.of(context).cancel),),
                        TextButton(
                          onPressed: () {
                            confirmarFertilizante((bool cumplido) {
                              onEstadoFertilizanteActualizado(cumplido);
                            });
                            Navigator.pop(context);
                          },
                          child: Text(S.of(context).yesAdded),
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
