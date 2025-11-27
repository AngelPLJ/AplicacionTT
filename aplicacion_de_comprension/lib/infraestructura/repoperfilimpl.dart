// lib/infraestructura/repoperfilimpl.dart
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' show Value;
import 'package:aplicacion_de_comprension/core/database/database.dart'; // <-- tu ruta real
import '../features/usuario/repositorios/repoperfil.dart';
import '../features/usuario/entidades/perfil.dart'; // tu entidad (o ChildProfile)

class ProfileRepositoryImpl implements RepoPerfil {
  final AppDatabase db;
  ProfileRepositoryImpl(this.db);

  static const _kActiveProfile = 'active_profile_id';

  @override
  Future<Perfil> crearPerfil({required String name, required String avatarCode}) async {
    final tutorRow = await db.select(db.tutor).getSingle(); // hay un único tutor
    final id = const Uuid().v4();

    await db.into(db.usuarios).insert(UsuariosCompanion.insert(
      id: id,
      tutorId: tutorRow.id,
      nombre: name,
      icono: avatarCode,
      activo: const Value(false),
    ));

    return Perfil(
      id: id,
      tutorId: tutorRow.id,
      nombre: name,
      codigoAvatar: avatarCode,
      activo: false,
    );
  }

  @override
  Stream<List<Perfil>> mirarPerfiles() {
    return (db.select(db.usuarios)).watch().map((rows) => rows.map((r) =>
      Perfil(
        id: r.id,
        tutorId: r.tutorId,
        nombre: r.nombre,
        codigoAvatar: r.icono,
        activo: r.activo,
      )
    ).toList());
  }

  @override
  Future<void> elegirActivo(String profileId) async {
    // Pone activo=true solo al elegido, y false al resto
    final todos = await db.select(db.usuarios).get();
    for (final r in todos) {
      await (db.update(db.usuarios)..where((t) => t.id.equals(r.id)))
          .write(UsuariosCompanion(activo: Value(r.id == profileId)));
    }
    await db.upsertKv(_kActiveProfile, profileId);
  }

  @override
  Future<Perfil?> getActivo() async {
    final activeId = await db.getKv(_kActiveProfile);
    if (activeId == null) return null;
    final r = await (db.select(db.usuarios)..where((t) => t.id.equals(activeId))).getSingleOrNull();
    if (r == null) return null;
    return Perfil(
      id: r.id,
      tutorId: r.tutorId,
      nombre: r.nombre,
      codigoAvatar: r.icono,
      activo: r.activo,
    );
  }
}