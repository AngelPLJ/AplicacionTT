// lib/features/dashboard/presentacion/widgets/boton_play_gigante.dart
import 'package:flutter/material.dart';

class BotonPlayGigante extends StatelessWidget {
  final VoidCallback onPressed;

  const BotonPlayGigante({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Colors.orange, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
              spreadRadius: 5
            ),
            const BoxShadow(
              color: Colors.white30,
              blurRadius: 0,
              offset: Offset(-5, -5),
              blurStyle: BlurStyle.inner
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.play_arrow_rounded, 
            size: 100, 
            color: Colors.white
          ),
        ),
      ),
    );
  }
}