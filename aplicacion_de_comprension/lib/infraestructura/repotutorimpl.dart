// lib/infraestructura/repotutorimpl.dart
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:aplicacion_de_comprension/core/database/database.dart';
import '../core/seguridad.dart';
import '../core/hasher.dart';
import '../features/usuario/repositorios/repotutor.dart';

class RepoTutorImpl implements RepoTutor {
  final AppDatabase db;
  final SecureStorage sec;
  final PasswordHasher hasher;
  RepoTutorImpl(this.db, this.sec, this.hasher);

  static const _kSaltKey = 'tutor_salt';
  static const _kSessionOpen = 'session_open';

  @override
  Future<bool> existeTutor() => db.tieneTutor();

  @override
  Future<void> crearTutor({String? usuario, required String secret}) async {
    if (await existeTutor()) {
      throw Exception('Tutor ya existe');
    }
    final salt = hasher.generateSalt();
    await sec.write(_kSaltKey, base64Encode(salt));
    final stored = await hasher.hash(secret, salt: salt);
    final id = const Uuid().v4();

    await db.into(db.tutor).insert(TutorCompanion.insert(
      id: id,
      usuario: usuario ?? '',
      pinSeguridad: stored,
    ));

    await setSesionRapida(true);
  }

  @override
  Future<bool> autenticar(String secreto) async {
    final row = await db.select(db.tutor).getSingle();
    final saltString = await sec.read(_kSaltKey);
    if (saltString == null) {
      // Si no hay salt guardado por algún error de corrupción, no podemos verificar
      return false; 
    }
    final salt = base64Decode(saltString);
    return hasher.verify(secreto, row.pinSeguridad, salt: salt);
  }

  @override
  Future<void> setSesionRapida(bool enabled) =>
      db.upsertKv(_kSessionOpen, enabled ? '1' : '0');

  @override
  Future<bool> sesionRapidaActiva() async =>
      (await db.getKv(_kSessionOpen)) == '1';
}
