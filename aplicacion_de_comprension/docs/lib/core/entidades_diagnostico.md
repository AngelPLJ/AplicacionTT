¡Excelente iniciativa! Como Senior Technical Writer experto en Flutter, entiendo la importancia de tener una documentación clara y estructurada, incluso para los modelos de datos más fundamentales. Este archivo es la espina dorsal del módulo de diagnóstico, así que su documentación es crucial.

---

# `entidades_diagnostico.dart` Documentation

Este documento describe las entidades centrales utilizadas para estructurar y gestionar el proceso de diagnóstico cognitivo dentro de la aplicación Flutter. Define las enumeraciones y la clase de modelo de datos que encapsulan las habilidades cognitivas, los tipos de actividades y la estructura de cada ítem de diagnóstico individual.

## 1. Resumen

El archivo `entidades_diagnostico.dart` es fundamental para el módulo de diagnóstico de la aplicación. Contiene las definiciones de los modelos de datos (`enums` y una `class`) que permiten categorizar, almacenar y presentar las tareas de diagnóstico.

Su propósito principal es:
*   **Estandarizar la clasificación:** Proporciona un vocabulario controlado para las habilidades cognitivas y los tipos de actividades.
*   **Definir la estructura de datos:** Establece un formato consistente para cada ítem de diagnóstico, asegurando que toda la información necesaria para una tarea (instrucción, contenido, opciones, respuesta correcta) esté encapsulada de manera uniforme.
*   **Facilitar la interoperabilidad:** Estos modelos son la base para la comunicación entre el backend (si existe), la capa de repositorio y la interfaz de usuario, garantizando que los datos sean interpretados de la misma manera en toda la aplicación.

En esencia, este archivo es el *contrato de datos* para el módulo de diagnóstico.

## 2. Arquitectura

Aunque `entidades_diagnostico.dart` no contiene Widgets, Providers o Repositories directamente, sus entidades son consumidas y gestionadas por estas capas dentro de una arquitectura Flutter bien definida.

### Integración en la Arquitectura Flutter:

*   **Repository Layer:**
    *   Un **`DiagnosticRepository`** sería responsable de obtener las instancias de `ItemDiagnostico` de una fuente de datos (por ejemplo, una API REST, una base de datos local como Hive/Sqflite, o un archivo de assets estático).
    *   Este repositorio se encargaría de la deserialización de datos crudos (JSON, etc.) en objetos `ItemDiagnostico` bien tipados.
    *   Proporcionaría métodos para `fetchDiagnosticItems(HabilidadCognitiva skill)` o `fetchNextItem()`.

*   **Provider / State Management Layer:**
    *   Un **`DiagnosticProvider`** (usando `package:provider`, Riverpod, BLoC, GetX, etc.) mantendría el estado actual del diagnóstico.
    *   Este Provider expondría una lista de `ItemDiagnostico`s, el `ItemDiagnostico` actual que se muestra al usuario, el progreso del usuario y sus respuestas.
    *   Dependería del `DiagnosticRepository` para obtener los datos.
    *   Sería el puente entre los datos crudos del repositorio y la lógica de negocio/UI, transformando y gestionando las entidades para su presentación.

*   **Widget Layer:**
    *   **Widgets de Presentación:** Los `ItemDiagnostico`s serían consumidos por Widgets dedicados en la interfaz de usuario.
        *   Un **`DiagnosticScreen`** o **`CognitiveTaskWidget`** observaría el `DiagnosticProvider` para obtener el `ItemDiagnostico` actual.
        *   Utilizaría la `instruccion` para mostrar el texto o reproducir el audio.
        *   Interpretaría el `contenido` (que puede ser dinámico: una URL de imagen, una lista de palabras, etc.) para renderizar el UI apropiado (ej. `Image.network()`, `ListView.builder()` de `Text`s).
        *   Crearía widgets interactivos (botones, `RadioListTiles`, `TextField`s) basados en las `opciones` para que el usuario ingrese su respuesta.
    *   **Widgets de Control:** Botones de "Siguiente", "Enviar", o indicadores de progreso consumirían el estado del `DiagnosticProvider` para manejar la navegación y la retroalimentación.

