import 'package:drift/drift.dart';
import '../../core/database/database.dart';
import '../features/perfiles/repositorios/repo_progreso.dart';
import '../core/utils.dart';

class RepoProgresoImpl implements RepoProgreso {
  final AppDatabase db;
  RepoProgresoImpl(this.db);

  @override
  Future<void> guardarProgresoNumero({
    required String usuarioId,
    required int numeroId,
    required bool fueAcierto,
  }) async {
    await db.transaction(() async {
      // Buscamos si ya existe registro para este usuario y este número
      final registro = await (db.select(db.usuariosHasNumeros)
            ..where((t) => t.usuarioId.equals(usuarioId) & t.numeroId.equals(numeroId)))
          .getSingleOrNull();

      if (registro == null) {
        // Si no existe, creamos uno nuevo
        await db.into(db.usuariosHasNumeros).insert(
              UsuariosHasNumerosCompanion.insert(
                usuarioId: usuarioId, // Asegúrate de haber corregido el tipo a String en la DB
                numeroId: numeroId,
                aciertos: fueAcierto ? 1 : 0,
                total: 1,
              ),
            );
      } else {
        // Si existe, actualizamos los contadores
        await (db.update(db.usuariosHasNumeros)
              ..where((t) => t.usuarioId.equals(usuarioId) & t.numeroId.equals(numeroId)))
            .write(
          UsuariosHasNumerosCompanion(
            aciertos: Value(registro.aciertos + (fueAcierto ? 1 : 0)),
            total: Value(registro.total + 1),
          ),
        );
      }
    });
  }

  @override
  Future<void> guardarProgresoFonema({
    required String usuarioId,
    required int fonemaId,
    required bool fueAcierto,
  }) async {
    // Lógica similar a numeros pero con la tabla fonemas...
     await db.transaction(() async {
      final registro = await (db.select(db.usuariosHasFonemas)
            ..where((t) => t.usuarioId.equals(usuarioId) & t.fonemaId.equals(fonemaId)))
          .getSingleOrNull();

      if (registro == null) {
        await db.into(db.usuariosHasFonemas).insert(
              UsuariosHasFonemasCompanion.insert(
                usuarioId: usuarioId, 
                fonemaId: fonemaId,
                aciertos: fueAcierto ? 1 : 0,
                total: 1,
              ),
            );
      } else {
        await (db.update(db.usuariosHasFonemas)
              ..where((t) => t.usuarioId.equals(usuarioId) & t.fonemaId.equals(fonemaId)))
            .write(
          UsuariosHasFonemasCompanion(
            aciertos: Value(registro.aciertos + (fueAcierto ? 1 : 0)),
            total: Value(registro.total + 1),
          ),
        );
      }
    });
  }

  @override
  Future<List<UsuariosHasNumero>> getProgresoNumeros(String usuarioId) {
    return (db.select(db.usuariosHasNumeros)..where((t) => t.usuarioId.equals(usuarioId))).get();
  }

  @override
  Future<double> getProgresoGeneral(String usuarioId) async {
    // Calculamos el promedio de la columna 'progreso' en la tabla intermedia
    final query = db.selectOnly(db.modulosHasUsuarios)
      ..addColumns([db.modulosHasUsuarios.progreso.avg()])
      ..where(db.modulosHasUsuarios.usuarioId.equals(usuarioId));

    final result = await query.getSingle();
    return result.read(db.modulosHasUsuarios.progreso.avg()) ?? 0.0;
  }

  @override
  Future<List<ModuloConProgreso>> getModulosDelUsuario(String usuarioId) async {
    // Hacemos un LEFT JOIN para traer TODOS los módulos, 
    // aunque el usuario no los haya empezado (progreso null = 0)
    final query = db.select(db.modulos).join([
      leftOuterJoin(
        db.modulosHasUsuarios,
        db.modulosHasUsuarios.moduloId.equalsExp(db.modulos.id) &
        db.modulosHasUsuarios.usuarioId.equals(usuarioId),
      ),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      final modulo = row.readTable(db.modulos);
      final relacion = row.readTableOrNull(db.modulosHasUsuarios);
      
      return ModuloConProgreso(
        id: modulo.id,
        nombre: modulo.nombre,
        porcentaje: relacion?.progreso ?? 0.0, // Si es nulo, es 0%
      );
    }).toList();
  }

  @override
  Future<void> guardarProgresoActividad({
    required String usuarioId,
    required int actividadId,
    required bool esAcierto,
  }) async {
    await db.transaction(() async {
      // 1. Buscamos si ya existe un registro para este usuario y esta actividad
      final registro = await (db.select(db.usuariosHasActividades)
            ..where((t) => t.usuarioId.equals(usuarioId) & t.actividadId.equals(actividadId)))
          .getSingleOrNull();

      if (registro == null) {
        // 2. Si NO existe, creamos el primer registro
        await db.into(db.usuariosHasActividades).insert(
              UsuariosHasActividadesCompanion.insert(
                usuarioId: usuarioId,
                actividadId: actividadId,
                aciertos: esAcierto ? 1 : 0,
                total: const Value(1), // Es el primer intento
              ),
            );
      } else {
        // 3. Si YA existe, actualizamos los contadores
        final nuevosAciertos = registro.aciertos + (esAcierto ? 1 : 0);
        // Nota: tu campo 'total' es nullable en la BD, así que manejamos el null con ?? 0
        final nuevoTotal = (registro.total ?? 0) + 1;

        await (db.update(db.usuariosHasActividades)
              ..where((t) => t.usuarioId.equals(usuarioId) & t.actividadId.equals(actividadId)))
            .write(
          UsuariosHasActividadesCompanion(
            aciertos: Value(nuevosAciertos),
            total: Value(nuevoTotal),
          ),
        );
      }
    });
  }
  @override
  Future<List<UsuariosHasActividadesData>> getHistorialCompleto(String usuarioId) async {
    return await (db.select(db.usuariosHasActividades)
          ..where((t) => t.usuarioId.equals(usuarioId)))
        .get();
  }
}