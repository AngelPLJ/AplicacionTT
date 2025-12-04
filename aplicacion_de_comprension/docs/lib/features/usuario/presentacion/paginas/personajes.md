Aquí tienes la documentación Markdown para `personajes.dart`, actuando como un Senior Technical Writer experto en Flutter:

---

# `personajes.dart` - Página de Selección de Perfil

Este archivo contiene la implementación de la página de selección de perfiles (`CharacterSelectPage`), permitiendo a los usuarios elegir entre perfiles existentes, crear nuevos o eliminar perfiles previos. Es un componente central en el flujo de inicio de la aplicación, proporcionando una interfaz intuitiva para la gestión de usuarios.

## Resumen

La `CharacterSelectPage` es la interfaz principal para que los usuarios (o "personajes") seleccionen su perfil activo. Utiliza `flutter_riverpod` para observar una lista de perfiles en tiempo real y presentarlos en una cuadrícula responsiva. La página incluye funcionalidades para:

*   **Seleccionar un perfil**: Al tocar una tarjeta de perfil, se establece como activo y se navega al menú principal.
*   **Crear un nuevo perfil**: A través de un diálogo que solicita un nombre y permite elegir un avatar.
*   **Eliminar un perfil existente**: Requiere la autenticación con un PIN de tutor para mayor seguridad.
*   **Visualización dinámica**: Muestra un fondo de imagen, un indicador de carga mientras se obtienen los perfiles y un mensaje de error si la carga falla.

## Arquitectura

### Estructura de Widgets

La `CharacterSelectPage` es un `ConsumerWidget` que se construye sobre un `Scaffold` para la estructura básica de la página.

*   **`Scaffold`**: Contiene un `AppBar` personalizado con el título de la aplicación y un `body`.
*   **`Stack`**: Permite superponer elementos:
    *   Un `Container` para la imagen de fondo dinámica, obtenida a través de `obtenerFondoEstacion()`.
    *   Un `Center` widget que contiene el contenido principal de la página, el cual depende del estado del `profilesStreamProvider`.
*   **`async.when`**: Gestiona los tres estados posibles de un `AsyncValue`:
    *   `data`: Cuando los perfiles se cargan exitosamente, se renderiza un `GridView.extent`.
    *   `loading`: Muestra un `PantallaCarga()` personalizada.
    *   `error`: Muestra un mensaje de error en el centro de la pantalla.
*   **`GridView.extent`**: Es la clave para la presentación responsiva de los perfiles.
    *   `maxCrossAxisExtent`: Define el ancho máximo de cada elemento, permitiendo que la cuadrícula se ajuste automáticamente al tamaño de la pantalla.
    *   `childAspectRatio`, `mainAxisSpacing`, `crossAxisSpacing`, `padding`: Controlan el diseño y espaciado de las tarjetas.
*   **`Card` (para perfiles existentes)**: Cada perfil se representa con una `Card` elevada.
    *   `Stack`: Dentro de la tarjeta para superponer el contenido del perfil y el botón de eliminar.
    *   `Positioned.fill` con `InkWell`: Hace que toda la tarjeta sea táctil para la selección del perfil. Contiene una `Column` con la imagen del avatar y el nombre del perfil.
    *   `Positioned` con `IconButton`: Coloca un botón de "Eliminar" en la esquina superior derecha de la tarjeta, activando el diálogo de eliminación.
*   **`GestureDetector` (para crear nuevo perfil)**: Una `Card` separada que actúa como botón para crear un nuevo perfil, solo si el número de perfiles es inferior a 7.

### Integración con Riverpod

La página hace un uso extensivo de `flutter_riverpod` para la gestión de estado y la inyección de dependencias.

*   **`profilesStreamProvider`**:
    *   Tipo: `StreamProvider<List<Perfil>>`
    *   Propósito: Proporciona una secuencia en tiempo real de todos los perfiles disponibles en la base de datos. Cada vez que se añade, actualiza o elimina un perfil, este `StreamProvider` emitirá una nueva lista, actualizando automáticamente la interfaz de usuario.
    *   Fuente de datos: `ref.read(repoPerfilProvider).mirarPerfiles()`, que delega la lógica de acceso a datos al repositorio de perfiles.
*   **`repoPerfilProvider`**:
    *   Uso: Se lee directamente para realizar operaciones de escritura:
        *   `elegirActivo(p.id)`: Para establecer el perfil seleccionado como el perfil activo de la aplicación.
        *   `crearPerfil(name: ..., avatarCode: ...)`: Para añadir un nuevo perfil a la base de datos.
        *   `eliminarPerfil(perfil.id)`: Para borrar un perfil existente.
*   **`repoTutorProvider`**:
    *   Uso: Se lee para la autenticación del tutor:
        *   `autenticar(pinLimpio)`: Utilizado durante el proceso de eliminación de perfiles para verificar el PIN de seguridad del tutor.

## Componentes y Funcionalidades Clave

1.  **Carga y Visualización de Perfiles**:
    *   El `profilesStreamProvider` asegura que la UI se mantenga sincronizada con la lista de perfiles.
    *   `GridView.extent` permite una presentación flexible y responsiva de los avatares y nombres de los perfiles.
    *   Cada perfil se visualiza en una `Card` interactiva con su avatar (`AssetImage`) y nombre.

2.  **Selección de Perfil**:
    *   Al hacer tap en la `InkWell` de un perfil, se invoca `ref.read(repoPerfilProvider).elegirActivo(p.id)`.
    *   Una vez que el perfil se establece como activo, la página navega a `MainMenuPage` usando `Navigator.pushReplacement` para evitar que el usuario regrese a la selección de perfiles con el botón de retroceso.

3.  **Creación de Nuevo Perfil (`_createProfileDialog`)**:
    *   Se presenta un `AlertDialog` personalizado.
    *   Utiliza `StatefulBuilder` para gestionar el estado del diálogo (nombre del perfil, selección de avatar, mensaje de error).
    *   Un `TextField` para que el usuario ingrese el nombre del perfil.
    *   Un `Wrap` de `GestureDetector` muestra los avatares disponibles, permitiendo al usuario seleccionar uno. El avatar seleccionado se destaca visualmente.
    *   Se realiza una validación básica del nombre antes de llamar a `ref.read(repoPerfilProvider).crearPerfil()`.

4.  **Eliminación de Perfil (`_mostrarDialogoEliminar`)**:
    *   Se presenta un `AlertDialog` de confirmación que solicita el PIN del tutor.
    *   También utiliza `StatefulBuilder` para manejar el estado del diálogo, especialmente para mostrar errores de validación del PIN.
    *   Un `TextField` oculto (`obscureText: true`) para ingresar el PIN.
    *   `ref.read(repoTutorProvider).autenticar(pinLimpio)` se utiliza para verificar el PIN.
    *   Solo si el PIN es correcto, se procede con `ref.read(repoPerfilProvider).eliminarPerfil(perfil.id)`. Si el PIN es incorrecto, se muestra un mensaje de error en el `TextField`.

5.  **Límite de Perfiles**:
    *   El botón para crear un nuevo perfil solo se muestra si el número actual de perfiles es inferior a 7, implementando una regla de negocio para limitar la cantidad de perfiles.

6.  **Gestión de Fondo**:
    *   La función `obtenerFondoEstacion()` (definida externamente) se utiliza para cargar dinámicamente una imagen de fondo que mejora la estética de la página.

---