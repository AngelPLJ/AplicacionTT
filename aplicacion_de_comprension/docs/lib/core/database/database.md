Claro, aquí tienes la documentación completa del archivo de código, siguiendo todas tus instrucciones.

```markdown
# Documentación de `database.dart`

## Resumen General

Este archivo define la capa de persistencia de datos local de la aplicación utilizando el paquete `drift` (anteriormente Moor), un potente kit de herramientas de base de datos reactiva para Flutter y Dart. Establece el esquema de una base de datos SQLite y proporciona la lógica para su inicialización y acceso.

El propósito principal es gestionar todos los datos del usuario, incluyendo cuentas de tutores, perfiles asociados, configuraciones de la aplicación y un almacén genérico de clave-valor.

### Componentes Principales

#### 1. Tablas (Esquema de la Base de Datos)
El archivo define cinco tablas que estructuran los datos de la aplicación:
*   **Tutor**: Almacena la información de la cuenta principal del usuario (tutor), incluyendo credenciales y fecha de creación.
*   **Perfiles**: Gestiona los perfiles individuales (probablemente para niños o estudiantes) asociados a una cuenta de tutor.
*   **Configuraciones**: Guarda las preferencias específicas de cada tutor, como la configuración de Texto a Voz (TTS) y el bloqueo parental.
*   **KvStore**: Una tabla de almacenamiento genérico de clave-valor para guardar datos arbitrarios y no estructurados, como flags de estado o configuraciones simples.
*   **Modulos**: Aunque está definida, esta tabla **no está incluida** en la anotación `@DriftDatabase`, por lo que actualmente no forma parte de la base de datos generada. Podría ser una tabla en desuso o para una funcionalidad futura.

#### 2. Clase de la Base de Datos (`AppDatabase`)
Esta es la clase central que `drift` utiliza para generar todo el código de acceso a la base de datos.
*   **Inicialización**: Proporciona un método estático `open()` que se encarga de encontrar la ubicación adecuada en el sistema de archivos del dispositivo, crear el archivo de la base de datos (`app.db`) y establecer la conexión.
*   **Control de Versiones**: Define una `schemaVersion` para gestionar futuras migraciones de la base de datos.
*   **Métodos de Ayuda (Helpers)**: Incluye métodos de conveniencia para realizar operaciones comunes, como verificar si existe un tutor o leer/escribir en la tabla `KvStore`.

### Dependencias Principales

*   **`drift`**: El ORM (Object-Relational Mapper) principal utilizado para definir tablas como clases de Dart y generar código para consultas seguras en tipos.
*   **`drift/native`**: Proporciona el backend de SQLite para plataformas nativas (iOS, Android, macOS, Windows, Linux).
*   **`path_provider`**: Utilizado para obtener la ruta del directorio de documentos de la aplicación, un lugar seguro y persistente para almacenar el archivo de la base de datos.
*   **`path`**: Una utilidad para manipular y construir rutas de sistema de archivos de manera multiplataforma.

### Rol en la Aplicación

Este archivo es la **fuente única de verdad** para todos los datos persistentes de la aplicación. Actúa como la capa de modelo de datos, permitiendo que el resto de la aplicación interactúe con la base de datos de una manera segura, estructurada y eficiente. Centraliza toda la lógica de la base de datos, facilitando su mantenimiento y evolución.

---

## Código Documentado

```dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Importa el código autogenerado por el paquete `drift_generator`.
// Este archivo contendrá la implementación concreta de la base de datos,
// data classes, companions, etc.
part 'database.g.dart';

/// Representa la tabla 'Tutor' en la base de datos.
/// Almacena la información de la cuenta principal del usuario.
class Tutor extends Table {
  /// Identificador único del tutor (ej. un UUID). Clave primaria.
  TextColumn get id => text()();
  /// Nombre de usuario para el inicio de sesión. Es opcional.
  TextColumn get usuario => text().nullable()();
  /// Hash de la contraseña del tutor. Se debe almacenar de forma segura
  /// utilizando algoritmos como PBKDF2, Argon2 o scrypt. Es opcional.
  TextColumn get contrasenia => text().nullable()();
  /// Fecha y hora en que se creó la cuenta del tutor.
  DateTimeColumn get fechaCreacion => dateTime()();
  @override Set<Column> get primaryKey => {id};
}

