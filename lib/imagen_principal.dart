import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagenPrincipal extends StatefulWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;

  const ImagenPrincipal({super.key, this.width, this.height, this.fit});

  @override
  State<ImagenPrincipal> createState() => _ImagenPrincipalState();
}

class _ImagenPrincipalState extends State<ImagenPrincipal> {
  File? _imagen;

  @override
  void initState() {
    super.initState();
    _cargarImagen();
  }

  Future<void> _cargarImagen() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('imagen_path');
    if (path != null && mounted) {
      setState(() {
        _imagen = File(path);
      });
    }
  }

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();

    final opcion = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Tomar foto"),
            onTap: () => Navigator.pop(context, 'camera'),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Elegir de galería"),
            onTap: () => Navigator.pop(context, 'gallery'),
          ),
          if (_imagen != null) // solo mostrar si hay una imagen
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Quitar foto"),
              onTap: () => Navigator.pop(context, 'remove'),
            ),
        ],
      ),
    );

    if (opcion == null) return;

    if (opcion == 'remove') {
      if (!mounted) return;

      final confirmacion = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirmar eliminación"),
          content: const Text("¿Estás seguro de que quieres quitar la foto?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Sí, eliminar"),
            ),
          ],
        ),
      );

      if (confirmacion == true && mounted) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('imagen_path');
        setState(() {
          _imagen = null;
        });
      }

      return;
    }

    final fuente = opcion == 'camera'
        ? ImageSource.camera
        : ImageSource.gallery;

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
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 40, color: Colors.black45),
                  SizedBox(height: 10),
                  Text(
                    "Pulsa para añadir foto",
                    style: TextStyle(color: Colors.black45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
