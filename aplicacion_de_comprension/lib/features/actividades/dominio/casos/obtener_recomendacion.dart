import 'dart:math';
import '../repositorios/repo_contenido.dart';
import '../repositorios/repo_progreso.dart';
import '../../dominio/entidades/actividad.dart';

class ObtenerRecomendacion {
  final RepoContenido repoContenido;
  final RepoProgreso repoProgreso;

  ObtenerRecomendacion(this.repoContenido, this.repoProgreso);

  Future<Actividad?> call(String usuarioId, {int? moduloId}) async {
    var candidatas = await repoContenido.getActividades();

    if (moduloId != null) {
      final modulos = await repoContenido.getModulos();
      try {
        final modulo = modulos.firstWhere((m) => m.id == moduloId);
        
        final nombreModuloLimpio = _quitarAcentos(modulo.nombre.toLowerCase());

        candidatas = candidatas.where((act) {
          return act.habilidades.any((h) {
            final nombreHabilidad = h.name.toLowerCase();
            return nombreHabilidad.contains(nombreModuloLimpio) || 
                   nombreModuloLimpio.contains(nombreHabilidad);
          });
        }).toList();
        
      } catch (e) {
        return null;
      }
    }

    if (candidatas.isEmpty) return null;

    final historial = await repoProgreso.getHistorialCompleto(usuarioId);

    final idsJugados = historial.map((e) => e.actividadId).toSet();

    final noJugadas = candidatas.where((a) => !idsJugados.contains(a.id)).toList();

    if (noJugadas.isNotEmpty) {
      noJugadas.shuffle(); 
      return noJugadas.first;
    }

    Map<int, double> promedios = {};

    for (var entry in historial) {
      if (!candidatas.any((c) => c.id == entry.actividadId)) continue;

      double porcentaje = entry.total! > 0 
          ? (entry.aciertos / entry.total!) 
          : 0.0;
      
      if (promedios.containsKey(entry.actividadId)) {
        promedios[entry.actividadId] = (promedios[entry.actividadId]! + porcentaje) / 2;
      } else {
        promedios[entry.actividadId] = porcentaje;
      }
    }

    candidatas.sort((a, b) {
      final scoreA = promedios[a.id] ?? 1.0; 
      final scoreB = promedios[b.id] ?? 1.0;
      return scoreA.compareTo(scoreB);
    });

    return candidatas.first;
  }

  String _quitarAcentos(String str) {
    var withDia = 'áéíóúÁÉÍÓÚ';
    var withoutDia = 'aeiouAEIOU';
    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    return str;
  }
}