import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../tutor/presentacion/proveedor_tutor.dart'; 
import '../dominio/entidades/progreso.dart';
import '../../actividades/presentacion/proveedor_actividades.dart';

class EstadisticasData {
  final double progresoGeneral;
  final List<ModuloConProgreso> modulos;
  final int totalEstrellas;
  final double precisionPromedio; 

  EstadisticasData({
    required this.progresoGeneral,
    required this.modulos,
    this.totalEstrellas = 0,
    this.precisionPromedio = 0.0,
  });
}

final estadisticasProvider = FutureProvider.autoDispose<EstadisticasData>((ref) async {
  final repo = ref.read(repoProgresoProvider);
  final usuario = await ref.read(repoPerfilProvider).getActivo(); 

  if (usuario == null) {
    return EstadisticasData(
      progresoGeneral: 0.0,
      modulos: [],
      totalEstrellas: 0,
      precisionPromedio: 0.0,
    );
  }

  final resultados = await Future.wait([
    repo.getProgresoGeneral(usuario.id),
    repo.getModulosDelUsuario(usuario.id),
    repo.getHistorialCompleto(usuario.id),
  ]);

  final general = resultados[0] as double;
  final modulos = resultados[1] as List<ModuloConProgreso>;
  final historial = resultados[2] as List<dynamic>; 

  final estrellas = historial.where((h) => (h.total ?? 0) > 0).length;

  return EstadisticasData(
    progresoGeneral: general,
    modulos: modulos,
    totalEstrellas: estrellas,
  );
});