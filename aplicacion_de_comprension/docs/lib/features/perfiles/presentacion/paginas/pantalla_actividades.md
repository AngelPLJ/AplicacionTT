¡Excelente! Me pongo el sombrero de Senior Technical Writer. Aquí tienes la documentación detallada para `pantalla_actividades.dart`, presentada en formato Markdown, enfocándonos en la estructura, la interacción con datos y la lógica de negocio.

---

# Documentación Técnica: `pantalla_actividades.dart`

## 1. Resumen

El archivo `pantalla_actividades.dart` define la pantalla `ActivityPlayerPage`, la cual es responsable de presentar una actividad educativa específica al usuario. Esta pantalla integra dos experiencias principales: la lectura de una historia o texto relacionado (`_HistoriaViewer`) y la interacción con un juego educativo (`_buildJuego`). Utiliza Riverpod para la gestión del estado y la inyección de dependencias, lo que permite una carga asíncrona de la actividad, su contenido textual y el guardado del progreso del usuario.

La pantalla es dinámica, adaptándose al tipo de actividad de juego (`ordenarOracion`, `trivia`) y proporcionando feedback visual al usuario tras completar el juego.

## 2. Arquitectura

La arquitectura de esta pantalla sigue un patrón MVVM-like impulsado por Riverpod, interactuando con repositorios para la persistencia y recuperación de datos.

### 2.1. Componentes Widget

*   **`ActivityPlayerPage` (ConsumerStatefulWidget):**
    *   Es el widget raíz de la pantalla y el orquestador principal.
    *   Gestiona el ciclo de vida, el `TabController` para las pestañas de "Lectura" y "Actividad", y la lógica de presentación basada en el estado de la actividad (cargando, error, datos).
    *   Contiene la lógica para construir el widget del juego adecuado y procesar sus resultados.
    *   Recibe `actividadId` como parámetro para identificar la actividad a cargar.

*   **`_HistoriaViewer` (ConsumerWidget):**
    *   Un widget privado y sin estado (`ConsumerWidget`) que se encarga exclusivamente de mostrar el contenido textual de una historia o texto relacionado con la actividad.
    *   Carga el contenido de la historia de forma asíncrona utilizando un `Provider` de Riverpod.
    *   Renderiza los capítulos de la historia en un `ListView.builder` de forma eficiente.

*   **`JuegoOrdenarOracion` / `JuegoTrivia` (Widgets Externos):**
    *   Representan los widgets de juego específicos. Son componentes externos importados de `../../../../core/widgets/widgets_juegos.dart`.
    *   Reciben un objeto `ActividadModelo` y un callback `onTerminar` que notifica a `ActivityPlayerPage` el resultado del juego.

*   **`PantallaCarga` (Core Widget):**
    *   Un widget genérico importado de `../../../../core/widgets/pantalla_carga.dart` para mostrar un indicador de carga mientras los datos están siendo recuperados.

### 2.2. Providers (Riverpod)

La pantalla se apoya fuertemente en Riverpod para la gestión de datos y el acceso a los repositorios.

*   **`actividadPorIdProvider(int id)`:**
    *   **Tipo:** `Provider` que expone un `FutureProvider<ActividadModelo>`.
    *   **Propósito:** Encargado de cargar de forma asíncrona una instancia de `ActividadModelo` dado un `id` específico.
    *   **Fuente:** Probablemente definido en `../../repositorios/repo_contenido_json.dart` y depende de `RepoContenidoJson`.
    *   **Uso:** `ref.watch(actividadPorIdProvider(widget.actividadId))` en `ActivityPlayerPage` para obtener la actividad.

*   **`historiaDeActividadProvider(String tituloHistoria)`:**
    *   **Tipo:** `Provider` que expone un `FutureProvider<List<CapituloModelo>>`.
    *   **Propósito:** Carga de forma asíncrona una lista de `CapituloModelo` (la historia) dado un `tituloHistoria`.
    *   **Fuente:** Probablemente definido en `../../repositorios/repo_contenido_json.dart` y depende de `RepoContenidoJson`.
    *   **Uso:** `ref.watch(historiaDeActividadProvider(tituloHistoria))` en `_HistoriaViewer` para obtener el contenido de la historia.

*   **`repoPerfilProvider`:**
    *   **Tipo:** `Provider` que expone una instancia de `RepoPerfil`.
    *   **Propósito:** Proporciona acceso a operaciones relacionadas con el perfil del usuario, como obtener el usuario activo (`getActivo()`).
    *   **Fuente:** Definido en `../../../../core/proveedor.dart`.
    *   **Uso:** `ref.read(repoPerfilProvider)` en `_procesarResultado` para acceder a los datos del usuario.

*   **`repoProgresoProvider`:**
    *   **Tipo:** `Provider` que expone una instancia de `RepoProgreso`.
    *   **Propósito:** Proporciona acceso a operaciones relacionadas con el progreso del usuario, como guardar el progreso de una actividad (`guardarProgresoActividad()`).
    *   **Fuente:** Definido en `../../../../core/proveedor.dart`.
    *   **Uso:** `ref.read(repoProgresoProvider)` en `_procesarResultado` para persistir el resultado de la actividad.

