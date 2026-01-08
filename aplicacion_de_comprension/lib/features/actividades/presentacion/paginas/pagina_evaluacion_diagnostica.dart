import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../dashboard/presentacion/proveedor_dashboard.dart';
import '../../dominio/entidades/actividad.dart';
import '../proveedor_actividades.dart'; 
import 'vista_ordenar_oracion.dart';
import 'vista_seleccion_multiple.dart';
import 'vista_encuentra_la_letra.dart';
import 'vista_memorama.dart';
import 'vista_selecciona_fonema.dart';
import 'vista_lectura_paginada.dart'; 

class PantallaEvaluacionDiagnostica extends ConsumerWidget {
  const PantallaEvaluacionDiagnostica({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(evaluacionProvider);
    final controlador = ref.read(evaluacionProvider.notifier);

    // 1. Loading
    if (estado.cargando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // 2. Finalizado
    if (estado.finalizado) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 84, 22, 116),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline, size: 100, color: Colors.white),
              const SizedBox(height: 20),
              const Text("¡Diagnóstico Completado!", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(dashboardInfoProvider);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.deepPurple),
                child: const Text("VOLVER AL INICIO"),
              )
            ],
          ),
        ),
      );
    }

    // 3. Error / Vacío
    if (estado.actividadActual == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("No hay actividades disponibles.")),
      );
    }
    final actividad = estado.actividadActual!;
    final total = estado.actividades.length;
    final progreso = total > 0 ? (estado.indiceActual + 1) / total : 0.0;

    final esLectura = actividad.tipo == TipoActividad.comprensionLectora;

    return Scaffold(
      appBar: AppBar(
        title: Text("Actividad ${estado.indiceActual + 1} de $total"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(value: progreso, color: Colors.orange, minHeight: 6),
        ),
      ),
      body: esLectura 
        ? _construirVistaLectura(context, ref, estado.actividades, actividad, controlador)
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(actividad.instruccion, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                Expanded(
                  child: _construirVista(actividad, (esCorrecta) {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      controlador.registrarRespuesta(esCorrecta);
                    });
                  }),
                ),
              ],
            ),
          ),
    );
  }

  Widget _construirVistaLectura(BuildContext context, WidgetRef ref, List<Actividad> todasLasActividades, Actividad actividadActual, dynamic controlador) {
    
    final tituloHistoria = actividadActual.contenido['Titulo Fuente'] ?? actividadActual.contenido['titulo'] ?? 'Lectura';
    
    final preguntasDeEstaHistoria = todasLasActividades.where((a) {
      final t = a.contenido['Titulo Fuente'] ?? a.contenido['titulo'];
      return a.tipo == TipoActividad.comprensionLectora && t == tituloHistoria;
    }).toList();

    final textoAsync = ref.watch(textoHistoriaProvider(tituloHistoria));

    return textoAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (textoReal) {
        final textoFinal = textoReal ?? "No se encontró el texto.";

        return VistaLecturaPaginada(
          key: ValueKey(tituloHistoria), 
          
          tituloHistoria: tituloHistoria,
          textoHistoria: textoFinal,
          preguntas: preguntasDeEstaHistoria,
          
          onLecturaTerminada: (mapaResultados) async {
            showDialog(
                context: context, 
                barrierDismissible: false,
                builder: (_) => const Center(child: CircularProgressIndicator())
            );

            for (var pregunta in preguntasDeEstaHistoria) {
               bool fueCorrecta = mapaResultados[pregunta.id] ?? false;
               
               controlador.registrarRespuesta(fueCorrecta);
               
               await Future.delayed(const Duration(milliseconds: 100));
            }

            Navigator.pop(context); 
          },
        );
      },
    );
  }

  Widget _construirVista(Actividad actividad, Function(bool) alResponder) {
    final key = ValueKey(actividad.id);

    switch (actividad.tipo) {
      case TipoActividad.encuentraLetraDistinta:
        return VistaEncuentraLetra(key: key, actividad: actividad, onFinalizar: alResponder);
      
      case TipoActividad.palabraEscuchada:
        return VistaAudioSeleccion(key: key, actividad: actividad, onFinalizar: alResponder);
      
      case TipoActividad.memorama:
        return VistaMemorama(key: key, actividad: actividad, onFinalizar: alResponder);
      
      case TipoActividad.ordenaOracion:
        return VistaOrdenarOracion(key: key, actividad: actividad, onFinalizar: alResponder);
      
      // NOTA: Comprensión Lectora ya no entra aquí porque lo filtramos arriba en el build
      case TipoActividad.comprensionLectora:
      default:
        return VistaSeleccionMultiple(key: key, actividad: actividad, onFinalizar: alResponder);
    }
  }
}