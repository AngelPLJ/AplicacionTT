// lib/features/actividades/presentacion/pantallas/vistas/vista_seleccion_multiple.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dominio/entidades/actividad.dart';
import '../proveedor_actividades.dart';

class VistaSeleccionMultiple extends ConsumerWidget {
  final Actividad actividad;

  const VistaSeleccionMultiple({super.key, required this.actividad});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(actividadControllerProvider(actividad));
    final controlador = ref.read(actividadControllerProvider(actividad).notifier);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Contexto (Fragmento de historia) si existe
          if (actividad.contenidoVisual != null && actividad.contenidoVisual.toString().isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Text(
                actividad.contenidoVisual.toString(),
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),

          // 2. Lista de Opciones
          ...actividad.opciones.map((opcion) {
            final esCorrecta = opcion == actividad.respuestaCorrecta;
            
            // Lógica de colores para cuando ya se respondió
            Color? colorBoton;
            if (estado.completado) {
              if (esCorrecta) colorBoton = Colors.green.shade100;
              // Si fue la que seleccioné y estaba mal (esto requiere guardar selección usuario en estado, 
              // por simplicidad aquí solo marcamos la correcta).
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorBoton,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: estado.completado
                    ? null // Bloquear si ya contestó
                    : () => controlador.verificarRespuesta(opcion),
                child: Text(
                  opcion,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}