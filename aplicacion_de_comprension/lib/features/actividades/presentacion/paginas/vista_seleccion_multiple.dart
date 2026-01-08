import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dominio/entidades/actividad.dart';
import '../proveedor_actividades.dart';

class VistaSeleccionMultiple extends ConsumerWidget {
  final Actividad actividad;
  // 1. CAMBIO: Renombramos a onFinalizar y lo hacemos requerido para uniformidad
  final Function(bool) onFinalizar; 

  const VistaSeleccionMultiple({
    super.key, 
    required this.actividad,
    required this.onFinalizar,  
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(actividadControllerProvider(actividad));
    final controlador = ref.read(actividadControllerProvider(actividad).notifier);

    String? textoLectura;
    if (actividad.contenido.containsKey('texto')) {
      textoLectura = actividad.contenido['texto'];
    } else if (actividad.contenido.containsKey('contenido')) {
      textoLectura = actividad.contenido['contenido'];
    }

    String pregunta = actividad.instruccion; // Default
    if (actividad.contenido.containsKey('pregunta')) {
      pregunta = actividad.contenido['pregunta'];
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Contexto (Fragmento de historia o texto)
          if (textoLectura != null && textoLectura.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Text(
                textoLectura,
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, height: 1.5),
              ),
            ),

          // 2. Pregunta específica (si es diferente a la instrucción general)
          if (actividad.contenido.containsKey('pregunta'))
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                pregunta,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
            ),

          // 3. Lista de Opciones
          ...actividad.opciones.map((opcion) {
            
            // Verificamos si es correcta
            final esCorrecta = opcion.toLowerCase().trim() == actividad.respuestaCorrecta.toLowerCase().trim();
            
            // Feedback visual (opcional, si usas el estado local)
            Color? colorFondo = Colors.white;
            Color colorTexto = Colors.black87;
            Color colorBorde = Colors.grey.shade300;

            if (estado.completado) {
              if (esCorrecta) {
                colorFondo = Colors.green.shade100;
                colorBorde = Colors.green;
              } else { // Si tu estado guarda la respuesta del usuario
                colorFondo = Colors.red.shade100;
                colorBorde = Colors.red;
              }
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorFondo,
                  foregroundColor: colorTexto,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: colorBorde),
                  ),
                  alignment: Alignment.centerLeft, 
                ),
                onPressed: () {
                  onFinalizar(esCorrecta);

                  controlador.verificarRespuesta(opcion);
                },
                child: Text(
                  opcion,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}