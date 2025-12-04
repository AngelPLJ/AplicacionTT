¡Excelente! Analicemos este esquema de base de datos Drift para una aplicación Flutter educativa. Como Senior Technical Writer experto en Flutter, me centraré en la claridad, la precisión y la relevancia para el contexto de desarrollo.

---

# Documentación del Esquema de Base de Datos (`database.dart`)

Este documento describe la estructura del esquema de base de datos local para la aplicación Flutter, definida mediante la librería [Drift](https://drift.simonbinder.eu/) (anteriormente `moor`). Drift es un ORM reactivo para SQLite en Flutter y Dart, que ofrece tipado seguro, consultas en Dart y generación de código.

## Resumen

El archivo `database.dart` es la piedra angular de la persistencia de datos local de la aplicación. Define el esquema completo de la base de datos SQLite, incluyendo todas las tablas, sus columnas, tipos de datos, claves primarias, claves foráneas y relaciones. Utiliza Drift para generar automáticamente gran parte del código boilerplate necesario para interactuar con la base de datos de manera segura y eficiente.

El esquema está diseñado para una aplicación educativa con las siguientes características:
*   **Gestión de Usuarios:** Soporte para un tutor principal y múltiples usuarios secundarios (niños/estudiantes).
*   **Configuración Personalizable:** Almacena configuraciones de la aplicación a nivel de tutor.
*   **Contenido Educativo:** Almacena elementos como números, fonemas y palabras, categorizados por tipo.
*   **Estructura Modular:** Define módulos y actividades educativas.
*   **Seguimiento de Progreso:** Registra el desempeño de los usuarios en números, fonemas, palabras y actividades específicas, así como su progreso general en módulos.
*   **Gamificación:** Incluye un sistema de medallas para reconocer logros.
*   **Almacén de Clave-Valor:** Un mecanismo genérico para almacenar configuraciones o datos pequeños.

La base de datos se inicializa como una base de datos nativa en segundo plano, asegurando que las operaciones de E/S no bloqueen el hilo principal de la UI de Flutter.

## Arquitectura de la Base de Datos (Drift en el Contexto de Flutter)

En una arquitectura Flutter bien estructurada, este archivo `database.dart` representa la **Capa de Persistencia** o **Capa de Datos Local**. No interactúa directamente con los Widgets o la lógica de negocio compleja, sino que sirve como la interfaz de bajo nivel para SQLite.

1.  **Capa de Persistencia (`database.dart`):**
    *   Contiene la definición del esquema Drift (`Table` classes).
    *   La clase `AppDatabase` es el punto de entrada principal para todas las operaciones de la base de datos.
    *   Maneja la inicialización de la base de datos (apertura del archivo `.sqlite`).
    *   Expone métodos básicos para interactuar con las tablas (ej., `select`, `insert`, `update`, `delete`), así como helpers específicos (`tieneTutor`, `upsertKv`, `getKv`).

2.  **Capa de Repositorio (Repository Layer - *Conceptual*):**
    *   **No está definida en este archivo**, pero es la capa que consumiría la instancia de `AppDatabase`.
    *   Encapsularía todas las operaciones de la base de datos para una entidad específica (ej., `UserRepository`, `ContentRepository`).
    *   Traduciría los objetos generados por Drift (ej., `Usuario`, `Tutor`) a modelos de dominio más puros si fuera necesario, desacoplando la lógica de negocio de la implementación de la base de datos.
    *   Proporcionaría una API limpia y orientada a objetos a las capas superiores, ocultando los detalles de las consultas SQL o Drift.

3.  **Capa de Lógica de Negocio / Gestión de Estado (Provider/BLoC/Riverpod/etc. - *Conceptual*):**
    *   **No está definida en este archivo.**
    *   Interactuaría con la Capa de Repositorio para obtener y manipular datos.
    *   Contendría la lógica de negocio de la aplicación, como la validación de entradas, la coordinación de múltiples operaciones de datos, etc.
    *   Expondría el estado y los métodos a la Capa de Presentación.

4.  **Capa de Presentación (Widgets - *Conceptual*):**
    *   **No está definida en este archivo.**
    *   Construida con Widgets de Flutter.
    *   Observaría el estado proporcionado por la Capa de Lógica de Negocio y enviaría eventos/acciones cuando el usuario interactúe con la UI.

En resumen, `database.dart` es la base de datos en sí, y su `AppDatabase` se inyectaría como una dependencia en una capa de repositorio, la cual a su vez sería utilizada por la lógica de negocio y finalmente por los Widgets.

## Componentes Clave

Este archivo se divide en tres secciones principales: Tablas Principales, Tablas Intermedias y Configuración de la Base de Datos.

### 1. Tablas Principales (Catálogos)

Definen las entidades fundamentales de la aplicación.

*   **`Tutor`**:
    *   **Propósito:** Almacena la información del usuario principal (tutor/administrador) de la aplicación.
    *   **Columnas Clave:**
        *   `id` (Text, UUID): Clave primaria, identificador único del tutor.
        *   `usuario` (Text): Nombre de usuario o identificador para el tutor.
        *   `pinSeguridad` (Text): Un PIN para proteger configuraciones sensibles.
        *   `fechaCreacion` (DateTime): Fecha de creación del registro, con valor por defecto la fecha actual.

*   **`KvStore`**:
    *   **Propósito:** Un almacén genérico de clave-valor para configuraciones flexibles o datos pequeños que no encajan en una tabla estructurada.
    *   **Columnas Clave:**
        *   `key` (Text): Clave única del par clave-valor.
        *   `value` (Text): Valor asociado a la clave.

*   **`Usuarios`**:
    *   **Propósito:** Almacena los perfiles de los usuarios secundarios (ej., niños) que utilizarán la aplicación.
    *   **Columnas Clave:**
        *   `id` (Text, UUID): Clave primaria, identificador único del usuario.
        *   `tutorId` (Text, FK): Clave foránea que referencia `Tutor.id`, indicando a qué tutor pertenece este usuario.
        *   `nombre` (Text, max 255): Nombre del usuario.
        *   `icono` (Text, max 32): Nombre del archivo o identificador del icono asociado al usuario.
        *   `activo` (Bool): Indica si el usuario está activo, por defecto `true`.

*   **`Configuraciones`**:
    *   **Propósito:** Almacena las configuraciones de la aplicación específicas para un tutor.
    *   **Columnas Clave:**
        *   `tutorId` (Text, FK): Clave foránea que referencia `Tutor.id`, es también la clave primaria de esta tabla, lo que implica una relación 1:1 entre `Tutor` y `Configuraciones`.
        *   `ttsHabilitado` (Bool): Habilita/deshabilita la función de Texto-a-Voz (TTS), por defecto `true`.
        *   `ttsVelocidad` (Real): Velocidad del TTS, por defecto `0.5`.
        *   `musicaFondo` (Bool): Habilita/deshabilita la música de fondo, por defecto `true`.

*   **`Numeros`**:
    *   **Propósito:** Catálogo de números para actividades educativas.
    *   **Columnas Clave:**
        *   `id` (Int, AutoIncrement): Clave primaria autoincremental.
        *   `numero` (Int): El valor del número.

*   **`Fonemas`**:
    *   **Propósito:** Catálogo de fonemas para actividades educativas.
    *   **Columnas Clave:**
        *   `id` (Int, AutoIncrement): Clave primaria autoincremental.
        *   `fonema` (Text, max 45): El fonema en formato de texto.

*   **`TipoDePalabra`**:
    *   **Propósito:** Catálogo de categorías para palabras (ej., sustantivo, verbo, adjetivo).
    *   **Columnas Clave:**
        *   `id` (Int, AutoIncrement): Clave primaria autoincremental.
        *   `tipo` (Text, max 15): Nombre del tipo de palabra.

*   **`Palabras`**:
    *   **Propósito:** Catálogo de palabras, asociadas a un tipo de palabra.
    *   **Columnas Clave:**
        *   `id` (Int, AutoIncrement): Clave primaria autoincremental.
        *   `palabra` (Text, max 24): La palabra en sí.
        *   `tipoDePalabraId` (Int, FK): Clave foránea que referencia `TipoDePalabra.id`.

*   **`Modulos`**:
    *   **Propósito:** Catálogo de módulos o unidades educativas.
    *   **Columnas Clave:**
        *   `id` (Int, AutoIncrement): Clave primaria autoincremental.
        *   `nombre` (Text, max 45): Nombre del módulo.

*   **`Actividades`**:
    *   **Propósito:** Catálogo de actividades educativas individuales.
    *   **Columnas Clave:**
        *   `id` (Int, AutoIncrement): Clave primaria autoincremental.
        *   `nombre` (Text, max 45, Nullable): Nombre de la actividad.

*   **`Medallas`**:
    *   **Propósito:** Catálogo de medallas o logros que los usuarios pueden obtener.
    *   **Columnas Clave:**
        *   `id` (Int, AutoIncrement): Clave primaria autoincremental.
        *   `nombre` (Text, max 45): Nombre de la medalla.
        *   `imagen` (Text, max 45): Nombre del archivo de imagen de la medalla (posiblemente un identificador).
        *   `assetPath` (Text): Ruta completa del asset de la imagen de la medalla.

### 2. Tablas Intermedias (Relaciones _has_)

Estas tablas gestionan las relaciones de muchos a muchos (N:M) y el seguimiento de progreso entre las entidades principales.

*   **`UsuariosHasNumeros`**:
    *   **Propósito:** Registra el progreso de un usuario en actividades relacionadas con números.
    *   **Columnas Clave:**
        *   `usuarioId` (Text, FK): Referencia `Usuarios.id`.
        *   `numeroId` (Int, FK): Referencia `Numeros.id`.
        *   `aciertos` (Int): Número de aciertos del usuario para este número.
        *   `total` (Int): Número total de intentos del usuario para este número.
    *   **Clave Primaria Compuesta:** `{usuarioId, numeroId}`.

*   **`UsuariosHasFonemas`**:
    *   **Propósito:** Registra el progreso de un usuario en actividades relacionadas con fonemas.
    *   **Columnas Clave:**
        *   `usuarioId` (Text, FK): Referencia `Usuarios.id`.
        *   `fonemaId` (Int, FK): Referencia `Fonemas.id`.
        *   `aciertos` (Int): Número de aciertos.
        *   `total` (Int): Número total de intentos.
    *   **Clave Primaria Compuesta:** `{usuarioId, fonemaId}`.

*   **`UsuariosHasPalabras`**:
    *   **Propósito:** Registra el progreso de un usuario en actividades relacionadas con palabras.
    *   **Columnas Clave:**
        *   `usuarioId` (Text, FK): Referencia `Usuarios.id`.
        *   `palabraId` (Int, FK): Referencia `Palabras.id`.
        *   `aciertos` (Int): Número de aciertos.
        *   `total` (Int): Número total de intentos.
    *   **Clave Primaria Compuesta:** `{usuarioId, palabraId}`.

*   **`ActividadesHasModulos`**:
    *   **Propósito:** Define qué actividades pertenecen a qué módulos.
    *   **Columnas Clave:**
        *   `actividadId` (Int, FK): Referencia `Actividades.id`.
        *   `moduloId` (Int, FK): Referencia `Modulos.id`.
    *   **Clave Primaria Compuesta:** `{actividadId, moduloId}`.

*   **`UsuariosHasActividades`**:
    *   **Propósito:** Registra el progreso general de un usuario en una actividad específica.
    *   **Columnas Clave:**
        *   `usuarioId` (Text, FK): Referencia `Usuarios.id`.
        *   `actividadId` (Int, FK): Referencia `Actividades.id`.
        *   `aciertos` (Int): Número de aciertos del usuario en esta actividad.
        *   `total` (Int, Nullable): Número total de intentos en esta actividad.
    *   **Clave Primaria Compuesta:** `{usuarioId, actividadId}`.

*   **`ModulosHasUsuarios`**:
    *   **Propósito:** Registra el progreso general de un usuario en un módulo completo.
    *   **Columnas Clave:**
        *   `moduloId` (Int, FK): Referencia `Modulos.id`.
        *   `usuarioId` (Text, FK): Referencia `Usuarios.id`.
        *   `progreso` (Real): Porcentaje o valor de progreso en el módulo.
    *   **Clave Primaria Compuesta:** `{moduloId, usuarioId}`.

*   **`UsuariosHasMedallas`**:
    *   **Propósito:** Registra las medallas obtenidas por cada usuario.
    *   **Columnas Clave:**
        *   `usuarioId` (Text, FK): Referencia `Usuarios.id`.
        *   `medallaId` (Int, FK): Referencia `Medallas.id`.
    *   **Clave Primaria Compuesta:** `{usuarioId, medallaId}`.

### 3. Configuración de la Base de Datos

*   **`@DriftDatabase` Anotación:**
    *   Lista todas las clases `Table` que conforman este esquema de base de datos. Esta lista es crucial para que Drift sepa qué tablas debe generar en el archivo `database.g.dart`.

*   **`AppDatabase` Clase:**
    *   Extiende `_$AppDatabase`: Esta es la clase base generada por Drift (en `database.g.dart`) que contiene todas las propiedades de las tablas y métodos de consulta básicos.
    *   `AppDatabase._(super.e)`: Constructor privado que toma un `QueryExecutor` (la conexión a la base de datos).
    *   `schemaVersion` (int): Actualmente `1`. Este número es fundamental para la gestión de migraciones futuras de la base de datos. Cuando se modifique el esquema, este número deberá incrementarse.
    *   `static Future<AppDatabase> open()`:
        *   Este es el método principal para inicializar y abrir la conexión a la base de datos.
        *   Obtiene el directorio de documentos de la aplicación (`getApplicationDocumentsDirectory`).
        *   Construye la ruta al archivo `db_educativa.sqlite` dentro de ese directorio.
        *   Crea un `NativeDatabase` que se ejecuta en un hilo de fondo (`createInBackground`), lo cual es una buena práctica para el rendimiento de la UI.
        *   Devuelve una instancia de `AppDatabase`.
    *   **Helpers Básicos:**
        *   `Future<bool> tieneTutor()`: Verifica si existe al menos un tutor en la base de datos.
        *   `Future<void> upsertKv(String k, String v)`: Inserta o actualiza un par clave-valor en la tabla `KvStore`.
        *   `Future<String?> getKv(String k)`: Recupera el valor asociado a una clave de `KvStore`.

## Notas Adicionales

*   **Generación de Código:** El comentario `// Recuerda ejecutar en la terminal: dart run build_runner build` es esencial. Drift requiere la ejecución de `build_runner` para generar el archivo `database.g.dart`, que contiene las implementaciones de las tablas, modelos de datos (`Data` y `Companion`) y utilidades de consulta.
*   **Integridad Referencial:** El uso de `.references(OtraTabla, #id)` asegura la integridad referencial, lo que significa que no se pueden crear registros de usuarios sin un tutor válido, ni registros de palabras sin un tipo de palabra existente, etc.
*   **Valores por Defecto:** Drift permite definir valores por defecto para las columnas (ej., `withDefault(currentDate)` o `withDefault(const Constant(true))`), lo que simplifica la lógica de inserción de datos.
*   **Columnas UUID:** Las columnas `id` de tipo `TextColumn` en `Tutor` y `Usuarios` están diseñadas para almacenar UUIDs, que deben ser generados en el lado de la aplicación antes de la inserción.
*   **Performance:** `NativeDatabase.createInBackground` es una optimización importante para aplicaciones móviles, evitando bloqueos de la UI durante operaciones de E/S de la base de datos.

Este documento proporciona una visión clara y detallada del esquema de la base de datos, su propósito y cómo se integra en una aplicación Flutter utilizando Drift.