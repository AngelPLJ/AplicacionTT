import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dominio/entidades/actividad.dart';
import '../../dominio/repositorios/repo_contenido.dart';
import '../../dominio/repositorios/repo_progreso.dart';
import '../../presentacion/controladores/controlador_diagnostico.dart';

class EvaluacionNotifier extends StateNotifier<EstadoEvaluacion> {
  final RepoContenido _repoContenido;
  final RepoProgreso _repoProgreso;
  final String _usuarioId;

  EvaluacionNotifier(this._repoContenido, this._repoProgreso, this._usuarioId) : super(EstadoEvaluacion()) {
    _cargarExamen();
  }

  Future<void> _cargarExamen() async {
    try {
      // 1. Obtenemos TODAS las actividades marcadas como 'esDiagnostico' de la BD
      final candidatos = await _repoContenido.getActividadesDiagnosticas();
      
      // 2. Definimos la configuración del examen: 
      // Queremos 20 actividades en total, divididas en 5 tipos (4 de cada una).
      // Si prefieres 25 (5 de cada una), cambia el valor a 5.
      const int cantidadPorTipo = 4; 

      final List<Actividad> examenFinal = [];

      // Helper para seleccionar aleatoriamente
      void agregarAlExamen(TipoActividad tipo) {
        // Filtramos por tipo
        var filtradas = candidatos.where((a) => a.tipo == tipo).toList();
        // Barajamos para que sea al azar
        filtradas.shuffle();
        // Tomamos solo la cantidad requerida (o todas si hay menos de la cantidad)
        examenFinal.addAll(filtradas.take(cantidadPorTipo));
      }

      // 3. Agregamos en el orden solicitado
      agregarAlExamen(TipoActividad.encuentraLetraDistinta);
      agregarAlExamen(TipoActividad.palabraEscuchada);
      agregarAlExamen(TipoActividad.memorama);
      agregarAlExamen(TipoActividad.ordenaOracion);
      agregarAlExamen(TipoActividad.comprensionLectora);
      // 4. Calculamos totales por habilidad para saber sobre cuánto calificar
      final mapTotales = <HabilidadCognitiva, int>{};
      for (var act in examenFinal) {
        for (var hab in act.habilidades) {
          mapTotales[hab] = (mapTotales[hab] ?? 0) + 1;
        }
      }

      state = state.copyWith(
        actividades: examenFinal,
        totalPreguntas: mapTotales,
        cargando: false,
      );
    } catch (e) {
      throw Exception('Error al cargar el examen diagnóstico: $e');
    }
  }

  Future<void> registrarRespuesta(bool esCorrecta) async {
    if (state.finalizado || state.actividadActual == null) return;

    final actividad = state.actividadActual!;

    await _repoProgreso.guardarProgresoActividad(
      usuarioId: _usuarioId,
      actividadId: actividad.id,
      esAcierto: esCorrecta,
    );

    if (esCorrecta) {
      final nuevosAciertos = Map<HabilidadCognitiva, int>.from(state.aciertos);
      
      for (var hab in actividad.habilidades) {
        nuevosAciertos[hab] = (nuevosAciertos[hab] ?? 0) + 1;
      }
      
      state = state.copyWith(aciertos: nuevosAciertos);
    }

    if (state.indiceActual < state.actividades.length - 1) {
      state = state.copyWith(indiceActual: state.indiceActual + 1);
    } else {
      await _guardarResultados();
      state = state.copyWith(finalizado: true);
    }
  }

  Future<void> registrarRespuestasLote(List<bool> resultados) async {
    for (var esCorrecta in resultados) {
      registrarRespuesta(esCorrecta);
    }
  }

  Future<void> _guardarResultados() async {
    final puntajes = <HabilidadCognitiva, double>{};
    
    for (var hab in HabilidadCognitiva.values) {
      final totalItems = state.totalPreguntas[hab] ?? 0;
      final aciertos = state.aciertos[hab] ?? 0;
      
      puntajes[hab] = totalItems == 0 ? 0.0 : (aciertos / totalItems);
    }

    await _repoProgreso.guardarResultadoDiagnostico(
      usuarioId: _usuarioId,
      puntajes: puntajes,
    );
  }
}