// Modelo para una Actividad (Pregunta/Juego)
enum TipoActividadJuego { ordenarOracion, trivia, desconocido }

class ActividadModelo {
  final int id;
  final String nombre;
  final String habilidad;
  final String fuenteTexto; // "Saltan y saltan", "Las aventuras de Pinocho"
  final TipoActividadJuego tipo;
  final Map<String, dynamic> contenido;

  ActividadModelo({
    required this.id,
    required this.nombre,
    required this.habilidad,
    required this.fuenteTexto,
    required this.tipo,
    required this.contenido,
  });

  factory ActividadModelo.fromJson(Map<String, dynamic> json) {
    TipoActividadJuego tipoInferido = TipoActividadJuego.desconocido;
    final contenido = json['Contenido'] as Map<String, dynamic>;

    if (contenido.containsKey('oracion_desordenada')) {
      tipoInferido = TipoActividadJuego.ordenarOracion;
    } else if (contenido.containsKey('pregunta')) {
      tipoInferido = TipoActividadJuego.trivia;
    }

    return ActividadModelo(
      id: json['Numero'],
      nombre: json['Nombre'],
      habilidad: json['Habilidad(es)'],
      fuenteTexto: json['Texto de donde se obtuvo'] ?? '',
      tipo: tipoInferido,
      contenido: contenido,
    );
  }
}

// Modelo para un Capítulo de Historia
class CapituloModelo {
  final String titulo;
  final String texto;

  CapituloModelo({required this.titulo, required this.texto});

  factory CapituloModelo.fromJson(Map<String, dynamic> json) {
    return CapituloModelo(
      titulo: json['Titulo'] ?? 'Sin título',
      texto: json['Texto'] ?? '',
    );
  }
}