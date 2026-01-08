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
  final bool esAcierto;
  final String mensajeFeedback;

  EstadoActividad({
    required this.actividad,
    this.indicePregunta = 0,
    this.aciertos = 0,
    this.intentos = 0,
    this.completado = false,
    this.esAcierto = false, // <--- Inicializamos en false
    this.mensajeFeedback = '',
  });

  EstadoActividad copyWith({
    int? aciertos,
    int? intentos,
    bool? completado,
    bool? esAcierto, // <--- Añadimos al copyWith
    String? mensajeFeedback,
  }) {
    return EstadoActividad(
      actividad: this.actividad,
      indicePregunta: this.indicePregunta,
      aciertos: aciertos ?? this.aciertos,
      intentos: intentos ?? this.intentos,
      completado: completado ?? this.completado,
      esAcierto: esAcierto ?? this.esAcierto, // <--- Actualizamos
      mensajeFeedback: mensajeFeedback ?? this.mensajeFeedback,
    );
  }
}

// 2. NOTIFIER (Lógica del Juego)
class ActividadNotifier extends StateNotifier<EstadoActividad> {
  final RepoProgreso _repoProgreso;
  final String? _usuarioId; // Puede ser null si el usuario no se ha logueado aún

  ActividadNotifier({
    required Actividad actividadInicial,
    required RepoProgreso repoProgreso,
    required String? usuarioId,
  }) : _repoProgreso = repoProgreso,
       _usuarioId = usuarioId,
       super(EstadoActividad(actividad: actividadInicial));

  // Opción A: Cuando la vista ya sabe si fue correcto (Ej: Memorama, Selección Múltiple)
  Future<void> registrarResultado(bool fueCorrecto) async {
     if (state.completado) return; // Evitar respuestas dobles

     _actualizarEstadoYBaseDeDatos(fueCorrecto);
  }

  // Opción B: Cuando necesitamos comparar texto (Ej: Entrada de texto manual, si la tuvieras)
  Future<void> verificarRespuesta(dynamic respuestaUsuario) async {
    if (state.completado) return;

    final correcta = state.actividad.respuestaCorrecta
        .toLowerCase().replaceAll('.', '').trim();
    final usuario = respuestaUsuario.toString()
        .toLowerCase().replaceAll('.', '').trim();
    
    final fueCorrecto = (correcta == usuario);

    _actualizarEstadoYBaseDeDatos(fueCorrecto);
  }

  // Método privado para centralizar la lógica de guardado
  Future<void> _actualizarEstadoYBaseDeDatos(bool esAcierto) async {
    // 1. Actualizamos el estado visual
    state = state.copyWith(
      intentos: state.intentos + 1,
      aciertos: state.aciertos + (esAcierto ? 1 : 0),
      esAcierto: esAcierto, // <--- Guardamos si fue acierto en el estado
      mensajeFeedback: esAcierto ? "¡Excelente!" : "Inténtalo de nuevo",
      completado: true, 
    );

    // 2. Guardamos en Base de Datos (Solo si hay usuario logueado)
    if (_usuarioId != null) {
      await _repoProgreso.guardarProgresoActividad(
        usuarioId: _usuarioId,
        actividadId: state.actividad.id,
        esAcierto: esAcierto,
      );
    }
  }
  
  void reiniciar() {
    // Reseteamos manteniendo la actividad original
    state = EstadoActividad(actividad: state.actividad);
  }
}