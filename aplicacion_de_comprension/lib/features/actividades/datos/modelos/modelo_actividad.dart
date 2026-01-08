// lib\features\actividades\datos\modelos\modelo_actividad.dart

import '../../dominio/entidades/actividad.dart';

class ActividadModel extends Actividad {
  ActividadModel({
    required super.id,
    required super.nombre,
    required super.habilidades,
    required super.tipo,
    required super.instruccion,
    required super.contenido,
    required super.opciones,
    required super.respuestaCorrecta,
  });

  factory ActividadModel.fromJson(Map<String, dynamic> json) {
    
    // 1. Extraer Habilidades (del string "Memoria, lógica")
    final habilidadesString = json['Habilidad(es)'] as String? ?? '';
    final listaHabilidades = _parsearHabilidades(habilidadesString);

    // 2. Detectar Tipo de Actividad (basado en nombre o estructura)
    final nombre = json['Nombre'] as String? ?? 'Sin nombre';
    final tipoDetectado = _inferirTipo(nombre);

    // 3. Aplanar el objeto "Contenido"
    // Tu JSON tiene todo metido dentro de "Contenido": {}, hay que sacarlo.
    final dynamic contenidoRaw = json['Contenido'];
    Map<String, dynamic> contenidoVisualMap = {};
    List<String> opciones = [];
    String respuestaCorrecta = '';
    String instruccion = 'Resuelve la actividad';

    if (contenidoRaw is Map<String, dynamic>) {
      // Copiamos todo para no modificar el original
      contenidoVisualMap = Map.from(contenidoRaw);

      // A. Extraer Opciones
      if (contenidoVisualMap.containsKey('opciones')) {
        opciones = List<String>.from(contenidoVisualMap['opciones']);
        contenidoVisualMap.remove('opciones'); // Lo quitamos del visual para no duplicar
      } else if (contenidoVisualMap.containsKey('oracion_desordenada')) {
        // Caso especial para ordenar oraciones
        opciones = List<String>.from(contenidoVisualMap['oracion_desordenada']);
      }

      // B. Extraer Respuesta
      if (contenidoVisualMap.containsKey('respuesta_correcta')) {
        respuestaCorrecta = contenidoVisualMap['respuesta_correcta'];
        contenidoVisualMap.remove('respuesta_correcta');
      } else if (contenidoVisualMap.containsKey('solucion')) {
        respuestaCorrecta = contenidoVisualMap['solucion'];
        contenidoVisualMap.remove('solucion');
      }

      // C. Extraer Pregunta/Instrucción
      if (contenidoVisualMap.containsKey('pregunta')) {
        instruccion = contenidoVisualMap['pregunta'];
        contenidoVisualMap.remove('pregunta');
      }
    }

    return ActividadModel(
      id: json['Numero'] ?? 0,
      nombre: nombre,
      habilidades: listaHabilidades,
      tipo: tipoDetectado,
      instruccion: instruccion,
      contenido: contenidoVisualMap, // Lo que sobró (ej: contexto, imagenes)
      opciones: opciones,
      respuestaCorrecta: respuestaCorrecta,
    );
  }

  // Helpers privados para mantener limpio el código
  static List<HabilidadCognitiva> _parsearHabilidades(String texto) {
    final limpio = texto.toLowerCase();
    final lista = <HabilidadCognitiva>[];
    if (limpio.contains('atención') || limpio.contains('atencion')) lista.add(HabilidadCognitiva.atencion);
    if (limpio.contains('memoria')) lista.add(HabilidadCognitiva.memoria);
    if (limpio.contains('lógica') || limpio.contains('logica')) lista.add(HabilidadCognitiva.logica);
    if (limpio.contains('inferencia')) lista.add(HabilidadCognitiva.inferencia);
    return lista;
  }

  static TipoActividad _inferirTipo(String nombre) {
    final n = nombre.toLowerCase();
    if (n.contains('ordena')) return TipoActividad.ordenaOracion;
    if (n.contains('letra')) return TipoActividad.encuentraLetraDistinta;
    if (n.contains('escuchaste')) return TipoActividad.palabraEscuchada;
    if (n.contains('memorama')) return TipoActividad.memorama;
    if (n.contains('pasará') || n.contains('pasara')) return TipoActividad.quePasaraDespues;
    return TipoActividad.comprensionLectora; // Default seguro
  }
}