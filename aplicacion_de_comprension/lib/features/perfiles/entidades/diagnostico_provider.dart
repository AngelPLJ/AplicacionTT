import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/entidades_diagnostico.dart'; // Tu enum y clase ItemDiagnostico
import '../repositorios/repo_contenido_json.dart'; // Tu repositorio de JSON
import 'modelos_json.dart'; // Tu modelo ActividadModelo

// 1. EL ESTADO (Agregamos isLoading para esperar la carga del JSON)
class DiagnosticoState {
  final int indiceActual;
  final Map<HabilidadCognitiva, int> puntajes;
  final bool completado;
  final List<ItemDiagnostico> items;
  final bool isLoading; // <--- Importante para la carga asíncrona

  DiagnosticoState({
    required this.indiceActual,
    required this.puntajes,
    required this.completado,
    required this.items,
    this.isLoading = true, 
  });

  DiagnosticoState copyWith({
    int? indiceActual,
    Map<HabilidadCognitiva, int>? puntajes,
    bool? completado,
    List<ItemDiagnostico>? items,
    bool? isLoading,
  }) {
    return DiagnosticoState(
      indiceActual: indiceActual ?? this.indiceActual,
      puntajes: puntajes ?? this.puntajes,
      completado: completado ?? this.completado,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// 2. EL NOTIFIER (LOGICA DE NEGOCIO)
class DiagnosticoNotifier extends StateNotifier<DiagnosticoState> {
  final RepoContenidoJson _repoJson;

  DiagnosticoNotifier(this._repoJson) : super(DiagnosticoState(
    indiceActual: 0,
    puntajes: {
      HabilidadCognitiva.atencion: 0,
      HabilidadCognitiva.memoriaTrabajo: 0,
      HabilidadCognitiva.logica: 0,
      HabilidadCognitiva.inferencia: 0,
    },
    completado: false,
    items: [],
    isLoading: true, // Empezamos cargando
  )) {
    _cargarActividadesReales();
  }

  // Carga los datos del JSON y los convierte al formato del examen
  Future<void> _cargarActividadesReales() async {
    try {
      // 1. Obtenemos la lista cruda del JSON
      final actividadesModelo = await _repoJson.cargarActividades();

      // 2. Convertimos ActividadModelo -> ItemDiagnostico
      final itemsReales = actividadesModelo.map((act) {
        return ItemDiagnostico(
          id: act.id.toString(),
          habilidad: _mapearHabilidad(act.habilidad),
          tipo: _mapearTipo(act.tipo),
          // Usamos la pregunta o el nombre como instrucción
          instruccion: act.contenido['pregunta'] ?? act.nombre,
          // El contenido visual (si es trivia, el texto; si es ordenar, nada extra)
          contenido: _extraerContenidoVisual(act),
          // Opciones y respuesta correcta
          opciones: act.contenido['opciones'] ?? act.contenido['oracion_desordenada'] ?? [],
          respuestaCorrecta: act.contenido['respuesta_correcta'] ?? act.contenido['solucion'],
        );
      }).toList();

      // 3. Actualizamos el estado con los datos reales
      state = state.copyWith(
        items: itemsReales,
        isLoading: false,
      );
    } catch (e) {
      print("Error cargando evaluación: $e");
      state = state.copyWith(isLoading: false, items: []);
    }
  }

  // --- HELPERS PARA CONVERTIR DATOS ---

  HabilidadCognitiva _mapearHabilidad(String textoJson) {
    final t = textoJson.toLowerCase();
    if (t.contains('atención')) return HabilidadCognitiva.atencion;
    if (t.contains('memoria')) return HabilidadCognitiva.memoriaTrabajo;
    if (t.contains('lógica')) return HabilidadCognitiva.logica;
    if (t.contains('inferencia')) return HabilidadCognitiva.inferencia;
    return HabilidadCognitiva.atencion; // Default
  }

  TipoActividad _mapearTipo(TipoActividadJuego tipoModelo) {
    switch (tipoModelo) {
      case TipoActividadJuego.ordenarOracion:
        return TipoActividad.ordenaOracion;
      case TipoActividadJuego.trivia:
        // Usamos un tipo genérico para preguntas de selección (inferencia/lectura)
        return TipoActividad.quePasaraDespues; 
      default:
        return TipoActividad.quePasaraDespues;
    }
  }

  dynamic _extraerContenidoVisual(ActividadModelo act) {
    // Si hay un fragmento de texto para leer (contexto), lo devolvemos
    if (act.contenido.containsKey('fragmento_contexto')) {
      return act.contenido['fragmento_contexto'];
    }
    // Si es ordenar oración, devolvemos la lista desordenada como string visual si se requiere
    if (act.tipo == TipoActividadJuego.ordenarOracion) {
      return "Ordena las palabras correctamente.";
    }
    return "";
  }

  // --- LÓGICA DEL EXAMEN ---

  void responder(dynamic respuestaUsuario) {
    if (state.items.isEmpty) return;

    final itemActual = state.items[state.indiceActual];
    final esCorrecto = _verificarRespuesta(itemActual, respuestaUsuario);

    final nuevosPuntajes = Map<HabilidadCognitiva, int>.from(state.puntajes);
    if (esCorrecto) {
      nuevosPuntajes[itemActual.habilidad] = (nuevosPuntajes[itemActual.habilidad] ?? 0) + 1;
    }

    if (state.indiceActual < state.items.length - 1) {
      state = state.copyWith(
        indiceActual: state.indiceActual + 1,
        puntajes: nuevosPuntajes,
      );
    } else {
      state = state.copyWith(
        puntajes: nuevosPuntajes,
        completado: true,
      );
    }
  }

  bool _verificarRespuesta(ItemDiagnostico item, dynamic respuesta) {
    // Normalización básica para comparar strings
    final resUsuario = respuesta.toString().trim().toLowerCase().replaceAll('.', '');
    final resCorrecta = item.respuestaCorrecta.toString().trim().toLowerCase().replaceAll('.', '');
    return resUsuario == resCorrecta;
  }
}

// 3. EL PROVIDER CONECTADO AL REPO JSON
final diagnosticoProvider = StateNotifierProvider<DiagnosticoNotifier, DiagnosticoState>((ref) {
  final repo = ref.read(repoContenidoJsonProvider); // <--- Le pasamos el lector de JSON
  return DiagnosticoNotifier(repo);
});