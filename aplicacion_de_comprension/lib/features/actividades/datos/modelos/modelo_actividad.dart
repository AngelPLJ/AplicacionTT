// lib\features\actividades\datos\modelos\modelo_actividad.dart

import '../../dominio/entidades/actividad.dart';

class ActividadModel extends Actividad {
  ActividadModel({
    required super.id,
    required super.nombre,
    required super.habilidades,
    required super.tipo,
    required super.instruccion,
    super.contenidoVisual,
    required super.opciones,
    required super.respuestaCorrecta,
  });

  factory ActividadModel.fromJson(Map<String, dynamic> json) {
    final contenido = json['Contenido'] as Map<String, dynamic>;
    final nombreActividad = json['Nombre'] as String;

    // 1. Determinar el Tipo de Actividad
    // Usamos una variable local para calcularlo antes de pasarlo al constructor
    TipoActividad tipoCalculado = TipoActividad.comprensionFragmentos; // Valor por defecto

    if (contenido.containsKey('oracion_desordenada')) {
      tipoCalculado = TipoActividad.ordenaOracion;
    } else if (nombreActividad.contains('¿Qué pasará después?')) {
      tipoCalculado = TipoActividad.quePasaraDespues;
    } else if (nombreActividad.contains('Comprensión')) {
      tipoCalculado = TipoActividad.comprensionFragmentos;
    } else if (contenido.containsKey('pregunta')) {
      // Fallback genérico si hay pregunta pero no coincide con los nombres anteriores
      tipoCalculado = TipoActividad.comprensionFragmentos; 
    }

    // 2. Mapeo de Habilidades (String -> Enum)
    final habString = json['Habilidad(es)'] as String? ?? '';
    final habilidadesCalculadas = _parseHabilidades(habString);

    // 3. Extracción de Opciones
    // Puede venir en 'opciones' o en 'oracion_desordenada'
    List<String> opcionesExtraidas = [];
    if (contenido['opciones'] != null) {
      opcionesExtraidas = List<String>.from(contenido['opciones']);
    } else if (contenido['oracion_desordenada'] != null) {
      opcionesExtraidas = List<String>.from(contenido['oracion_desordenada']);
    }

    // 4. Extracción de Respuesta Correcta
    final respuesta = contenido['respuesta_correcta'] ?? contenido['solucion'] ?? '';

    // 5. Extracción de Instrucción
    // A veces la instrucción es la pregunta misma, a veces es el nombre
    final instruccionExtraida = contenido['pregunta'] ?? nombreActividad;

    return ActividadModel(
      id: json['Numero'] ?? 0,
      nombre: nombreActividad,
      habilidades: habilidadesCalculadas,
      tipo: tipoCalculado,
      instruccion: instruccionExtraida,
      contenidoVisual: contenido['fragmento_contexto'], // Puede ser null, y está bien
      opciones: opcionesExtraidas,
      respuestaCorrecta: respuesta,
    );
  }

  static List<HabilidadCognitiva> _parseHabilidades(String raw) {
    final list = <HabilidadCognitiva>[];
    final t = raw.toLowerCase();

    if (t.contains('atención')) list.add(HabilidadCognitiva.atencion);
    // Nota: En tu enum definiste 'memoria', asegúrate de usar ese nombre
    if (t.contains('memoria')) list.add(HabilidadCognitiva.memoria); 
    if (t.contains('lógica')) list.add(HabilidadCognitiva.logica);
    if (t.contains('inferencia')) list.add(HabilidadCognitiva.inferencia);

    return list;
  }
}