import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/proveedor.dart';
import '../../usuario/entidades/perfil.dart';
import '../../../core/utils.dart';

 
class MenuData {
  final Perfil usuario;
  final double progresoTotal;
  final List<ModuloConProgreso> modulos;
  final bool esNuevoUsuario;

  final int actividadRecomendadaId;
  final String tituloRecomendacion;
  final String motivoRecomendacion;

  MenuData({
    required this.usuario,
    required this.progresoTotal,
    required this.modulos,
    required this.esNuevoUsuario,
    required this.actividadRecomendadaId,
    required this.tituloRecomendacion,
    required this.motivoRecomendacion,
  });
}

final menuDataProvider = FutureProvider.autoDispose<MenuData>((ref) async {
  final repoPerfil = ref.read(repoPerfilProvider);
  final usuario = await repoPerfil.getActivo();
  if (usuario == null) throw Exception("No hay usuario activo");

  final repoProgreso = ref.read(repoProgresoProvider);
  final progresoTotal = await repoProgreso.getProgresoGeneral(usuario.id);
  final modulos = await repoProgreso.getModulosDelUsuario(usuario.id);
  final esNuevo = progresoTotal <= 0.01;

  // --- LÓGICA DE RECOMENDACIÓN INTELIGENTE ---
  int recId = 1; // Default: Actividad 1
  String recTitulo = "Empezar Aventura";
  String recMotivo = "Comienza por el principio";

  if (!esNuevo) {
    // 1. Obtenemos historial y definiciones
    final historial = await repoProgreso.getHistorialCompleto(usuario.id);
    final repoJson = ref.read(repoContenidoJsonProvider);
    final todasLasActividades = await repoJson.cargarActividades();

    // 2. Calculamos efectividad por habilidad
    // Mapa: "Atención" -> [0.5, 1.0, 0.0] (Lista de porcentajes de acierto)
    Map<String, List<double>> puntajesPorHabilidad = {};

    for (var intento in historial) {
      // Buscamos qué actividad fue
      try {
        final actModelo = todasLasActividades.firstWhere((a) => a.id == intento.actividadId);
        
        // Calculamos score de este intento (aciertos / total)
        // Evitamos división por cero
        double score = (intento.total ?? 1) > 0 
            ? intento.aciertos / (intento.total!) 
            : 0.0;

        // Una actividad puede tener varias habilidades: "Vocabulario, lógica"
        final habilidades = actModelo.habilidad.split(',').map((e) => e.trim());
        
        for (var h in habilidades) {
          if (!puntajesPorHabilidad.containsKey(h)) {
            puntajesPorHabilidad[h] = [];
          }
          puntajesPorHabilidad[h]!.add(score);
        }
      } catch (e) {
        // Si no encontramos la actividad en el JSON, la ignoramos
      }
    }

    // 3. Encontramos la habilidad más débil (Menor promedio)
    String? habilidadMasDebil;
    double menorPromedio = 100.0;

    puntajesPorHabilidad.forEach((habilidad, scores) {
      final promedio = scores.reduce((a, b) => a + b) / scores.length;
      if (promedio < menorPromedio) {
        menorPromedio = promedio;
        habilidadMasDebil = habilidad;
      }
    });

    // 4. Seleccionamos una actividad de esa habilidad
    if (habilidadMasDebil != null) {
      recMotivo = "Refuerza tu $habilidadMasDebil";
      
      // Buscamos una actividad que tenga esa habilidad
      // Idealmente una que NO haya hecho, o una aleatoria de ese tipo
      final candidatas = todasLasActividades.where(
        (a) => a.habilidad.contains(habilidadMasDebil!)
      ).toList();
      
      if (candidatas.isNotEmpty) {
        candidatas.shuffle(); // Aleatorio para variar
        final seleccionada = candidatas.first;
        recId = seleccionada.id;
        recTitulo = seleccionada.nombre;
      }
    }
  }

  final progresoDiagnostico = await db.select(db.modulosHasUsuarios)
    .where((t) => t.usuarioId.equals(usuarioId) & t.moduloId.equals(0)) // Módulo 0
    .getSingleOrNull();

  bool diagnosticoCompletado = (progresoDiagnostico?.progreso ?? 0.0) >= 1.0;

  if (!diagnosticoCompletado) {
    // Redirigir a Evaluación Diagnóstica
  }

  return MenuData(
    usuario: usuario,
    progresoTotal: progresoTotal,
    modulos: modulos,
    esNuevoUsuario: esNuevo,
    actividadRecomendadaId: recId,
    tituloRecomendacion: recTitulo,
    motivoRecomendacion: recMotivo,
  );
});