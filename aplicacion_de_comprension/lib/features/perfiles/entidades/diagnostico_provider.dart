import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/entidades_diagnostico.dart';

// Estado del examen
class DiagnosticoState {
  final int indiceActual;
  final Map<HabilidadCognitiva, int> puntajes; // Puntos por habilidad
  final bool completado;
  final List<ItemDiagnostico> items;

  DiagnosticoState({
    required this.indiceActual,
    required this.puntajes,
    required this.completado,
    required this.items,
  });

  DiagnosticoState copyWith({
    int? indiceActual,
    Map<HabilidadCognitiva, int>? puntajes,
    bool? completado,
    List<ItemDiagnostico>? items,
  }) {
    return DiagnosticoState(
      indiceActual: indiceActual ?? this.indiceActual,
      puntajes: puntajes ?? this.puntajes,
      completado: completado ?? this.completado,
      items: items ?? this.items,
    );
  }
}

// El Notifier que controla la lógica
class DiagnosticoNotifier extends StateNotifier<DiagnosticoState> {
  DiagnosticoNotifier() : super(DiagnosticoState(
    indiceActual: 0,
    puntajes: {
      HabilidadCognitiva.atencion: 0,
      HabilidadCognitiva.memoriaTrabajo: 0,
      HabilidadCognitiva.logica: 0,
      HabilidadCognitiva.inferencia: 0,
    },
    completado: false,
    items: _generarItemsMock(), // Aquí cargamos los 24 items
  ));

  void responder(dynamic respuestaUsuario) {
    final itemActual = state.items[state.indiceActual];
    final esCorrecto = _verificarRespuesta(itemActual, respuestaUsuario);

    // Actualizar puntaje si es correcto
    final nuevosPuntajes = Map<HabilidadCognitiva, int>.from(state.puntajes);
    if (esCorrecto) {
      nuevosPuntajes[itemActual.habilidad] = (nuevosPuntajes[itemActual.habilidad] ?? 0) + 1;
    }

    // Avanzar
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
    // Lógica simple de comparación. 
    // Para ordenamiento, comparamos listas convertidas a string
    return respuesta.toString() == item.respuestaCorrecta.toString();
  }

  // AQUÍ GENERAMOS LOS 24 REACTIVOS (Ejemplo reducido, deberías llenarlo con los 24 reales)
  static List<ItemDiagnostico> _generarItemsMock() {
    List<ItemDiagnostico> lista = [];

    // --- 1. ATENCIÓN (6 items) ---
    // Actividad 1: Encuentra la letra distinta (3 items)
    lista.add(ItemDiagnostico(
      id: 'a1_1', habilidad: HabilidadCognitiva.atencion, tipo: TipoActividad.encuentraLetraDistinta,
      instruccion: 'Encuentra la letra "O" entre las "Q"',
      contenido: 'QQQQQQOQQQ', opciones: ['Q', 'O'], respuestaCorrecta: 'O',
    ));
    // ... agregar 2 más de letras ...
    
    // Actividad 2: Palabra escuchada (3 items)
    lista.add(ItemDiagnostico(
      id: 'a2_1', habilidad: HabilidadCognitiva.atencion, tipo: TipoActividad.palabraEscuchada,
      instruccion: 'Escucha y selecciona la palabra correcta',
      contenido: 'audio_path_sol.mp3', opciones: ['Sol', 'Sal', 'Col'], respuestaCorrecta: 'Sol',
    ));
     // ... agregar 2 más de audio ...

    // --- 2. MEMORIA (6 items) ---
    // Actividad 1: Memorama (simplificado a: ¿Qué imagen acabas de ver?)
    lista.add(ItemDiagnostico(
      id: 'm1_1', habilidad: HabilidadCognitiva.memoriaTrabajo, tipo: TipoActividad.memorama,
      instruccion: 'Memoriza la imagen anterior. ¿Cuál era?',
      contenido: 'gato.png', opciones: ['perro.png', 'gato.png'], respuestaCorrecta: 'gato.png',
    ));

    // --- 3. LÓGICA (6 items) ---
    lista.add(ItemDiagnostico(
      id: 'l1_1', habilidad: HabilidadCognitiva.logica, tipo: TipoActividad.ordenaOracion,
      instruccion: 'Ordena la oración',
      contenido: null, opciones: ['come', 'El', 'perro'], respuestaCorrecta: '[El, perro, come]', // Comparación simple
    ));

    // --- 4. INFERENCIA (6 items) ---
    lista.add(ItemDiagnostico(
      id: 'i1_1', habilidad: HabilidadCognitiva.inferencia, tipo: TipoActividad.quePasaraDespues,
      instruccion: 'Si sueltas un vaso de vidrio, ¿qué pasará?',
      contenido: 'imagen_vaso_cayendo.png', opciones: ['Rebota', 'Se rompe', 'Vuela'], respuestaCorrecta: 'Se rompe',
    ));

    // DUPLICAR ESTOS ITEMS HASTA TENER 24 PARA PROBAR EL FLUJO COMPLETO
    // ...
    
    return lista;
  }
}

final diagnosticoProvider = StateNotifierProvider<DiagnosticoNotifier, DiagnosticoState>((ref) {
  return DiagnosticoNotifier();
});