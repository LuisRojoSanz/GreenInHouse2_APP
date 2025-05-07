import 'package:flutter/material.dart';
import 'package:greeninhouse2/api_service.dart';
import 'package:greeninhouse2/pantalla_cambio_idioma.dart';
import 'package:greeninhouse2/pantalla_modificarplanta.dart';
import 'porcentaje_estado_planta.dart';
import 'generated/l10n.dart';
import 'pantalla_creacionplantas.dart';
import 'botones_inicio.dart';
import 'consejos_plantas.dart';
import 'pantalla_comprobacion_sensores.dart';
import 'pantalla_eliminarplanta.dart';
import 'imagen_principal.dart';
import 'planta_service.dart';


class PantallaInicio extends StatefulWidget {
  final void Function(Locale locale)? onLocaleChange;

  const PantallaInicio({super.key, this.onLocaleChange});

  @override
  PantallaInicioState createState() => PantallaInicioState();
}

class PantallaInicioState extends State<PantallaInicio> {
  final int plantLifeDays = 10;
  int _currentIndex = 2;
  bool hayPlantaActiva = false;
  bool cargandoEstadoPlanta = true;
  String plantName = '';


  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _verificarPlantaActiva();
  }

  Future<void> _verificarPlantaActiva() async {
    try {
      final apiService = ApiService('http://192.168.1.240:5000/api/v1');
      final resultado = await apiService.get('Plantas/All/Active');

      final nombre = await PlantaService.obtenerNombrePlantaActiva();

      setState(() {
        hayPlantaActiva = resultado != null && resultado is List && resultado.isNotEmpty;
        plantName = nombre ?? '';
        cargandoEstadoPlanta = false;
      });
    } catch (e) {
      setState(() {
        hayPlantaActiva = false;
        cargandoEstadoPlanta = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GREEN IN HOUSE 2.0'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFC8E6C9), Color(0xFF81C784)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    plantName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(50, 0, 0, 0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: ImagenPrincipal(
                      width: 200,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade300, Colors.green.shade700],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${S.of(context).daysWithLife}: $plantLifeDays',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          S.of(context).plantName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        //Llamda a la clase que muestra por pantalla la barra del estado de la planta
                        const PorcentajeEstadoPlanta(),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConsejosPlantasScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    child: Text(
                      S.of(context).viewPlantTips,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.teal),
              child: Center(
                child: Text(
                  S.of(context).drawer_header,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              title: Text(
                S.of(context).menu_create_plant,
                style: TextStyle(
                  color: hayPlantaActiva ? Colors.grey : Colors.black,
                ),
              ),
              enabled: !hayPlantaActiva,
              onTap: hayPlantaActiva
                  ? null
                  : () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title: S.of(context).title)),
                );
              },
            ),

            ListTile(
              title: Text(S.of(context).menu_modify_plant),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ModificarPlantaScreen()),
                );
              },
            ),
            ListTile(
              title: Text(S.of(context).menu_delete_plant),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EliminarPlantaScreen()),
                );
              },
            ),
            ListTile(
              title: Text(S.of(context).menu_sensor_check),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SensoresActivosScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(S.of(context).change_language),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaCambioIdioma(
                      onLocaleChange: widget.onLocaleChange ?? (locale) {},
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationCustom(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
