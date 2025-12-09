import 'package:flutter/material.dart';
import '../../entidades/perfil.dart';

class TarjetasPerfiles extends StatelessWidget {
  final Perfil perfil;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const TarjetasPerfiles({
    super.key,
    required this.perfil,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: AssetImage('assets/imagenes/${perfil.codigoAvatar}.png'),
                      width: 90,
                      height: 90,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      perfil.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}