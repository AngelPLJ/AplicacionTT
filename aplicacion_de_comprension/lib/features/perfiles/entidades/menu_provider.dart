import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart'; // Necesario para 'select'
import '../../../core/providers/proveedor.dart';
import '../../usuario/entidades/perfil.dart';
import '../repositorios/repo_contenido_json.dart'; // Asegúrate de importar esto
import '../../../core/utils/utils.dart'; // Importa ProgresoActividad
class MenuData {
  final Perfil usuario;
  final double progresoTotal;
  final List<ModuloConProgreso> modulos;
  final bool esNuevoUsuario;
  
  // Recomendación
  final int actividadRecomendadaId;
  final String tituloRecomendacion;
  final String motivoRecomendacion;

  // NUEVO: Flag para controlar la navegación
  final bool necesitaDiagnostico;

  MenuData({
    required this.usuario,
    required this.progresoTotal,
    required this.modulos,
    required this.esNuevoUsuario,
    required this.actividadRecomendadaId,
    required this.tituloRecomendacion,
    required this.motivoRecomendacion,
    required this.necesitaDiagnostico, 
  });
}

final menuDataProvider = FutureProvider.autoDispose<MenuData>((ref) async {
  // 1. Obtener dependencias
  final repoPerfil = ref.read(repoPerfilProvider);
  final repoProgreso = ref.read(repoProgresoProvider);
  final db = ref.read(dbProvider); // <--- CORRECCIÓN 1: Obtenemos la DB
  
  final usuario = await repoPerfil.getActivo();
  if (usuario == null) throw Exception("No hay usuario activo");

  final progresoTotal = await repoProgreso.getProgresoGeneral(usuario.id);
  final modulos = await repoProgreso.getModulosDelUsuario(usuario.id);
  final esNuevo = progresoTotal <= 0.01;

  // --- LÓGICA DE DIAGNÓSTICO ---
  // Consultamos si el Módulo 0 (Diagnóstico) está al 100% (1.0)
  final progresoDiagnostico = await (db.select(db.modulosHasUsuarios)
    ..where((t) => t.usuarioId.equals(usuario.id) & t.moduloId.equals(0)))
    .getSingleOrNull();

  // Si es nulo o menor a 1.0, falta el diagnóstico
  bool diagnosticoCompletado = (progresoDiagnostico?.progreso ?? 0.0) >= 1.0;

  // --- LÓGICA DE RECOMENDACIÓN INTELIGENTE ---
  int recId = 1; 
  String recTitulo = "Empezar Aventura";
  String recMotivo = "Comienza por el principio";

  // Solo calculamos recomendación si ya hizo el diagnóstico
  if (!esNuevo && diagnosticoCompletado) {
    final historial = await repoProgreso.getHistorialCompleto(usuario.id);
    final repoJson = ref.read(repoContenidoJsonProvider);
    final todasLasActividades = await repoJson.cargarActividades();

    Map<String, List<double>> puntajesPorHabilidad = {};

    for (var intento in historial) {
      try {
        final actModelo = todasLasActividades.firstWhere((a) => a.id == intento.actividadId);
        // Validación para evitar división por cero
        double score = (intento.total ?? 0) > 0 
            ? (intento.aciertos / intento.total!) 
            : 0.0;

        final habilidades = actModelo.habilidad.split(',').map((e) => e.trim());
        
        for (var h in habilidades) {
          if (!puntajesPorHabilidad.containsKey(h)) {
            puntajesPorHabilidad[h] = [];
          }
          puntajesPorHabilidad[h]!.add(score);
        }
      } catch (e) {
        // Ignoramos actividades que no estén en el JSON actual
      }
    }

    String? habilidadMasDebil;
    double menorPromedio = 100.0;

    puntajesPorHabilidad.forEach((habilidad, scores) {
      if (scores.isNotEmpty) {
        final promedio = scores.reduce((a, b) => a + b) / scores.length;
        if (promedio < menorPromedio) {
          menorPromedio = promedio;
          habilidadMasDebil = habilidad;
        }
      }
    });

    if (habilidadMasDebil != null) {
      recMotivo = "Refuerza tu $habilidadMasDebil";
      final candidatas = todasLasActividades.where(
        (a) => a.habilidad.contains(habilidadMasDebil!)
      ).toList();
      
      if (candidatas.isNotEmpty) {
        candidatas.shuffle();
        final seleccionada = candidatas.first;
        recId = seleccionada.id;
        recTitulo = seleccionada.nombre;
      }
    }
  } 
  // Si no ha hecho el diagnóstico, forzamos la recomendación hacia allá (opcional)
  else if (!diagnosticoCompletado) {
     recTitulo = "Evaluación Diagnóstica";
     recMotivo = "Descubre tu nivel inicial";
     recId = 0; // ID reservado para navegar al diagnóstico si quieres usar el mismo botón
  }

  return MenuData(
    usuario: usuario,
    progresoTotal: progresoTotal,
    modulos: modulos,
    esNuevoUsuario: esNuevo,
    actividadRecomendadaId: recId,
    tituloRecomendacion: recTitulo,
    motivoRecomendacion: recMotivo,
    necesitaDiagnostico: !diagnosticoCompletado, // <--- CORRECCIÓN 2: Pasamos el dato
  );
});