import 'package:flutter/material.dart';
import 'pantalla_inicio.dart';
import 'generated/l10n.dart';

bool _mostrandoDialogoConexion = false;

Future<void> mostrarDialogoErrorConexion(BuildContext context) async {
  if (_mostrandoDialogoConexion || !context.mounted) return;

  _mostrandoDialogoConexion = true;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          const Icon(Icons.wifi_off, color: Colors.redAccent),
          const SizedBox(width: 10),
          Text(S.of(context).noConnectionTitle),
        ],
      ),
      content: Text(
        S.of(context).noConnectionMessage,
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const PantallaInicio()),
                  (route) => false,
            );
          },
          child: Text(
            S.of(context).noConnectionAccept,
            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    ),
  );

  _mostrandoDialogoConexion = false;
}
