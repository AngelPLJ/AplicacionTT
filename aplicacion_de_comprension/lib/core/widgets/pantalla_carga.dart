import 'package:flutter/material.dart';

class PantallaCarga extends StatelessWidget {
  final String? mensaje;

  const PantallaCarga({super.key, this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5), // Fondo semitransparente oscuro
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Para que se ajuste al contenido
          children: [
            const CircularProgressIndicator(
              color: Colors.white, // Color que resalte
              strokeWidth: 3,
            ),
            if (mensaje != null) ...[
              const SizedBox(height: 16),
              Text(
                mensaje!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none, // Evita subrayado amarillo feo
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}