import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dominio/entidades/actividad.dart';
import '../proveedor_actividades.dart'; 

// Importa tu Painter (Ajusta la ruta según donde lo guardaste)
import '../../../../core/utils/fondo_geometrico.dart'; 

// Importamos todas tus vistas
import 'vista_seleccion_multiple.dart';
import 'vista_ordenar_oracion.dart';
import 'vista_memorama.dart';
import 'vista_encuentra_la_letra.dart'; 
import 'vista_selecciona_fonema.dart';

class PantallaDetalleActividad extends ConsumerWidget {
  final int actividadId;

  const PantallaDetalleActividad({super.key, required this.actividadId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Obtenemos la actividad por ID
    final actividadAsync = ref.watch(actividadPorIdProvider(actividadId));

    return Scaffold(
      // Importante: Fondo blanco base para que las figuras se pinten sobre él
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Practicando"),
        centerTitle: true,
        elevation: 0,
        // Opcional: Si quieres que el AppBar sea transparente y deje ver las figuras:
        // backgroundColor: Colors.transparent, 
        // flexibleSpace: ... (Tu degradado si lo deseas),
      ),
      body: actividadAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (actividad) {
          
          final estadoActividad = ref.watch(actividadControllerProvider(actividad));
          final notifier = ref.read(actividadControllerProvider(actividad).notifier);

          void procesarResultado(bool esCorrecto) {
            notifier.verificarRespuesta(esCorrecto ? actividad.respuestaCorrecta : ""); 
          }

          // --- CAMBIO AQUÍ: Usamos Stack para poner el fondo ---
          return Stack(
            children: [
              // 1. CAPA DE FONDO (Painter)
              Positioned.fill(
                child: CustomPaint(
                  painter: FondoGeometricoPainter(), 
                ),
              ),

              // 2. CAPA DE CONTENIDO (Tu columna original)
              Column(
                children: [
                  // Cabecera con instrucciones
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _HeaderActividad(actividad: actividad),
                  ),
                  
                  const Divider(height: 1),

                  // AREA DE JUEGO
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      // Envolvemos la vista en un Container transparente por seguridad
                      child: _construirVistaEspecifica(actividad, procesarResultado),
                    ),
                  ),

                  // BARRA DE FEEDBACK
                  if (estadoActividad.completado)
                    _BarraFeedback(
                      esCorrecto: estadoActividad.esAcierto,
                      mensaje: estadoActividad.esAcierto 
                          ? "¡Excelente trabajo!" 
                          : "¡Inténtalo de nuevo!",
                      onContinuar: () {
                        if (estadoActividad.esAcierto) {
                          Navigator.pop(context); 
                        } else {
                          notifier.reiniciar(); 
                        }
                      },
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _construirVistaEspecifica(Actividad actividad, Function(bool) onFinalizar) {
    final key = ValueKey(actividad.id);

    switch (actividad.tipo) {
      case TipoActividad.identificacionFonema:          
      case TipoActividad.palabraEscuchada:              
      case TipoActividad.correspondenciaFonemaGrafema:  
        return VistaAudioSeleccion(
          key: key,
          actividad: actividad,
          onFinalizar: onFinalizar,
        );

      case TipoActividad.encuentraLetraDistinta:
        return VistaEncuentraLetra(
          key: key,
          actividad: actividad,
          onFinalizar: onFinalizar,
        );

      case TipoActividad.memorama:
        return VistaMemorama(
          key: key,
          actividad: actividad,
          onFinalizar: onFinalizar,
        );

      case TipoActividad.ordenaOracion:
        return VistaOrdenarOracion(
          key: key,
          actividad: actividad,
          onFinalizar: onFinalizar,
        );

      case TipoActividad.quePasaraDespues: 
      case TipoActividad.comprensionLectora: 
        return VistaSeleccionMultiple(
          key: key,
          actividad: actividad,
          onFinalizar: onFinalizar,
        );
    }
  }
}

// ... Tus widgets auxiliares (_HeaderActividad, _BarraFeedback) se quedan igual ...
// --- WIDGETS AUXILIARES ---

class _HeaderActividad extends StatelessWidget {
  final Actividad actividad;
  const _HeaderActividad({required this.actividad});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          actividad.nombre,
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold, 
            color: Colors.grey.shade600,
            letterSpacing: 1.0
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          actividad.instruccion,
          style: const TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.w600, 
            color: Colors.indigo
          ),
          textAlign: TextAlign.center,
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
    final color = esCorrecto ? Colors.green : Colors.orange;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0,-5))],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  esCorrecto ? Icons.check_circle : Icons.refresh, 
                  color: color, 
                  size: 32
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    mensaje,
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: color.shade800
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: onContinuar,
                child: Text(
                  esCorrecto ? "CONTINUAR" : "INTENTAR DE NUEVO",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}