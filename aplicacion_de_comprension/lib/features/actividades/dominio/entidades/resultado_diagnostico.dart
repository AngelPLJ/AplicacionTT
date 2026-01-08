import 'actividad.dart'; 

class ResultadoDiagnostico {
  final Map<HabilidadCognitiva, double> puntajesPorHabilidad; // Del 0.0 al 1.0 (o 0 a 100)
  final String nivelGeneral;
  final DateTime fecha;

  ResultadoDiagnostico({
    required this.puntajesPorHabilidad,
    required this.nivelGeneral,
    required this.fecha,
  });
}