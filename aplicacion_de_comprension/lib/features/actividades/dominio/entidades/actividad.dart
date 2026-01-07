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
enum HabilidadCognitiva { atencion, memoria, logica, inferencia }

class Actividad {
  final int id;
  final String nombre;
  final List<HabilidadCognitiva> habilidades; // Lista tipada, no String
  final TipoActividad tipo;
  final String instruccion;
  final dynamic contenidoVisual; // Texto o imagen
  final List<String> opciones;
  final String respuestaCorrecta;

  Actividad({
    required this.id,
    required this.nombre,
    required this.habilidades,
    required this.tipo,
    required this.instruccion,
    this.contenidoVisual,
    required this.opciones,
    required this.respuestaCorrecta,
  });
}