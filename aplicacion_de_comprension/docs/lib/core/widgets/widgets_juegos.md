¡Claro! Aquí tienes la documentación Markdown para `widgets_juegos.dart`, redactada desde la perspectiva de un Senior Technical Writer experto en Flutter.

---

# `widgets_juegos.dart`

Este archivo contiene una colección de widgets Flutter diseñados para implementar actividades de juego educativas o interactivas. Estos widgets están construidos para ser reutilizables y se integran fácilmente en aplicaciones que requieren módulos de juego específicos, actuando como componentes de UI "puros" que reciben datos y reportan resultados a un controlador superior.

---

## 1. Resumen

`widgets_juegos.dart` proporciona dos widgets principales que encapsulan lógicas y UI para tipos de juegos educativos comunes:

1.  **`JuegoOrdenarOracion`**: Un juego donde el usuario debe reconstruir una oración arrastrando o seleccionando palabras desordenadas.
2.  **`JuegoTrivia`**: Un juego de preguntas y respuestas de opción múltiple, que puede incluir un fragmento de contexto.

Ambos widgets están diseñados para operar con una instancia de `ActividadModelo` (proveniente de `../../features/perfiles/entidades/modelos_json.dart`) como su fuente principal de datos de configuración y contenido. Reportan el resultado del juego (éxito o fracaso) a través de un callback `onTerminar`.

---

## 2. Arquitectura y Patrones

Estos widgets siguen un patrón de diseño **presentacional** o **"dumb component"**:

*   **Flutter Widgets**: `JuegoOrdenarOracion` es un `StatefulWidget` para gestionar el estado interno de las palabras seleccionadas, mientras que `JuegoTrivia` es un `StatelessWidget` ya que su estado de UI es completamente derivado de sus propiedades iniciales.
*   **Independencia de Estado Global**: No utilizan soluciones de gestión de estado externas (como Provider, BLoC, Riverpod, etc.) internamente. Su estado es local o se deriva directamente de sus propiedades.
*   **Inyección de Dependencias (mediante propiedades)**: Reciben toda la información necesaria para su funcionamiento a través de su constructor:
    *   `ActividadModelo actividad`: Contiene los datos específicos de la actividad a presentar (e.g., palabras desordenadas, la pregunta, opciones, etc.). Se espera que el campo `contenido` de `ActividadModelo` sea un `Map<String, dynamic>` con una estructura predefinida para cada tipo de juego.
    *   `Function(bool) onTerminar`: Un callback que se invoca cuando el juego concluye, reportando si el usuario ha completado la actividad correctamente (`true`) o no (`false`). Esto permite que un widget padre maneje la lógica de puntuación, navegación o retroalimentación.
*   **Separación de Preocupaciones**: Los widgets se centran exclusivamente en la presentación de la UI y la interacción del usuario para la actividad de juego específica, dejando la lógica de negocio más amplia y la persistencia de datos a capas superiores de la aplicación.

---

## 3. Componentes Clave

### 3.1. `JuegoOrdenarOracion`

*   **Propósito**: Permite al usuario reconstruir una oración correcta a partir de un conjunto de palabras desordenadas.
*   **Tipo**: `StatefulWidget`.
*   **Propiedades (`props`)**:
    *   `final ActividadModelo actividad`: Objeto que contiene la configuración y las palabras del juego. Se espera que `actividad.contenido` tenga las claves `oracion_desordenada` (una lista de `String`) y `solucion` (la `String` correcta).
    *   `final Function(bool) onTerminar`: Callback invocado al finalizar el juego con el resultado (`true` si la oración es correcta, `false` en caso contrario).
*   **Estado Interno (`_JuegoOrdenarOracionState`)**:
    *   `late List<String> palabrasDisponibles`: Lista de palabras que el usuario aún no ha seleccionado, inicializada con las palabras desordenadas y luego mezclada.
    *   `late List<String> oracionArmada`: Lista de palabras que el usuario ha seleccionado para formar la oración.
    *   `late String solucion`: La oración correcta esperada para la validación.
*   **Flujo de Interacción**:
    1.  El usuario ve una lista de palabras disponibles (mezcladas) y una zona vacía para armar la oración.
    2.  Al tocar una palabra en la zona de `palabrasDisponibles` (usando un `FilterChip`), la palabra se mueve a `oracionArmada`.
    3.  Al tocar una palabra en la zona de `oracionArmada` (usando un `ActionChip`), la palabra se mueve de vuelta a `palabrasDisponibles`, permitiendo correcciones.
    4.  El botón "Comprobar" se habilita solo cuando todas las palabras de `palabrasDisponibles` han sido usadas (es decir, `palabrasDisponibles` está vacío).
    5.  Al pulsar "Comprobar", se valida la oración y se llama a `onTerminar`.
*   **Componentes UI Clave**:
    *   `Wrap` de `FilterChip`s: Para las palabras disponibles. Tocar uno lo añade a la oración.
    *   `Wrap` de `ActionChip`s: Para las palabras en la oración armada. Tocar uno lo quita de la oración.
    *   `FilledButton`: "Comprobar", que activa la lógica de validación.
*   **Lógica de Validación (`_validar`)**:
    *   Une las palabras de `oracionArmada` con espacios.
    *   Normaliza ambas oraciones (la armada y la `solucion`) a minúsculas y elimina los puntos (`.`) para una comparación insensible a mayúsculas/puntuación.
    *   Compara las oraciones normalizadas y llama a `widget.onTerminar` con el resultado.

### 3.2. `JuegoTrivia`

*   **Propósito**: Presenta una pregunta de trivia (o inferencia) con múltiples opciones de respuesta.
*   **Tipo**: `StatelessWidget`.
*   **Propiedades (`props`)**:
    *   `final ActividadModelo actividad`: Objeto que contiene la pregunta, opciones y la respuesta correcta. Se espera que `actividad.contenido` tenga las claves `pregunta` (`String`), `opciones` (`List<dynamic>`), `respuesta_correcta` (`String`), y opcionalmente `fragmento_contexto` (`String`).
    *   `final Function(bool) onTerminar`: Callback invocado al seleccionar una opción con el resultado (`true` si la opción es correcta, `false` en caso contrario).
*   **Flujo de Interacción**:
    1.  El usuario ve un fragmento de contexto (opcional), seguido de la pregunta.
    2.  Debajo, se muestran múltiples botones, cada uno representando una opción de respuesta.
    3.  Al tocar una opción, se valida inmediatamente si es la respuesta correcta.
    4.  Se llama a `onTerminar` con el resultado de la validación.
*   **Componentes UI Clave**:
    *   `Text` (para `fragmento_contexto`): Mostrado condicionalmente con estilo itálico.
    *   `Text` (para `pregunta`): Estilo negrita y tamaño de fuente mayor.
    *   `ElevatedButton`s: Cada botón representa una opción de respuesta. Al ser pulsado, activa la lógica de validación y llama a `onTerminar`.
*   **Lógica de Validación**:
    *   La validación ocurre directamente en el `onPressed` de cada `ElevatedButton`.
    *   Se compara la opción seleccionada (`opc`) con la `respuesta_correcta` del modelo de actividad.
    *   El resultado booleano de esta comparación se pasa directamente a `onTerminar`.

### 3.3. `ActividadModelo` (Contexto)

Aunque no está definida en este archivo, la `ActividadModelo` es fundamental. Es una entidad de datos que sirve como contrato para la información que estos widgets de juego esperan. Su campo `contenido` es un `Map<String, dynamic>` que debe estructurarse de forma específica para cada tipo de juego, permitiendo la flexibilidad de definir diferentes actividades sin modificar la lógica interna del widget.

---