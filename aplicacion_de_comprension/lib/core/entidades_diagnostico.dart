// lib/core/entidades_diagnostico.dart

enum HabilidadCognitiva {
  atencion,
  memoriaTrabajo,
  inferencia,
  logica,
}

enum TipoActividad {
  // Atención
  encuentraLetraDistinta,
  palabraEscuchada,
  // Memoria
  memorama,
  memoriaFonetica,
  // Lógica
  ordenaOracion,
  seleccionaImagen,
  // Inferencia
  quePasaraDespues,
  comprensionFragmentos,
}

class ItemDiagnostico {
  final String id;
  final HabilidadCognitiva habilidad;
  final TipoActividad tipo;
  final String instruccion; // Texto o URL de audio
  final dynamic contenido; // Puede ser una lista de letras, una url de imagen, etc.
  final dynamic respuestaCorrecta;
  final List<dynamic> opciones;

  ItemDiagnostico({
    required this.id,
    required this.habilidad,
    required this.tipo,
    required this.instruccion,
    required this.contenido,
    required this.respuestaCorrecta,
    required this.opciones,
  });
}