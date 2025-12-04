¡Claro! Aquí tienes la documentación detallada para el archivo `menu_principal.dart`, escrita desde la perspectiva de un Senior Technical Writer experto en Flutter.

---

# Documentación del Componente: `menu_principal.dart`

Este documento describe la estructura, funcionalidad y componentes clave de la página principal de la aplicación (`MainMenuPage`), que sirve como el punto de entrada principal después de que un usuario ha iniciado sesión. Gestiona la visualización del progreso del usuario, módulos de aprendizaje, recomendaciones personalizadas y la navegación fundamental de la aplicación.

## 1. Resumen

El archivo `menu_principal.dart` define la `MainMenuPage`, una `ConsumerWidget` de Flutter que actúa como el *dashboard* central para el usuario. Utiliza `flutter_riverpod` para gestionar el estado de los datos del menú (información del usuario, progreso, módulos, recomendaciones) y los presenta a través de una interfaz de usuario dinámica y responsiva, incluyendo una `SliverAppBar` personalizada, tarjetas de acción condicionales y un `SliverGrid` para los módulos. También integra una `BottomNavigationBar` para la navegación global y la funcionalidad de cierre de sesión.

## 2. Arquitectura

### 2.1. Widgets

*   **`MainMenuPage` (ConsumerWidget):** El widget de nivel superior que construye el `Scaffold` principal. Es un `ConsumerWidget` para poder observar los `Provider` de Riverpod. Se encarga de manejar los estados de carga, error y datos para el contenido principal del menú.
*   **`_MenuContent` (StatelessWidget):** Un widget privado que encapsula la lógica de presentación de los datos del menú una vez que han sido cargados exitosamente. Utiliza un `CustomScrollView` para combinar diferentes tipos de *scrollable widgets* (Slivers).
*   **`_AccionPrincipalCard` (StatelessWidget):** Un widget auxiliar reutilizable para mostrar una tarjeta de acción prominente, ya sea la evaluación diagnóstica para nuevos usuarios o una actividad recomendada. Incluye título, subtítulo, icono y un manejador de tap.
*   **`_ModuloCard` (StatelessWidget):** Un widget auxiliar reutilizable para representar un módulo de aprendizaje individual dentro de un `SliverGrid`. Muestra el nombre del módulo, su progreso, un icono representativo y un manejador de tap (actualmente no implementado para navegación).
*   **`PantallaCarga`:** (Importado de `core/widgets`) Un widget de pantalla completa que se muestra mientras los datos del menú están cargando.

### 2.2. Gestión de Estado (Riverpod)

La aplicación utiliza `flutter_riverpod` para la gestión de estado, siguiendo un enfoque reactivo y basado en proveedores:

*   **`menuDataProvider` (AsyncNotifierProvider/StreamProvider):** Este proveedor (definido en `menu_provider.dart`) es la fuente principal de datos para la `MainMenuPage`. Proporciona un `AsyncValue<MenuData>`, permitiendo a `MainMenuPage` reaccionar automáticamente a los estados de `loading`, `error` y `data`. `MenuData` es el modelo que agrupa toda la información necesaria para el menú (usuario, progreso total, módulos, recomendaciones, etc.).
*   **`repoPerfilProvider` (Provider):** Este proveedor (definido en `core/proveedor.dart`) proporciona acceso al repositorio de perfil del usuario. Se utiliza específicamente en la `BottomNavigationBar` para invocar el método `cerrarSesion()` del repositorio.

### 2.3. Repositorios

*   **`PerfilRepository` (implícito):** Aunque no se define directamente en este archivo, el uso de `ref.read(repoPerfilProvider).cerrarSesion()` implica la existencia de una implementación de un `PerfilRepository` que maneja la lógica de negocio relacionada con la sesión del usuario, incluyendo el cierre de la misma.

### 2.4. Modelo de Datos

*   **`MenuData`:** (Clase importada de `menu_provider.dart`). Este modelo de datos encapsula toda la información necesaria para renderizar la `MainMenuPage`, incluyendo:
    *   `usuario` (probablemente un objeto `Usuario`).
    *   `progresoTotal` (double).
    *   `esNuevoUsuario` (bool).
    *   `tituloRecomendacion` (String).
    *   `motivoRecomendacion` (String).
    *   `actividadRecomendadaId` (String).
    *   `modulos` (List<Modulo>, donde `Modulo` es otro modelo con `nombre` y `porcentaje`).

