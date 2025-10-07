import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Tutor extends Table {
  TextColumn get id => text()();
  TextColumn get usuario => text().nullable()(); // opcional
  TextColumn get contrasenia => text().nullable()(); // PBKDF2/Argon2/scrypt
  DateTimeColumn get fechaCreacion => dateTime()();
  @override Set<Column> get primaryKey => {id};
}

class Perfiles extends Table {
  TextColumn get id => text()();
  TextColumn get tutorId => text().references(Tutor, #id)();
  TextColumn get nombre => text()();
  TextColumn get codigoAvatar => text()();
  BoolColumn get activo => boolean().withDefault(const Constant(false))();
  @override Set<Column> get primaryKey => {id};
}

class Modulos extends Table {
  TextColumn get id => text()();
  TextColumn get nombreModulo => text()();
}

class Configuraciones extends Table {
  TextColumn get tutorId => text().references(Tutor, #id)();
  BoolColumn get ttsHabilitado => boolean().withDefault(const Constant(true))();
  RealColumn get ttsFrecuencia => real().withDefault(const Constant(0.5))();
  RealColumn get ttsTono => real().withDefault(const Constant(1.0))();
  BoolColumn get parentalLock => boolean().withDefault(const Constant(false))();
  @override Set<Column> get primaryKey => {tutorId};
}

class KvStore extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  @override Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [Tutor, Perfiles, Configuraciones, KvStore])
class AppDatabase extends _$AppDatabase {
  AppDatabase._(super.e);
  @override int get schemaVersion => 1;

  static Future<AppDatabase> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app.db'));
    final executor = NativeDatabase.createInBackground(file);
    return AppDatabase._(executor);
  }

  // Helpers básicos
  Future<bool> tieneTutor() async => (await select(tutor).get()).isNotEmpty;

  Future<void> upsertKv(String k, String v) async =>
      into(kvStore).insertOnConflictUpdate(KvStoreCompanion.insert(key: k, value: v));
  Future<String?> getKv(String k) async =>
      (await (select(kvStore)..where((t) => t.key.equals(k))).getSingleOrNull())?.value;
}