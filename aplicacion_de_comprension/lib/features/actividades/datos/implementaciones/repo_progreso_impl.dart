import 'package:drift/drift.dart';
import '../../../../core/database/database.dart'; 
import '../../dominio/repositorios/repo_progreso.dart';
import '../../../dashboard/dominio/entidades/progreso.dart';
import '../../dominio/entidades/actividad.dart';

class RepoProgresoImpl implements RepoProgreso {
  final AppDatabase _db;

  RepoProgresoImpl(this._db);

  @override
  Future<void> guardarProgresoActividad({
    required String usuarioId,
    required int actividadId,
    required bool esAcierto,
  }) async {
    final registroPrevio = await (_db.select(_db.usuariosHasActividades)
          ..where((t) =>
              t.usuarioId.equals(usuarioId) & t.actividadId.equals(actividadId))
          ..limit(1))
        .getSingleOrNull();

    final aciertosAnteriores = registroPrevio?.aciertos ?? 0;
    final totalAnterior = registroPrevio?.total ?? 0;

    final nuevosAciertos = aciertosAnteriores + (esAcierto ? 1 : 0);
    final nuevoTotal = totalAnterior + 1;

    await _db.into(_db.usuariosHasActividades).insertOnConflictUpdate(
          UsuariosHasActividadesCompanion(
            usuarioId: Value(usuarioId),
            actividadId: Value(actividadId),
            aciertos: Value(nuevosAciertos),
            total: Value(nuevoTotal),
          ),
        );

    await _actualizarModulosRelacionados(usuarioId, actividadId);
  }

  // --- LÓGICA DE ACTUALIZACIÓN AUTOMÁTICA ---
  Future<void> _actualizarModulosRelacionados(String usuarioId, int actividadId) async {
    // A. Buscamos a qué módulos pertenece esta actividad (ej: Atención y Vocabulario)
    final relaciones = await (_db.select(_db.actividadesHasModulos)
      ..where((t) => t.actividadId.equals(actividadId)))
      .get();

    // B. Recalculamos el porcentaje para cada uno de esos módulos
    for (var rel in relaciones) {
      await _recalcularPorcentajeModulo(usuarioId, rel.moduloId);
    }
  }

  Future<void> _recalcularPorcentajeModulo(String usuarioId, int moduloId) async {
    // 1. Contar TOTAL de actividades que tiene este módulo
    final queryTotal = _db.select(_db.actividadesHasModulos)
      ..where((t) => t.moduloId.equals(moduloId));
    final listaTotal = await queryTotal.get();
    final totalActividades = listaTotal.length;

    if (totalActividades == 0) return;

    // 2. Contar cuántas ha COMPLETADO el usuario en este módulo
    // Hacemos un JOIN entre las actividades del módulo y las que el usuario ha jugado
    final queryCompletadas = _db.select(_db.usuariosHasActividades).join([
      innerJoin(
        _db.actividadesHasModulos,
        _db.actividadesHasModulos.actividadId.equalsExp(_db.usuariosHasActividades.actividadId)
      )
    ]);
    
    queryCompletadas.where(
      _db.actividadesHasModulos.moduloId.equals(moduloId) &
      _db.usuariosHasActividades.usuarioId.equals(usuarioId) &
      _db.usuariosHasActividades.total.isBiggerThanValue(0) // Si total > 0, ya la jugó
    );

    final listaCompletadas = await queryCompletadas.get();
    final actividadesCompletadas = listaCompletadas.length;

    // 3. Calcular Porcentaje (Ej: 2 completadas / 4 totales = 0.5 -> 50%)
    double nuevoPorcentaje = actividadesCompletadas / totalActividades;
    if (nuevoPorcentaje > 1.0) nuevoPorcentaje = 1.0;

    // 4. Guardar en la tabla caché que lee el Dashboard
    await actualizarProgresoModulo(
      usuarioId: usuarioId, 
      moduloId: moduloId, 
      progreso: nuevoPorcentaje
    );
  }

  // --- RESTO DE MÉTODOS (SIN CAMBIOS) ---

  @override
  Future<List<ProgresoActividad>> getHistorialCompleto(String usuarioId) async {
    return (_db.select(_db.usuariosHasActividades)
          ..where((t) => t.usuarioId.equals(usuarioId)))
        .get();
  }
  
  @override
  Future<double> getProgresoGeneral(String usuarioId) async {
      // Tu lógica original de promedio general
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
  Future<void> guardarResultadoDiagnostico({
    required String usuarioId,
    required Map<HabilidadCognitiva, double> puntajes,
  }) async {
    double suma = 0;
    int count = 0;
    puntajes.forEach((k, v) {
      if (v > 0) { 
        suma += v;
        count++;
      }
    });
    
    double promedio = count == 0 ? 0 : suma / count;

    String nivel = "Inicial";
    if (promedio >= 0.85) nivel = "Avanzado";
    else if (promedio >= 0.60) nivel = "Intermedio";

    await _db.into(_db.resultadosDiagnostico).insert(
      ResultadosDiagnosticoCompanion.insert(
        usuarioId: usuarioId,
        puntajeAtencion: puntajes[HabilidadCognitiva.atencion] ?? 0.0,
        puntajeMemoria: puntajes[HabilidadCognitiva.memoria] ?? 0.0,
        puntajeLogica: puntajes[HabilidadCognitiva.logica] ?? 0.0,
        puntajeInferencia: puntajes[HabilidadCognitiva.inferencia] ?? 0.0,
        nivelGeneral: nivel,
        fecha: Value(DateTime.now()),
      ),
    );
  }
  @override
  Future<List<UsuariosHasNumero>> getProgresoNumeros(String usuarioId) async => (_db.select(_db.usuariosHasNumeros)
        ..where((t) => t.usuarioId.equals(usuarioId)))
      .get();
}