## 3. Componentes Clave y Funcionalidades

### 3.1. `MainMenuPage`

*   **Estructura Principal (`Scaffold`):** Proporciona la estructura básica de la página, incluyendo un `backgroundColor` personalizado y una `BottomNavigationBar`.
*   **Carga de Datos Asíncrona:**
    *   Utiliza `ref.watch(menuDataProvider)` para observar el estado de los datos del menú.
    *   El cuerpo del `Scaffold` maneja los diferentes estados del `AsyncValue`:
        *   `loading:` Muestra una `PantallaCarga`.
        *   `error:` Muestra un `Center` con un `Text` indicando el error.
        *   `data:` Renderiza el widget `_MenuContent` con los datos cargados.
*   **`BottomNavigationBar`:**
    *   **Tipo Fijo (`BottomNavigationBarType.fixed`):** Asegura que todos los ítems tengan el mismo ancho y estén siempre visibles.
    *   **Estilos Personalizados:** Colores de fondo, ítems seleccionados y no seleccionados definidos.
    *   **Ítems:** Cuatro iconos y etiquetas: 'Inicio', 'Ajustes', 'Practicar', 'Salir'.
    *   **Lógica `onTap`:**
        *   **Cierre de Sesión (Índice 3 - 'Salir'):**
            *   Muestra un `AlertDialog` de confirmación al usuario.
            *   Si el usuario confirma, invoca `ref.read(repoPerfilProvider).cerrarSesion()`.
            *   Navega a `CharacterSelectPage` (pantalla de selección de personaje/perfil) utilizando `pushAndRemoveUntil` para asegurar que el usuario no pueda volver a la `MainMenuPage` con el botón de retroceso.
            *   Verifica `context.mounted` para evitar errores si el widget se desmonta antes de la navegación.
        *   **Otros Índices (0, 1, 2):** Actualmente comentados, indican puntos de extensión futuros para navegar a las secciones de 'Inicio', 'Ajustes' y 'Practicar' respectivamente.

### 3.2. `_MenuContent`

*   **`CustomScrollView`:** Permite una experiencia de desplazamiento avanzada, combinando un `SliverAppBar` y contenido estático (`SliverToBoxAdapter`) y dinámico (`SliverGrid`).
*   **`SliverAppBar`:**
    *   **Cabecera Colapsable/Expandible:** `expandedHeight: 200.0`, `floating: false`, `pinned: true`.
    *   **`FlexibleSpaceBar`:**
        *   `title:` Muestra un saludo personalizado ("Hola, [nombre_usuario]").
        *   `background:` Un `Container` con un `LinearGradient` y un `Row` que contiene:
            *   Un `CircleAvatar` para mostrar la imagen del avatar del usuario (cargada desde `assets`).
            *   Un indicador de progreso general con el "Nivel General" y un porcentaje.
*   **Tarjeta de Acción Principal Condicional:**
    *   Utiliza `if (data.esNuevoUsuario)`:
        *   Si es `true`, muestra una `_AccionPrincipalCard` para la **Evaluación Diagnóstica** que navega a `EvaluacionDiagnosticaPage`.
        *   Si es `false`, muestra una `_AccionPrincipalCard` para una **Actividad Recomendada** (obteniendo título, subtítulo e ID de la `MenuData`) que navega a `ActivityPlayerPage` con el `actividadRecomendadaId`.
*   **Grid de Módulos (`SliverGrid`):**
    *   Si `data.modulos` está vacío, muestra un texto "Cargando módulos...".
    *   Si hay módulos, renderiza un `SliverGrid` con `_ModuloCard`s.
    *   `SliverGridDelegateWithFixedCrossAxisCount`: Organiza los módulos en una cuadrícula de 2 columnas.
    *   Utiliza funciones auxiliares privadas (`_getIconForModule`, `_getColorForModule`) para asignar dinámicamente iconos y colores a los módulos según su nombre o índice.

### 3.3. `_AccionPrincipalCard` y `_ModuloCard`

*   **Reusabilidad:** Ambos widgets están diseñados para ser reutilizables, promoviendo la consistencia visual y la modularidad del código.
*   **Diseño:** Implementan `Card`s con `InkWell` para efectos visuales de interacción, `borderRadius` y `gradient` (`_AccionPrincipalCard`) o `LinearProgressIndicator` (`_ModuloCard`) para una presentación atractiva.

---