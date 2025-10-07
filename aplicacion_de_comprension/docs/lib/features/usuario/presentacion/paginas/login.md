Claro, aquí tienes la documentación completa del archivo de código en un único bloque de Markdown, siguiendo tus instrucciones.

````markdown
# Documentación: `lib/features/usuario/presentacion/paginas/owner_login_page.dart`

## Resumen General

Este archivo define la interfaz de usuario y la lógica de presentación para la página de inicio de sesión (`Login`). Está implementado como un `ConsumerStatefulWidget` de Flutter, lo que indica su profunda integración con el paquete de gestión de estado `flutter_riverpod`. Su propósito principal es capturar las credenciales del usuario (una contraseña o PIN), interactuar con un controlador de autenticación para validar dichas credenciales y gestionar los diferentes estados de la UI (carga, error, éxito) durante este proceso.

## Funcionalidad Principal

-   **Formulario de Entrada:** Proporciona un campo de texto (`TextField`) para que el usuario ingrese su "secreto" (contraseña/PIN) y un `Checkbox` para la opción de "Mantener sesión".
-   **Gestión de Estado:** Utiliza una combinación de estado local (con `setState` para `loading` y `error`) y estado global (observando `authControllerProvider` con `ref.watch`). Esto le permite reaccionar tanto a las interacciones del usuario inmediatas como a los cambios en el estado de autenticación de toda la aplicación.
-   **Interacción con la Lógica de Negocio:** Al presionar el botón "Entrar", invoca el método `login` del `authControllerProvider.notifier`, delegando la responsabilidad de la autenticación al controlador.
-   **Feedback al Usuario:** Muestra un indicador de progreso (`CircularProgressIndicator`) mientras la autenticación está en curso y presenta mensajes de error si las credenciales son incorrectas o si ocurre un error en el proveedor de autenticación.
-   **Navegación:** En caso de un inicio de sesión exitoso, redirige al usuario a la `CharacterSelectPage`, reemplazando la página de login en el stack de navegación.

## Dependencias Clave

-   **`flutter/material.dart`**: Para todos los componentes de la interfaz de usuario de Material Design.
-   **`flutter_riverpod`**: Es la dependencia fundamental para la gestión de estado. Conecta la UI (`Login`) con la lógica de negocio (`authControllerProvider`).
-   **`authControllerProvider`** (de `../controladores/contautenticacion.dart`): El proveedor de Riverpod que expone el controlador de autenticación. Es el puente hacia la lógica de negocio.
-   **`AuthLoading`, `AuthError`** (de `../estados/autenticacion.dart`): Clases de estado que representan los diferentes estados del proceso de autenticación, permitiendo a la UI reaccionar de forma declarativa.
-   **`CharacterSelectPage`** (de `personajes.dart`): La página a la que se navega tras un inicio de sesión exitoso.

## Rol en la Aplicación

Este archivo cumple el rol de **capa de presentación** para la funcionalidad de autenticación. Actúa como la puerta de entrada para los usuarios a las secciones protegidas de la aplicación. Su responsabilidad se limita a mostrar la UI, capturar la entrada del usuario y comunicar los eventos al controlador correspondiente, manteniendo una clara separación de responsabilidades.

---

## Código Documentado

```dart
// lib/features/usuario/presentacion/paginas/owner_login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controladores/contautenticacion.dart';
import '../estados/autenticacion.dart';
import 'personajes.dart'; // tu CharacterSelectPage

/// Un widget que representa la página de inicio de sesión de la aplicación.
///
/// Este widget es un [ConsumerStatefulWidget], lo que le permite interactuar
/// con los proveedores de Riverpod para gestionar el estado de autenticación.
/// Presenta un formulario para que el usuario ingrese sus credenciales.
class Login extends ConsumerStatefulWidget {
  /// Crea una nueva instancia de la página de login.
  const Login({super.key});
  
  @override
  ConsumerState<Login> createState() => _S();
}

/// La clase de estado para el widget [Login].
///
/// Extiende [ConsumerState], lo que proporciona acceso al [WidgetRef] (`ref`)
/// para interactuar con los proveedores de Riverpod. Gestiona el estado local de la UI,
/// como los controladores de texto y los indicadores de carga y error.
class _S extends ConsumerState<Login> {
  /// Controlador para el campo de texto de la contraseña o PIN.
  final secretCtrl = TextEditingController();

  /// Indica si el usuario desea que se recuerde su sesión en el dispositivo.
  ///
  /// Por defecto, su valor es `true`.
  bool remember = true;

  /// Almacena un mensaje de error local para ser mostrado en la UI,
  /// típicamente cuando las credenciales son inválidas tras la validación.
  String? error;

  /// Controla el estado de carga local para la operación de login asíncrona,
  /// deshabilitando el botón de envío para prevenir múltiples solicitudes.
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // Observa el estado del proveedor de autenticación. La UI se reconstruirá
    // cada vez que este estado cambie (ej. de AuthInitial a AuthLoading).
    final auth = ref.watch(authControllerProvider);

    // Determina si se debe mostrar el indicador de carga. Se activa por el
    // estado local `loading` o si el estado global de autenticación es [AuthLoading].
    final isLoading = loading || auth is AuthLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Ingresar')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          // Muestra un error local si existe (ej. credenciales inválidas).
          if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
          // Muestra un error proveniente del estado global de autenticación.
          if (auth is AuthError) Text(auth.message, style: const TextStyle(color: Colors.red)),
          TextField(
            controller: secretCtrl,
            decoration: const InputDecoration(labelText: 'Contraseña o PIN'),
            obscureText: true,
          ),
          Row(children: [
            Checkbox(value: remember, onChanged: (v) => setState(() => remember = v ?? true)),
            const Text('Mantener sesión en este dispositivo')
          ]),
          const SizedBox(height: 12),
          FilledButton(
            // El botón se deshabilita si está en estado de carga.
            onPressed: isLoading ? null : () async {
              // Inicia el estado de carga local y limpia errores previos.
              setState(() { loading = true; error = null; });
              
              // Llama al método login del controlador de autenticación.
              // Usamos `ref.read` porque es una acción que no necesita observar cambios.
              final ok = await ref.read(authControllerProvider.notifier)
                  .login(secret: secretCtrl.text, remember: remember);
              
              // Finaliza el estado de carga local.
              setState(() { loading = false; });
              
              // Si el login falla, muestra un mensaje de error.
              if (!ok) { 
                setState(() { error = 'Credenciales inválidas'; }); 
                return; 
              }
              
              // Comprobación de seguridad para evitar errores si el widget se ha
              // desmontado del árbol durante la operación asíncrona.
              if (!mounted) return;
              
              // Si el login es exitoso, navega a la siguiente página.
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const CharacterSelectPage()),
              );
            },
            child: isLoading ? const CircularProgressIndicator() : const Text('Entrar'),
          ),
        ]),
      ),
    );
  }
}
```
````