/// Define los perfiles de usuario asociados a un tutor.
/// Permite que una cuenta de tutor gestione múltiples perfiles (ej. para diferentes niños).
class Perfiles extends Table {
  /// Identificador único del perfil (ej. un UUID). Clave primaria.
  TextColumn get id => text()();
  /// Clave foránea que referencia al [Tutor] propietario de este perfil.
  TextColumn get tutorId => text().references(Tutor, #id)();
  /// Nombre del perfil (ej. "Juan", "Ana").
  TextColumn get nombre => text()();
  /// Código o identificador del avatar seleccionado para el perfil.
  TextColumn get codigoAvatar => text()();
  /// Indica si este es el perfil actualmente activo en la aplicación.
  BoolColumn get activo => boolean().withDefault(const Constant(false))();
  @override Set<Column> get primaryKey => {id};
}

/// Define los módulos de contenido o aprendizaje disponibles en la aplicación.
/// NOTA: Esta tabla está definida pero no incluida en la lista de tablas de `AppDatabase`,
/// por lo que actualmente no se genera ni se utiliza.
class Modulos extends Table {
  /// Identificador único del módulo.
  TextColumn get id => text()();
  /// Nombre descriptivo del módulo.
  TextColumn get nombreModulo => text()();
}

/// Almacena las configuraciones específicas de un tutor.
/// Utiliza el `tutorId` como clave primaria para asegurar una única fila de
/// configuración por tutor (relación uno a uno).
class Configuraciones extends Table {
  /// Clave foránea que referencia al [Tutor]. También es la clave primaria.
  TextColumn get tutorId => text().references(Tutor, #id)();
  /// Indica si la funcionalidad de Texto a Voz (Text-to-Speech) está activa.
  BoolColumn get ttsHabilitado => boolean().withDefault(const Constant(true))();
  /// Velocidad de habla (frecuencia) para el TTS. Un valor de 0.5 es más lento, 1.0 es normal.
  RealColumn get ttsFrecuencia => real().withDefault(const Constant(0.5))();
  /// Tono de la voz para el TTS. Un valor de 1.0 es el tono normal.
  RealColumn get ttsTono => real().withDefault(const Constant(1.0))();
  /// Indica si el bloqueo parental está activado.
  BoolColumn get parentalLock => boolean().withDefault(const Constant(false))();
  @override Set<Column> get primaryKey => {tutorId};
}

/// Una tabla genérica de clave-valor para almacenar datos diversos y no estructurados,
/// como flags de estado de la aplicación, tokens, o configuraciones simples.
class KvStore extends Table {
  /// La clave única para el valor almacenado. Clave primaria.
  TextColumn get key => text()();
  /// El valor asociado a la clave, almacenado como una cadena de texto.
  TextColumn get value => text()();
  @override Set<Column> get primaryKey => {key};
}

/// Anotación que indica a `drift_generator` qué tablas debe incluir
/// en la base de datos generada.
@DriftDatabase(tables: [Tutor, Perfiles, Configuraciones, KvStore])
/// Clase principal de la base de datos de la aplicación, gestionada por Drift.
/// Esta clase es el punto de entrada central para todas las operaciones de la base de datos.
/// Hereda de la clase `_$AppDatabase` generada por `drift_generator`.
class AppDatabase extends _$AppDatabase {
  /// Constructor privado para forzar la creación de instancias a través del método `open`.
  AppDatabase._(super.e);

  @override
  /// La versión actual del esquema de la base de datos.
  /// Se debe incrementar este número cada vez que se realicen cambios en la estructura
  /// de las tablas (añadir/quitar/modificar columnas) para gestionar las migraciones.
  int get schemaVersion => 1;

  /// Método estático y asíncrono para abrir la conexión a la base de datos.
  ///
  /// Se encarga de:
  /// 1. Obtener el directorio de documentos de la aplicación.
  /// 2. Construir la ruta al archivo de la base de datos (`app.db`).
  /// 3. Crear un ejecutor `NativeDatabase` que se ejecuta en un hilo de fondo
  ///    para no bloquear el hilo de la UI.
  /// 4. Devolver una instancia de [AppDatabase] lista para ser usada.
  static Future<AppDatabase> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app.db'));
    final executor = NativeDatabase.createInBackground(file);
    return AppDatabase._(executor);
  }

  // --- Métodos de Ayuda (Helpers) ---

  /// Comprueba si ya existe al menos un tutor registrado en la base de datos.
  ///
  /// Útil para flujos de onboarding para determinar si se debe mostrar la pantalla
  /// de registro o la de inicio de sesión.
  /// Retorna `true` si hay al menos un tutor, `false` en caso contrario.
  Future<bool> tieneTutor() async => (await select(tutor).get()).isNotEmpty;

  /// Inserta o actualiza un par clave-valor en la tabla [KvStore].
  ///
  /// Si la clave [k] ya existe, su valor se actualiza a [v].
  /// Si no existe, se inserta una nueva fila.
  Future<void> upsertKv(String k, String v) async =>
      into(kvStore).insertOnConflictUpdate(KvStoreCompanion.insert(key: k, value: v));

  /// Obtiene el valor asociado a una clave [k] de la tabla [KvStore].
  ///
  /// Retorna el valor como un `String?`. Si la clave no se encuentra,
  /// retorna `null`.
  Future<String?> getKv(String k) async =>
      (await (select(kvStore)..where((t) => t.key.equals(k))).getSingleOrNull())?.value;
}

```
```