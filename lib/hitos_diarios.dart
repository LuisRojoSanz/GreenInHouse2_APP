import 'package:flutter/material.dart';
import 'package:greeninhouse2/generated/l10n.dart';

/// Construye un widget `Card` para representar un hito de la planta, mostrando su estado actual.
/// La tarjeta tiene un icono, un mensaje y un estado que puede ser "completado", "pendiente" o "en carga".
///
/// Atributos:
/// - `context`: El contexto de la aplicación, utilizado para acceder a recursos como traducciones.
/// - `mensaje`: El texto que describe el hito.
/// - `cumplido`: Un valor booleano que indica si el hito ha sido completado (`true`), está pendiente (`false`),
///   o está en proceso de carga (`null`).
/// - `icono`: El icono que representa el tipo de hito.
///
/// La tarjeta cambia su color y muestra un ícono diferente según el estado del hito:
/// - Si `cumplido` es `null`, se muestra un ícono de "hora de espera" y un mensaje de carga.
/// - Si `cumplido` es `true`, se muestra un ícono de "check" con un fondo verde.
/// - Si `cumplido` es `false`, se muestra un ícono de "advertencia" con un fondo rojo.

Widget buildHitoCard(BuildContext context, String mensaje, bool? cumplido, IconData icono) {
  Color cardColor;
  Color iconColor;
  String estadoTexto;
  IconData estadoIcono;

  if (cumplido == null) {
    cardColor = Colors.black12;
    iconColor = Colors.black;
    estadoTexto = S.of(context).loadingMessage;
    estadoIcono = Icons.hourglass_empty;
  } else if (cumplido) {
    cardColor = Colors.green[100]!;
    iconColor = Colors.green;
    estadoTexto = S.of(context).completed;
    estadoIcono = Icons.check_circle;
  } else {
    cardColor = Colors.red[100]!;
    iconColor = Colors.red;
    estadoTexto = S.of(context).pending;
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

