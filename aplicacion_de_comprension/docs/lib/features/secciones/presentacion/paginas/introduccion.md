Claro, aquí tienes la documentación completa del archivo en un único bloque de Markdown, siguiendo las instrucciones proporcionadas.

***

```markdown
# Documentación: `lib/features/secciones/presentacion/paginas/introduccion.dart`

## Resumen General

Este archivo define la pantalla de introducción u *onboarding* de la aplicación "Aplico". Su propósito es presentar la aplicación a los nuevos usuarios a través de una serie de páginas informativas que se pueden deslizar. Explica el objetivo educativo de la aplicación, centrado en fortalecer la comprensión lectora, y detalla las habilidades clave que se trabajan: atención, memoria de trabajo, lógica e inferencia.

Una vez que el usuario completa o salta la introducción, la pantalla guarda una bandera en las preferencias locales para no volver a mostrarse en futuros inicios. Además, invalida un proveedor de Riverpod (`bootProvider`) para señalar al resto de la aplicación que el proceso de *onboarding* ha finalizado, lo que típicamente desencadena la navegación hacia la pantalla principal.

### Dependencias Principales

*   **`flutter/material.dart`**: Utilizado para construir la interfaz de usuario con los widgets de Material Design.
*   **`flutter_riverpod`**: Empleado para la gestión de estado. Específicamente, se usa `ref.invalidate()` para interactuar con el `bootProvider` y actualizar el estado de arranque de la aplicación.
*   **`shared_preferences`**: Usado para almacenar de forma persistente si el usuario ya ha visto la pantalla de introducción.

### Rol en la Aplicación

Este archivo es crucial para la primera experiencia del usuario. Actúa como la puerta de entrada a la aplicación, estableciendo el contexto y el propósito de "Aplico" de una manera amigable e interactiva. Su lógica asegura que esta introducción solo se muestre una vez, creando un flujo de arranque fluido para los usuarios recurrentes.

---

## Código Documentado

```dart
// lib/features/secciones/presentacion/paginas/introduccion.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../features/usuario/presentacion/controladores/cargar.dart';

/// La clave utilizada para almacenar en SharedPreferences si el usuario ya ha visto
/// la pantalla de introducción.
const kOnboardingSeenKey = 'onboarding_visto';

/// Una pantalla de introducción (onboarding) que se muestra a los usuarios
/// la primera vez que abren la aplicación.
///
/// Utiliza un `PageView` para guiar al usuario a través de varias páginas
/// informativas sobre el propósito y las funcionalidades de la aplicación.
class Introduccion extends ConsumerStatefulWidget {
  /// Crea una instancia de la pantalla de introducción.
  const Introduccion({super.key});

  @override
  ConsumerState<Introduccion> createState() => _IntroduccionState();
}

/// El estado asociado al widget [Introduccion].
///
/// Gestiona el `PageController`, el seguimiento de la página actual y la lógica
/// para finalizar o saltar la introducción.
class _IntroduccionState extends ConsumerState<Introduccion> {
  /// Controlador para el `PageView` que permite la navegación programática
  /// entre las páginas.
  final _controller = PageController();

  /// El índice de la página que se está mostrando actualmente.
  int _page = 0;

  /// Marca la introducción como completada y actualiza el estado de la aplicación.
  ///
  /// Guarda una bandera en `SharedPreferences` para no volver a mostrar esta
  /// pantalla y luego invalida `bootProvider` para que la lógica de arranque
  /// de la aplicación pueda redirigir al usuario a la pantalla principal.
  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kOnboardingSeenKey, true);

    // Invalida el proveedor para forzar un recálculo. Esto es útil para
    // que el `bootProvider` detecte que el onboarding ha terminado y redirija
    // al usuario a la pantalla principal de la aplicación.
    ref.invalidate(bootProvider);
  }

  @override
  void dispose() {
    // Libera los recursos utilizados por el PageController.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Lista de páginas que se mostrarán en la introducción.
    /// Cada página es un widget [_IntroPage] con su propio título y texto.
    final pages = const [
      _IntroPage(
        title: '✨ Bienvenidos a Aplico ✨',
        text:
            'Aplico es una aplicación educativa creada para fortalecer la comprensión lectora en estudiantes de primaria.',
      ),
      _IntroPage(
        title: 'La lectura',
        text: 'La lectura no solo implica reconocer palabras, sino también comprender y dar sentido a los textos. Para lograrlo, se apoyan cuatro habilidades clave:',
      ),
      _IntroPage(
        title: 'Atención',
        text: 'Mantener el foco en el texto, ignorar distracciones, seleccionar información relevante.',
      ),
      _IntroPage(
        title: 'Memoria de trabajo',
        text: 'Retener e integrar información leída para construir significado en tiempo real.',
      ),
      _IntroPage(
        title: 'Lógica',
        text: 'Ordenar ideas, identificar relaciones causa-efecto, seguir secuencias narrativas.',
      ),
      _IntroPage(
        title: 'Y la inferencia',
        text: 'Deducir significados no explícitos, anticipar contenidos y activar conocimientos previos.',
      ),
      _IntroPage(
        title: 'Diviertete',
        text: 'Cada actividad dentro de la aplicación está diseñada para estimular estas habilidades de manera lúdica e interactiva, promoviendo un aprendizaje significativo y divertido.',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              /// Widget que permite deslizar entre diferentes páginas.
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) => pages[i],
              ),
            ),
            
            /// Indicador de puntos que muestra la página actual.
            _Dots(count: pages.length, index: _page),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  /// Botón para saltar la introducción y finalizar el proceso.
                  TextButton(onPressed: _finish, child: const Text('Saltar')),
                  const Spacer(),
                  /// Botón principal que cambia de "Siguiente" a "Comenzar".
                  FilledButton(
                    onPressed: () {
                      if (_page == pages.length - 1) {
                        // Si es la última página, finaliza la introducción.
                        _finish();
                      } else {
                        // Si no, avanza a la siguiente página.
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    child: Text(_page == pages.length - 1 ? 'Comenzar' : 'Siguiente'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Un widget reutilizable para mostrar el contenido de una página de introducción.
///
/// Muestra un título y un texto descriptivo centrados verticalmente.
class _IntroPage extends StatelessWidget {
  /// El título principal de la página.
  final String title;

  /// El texto descriptivo de la página.
  final String text;

  /// Crea una instancia de [_IntroPage].
  const _IntroPage({
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Text(title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(text,
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

/// Un widget que muestra una fila de puntos para indicar el progreso
/// a través de las páginas de un `PageView`.
///
/// El punto correspondiente a la página actual es más grande y de un color
/// diferente para destacarlo.
class _Dots extends StatelessWidget {
  /// El número total de puntos a mostrar, que corresponde al número de páginas.
  final int count;

  /// El índice del punto activo, que corresponde a la página actual.
  final int index;

  /// Crea una instancia de [_Dots].
  const _Dots({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          width: i == index ? 16 : 8, // El punto activo es más ancho.
          height: 8,
          decoration: BoxDecoration(
            color: i == index
                ? Theme.of(context).colorScheme.primary // Color para el punto activo.
                : Colors.grey.shade400, // Color para los puntos inactivos.
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
```
```