import '../../dominio/entidades/actividad.dart';

class SesionLectura {
  final String titulo;
  final String contenidoTexto; // El cuento completo
  final List<Actividad> preguntas;

  SesionLectura({
    required this.titulo,
    required this.contenidoTexto,
    required this.preguntas,
  });
}

/// Método para agrupar (puedes ponerlo en un Utils o Controller)
List<SesionLectura> agruparActividadesPorLectura(List<Actividad> actividadesDiagnosticas, Map<String, String> textosCompletos) {
  final Map<String, List<Actividad>> agrupadas = {};

  for (var act in actividadesDiagnosticas) {
    // Asumimos que guardaste "Titulo Fuente" dentro de contenidoVisual en la BD
    // O que puedes deducirlo. Aquí uso un key hipotético del mapa de contenido.
    final titulo = act.contenido['Titulo Fuente'] ?? 'Lectura General'; 
    
    if (!agrupadas.containsKey(titulo)) {
      agrupadas[titulo] = [];
    }
    agrupadas[titulo]!.add(act);
  }

  return agrupadas.entries.map((entry) {
    return SesionLectura(
      titulo: entry.key,
      // Aquí deberías obtener el texto real del cuento según el título
      contenidoTexto: textosCompletos[entry.key] ?? "Texto no encontrado...",
      preguntas: entry.value,
    );
  }).toList();
}