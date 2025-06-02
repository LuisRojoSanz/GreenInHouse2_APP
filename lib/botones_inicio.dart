import 'package:flutter/material.dart';
import 'package:greeninhouse2/hitos.dart';
import 'pantalla_graficas.dart';
import 'pantalla_inicio.dart';
import 'generated/l10n.dart';
import 'pantalla_ajustes.dart';

class BottomNavigationCustom extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final ValueChanged<Locale>? onLocaleChange;

  const BottomNavigationCustom({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.onLocaleChange,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: S.of(context).home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.show_chart),
          label: S.of(context).graphs,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.event),
          label: S.of(context).milestones,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: S.of(context).settings,
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        Widget? destination;

        switch (index) {
          case 0:
            destination = const PantallaInicio();
            break;
          case 1:
            destination = const GraficasScreen();
            break;
          case 2:
            destination = const Hitos();
            break;
          case 3:
            destination = const Ajustes();
            break;
        }

        if (destination != null && index != currentIndex) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => destination!),
          );
        }

        // Actualiza el índice si es necesario
        onTap(index);

        // Cambia el idioma si se ha definido un callback
        if (onLocaleChange != null) {
          onLocaleChange!(Locale('es'));
        }
      },
    );
  }
}
