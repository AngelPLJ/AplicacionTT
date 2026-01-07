import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/proveedor.dart'; 
import '../../tutor/presentacion/proveedor_tutor.dart'; 
import '../dominio/casos/obtener_recomendacion.dart';

import '../datos/implementaciones/repo_contenido_impl.dart';
import '../datos/implementaciones/repo_progreso_impl.dart';
import '../dominio/entidades/actividad.dart';
import 'controladores/controlador_actividad.dart';

final poblarBaseDeDatosProvider = FutureProvider<void>((ref) async {
  final db = ref.watch(dbProvider);
  final repoContenido = RepoContenidoImpl(db);
  await repoContenido.poblarBaseDeDatos();
});

final repoContenidoProvider = Provider<RepoContenidoImpl>((ref) {
  final db = ref.watch(dbProvider);
  return RepoContenidoImpl(db);
});

final repoProgresoProvider = Provider<RepoProgresoImpl>((ref) {
  final db = ref.watch(dbProvider);
  return RepoProgresoImpl(db);
});

final listaActividadesProvider = FutureProvider<List<Actividad>>((ref) async {
  final repo = ref.watch(repoContenidoProvider);
  return repo.getActividades();
});

final actividadPorIdProvider = FutureProvider.family<Actividad, int>((ref, id) async {
  final actividades = await ref.watch(listaActividadesProvider.future);
  return actividades.firstWhere(
    (a) => a.id == id,
    orElse: () => throw Exception("Actividad $id no encontrada"),
  );
});

final actividadControllerProvider = StateNotifierProvider.family
    .autoDispose<ActividadNotifier, EstadoActividad, Actividad>((ref, actividad) {
  
  final repoProgreso = ref.watch(repoProgresoProvider);
  
  final usuarioAsync = ref.watch(perfilActivoProvider); 
  
  return ActividadNotifier(
    actividadInicial: actividad,
    repoProgreso: repoProgreso,
    usuarioId: usuarioAsync.value?.id,
  );
});

final siguienteActividadProvider = FutureProvider.autoDispose<Actividad?>((ref) async {
  final usuario = await ref.watch(perfilActivoProvider.future);
  if (usuario == null) return null;

  // Instanciamos el caso de uso (asegúrate de tener los repositorios instanciados)
  final repoContenido = ref.read(repoContenidoProvider);
  final repoProgreso = ref.read(repoProgresoProvider);
  
  final obtenerRecomendacion = ObtenerRecomendacion(repoContenido, repoProgreso);
  
  return obtenerRecomendacion(usuario.id);
});