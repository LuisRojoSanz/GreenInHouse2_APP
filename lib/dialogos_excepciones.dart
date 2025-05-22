import 'package:flutter/material.dart';
import 'pantalla_inicio.dart'; // Ajusta según la ruta real de tu archivo

bool _mostrandoDialogoConexion = false;

Future<void> mostrarDialogoErrorConexion(BuildContext context) async {
  if (_mostrandoDialogoConexion || !context.mounted) return;

  _mostrandoDialogoConexion = true;

  await showDialog(
    context: context,
    barrierDismissible: false, // impide que se cierre con tap fuera
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: const [
          Icon(Icons.wifi_off, color: Colors.redAccent),
          SizedBox(width: 10),
          Text("Sin conexión"),
        ],
      ),
      content: const Text(
        "No se pudo contactar con el servidor.\n"
            "Por favor, revisa tu conexión a la red.",
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cierra el diálogo
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const PantallaInicio()),
                  (route) => false,
            );
          },
          child: const Text(
            "Aceptar",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );

  _mostrandoDialogoConexion = false;
}
