import 'package:flutter/material.dart';

class PantallaCarga extends StatelessWidget {
  const PantallaCarga({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos Container si queremos usarlo dentro de otro Scaffold,
    // o Scaffold si es pantalla completa.
    return Container(
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white, // Spinner blanco
        ),
      ),
    );
  }
}