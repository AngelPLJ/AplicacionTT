// lib/infraestructura/reposettingsimpl.dart
import 'package:drift/drift.dart' show Value;
import 'package:aplicacion_de_comprension/core/database/database.dart';
import '../features/usuario/repositorios/repoconfig.dart';
import '../features/usuario/entidades/configuracion.dart';

class RepoConfImpl implements RepoConfig {
  final AppDatabase db;
  RepoConfImpl(this.db);

  @override
  Future<Configuracion> getSettings(userId) async {
    final t = await db.select(db.tutor).getSingle();
    final s = await (db.select(db.configuraciones)..where((x) => x.tutorId.equals(t.id))).getSingleOrNull();

    if (s == null) {
      return Configuracion(
        tutorId: t.id,
        ttsHabilitado: true,
        ttsVelocidad: 0.5,
        musicaFondo: true
      );
    }

    return Configuracion(
      tutorId: s.tutorId,
      ttsHabilitado: s.ttsHabilitado,
      ttsVelocidad: s.ttsVelocidad,
      musicaFondo: s.musicaFondo
    );
  }

  @override
  Future<void> upsertSettings(Configuracion a) async {
    await db.into(db.configuraciones).insertOnConflictUpdate(ConfiguracionesCompanion(
      tutorId: Value(a.tutorId),
      ttsHabilitado: Value(a.ttsHabilitado),
      ttsVelocidad: Value(a.ttsVelocidad),
      musicaFondo: Value(a.musicaFondo)
    ));
  }
}
