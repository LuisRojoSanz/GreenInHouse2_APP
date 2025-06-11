import 'package:flutter/material.dart';
import 'pantalla_inicio.dart';
import 'generated/l10n.dart';

/// - `_mostrandoDialogoConexion`: variable booleana que impide que se muestren
/// múltiples diálogos de conexión simultáneamente.
bool _mostrandoDialogoConexion = false;

/// Función que muestra un diálogo de error de conexión si no hay conexión disponible.
///
/// Verifica si ya se está mostrando un diálogo para evitar superposiciones.
/// Si no se está mostrando, abre un `AlertDialog` que informa al usuario
/// que no hay conexión a internet y permite volver a la pantalla principal al pulsar "Aceptar".
///
/// Este método se va a usar en todas las pantallas que requieran de realizar
/// peticiones a la API.
///
/// @param context Representa la ubicación del widget en el árbol de widgets.
/// Se utiliza para mostrar el diálogo y para acceder a traducciones mediante `S.of(context)`.
///
/// @return Un `Future<void>` que finaliza cuando se cierra el diálogo.
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
