import 'package:drift/drift.dart';
import '../../../../core/database/database.dart'; // Tu archivo generado por drift
import '../../dominio/repositorios/repo_progreso.dart';
import '../../../dashboard/dominio/entidades/progreso.dart'; // Tu modelo ModuloConProgreso

class RepoProgresoImpl implements RepoProgreso {
  final AppDatabase _db;

  RepoProgresoImpl(this._db);

  @override
  Future<void> guardarProgresoActividad({
    required String usuarioId,
    required int actividadId,
    required bool esAcierto,
  }) async {
    // 1. Buscamos si ya existe un registro previo
    final registroPrevio = await (_db.select(_db.usuariosHasActividades)
          ..where((t) =>
              t.usuarioId.equals(usuarioId) & t.actividadId.equals(actividadId)))
        .getSingleOrNull();

    final aciertosAnteriores = registroPrevio?.aciertos ?? 0;
    final totalAnterior = registroPrevio?.total ?? 0;

    // 2. Calculamos nuevos valores (Acumulativo)
    final nuevosAciertos = aciertosAnteriores + (esAcierto ? 1 : 0);
    final nuevoTotal = totalAnterior + 1;

    // 3. Upsert (Insertar o Actualizar)
    await _db.into(_db.usuariosHasActividades).insertOnConflictUpdate(
          UsuariosHasActividadesCompanion(
            usuarioId: Value(usuarioId),
            actividadId: Value(actividadId),
            aciertos: Value(nuevosAciertos),
            total: Value(nuevoTotal),
          ),
        );
  }

  @override
  Future<List<ProgresoActividad>> getHistorialCompleto(String usuarioId) async {
    return (_db.select(_db.usuariosHasActividades)
          ..where((t) => t.usuarioId.equals(usuarioId)))
        .get();
  }
  
  // Implementación básica de los otros métodos requeridos por la interfaz abstracta...
  @override
  Future<double> getProgresoGeneral(String usuarioId) async {
      final actividadesRealizadas = await (_db.select(_db.usuariosHasActividades)
          ..where((t) => t.usuarioId.equals(usuarioId)))
        .get();
      if (actividadesRealizadas.isEmpty) return 0.0;
      double totalProgreso = 0.0;
      for (var actividad in actividadesRealizadas) {
        if (actividad.total != null && actividad.total! > 0) {
          totalProgreso += actividad.aciertos / actividad.total!;
        }
      }
      return totalProgreso / actividadesRealizadas.length; 
  }

  @override
  Future<List<ModuloConProgreso>> getModulosDelUsuario(String usuarioId) async {
    // Retorna lista vacía o implementa el join si lo necesitas aquí
    final query = _db.select(_db.modulos).join([
      leftOuterJoin(
        _db.modulosHasUsuarios,
        _db.modulos.id.equalsExp(_db.modulosHasUsuarios.moduloId) &
            _db.modulosHasUsuarios.usuarioId.equals(usuarioId),
      ),
    ]);
    final results = await query.get();
    return results.map((row) {
      final modulo = row.readTable(_db.modulos);
      final progresoRow = row.readTableOrNull(_db.modulosHasUsuarios);
      final progreso = progresoRow?.progreso ?? 0.0;
      return ModuloConProgreso(
        id: modulo.id,
        nombre: modulo.nombre,
        porcentaje: progreso,
      );
    }).toList();
  }

  @override
  Future<void> actualizarProgresoModulo({required String usuarioId, required int moduloId, required double progreso}) async {
      await _db.into(_db.modulosHasUsuarios).insertOnConflictUpdate(
        ModulosHasUsuariosCompanion(
            usuarioId: Value(usuarioId),
            moduloId: Value(moduloId),
            progreso: Value(progreso)
        )
      );
  }
  
  // ... (Implementar los métodos de fonemas/números si los usas, o dejarlos vacíos por ahora)
  @override
  Future<void> guardarProgresoNumero({required String usuarioId, required int numeroId, required bool fueAcierto}) async {
    await _db.into(_db.usuariosHasNumeros).insertOnConflictUpdate(
      UsuariosHasNumerosCompanion(
        usuarioId: Value(usuarioId),
        numeroId: Value(numeroId),
        aciertos: Value(fueAcierto ? 1 : 0),
        total: Value(1),
      ),
    );
  }
  @override
  Future<void> guardarProgresoFonema({required String usuarioId, required int fonemaId, required bool fueAcierto}) async {
    await _db.into(_db.usuariosHasFonemas).insertOnConflictUpdate(
      UsuariosHasFonemasCompanion(
        usuarioId: Value(usuarioId),
        fonemaId: Value(fonemaId),
        aciertos: Value(fueAcierto ? 1 : 0),
        total: Value(1),
      ),
    );
  }
  @override
  Future<List<UsuariosHasNumero>> getProgresoNumeros(String usuarioId) async => [];
}