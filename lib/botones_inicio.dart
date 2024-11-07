import 'package:flutter/material.dart';
import 'generated/l10n.dart';

class BottomNavigationCustom extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavigationCustom({
    super.key,
    required this.currentIndex,
    required this.onTap,
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
      onTap: onTap,
    );
  }
}
