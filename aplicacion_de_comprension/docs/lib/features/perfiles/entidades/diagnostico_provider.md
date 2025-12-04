¡Excelente! Aquí tienes la documentación Markdown para `diagnostico_provider.dart`, presentada desde la perspectiva de un Senior Technical Writer experto en Flutter y Riverpod.

---

# Documentación Técnica: `diagnostico_provider.dart`

## 1. Resumen

El archivo `diagnostico_provider.dart` es responsable de gestionar el estado reactivo y la lógica de negocio central de un examen de diagnóstico cognitivo en una aplicación Flutter, utilizando la librería Riverpod.

Este módulo define:
*   La estructura de datos (`DiagnosticoState`) que representa el estado actual del examen, incluyendo el progreso, los puntajes por habilidad cognitiva y la lista de ítems.
*   El controlador de estado (`DiagnosticoNotifier`) que encapsula la lógica para iniciar el examen, procesar las respuestas del usuario, actualizar los puntajes y determinar la finalización del diagnóstico.
*   Un `StateNotifierProvider` (`diagnosticoProvider`) para exponer este estado y su lógica a la interfaz de usuario de manera eficiente y reactiva.

El objetivo principal de este provider es ofrecer una fuente de verdad única y bien definida para el flujo del diagnóstico, facilitando que los widgets muestren el estado actual y reaccionen a los cambios sin acoplamiento directo.

## 2. Arquitectura del Componente

Este archivo se sitúa firmemente en la capa de **Provider** dentro de una arquitectura de aplicación Flutter que sigue el patrón de separación de preocupaciones (ej., MVVM-C, Clean Architecture).

### 2.1. Capa de Provider (Este archivo)

*   **`DiagnosticoState`**: Define la interfaz y la estructura de los datos que representarán el estado completo del examen de diagnóstico. Es una clase inmutable, lo que significa que cada modificación de estado genera una nueva instancia, un principio fundamental para la reactividad en Riverpod.
*   **`DiagnosticoNotifier`**: Actúa como el "ViewModel" o "Presenter" para la lógica de negocio del diagnóstico. Recibe acciones (como `responder`) y actualiza el `DiagnosticoState` basándose en esas acciones. Gestiona la transición entre ítems, el cálculo de puntajes y la finalización del examen.
*   **`diagnosticoProvider`**: El objeto Riverpod `StateNotifierProvider` que permite a los widgets "escuchar" los cambios en el `DiagnosticoState` y "interactuar" con el `DiagnosticoNotifier` para desencadenar acciones.

### 2.2. Interacción con la Capa de Widgets (External)

Los widgets de la interfaz de usuario (ej., `DiagnosticoScreen`, `ItemDiagnosticoWidget`) utilizarán el `diagnosticoProvider` para:
*   **Observar el estado**: `ref.watch(diagnosticoProvider)` para reconstruir automáticamente cuando el `DiagnosticoState` cambie (ej., al avanzar de ítem, actualizar puntajes, o al finalizar el examen).
*   **Ejecutar acciones**: `ref.read(diagnosticoProvider.notifier).responder(respuesta)` para llamar a los métodos del `DiagnosticoNotifier` y modificar el estado.

### 2.3. Interacción con la Capa de Repositorios/Datos (External/Implícito)

Actualmente, los ítems de diagnóstico se generan mediante el método estático `_generarItemsMock()`. En una aplicación de producción, esta lógica de carga de datos debería externalizarse a una **Capa de Repositorio**.

*   Un `DiagnosticoRepository` (o similar) sería responsable de obtener los `ItemDiagnostico` de una fuente persistente (API, base de datos local, assets).
*   El `DiagnosticoNotifier` (o su constructor) recibiría una instancia de este repositorio para cargar los ítems iniciales, promoviendo una mejor separación de responsabilidades y testabilidad. La dependencia de `entidades_diagnostico.dart` subraya la necesidad de una fuente externa para estas entidades.

## 3. Componentes Clave

### 3.1. `DiagnosticoState`

Representa el estado inmutable del examen de diagnóstico en un momento dado.

*   **`indiceActual` (int)**: El índice del `ItemDiagnostico` actual que se está presentando al usuario.
*   **`puntajes` (Map<HabilidadCognitiva, int>)**: Un mapa que almacena los puntajes acumulados para cada `HabilidadCognitiva` definida en el sistema. Inicialmente, todos los puntajes son cero.
*   **`completado` (bool)**: Indicador booleano que es `true` cuando todos los ítems del diagnóstico han sido respondidos.
*   **`items` (List<ItemDiagnostico>)**: La lista completa de ítems de diagnóstico que componen el examen.
*   **`copyWith(...)`**: Un método de conveniencia para crear una nueva instancia de `DiagnosticoState` con algunos campos modificados, mientras se mantienen los demás. Es crucial para mantener la inmutabilidad del estado.

### 3.2. `DiagnosticoNotifier`

La clase que gestiona el `DiagnosticoState` y contiene la lógica de negocio del examen.

*   **Constructor**:
    *   Inicializa el `DiagnosticoState` con `indiceActual` en `0`, todos los `puntajes` de habilidad en `0`, `completado` en `false`, y la lista de `items` generada por `_generarItemsMock()`.

*   **`responder(dynamic respuestaUsuario)`**:
    *   Este es el método principal para la interacción del usuario.
    *   Toma la `respuestaUsuario` y la compara con la `respuestaCorrecta` del `itemActual` utilizando `_verificarRespuesta`.
    *   Si la respuesta es correcta, actualiza el puntaje de la `HabilidadCognitiva` asociada al ítem.
    *   Avanza el `indiceActual` al siguiente ítem.
    *   Si se ha respondido al último ítem, establece `completado` en `true`.
    *   Siempre actualiza el estado utilizando `state = state.copyWith(...)` para asegurar la inmutabilidad y notificar a los oyentes de Riverpod.

*   **`_verificarRespuesta(ItemDiagnostico item, dynamic respuesta)` (Private)**:
    *   Método auxiliar para comparar la respuesta del usuario con la respuesta correcta del ítem.
    *   Realiza una comparación simple de cadenas (`.toString()`) para manejar diferentes tipos de respuestas (ej., String, int, List). Para casos de uso más complejos (tolerancia a errores, ordenamiento de listas más robusto), esta lógica podría necesitar ser ampliada.

*   **`_generarItemsMock()` (Static Private)**:
    *   Un método estático que crea y retorna una lista predefinida de `ItemDiagnostico` para el examen.
    *   Actualmente contiene un conjunto reducido de ítems de ejemplo para cada `HabilidadCognitiva` (Atención, Memoria de Trabajo, Lógica, Inferencia).
    *   **Nota de Implementación**: La implementación actual utiliza datos "hardcodeados" para simular 24 reactivos. Para una aplicación en producción, esta data debería ser cargada desde una fuente externa (API, base de datos, assets) gestionada por un repositorio dedicado. Es crucial que la lista final contenga los 24 ítems reales distribuidos adecuadamente entre las habilidades.

### 3.3. `diagnosticoProvider`

*   **Tipo**: `StateNotifierProvider<DiagnosticoNotifier, DiagnosticoState>`
*   **Propósito**: Es el punto de entrada para que la interfaz de usuario interactúe con el `DiagnosticoNotifier` y observe el `DiagnosticoState`.
*   **Creación**: Instancia `DiagnosticoNotifier` y lo retorna. Riverpod se encarga de gestionar el ciclo de vida de esta instancia.

---