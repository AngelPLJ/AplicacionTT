// lib\features\actividades\dominio\casos\obtener_recomendacion.dart

import '../repositorios/repo_contenido.dart';
import '../repositorios/repo_progreso.dart';
import '../../dominio/entidades/actividad.dart';

class ObtenerRecomendacion {
  final RepoContenido repoContenido;
  final RepoProgreso repoProgreso;

  ObtenerRecomendacion(this.repoContenido, this.repoProgreso);

  Future<Actividad?> call(String usuarioId) async {
    // 1. Obtener historial y todas las actividades disponibles
    final historial = await repoProgreso.getHistorialCompleto(usuarioId);
    final todas = await repoContenido.getActividades(); 

    // Si no hay historial, sugerimos la primera actividad (o podrías sugerir una aleatoria)
    if (historial.isEmpty) {
       return todas.isNotEmpty ? todas.first : null;
    }

   Map<int, List<double>> puntajesPorActividad = {};
    
    for (var entry in historial) {
      final actId = entry.actividadId;
    
      double porcentaje = entry.total! > 0 
          ? (entry.aciertos / entry.total!) 
          : 0.0;

      if (!puntajesPorActividad.containsKey(actId)) {
        puntajesPorActividad[actId] = [];
      }
      puntajesPorActividad[actId]!.add(porcentaje);
    }

    int? idPeorActividad;
    double peorPromedio = 2.0;

    puntajesPorActividad.forEach((id, listaPuntajes) {
      double promedio = listaPuntajes.reduce((a, b) => a + b) / listaPuntajes.length;
      
      if (promedio < peorPromedio) {
        peorPromedio = promedio;
        idPeorActividad = id;
      }
    });

    if (idPeorActividad != null) {
      try {
        return todas.firstWhere((a) => a.id == idPeorActividad);
      } catch (e) {
        return todas.first;
      }
    }

    return todas.first; 
  }
}