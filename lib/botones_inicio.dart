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
          icon: const Icon(Icons.show_chart),
          label: S.of(context).graphs,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.event),
          label: S.of(context).milestones,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: S.of(context).home,
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
        if (index == 0) { // Gráficas
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const GraficasScreen()),
          );
        } else if (index == 1) { // Hitos
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Hitos()),
          );
        } else if (index == 2) { // Inicio
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PantallaInicio()),
          );
        } else if (index == 3) { // Ajustes
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Ajustes()),
          );
        } else {
          onTap(index);
        }

        // Solo llama a onLocaleChange si no es null
        if (onLocaleChange != null) {
          onLocaleChange!(Locale('es'));
        }
      },
    );
  }
}
