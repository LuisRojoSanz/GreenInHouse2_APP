import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:greeninhouse2/generated/l10n.dart';

/// Widget para mostrar y gestionar la imagen principal de una planta.
/// Permite seleccionar una imagen desde la cámara o galería, o eliminarla.
///
/// Atributos:
/// - `width`: Ancho de la imagen mostrada (opcional).
/// - `height`: Alto de la imagen mostrada (opcional).
/// - `fit`: Cómo se ajustará la imagen dentro del contenedor (opcional).
///
/// Este widget muestra la imagen asociada a la planta activa. Si no hay imagen seleccionada,
/// se muestra un contenedor vacío con un ícono y un texto invitando al usuario a añadir una foto.
/// Al tocar el widget, permite elegir entre tomar una foto o seleccionar una imagen desde la galería.
/// Si ya hay una imagen, también se puede eliminar.
class ImagenPrincipal extends StatefulWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;

  const ImagenPrincipal({super.key, this.width, this.height, this.fit});

  @override
  State<ImagenPrincipal> createState() => _ImagenPrincipalState();
}

/// Estado para manejar la lógica de la imagen principal de la planta.
///
/// Atributos:
/// - `_imagen`: Archivo de la imagen seleccionada.
/// - `_hayPlantaActiva`: Indica si hay una planta activa registrada.
/// - `_mostrandoSnackBar`: Controla la visualización del mensaje informativo.
///
/// Este estado maneja la lógica de visualización, selección, y eliminación de la imagen principal de una planta.
/// Verifica si existe una planta activa, y si no es así, muestra un mensaje para informar al usuario.
class _ImagenPrincipalState extends State<ImagenPrincipal> {
  File? _imagen;
  bool _hayPlantaActiva = false;
  bool _mostrandoSnackBar = false;

  @override
  void initState() {
    super.initState();
    _verificarPlantaActiva();
  }

  /// Verifica si hay una planta activa y carga la imagen asociada desde `SharedPreferences`.
  ///
  /// Atributos:
  /// - `path`: Ruta de la imagen guardada en `SharedPreferences`.
  /// - `nombrePlanta`: Nombre de la planta activa guardado en `SharedPreferences`.
  ///
  /// Si se encuentra una imagen previamente guardada, la carga en el estado.
  Future<void> _verificarPlantaActiva() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('imagen_path');
    final nombrePlanta = prefs.getString('nombrePlantaActiva');

    setState(() {
      _imagen = path != null ? File(path) : null;
      _hayPlantaActiva = nombrePlanta != null && nombrePlanta.isNotEmpty;
    });
  }

  /// Permite al usuario seleccionar una imagen desde la cámara o la galería,
  /// o eliminar la imagen actual si ya existe.
  ///
  /// Si no hay planta activa, se muestra un `SnackBar` informando al usuario.
  Future<void> _seleccionarImagen() async {
    if (!_hayPlantaActiva) {
      if (!_mostrandoSnackBar && mounted) {
        _mostrandoSnackBar = true;

        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(S.of(context).photoNeedsPlant),
            backgroundColor: Colors.lightGreen,
            duration: const Duration(seconds: 2),
          ),
        )
            .closed
            .then((_) {
          if (mounted) {
            setState(() {
              _mostrandoSnackBar = false;
            });
          }
        });
      }
      return;
    }

    final picker = ImagePicker();

    final opcion = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: Text(S.of(context).takePhoto),
            onTap: () => Navigator.pop(context, 'camera'),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(S.of(context).chooseFromGallery),
            onTap: () => Navigator.pop(context, 'gallery'),
          ),
          if (_imagen != null)
            ListTile(
              leading: const Icon(Icons.delete),
              title: Text(S.of(context).removePhoto),
              onTap: () => Navigator.pop(context, 'remove'),
            ),
        ],
      ),
    );

    if (opcion == null) return;

    if (opcion == 'remove') {
      final confirmacion = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(S.of(context).confirmPhotoRemoval),
          content: Text(S.of(context).areYouSureRemovePhoto),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(S.of(context).yesRemove),
            ),
          ],
        ),
      );

      if (confirmacion == true && mounted) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('imagen_path');
        setState(() => _imagen = null);
      }

      return;
    }

    final fuente = opcion == 'camera' ? ImageSource.camera : ImageSource.gallery;
    final imagenSeleccionada = await picker.pickImage(source: fuente);

    if (imagenSeleccionada != null && mounted) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagen_path', imagenSeleccionada.path);
      setState(() {
        _imagen = File(imagenSeleccionada.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _seleccionarImagen,
      child: _imagen != null
          ? Image.file(
        _imagen!,
        width: widget.width,
        height: widget.height,
        fit: widget.fit ?? BoxFit.cover,
      )
          : Container(
            width: widget.width ?? 200,
            height: widget.height ?? 250,
            color: Colors.grey.shade300,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 40, color: Colors.black45),
                  SizedBox(height: 10),
                  Text(
                    S.of(context).tapToAddPhoto,
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

