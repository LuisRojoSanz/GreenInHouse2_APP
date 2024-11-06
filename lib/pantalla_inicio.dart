import 'package:flutter/material.dart';
import 'package:greeninhouse2/pantalla_creacionplantas.dart';
import 'generated/l10n.dart'; // Importa el archivo generado correctamente

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(S.of(context).MainTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a la app de Plantas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Aquí puedes gestionar tus plantas y macetas.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de creación de plantas
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(title: S.of(context).addPlantButton),
                  ),
                );
              },
              child: const Text('Añadir Planta'),
            ),
          ],
        ),
      ),
    );
  }
}

class PantallaCreacionPlantas extends StatelessWidget {
  const PantallaCreacionPlantas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Planta'),
      ),
      body: const Center(
        child: Text('Pantalla de Creación de Plantas'),
      ),
    );
  }
}
