import 'package:flutter/material.dart';
import 'package:greeninhouse2/generated/l10n.dart';


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

