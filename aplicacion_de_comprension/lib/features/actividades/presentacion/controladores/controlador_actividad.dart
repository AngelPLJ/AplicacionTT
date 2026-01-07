import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dominio/entidades/actividad.dart';
import '../../dominio/repositorios/repo_progreso.dart';

// 1. ESTADO DE LA ACTIVIDAD
class EstadoActividad {
  final Actividad actividad;
  final int indicePregunta;
  final int aciertos;
  final int intentos;
  final bool completado;
  final String mensajeFeedback;

  EstadoActividad({
    required this.actividad,
    this.indicePregunta = 0,
    this.aciertos = 0,
    this.intentos = 0,
    this.completado = false,
    this.mensajeFeedback = '',
  });

  EstadoActividad copyWith({
    int? aciertos,
    int? intentos,
    bool? completado,
    String? mensajeFeedback,
  }) {
    return EstadoActividad(
      actividad: this.actividad,
      indicePregunta: this.indicePregunta,
      aciertos: aciertos ?? this.aciertos,
      intentos: intentos ?? this.intentos,
      completado: completado ?? this.completado,
      mensajeFeedback: mensajeFeedback ?? this.mensajeFeedback,
    );
  }
}

// 2. NOTIFIER (Lógica del Juego)
class ActividadNotifier extends StateNotifier<EstadoActividad> {
  final RepoProgreso _repoProgreso;
  final String? _usuarioId;

  ActividadNotifier({
    required Actividad actividadInicial,
    required RepoProgreso repoProgreso,
    required String? usuarioId,
  }) : _repoProgreso = repoProgreso,
       _usuarioId = usuarioId,
       super(EstadoActividad(actividad: actividadInicial));

  // Evaluar Respuesta
  Future<void> verificarRespuesta(dynamic respuestaUsuario) async {
    if (state.completado || _usuarioId == null) return;

    // Sugerencia para tu Notifier
    final correcta = state.actividad.respuestaCorrecta
        .toLowerCase().replaceAll('.', '').trim();
    final usuario = respuestaUsuario.toString()
        .toLowerCase().replaceAll('.', '').trim();
    
    final esAcierto = (correcta == usuario);

    // 1. Actualizamos el estado visual (Feedback inmediato)
    state = state.copyWith(
      intentos: state.intentos + 1,
      aciertos: state.aciertos + (esAcierto ? 1 : 0),
      mensajeFeedback: esAcierto ? "¡Excelente!" : "Casi, inténtalo de nuevo",
      completado: true, // En este diseño simple, 1 actividad = 1 pregunta/juego.
    );

    // 2. Guardamos en Base de Datos (Drift)
    await _repoProgreso.guardarProgresoActividad(
      usuarioId: _usuarioId,
      actividadId: state.actividad.id,
      esAcierto: esAcierto,
    );
  }
  
  void reiniciar() {
    state = EstadoActividad(actividad: state.actividad);
  }
}