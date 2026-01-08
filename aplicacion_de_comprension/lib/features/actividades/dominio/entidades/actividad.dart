enum TipoActividad {
  // Fonética y Auditiva
  identificacionFonema,        // "Identificación de palabras por fonema inicial"
  palabraEscuchada,            // "¿Qué palabra escuchaste?"
  correspondenciaFonemaGrafema,// "Actividad de correspondencia fonema-grafema"
  
  encuentraLetraDistinta,      // "Encuentra la letra distinta"
  memorama,                    // "Memorama"
  
  ordenaOracion,               // "Ordena la oración"
  quePasaraDespues,            // "¿Qué pasará después?"
  comprensionLectora,          // "Comprensión lectora"
}
enum HabilidadCognitiva { atencion, memoria, logica, inferencia, vocabulario }

class Actividad {
  final int id;
  final String nombre;
  final List<HabilidadCognitiva> habilidades;
  final TipoActividad tipo;
  final String instruccion;
  final Map<String, dynamic> contenido; // Cambiado a Map estricto
  final List<String> opciones; 
  final String respuestaCorrecta;
  final bool esDiagnostico;

  Actividad({
    required this.id,
    required this.nombre,
    required this.habilidades,
    required this.tipo,
    required this.instruccion,
    required this.contenido,
    this.opciones = const [],
    this.respuestaCorrecta = '',
    this.esDiagnostico = false,
  });
}