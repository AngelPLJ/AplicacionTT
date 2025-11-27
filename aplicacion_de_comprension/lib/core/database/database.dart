import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Recuerda ejecutar en la terminal: dart run build_runner build
part 'database.g.dart';

// ==========================================
// 1. TABLAS PRINCIPALES (Catálogos)
// ==========================================

class Tutor extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get usuario => text()(); 
  TextColumn get pinSeguridad => text()(); // Para bloquear config
  DateTimeColumn get fechaCreacion => dateTime().withDefault(currentDate)();
  
  @override
  Set<Column> get primaryKey => {id};
}

class KvStore extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  
  @override
  Set<Column> get primaryKey => {key};
}

class Usuarios extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get tutorId => text().references(Tutor, #id)();
  TextColumn get nombre => text().withLength(max: 255)();
  TextColumn get icono => text().withLength(max: 32)();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
  @override
  Set<Column> get primaryKey => {id};
}

class Configuraciones extends Table {
  TextColumn get tutorId => text().references(Tutor, #id)();
  BoolColumn get ttsHabilitado => boolean().withDefault(const Constant(true))();
  RealColumn get ttsVelocidad => real().withDefault(const Constant(0.5))();
  BoolColumn get musicaFondo => boolean().withDefault(const Constant(true))();
  
  @override
  Set<Column> get primaryKey => {tutorId};
}

class Numeros extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get numero => integer()();
  @override
  Set<Column> get primaryKey => {id};
}

class Fonemas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fonema => text().withLength(max: 45)();
  @override
  Set<Column> get primaryKey => {id};
}

class TipoDePalabra extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tipo => text().withLength(max: 15)();
  @override
  Set<Column> get primaryKey => {id};
}

class Palabras extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get palabra => text().withLength(max: 24)();
  // Relación con TipoDePalabra
  IntColumn get tipoDePalabraId => integer().references(TipoDePalabra, #id)();
  @override
  Set<Column> get primaryKey => {id};
}

class Modulos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(max: 45)();
  @override
  Set<Column> get primaryKey => {id};
}

class Actividades extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(max: 45).nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class Medallas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(max: 45)();
  TextColumn get imagen => text().withLength(max: 45)();
  TextColumn get assetPath => text()(); // Ruta de la imagen
  @override
  Set<Column> get primaryKey => {id};
}

// ==========================================
// 2. TABLAS INTERMEDIAS (Relaciones _has_)
// ==========================================

// Tabla: usuarios_has_numeros
class UsuariosHasNumeros extends Table {
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
  IntColumn get numeroId => integer().references(Numeros, #id)();
  IntColumn get aciertos => integer()();
  IntColumn get total => integer()();

  @override
  Set<Column> get primaryKey => {usuarioId, numeroId};
}

// Tabla: usuarios_has_fonemas
class UsuariosHasFonemas extends Table {
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
  IntColumn get fonemaId => integer().references(Fonemas, #id)();
  IntColumn get aciertos => integer()();
  IntColumn get total => integer()();

  @override
  Set<Column> get primaryKey => {usuarioId, fonemaId};
}

// Tabla: usuarios_has_palabras
class UsuariosHasPalabras extends Table {
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
  IntColumn get palabraId => integer().references(Palabras, #id)();
  IntColumn get aciertos => integer()();
  IntColumn get total => integer()();

  @override
  Set<Column> get primaryKey => {usuarioId, palabraId}; 
}

// Tabla: actividades_has_modulos
class ActividadesHasModulos extends Table {
  IntColumn get actividadId => integer().references(Actividades, #id)();
  IntColumn get moduloId => integer().references(Modulos, #id)();

  @override
  Set<Column> get primaryKey => {actividadId, moduloId};
}

// Tabla: usuarios_has_actividades
class UsuariosHasActividades extends Table {
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
  IntColumn get actividadId => integer().references(Actividades, #id)();
  IntColumn get aciertos => integer()();
  IntColumn get total => integer().nullable()(); // Nullable en tu SQL

  @override
  Set<Column> get primaryKey => {usuarioId, actividadId};
}

// Tabla: modulos_has_usuarios
class ModulosHasUsuarios extends Table {
  IntColumn get moduloId => integer().references(Modulos, #id)();
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
  RealColumn get progreso => real()(); 

  @override
  Set<Column> get primaryKey => {moduloId, usuarioId};
}

// Tabla: usuarios_has_medallas
class UsuariosHasMedallas extends Table {
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
  IntColumn get medallaId => integer().references(Medallas, #id)();

  @override
  Set<Column> get primaryKey => {usuarioId, medallaId};
}

// ==========================================
// CONFIGURACIÓN DE LA BASE DE DATOS
// ==========================================

@DriftDatabase(tables: [
  Tutor,
  KvStore,
  Usuarios,
  Configuraciones,
  Numeros,
  Fonemas,
  TipoDePalabra,
  Palabras,
  Modulos,
  Actividades,
  Medallas,
  UsuariosHasNumeros,
  UsuariosHasFonemas,
  UsuariosHasPalabras,
  ActividadesHasModulos,
  UsuariosHasActividades,
  ModulosHasUsuarios,
  UsuariosHasMedallas,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase._(super.e);

  @override
  int get schemaVersion => 1;

  static Future<AppDatabase> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'db_educativa.sqlite'));
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

