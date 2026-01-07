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

    final query = _db.select(_db.modulos).join([
      leftOuterJoin(
        _db.modulosHasUsuarios,
        _db.modulosHasUsuarios.moduloId.equalsExp(_db.modulos.id) &
        _db.modulosHasUsuarios.usuarioId.equals(usuario.id),
      ),
    ]);

    final rows = await query.get();

    List<ModuloConProgreso> listaModulos = [];
    bool diagnosticoCompletado = false;
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

    // Calcular promedio general (evitando división por cero)
    final promedioGeneral = conteoModulos > 0 
        ? sumaProgreso / conteoModulos 
        : 0.0;

    return MenuData(
      usuario: usuario.nombre,
      usuarioAvatar: usuario.codigoAvatar,
      progresoTotal: promedioGeneral,
      necesitaDiagnostico: !diagnosticoCompletado, // <--- Lógica clave
      modulos: listaModulos,
    );
  }
}