### 2.3. Repositorios (Conceptual)

Aunque no están definidos directamente en este archivo, los proveedores mencionados interactúan con los siguientes repositorios abstractos o interfaces:

*   **`RepoContenidoJson`:** (Implicado por `actividadPorIdProvider` y `historiaDeActividadProvider`)
    *   Responsable de la lógica para cargar datos de actividades y contenido de historias, presumiblemente desde activos JSON o fuentes de datos locales.
    *   Métodos clave: `getActividadPorId(int id)`, `getHistoria(String titulo)`.

*   **`RepoPerfil`:** (Implicado por `repoPerfilProvider`)
    *   Responsable de la lógica de gestión del perfil de usuario.
    *   Métodos clave: `getActivo()`.

*   **`RepoProgreso`:** (Implicado por `repoProgresoProvider`)
    *   Responsable de la lógica para guardar y recuperar el progreso del usuario en las actividades.
    *   Métodos clave: `guardarProgresoActividad({required String usuarioId, required int actividadId, required bool esAcierto})`.

## 3. Componentes Clave y Flujos de Lógica

### 3.1. `ActivityPlayerPage`

*   **Constructor:** Recibe `actividadId`, que es fundamental para identificar y cargar la actividad correcta.
*   **`initState`:** Inicializa un `TabController` con dos pestañas ("Lectura" y "Actividad"), sincronizado con el `vsync` del `SingleTickerProviderStateMixin`.
*   **`build` (Flujo de Carga de Actividad):**
    1.  `ref.watch(actividadPorIdProvider(widget.actividadId))`: Observa el estado asíncrono de la actividad.
    2.  **`loading`:** Muestra `PantallaCarga`.
    3.  **`error`:** Muestra un `Scaffold` simple con el mensaje de error.
    4.  **`data`:** Una vez que la actividad se carga con éxito, construye la interfaz de usuario principal:
        *   `AppBar` con el título de la actividad (`actividad.nombre`) y un `TabBar` para navegar entre las vistas.
        *   `TabBarView` que contiene:
            *   `_HistoriaViewer(tituloHistoria: actividad.fuenteTexto)`: La pestaña de lectura.
            *   Un `Padding` que envuelve `_buildJuego(actividad)`: La pestaña de juego.

### 3.2. `_HistoriaViewer`

*   **Constructor:** Recibe `tituloHistoria`, que es el identificador para cargar el contenido del texto.
*   **`build` (Flujo de Carga de Historia):**
    1.  `ref.watch(historiaDeActividadProvider(tituloHistoria))`: Observa el estado asíncrono de la historia.
    2.  **`loading`:** Muestra un `CircularProgressIndicator`.
    3.  **`error`:** Muestra un mensaje indicando que no se encontró el texto y sugiere verificar la configuración.
    4.  **`data`:** Muestra los capítulos de la historia en un `ListView.builder`, con cada capítulo presentado en una `Card` con su título y texto.

### 3.3. `_buildJuego(ActividadModelo actividad)`

*   **Función Factory:** Actúa como una fábrica de widgets de juego.
*   Utiliza una sentencia `switch` sobre `actividad.tipo` (que es de tipo `TipoActividadJuego`):
    *   **`TipoActividadJuego.ordenarOracion`:** Devuelve un `JuegoOrdenarOracion`.
    *   **`TipoActividadJuego.trivia`:** Devuelve un `JuegoTrivia`.
    *   **`default`:** Muestra un mensaje indicando que el juego no está configurado.
*   Ambos juegos reciben la `actividad` completa y un callback `onTerminar` que invoca a `_procesarResultado` con el éxito (`ok`) y el `id` de la actividad.

### 3.4. `_procesarResultado(bool acierto, int id)`

*   **Función Asíncrona:** Marcada como `Future<void> async`, lo que permite realizar operaciones asíncronas como la interacción con los repositorios.
*   **Lógica de Éxito (`acierto = true`):**
    1.  **Persistencia:**
        *   Obtiene el usuario activo a través de `ref.read(repoPerfilProvider).getActivo()`.
        *   Si hay un usuario, guarda el progreso de la actividad como un acierto usando `ref.read(repoProgresoProvider).guardarProgresoActividad()`.
        *   Incluye un bloque `try-catch` para manejar posibles errores durante el guardado del progreso.
    2.  **Feedback Visual:**
        *   Asegura que el widget aún está montado (`if (!mounted) return;`) antes de intentar actualizar la UI.
        *   Muestra un `AlertDialog` amigable ("¡Correcto!") con un ícono de estrella y un mensaje de actividad completada.
    3.  **Navegación:**
        *   El botón "Ok" del diálogo cierra el `AlertDialog` (`Navigator.pop(context)`).
        *   Inmediatamente después, si el widget sigue montado, cierra la `ActivityPlayerPage` también (`Navigator.pop(context)`), lo que implica que la actividad se considera finalizada y el usuario regresa a la pantalla anterior.
*   **Lógica de Fallo (`acierto = false`):**
    1.  **Feedback Visual:**
        *   Muestra un `SnackBar` temporal ("Inténtalo de nuevo") con un fondo rojo para indicar que la respuesta fue incorrecta.

---