En resumen, `entidades_diagnostico.dart` forma la capa de *Modelos* en una arquitectura MVVM (Model-View-ViewModel) o de Bloque/Provider, siendo la base sobre la cual el resto de la aplicación construye la lógica y la interfaz de usuario del diagnóstico.

## 3. Componentes Clave

### `enum HabilidadCognitiva`

Define las categorías principales de habilidades cognitivas que se buscan diagnosticar.

*   **`atencion`**: Capacidad para concentrarse en estímulos relevantes y filtrar distracciones.
*   **`memoriaTrabajo`**: Habilidad para mantener y manipular información en la mente por un corto período para realizar una tarea.
*   **`inferencia`**: Capacidad para deducir o concluir información no explícita a partir de datos disponibles.
*   **`logica`**: Habilidad para razonar, identificar patrones y resolver problemas siguiendo principios consistentes.

### `enum TipoActividad`

Especifica los tipos concretos de actividades o ejercicios que corresponden a cada `HabilidadCognitiva`.

*   **Atención:**
    *   `encuentraLetraDistinta`: Localizar un elemento diferente en un conjunto de elementos similares.
    *   `palabraEscuchada`: Identificar una palabra específica dentro de una secuencia auditiva.
*   **Memoria:**
    *   `memorama`: Juego de emparejamiento para evaluar la memoria visual.
    *   `memoriaFonetica`: Recordar secuencias de sonidos o palabras.
*   **Lógica:**
    *   `ordenaOracion`: Reorganizar palabras para formar una oración coherente.
    *   `seleccionaImagen`: Elegir la imagen que sigue una regla o patrón lógico.
*   **Inferencia:**
    *   `quePasaraDespues`: Predecir un evento futuro basándose en un contexto dado.
    *   `comprensionFragmentos`: Derivar significado o conclusiones de pequeños fragmentos de información.

### `class ItemDiagnostico`

Esta clase es el modelo de datos principal para un ítem o pregunta individual dentro del diagnóstico. Encapsula toda la información necesaria para presentar una tarea y evaluar la respuesta del usuario.

| Propiedad          | Tipo                     | Descripción                                                                                                                                                                                                                                  |
| :----------------- | :----------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `id`               | `String`                 | Identificador único para este ítem de diagnóstico. Utilizado para referencia y seguimiento.                                                                                                                                                  |
| `habilidad`        | `HabilidadCognitiva`     | La habilidad cognitiva principal que este ítem está diseñado para evaluar. Vincula este ítem a una categoría más amplia.                                                                                                                   |
| `tipo`             | `TipoActividad`          | El tipo específico de actividad que representa este ítem. Proporciona granularidad sobre la mecánica de la tarea.                                                                                                                            |
| `instruccion`      | `String`                 | La instrucción para el usuario. Puede ser un texto directo o una URL a un archivo de audio con la instrucción. La UI debe ser capaz de interpretar ambos.                                                                                  |
| `contenido`        | `dynamic`                | El material o estímulo principal de la tarea. Su tipo es `dynamic` para permitir flexibilidad: podría ser una `List<String>` (para letras o palabras), una `String` que es una URL de imagen o audio, un `Map`, etc. La UI debe saber cómo renderizarlo según el `tipo`. |
| `respuestaCorrecta` | `dynamic`                | La respuesta esperada para el ítem. Su tipo también es `dynamic` para acomodar diferentes formatos de respuesta (ej. un `String`, un `int`, una `List<String>`).                                                                          |
| `opciones`         | `List<dynamic>`          | Una lista de opciones de respuesta disponibles para el usuario. Si la tarea es de selección múltiple, estas serían las opciones. Puede ser una lista vacía si la respuesta es de texto libre o no hay opciones predefinidas.              |

Este modelo está diseñado para ser flexible, permitiendo la creación de una amplia variedad de tareas de diagnóstico sin requerir cambios en la estructura de la clase, delegando la interpretación específica del `contenido` y `respuestaCorrecta` a la lógica de presentación basada en `tipo`.