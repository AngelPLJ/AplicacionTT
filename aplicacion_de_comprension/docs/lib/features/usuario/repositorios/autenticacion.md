Claro, aquí tienes la documentación completa para el archivo `auth_repository.dart`, siguiendo todas tus instrucciones.

````markdown
```dart
// domain/repositories/auth_repository.dart
import 'package:aplicacion_de_comprension/features/usuario/entidades/usuario.dart';

/// Define el contrato (interfaz) para la gestión de la autenticación de usuarios.
///
/// Esta clase abstracta establece los métodos que cualquier repositorio de autenticación
/// debe implementar, independientemente de la fuente de datos subyacente (Firebase, una API REST,
/// base de datos local, etc.).
///
/// Su propósito es desacoplar la lógica de negocio (casos de uso) de los detalles de
/// implementación de la capa de datos, siguiendo los principios de la Arquitectura Limpia.
abstract class AuthRepository {
  /// Registra un nuevo usuario en el sistema con su nombre y contraseña.
  ///
  /// Lanza una excepción si el registro falla (por ejemplo, si el usuario ya existe).
  ///
  /// - [nombre]: El nombre de usuario para el nuevo registro.
  /// - [contrasenia]: La contraseña elegida por el usuario.
  ///
  /// Retorna un [Future] que se completa con el objeto [Usuario] recién creado.
  Future<Usuario> register({required String nombre, required String contrasenia});

  /// Autentica a un usuario existente con su nombre y contraseña.
  ///
  /// Lanza una excepción si las credenciales son incorrectas o si ocurre otro error.
  ///
  /// - [nombre]: El nombre de usuario para iniciar sesión.
  /// - [contrasenia]: La contraseña del usuario.
  ///
  /// Retorna un [Future] que se completa con el objeto [Usuario] del usuario autenticado.
  Future<Usuario> login({required String nombre, required String contrasenia});

  /// Cierra la sesión del usuario actualmente autenticado.
  ///
  /// Este método limpia cualquier dato de sesión persistente (tokens, etc.).
  /// Retorna un [Future<void>] que se completa una vez que el proceso ha finalizado.
  Future<void> logout();

  /// Obtiene el estado de autenticación actual.
  ///
  /// Es útil para verificar si un usuario ya ha iniciado sesión al arrancar la aplicación.
  ///
  /// Retorna un [Future] que se completa con el objeto [Usuario] si hay una sesión activa,
  /// o con `null` si no hay ningún usuario autenticado.
  Future<Usuario?> currentUser();
}
```

---

### Resumen del Archivo: `domain/repositories/auth_repository.dart`

#### Resumen General

Este archivo define el contrato abstracto `AuthRepository`, que actúa como una interfaz para todas las operaciones relacionadas con la autenticación de usuarios en la aplicación. Al ser una clase abstracta, no contiene ninguna implementación lógica, sino que establece las firmas de los métodos que cualquier repositorio concreto de autenticación deberá implementar.

Este enfoque es fundamental en arquitecturas como Clean Architecture, ya que permite que la capa de dominio (donde reside este repositorio) permanezca independiente de las fuentes de datos externas (Firebase, API, etc.).

#### Funcionalidad Principal

El contrato `AuthRepository` define cuatro operaciones esenciales para la gestión de usuarios:

1.  **`register`**: Permite la creación de una nueva cuenta de usuario.
2.  **`login`**: Autentica a un usuario con sus credenciales.
3.  **`logout`**: Cierra la sesión del usuario activo.
4.  **`currentUser`**: Verifica si existe un usuario actualmente autenticado en la aplicación.

#### Dependencias Principales

*   **`Usuario`**: (`package:aplicacion_de_comprension/features/usuario/entidades/usuario.dart`)
    *   Depende de la entidad `Usuario`, que es el modelo que representa a un usuario dentro del dominio de la aplicación. Todos los métodos que devuelven información del usuario lo hacen a través de este objeto.

#### Rol en la Aplicación

El `AuthRepository` es una pieza central en la arquitectura de la aplicación. Su rol es:

*   **Abstracción:** Actúa como un puente entre la lógica de negocio (casos de uso que necesitan registrar, loguear, etc.) y la capa de datos (la implementación que realmente habla con Firebase o una API).
*   **Inversión de Dependencias:** Permite que los casos de uso dependan de esta abstracción y no de una implementación concreta, facilitando la sustitución de la fuente de datos (por ejemplo, cambiar de Firebase a una API propia) sin modificar la lógica de negocio.
*   **Testeabilidad:** Facilita las pruebas unitarias de la lógica de negocio, ya que se puede proporcionar una implementación "falsa" (mock) de este repositorio para simular diferentes escenarios de autenticación (éxito, fallo, usuario no encontrado, etc.).

En resumen, este archivo define el **"qué"** se puede hacer con la autenticación, dejando el **"cómo"** a las clases que lo implementen en la capa de infraestructura/datos.
````