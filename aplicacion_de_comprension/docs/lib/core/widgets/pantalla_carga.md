¡Claro! Como Senior Technical Writer experto en Flutter, aquí tienes la documentación Markdown para `pantalla_carga.dart`:

---

# Documentación Técnica: `PantallaCarga` (Widget de Carga)

## Resumen

El widget `PantallaCarga` es un componente de UI simple y declarativo diseñado para mostrar un indicador visual de progreso durante operaciones asíncronas, inicialización de la aplicación o la carga de datos. Su propósito principal es mejorar la experiencia del usuario al proporcionar retroalimentación visual, indicando que la aplicación está procesando o esperando una respuesta.

Es un `StatelessWidget`, lo que significa que no gestiona ningún estado interno y es puramente presentacional. Su diseño minimalista lo hace altamente reutilizable en diversas partes de la aplicación donde se requiera una señalización de carga genérica.

## Arquitectura (Widget/Provider/Repo)

Este componente se adscribe estrictamente a la **capa de Widgets (UI)**.

*   **Widget:** `PantallaCarga` extiende `StatelessWidget`. Esto subraya su naturaleza como un componente de UI que no mantiene estado interno. Recibe su configuración a través de su constructor (aunque en este caso es solo la `key`) y su representación es completamente determinista en función de sus propiedades. Su construcción se limita a widgets básicos de Flutter para presentar una interfaz visual.
*   **Provider/BLoC/Riverpod/etc.:** Este widget **no interactúa directamente** con ninguna solución de gestión de estado (como Provider, BLoC, Riverpod, etc.) ni tiene conocimiento de la lógica de negocio o de las operaciones asíncronas que está representando. Su única responsabilidad es la visualización. Se espera que sea orquestado por un widget padre o una capa de gestión de estado que determine cuándo debe mostrarse u ocultarse.
*   **Repository:** No hay interacción con repositorios de datos ni fuentes de información externas. El widget es completamente agnóstico al origen de la información que está esperando cargar.

En resumen, `PantallaCarga` es un componente de bajo acoplamiento, ideal para la composición en arquitecturas más complejas, actuando como una pieza fundamental de la capa de presentación.

## Componentes Clave

Los elementos constitutivos de `PantallaCarga` son los siguientes:

*   **`PantallaCarga` (Clase principal):**
    *   Extiende `StatelessWidget`, indicando su naturaleza inmutable y sin estado.
    *   Su método `build` define la estructura visual del indicador de carga.

*   **`Container`:**
    *   Sirve como el widget raíz para el contenido de la pantalla.
    *   La elección de `Container` sobre `Scaffold` es intencionada y clave:
        *   Permite que `PantallaCarga` sea fácilmente incrustado dentro de otros `Scaffold` o estructuras de widgets existentes sin introducir un `Scaffold` anidado.
        *   Esto lo hace versátil para ser utilizado como un overlay de carga, un componente de carga de sección, o como una pantalla de carga completa si el `Container` ocupa todo el espacio disponible.

*   **`Center`:**
    *   Un widget de diseño que centra a su único hijo tanto horizontal como verticalmente dentro del espacio disponible.
    *   Se utiliza para asegurar que el indicador de progreso se muestre en el medio de la `PantallaCarga`.

*   **`CircularProgressIndicator`:**
    *   El widget principal que representa el estado de carga.
    *   Muestra un círculo animado que gira continuamente, indicando que una operación está en curso.
    *   **`color: Colors.white`**: Se ha configurado explícitamente para que el indicador de progreso sea de color blanco, lo que lo hace adecuado para fondos oscuros o para una visibilidad contrastada en diversas interfaces de usuario.

---