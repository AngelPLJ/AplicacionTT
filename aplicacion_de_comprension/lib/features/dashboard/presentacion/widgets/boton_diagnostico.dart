// lib/features/dashboard/presentacion/widgets/boton_diagnostico.dart
import 'package:flutter/material.dart';

class BotonDiagnostico extends StatelessWidget {
  final VoidCallback onPressed;
  // Agregamos variables para personalizar el texto
  final String titulo;
  final String subtitulo;

  const BotonDiagnostico({
    super.key, 
    required this.onPressed,
    // Valores por defecto: si no envías nada, se pone el texto original
    this.titulo = "Comenzar Diagnóstico",
    this.subtitulo = "Descubre tu nivel inicial",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500), 
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.4), 
                blurRadius: 8, 
                offset: const Offset(0, 4)
              )
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    const Icon(Icons.rocket_launch, color: Colors.white, size: 30),
                    const SizedBox(width: 15),
                    Flexible( 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            titulo, // <--- Usamos la variable aquí
                            style: const TextStyle(
                              color: Colors.white, 
                              fontSize: 18, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            subtitulo, // <--- Usamos la variable aquí
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}