import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplicacion_de_comprension/core/providers/proveedor.dart';
import '../datos/repo_dashboard_impl.dart';
import '../dominio/entidades/dashboard.dart';
import '../../tutor/presentacion/proveedor_tutor.dart';

final dashboardRepoProvider = Provider<DashboardRepositoryImpl>((ref) {
  final db = ref.read(dbProvider); // Tu provider global de base de datos
  return DashboardRepositoryImpl(db);
});

// 2. Proveedor de los Datos (FutureProvider es ideal para carga inicial)
final dashboardInfoProvider = FutureProvider.autoDispose<MenuData?>((ref) async {
  final repo = ref.read(dashboardRepoProvider);
  final perfil = await ref.watch(perfilActivoProvider.future);
  return repo.getMenuData(perfil);
});