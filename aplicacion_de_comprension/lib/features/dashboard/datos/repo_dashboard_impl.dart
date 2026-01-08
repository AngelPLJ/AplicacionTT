import 'package:drift/drift.dart'; 
import '../../../core/database/database.dart';
import '../../tutor/dominio/entidades/perfil.dart';
import '../dominio/entidades/dashboard.dart';
import '../dominio/entidades/progreso.dart';

class DashboardRepositoryImpl {
  final AppDatabase _db;

  DashboardRepositoryImpl(this._db);

  Future<MenuData?> getMenuData(Perfil? perfil) async {
    final usuario = perfil;
    if (usuario == null) return null;

    // 1. OBTENER PROGRESO DE MÓDULOS (Tu código original)
    final query = _db.select(_db.modulos).join([
      leftOuterJoin(
        _db.modulosHasUsuarios,
        _db.modulosHasUsuarios.moduloId.equalsExp(_db.modulos.id) &
        _db.modulosHasUsuarios.usuarioId.equals(usuario.id),
      ),
    ]);

    final rows = await query.get();

    List<ModuloConProgreso> listaModulos = [];
    double sumaProgreso = 0;
    int conteoModulos = 0;

    for (final row in rows) {
      final modulo = row.readTable(_db.modulos);
      final progresoRow = row.readTableOrNull(_db.modulosHasUsuarios);
      
      final double porcentaje = progresoRow?.progreso ?? 0.0;

      listaModulos.add(ModuloConProgreso(
        id: modulo.id,
        nombre: modulo.nombre,
        porcentaje: porcentaje,
      ));
      sumaProgreso += porcentaje;
      conteoModulos++;
    }

    final promedioGeneral = conteoModulos > 0 
        ? sumaProgreso / conteoModulos 
        : 0.0;

    // 2. VERIFICAR DIAGNÓSTICO (ESTO ES LO QUE FALTABA)
    // Buscamos si existe un registro en la tabla de resultados para este usuario
    final resultadoDiagnostico = await (_db.select(_db.resultadosDiagnostico)
      ..where((t) => t.usuarioId.equals(usuario.id)))
      .getSingleOrNull();

    // Si encontramos un registro (no es null), significa que YA LO HIZO.
    final bool diagnosticoCompletado = resultadoDiagnostico != null;

    return MenuData(
      usuario: usuario.nombre,
      usuarioAvatar: usuario.codigoAvatar,
      progresoTotal: promedioGeneral,
      
      // Si diagnosticoCompletado es TRUE, necesitaDiagnostico es FALSE.
      necesitaDiagnostico: !diagnosticoCompletado, 
      
      modulos: listaModulos,
    );
  }
}