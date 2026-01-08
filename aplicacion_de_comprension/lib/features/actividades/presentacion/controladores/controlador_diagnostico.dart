import '../../dominio/entidades/actividad.dart';

class EstadoEvaluacion {
  final List<Actividad> actividades;
  final int indiceActual;
  final Map<HabilidadCognitiva, int> aciertos;
  final Map<HabilidadCognitiva, int> totalPreguntas;
  final bool cargando;
  final bool finalizado;

  EstadoEvaluacion({
    this.actividades = const [],
    this.indiceActual = 0,
    this.aciertos = const {},
    this.totalPreguntas = const {},
    this.cargando = true,
    this.finalizado = false,
  });

  Actividad? get actividadActual => 
      (actividades.isNotEmpty && indiceActual < actividades.length) 
      ? actividades[indiceActual] 
      : null;

  EstadoEvaluacion copyWith({
    List<Actividad>? actividades,
    int? indiceActual,
    Map<HabilidadCognitiva, int>? aciertos,
    Map<HabilidadCognitiva, int>? totalPreguntas,
    bool? cargando,
    bool? finalizado,
  }) {
    return EstadoEvaluacion(
      actividades: actividades ?? this.actividades,
      indiceActual: indiceActual ?? this.indiceActual,
      aciertos: aciertos ?? this.aciertos,
      totalPreguntas: totalPreguntas ?? this.totalPreguntas,
      cargando: cargando ?? this.cargando,
      finalizado: finalizado ?? this.finalizado,
    );
  }
}