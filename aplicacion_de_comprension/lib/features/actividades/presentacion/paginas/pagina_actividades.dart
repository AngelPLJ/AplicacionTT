// lib/features/actividades/presentacion/pantallas/pantalla_detalle_actividad.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dominio/entidades/actividad.dart';
import '../proveedor_actividades.dart'; // Tu archivo de providers
import 'vista_seleccion_multiple.dart';
import 'vista_ordenar_oracion.dart';

class PantallaDetalleActividad extends ConsumerWidget {
  final int actividadId;

  const PantallaDetalleActividad({super.key, required this.actividadId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Cargamos la definición de la actividad
    final actividadAsync = ref.watch(actividadPorIdProvider(actividadId));

    return Scaffold(
      appBar: AppBar(title: const Text("Actividad")),
      body: actividadAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (actividad) {
          // 2. Inicializamos el estado de ESTA actividad específica
          // Esto asegura que el Notifier se construya
          final estadoActividad = ref.watch(actividadControllerProvider(actividad));
          
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Encabezado común: Título e Instrucción
                _HeaderActividad(actividad: actividad),
                
                const SizedBox(height: 20),

                // Cuerpo Variable según el tipo
                Expanded(
                  child: _construirVistaEspecifica(actividad, ref),
                ),

                // Feedback visual (Barra inferior)
                if (estadoActividad.completado)
                  _BarraFeedback(
                    esCorrecto: estadoActividad.aciertos > 0, // Simplificación basada en tu lógica
                    mensaje: estadoActividad.mensajeFeedback,
                    onContinuar: () {
                      Navigator.pop(context); // O ir a la siguiente
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _construirVistaEspecifica(Actividad actividad, WidgetRef ref) {
    switch (actividad.tipo) {
      case TipoActividad.ordenaOracion:
        return VistaOrdenarOracion(actividad: actividad);
      
      case TipoActividad.palabraEscuchada:
      case TipoActividad.quePasaraDespues: // Asumiendo que mapeaste esto a trivia o similar
      case TipoActividad.comprensionFragmentos:
        return VistaSeleccionMultiple(actividad: actividad);
        
      default:
        // Fallback por si acaso
        return VistaSeleccionMultiple(actividad: actividad);
    }
  }
}

class _HeaderActividad extends StatelessWidget {
  final Actividad actividad;
  const _HeaderActividad({required this.actividad});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          actividad.nombre,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          actividad.instruccion,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

class _BarraFeedback extends StatelessWidget {
  final bool esCorrecto;
  final String mensaje;
  final VoidCallback onContinuar;

  const _BarraFeedback({
    required this.esCorrecto,
    required this.mensaje,
    required this.onContinuar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: esCorrecto ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: esCorrecto ? Colors.green : Colors.red, 
          width: 2
        ),
      ),
      child: Row(
        children: [
          Icon(
            esCorrecto ? Icons.sentiment_very_satisfied : Icons.sentiment_dissatisfied,
            size: 40,
            color: esCorrecto ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              mensaje,
              style: TextStyle(
                color: esCorrecto ? Colors.green.shade900 : Colors.red.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onContinuar,
            child: const Text("Continuar"),
          )
        ],
      ),
    );
  }
}