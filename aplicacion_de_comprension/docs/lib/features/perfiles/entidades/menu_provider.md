¡Claro! Aquí tienes la documentación Markdown para `menu_provider.dart`, escrita desde la perspectiva de un Senior Technical Writer experto en Flutter y Riverpod.

---

# Documentación: `menu_provider.dart`

Este archivo define la lógica y el estado para la pantalla principal del menú o dashboard de la aplicación. Su objetivo es consolidar toda la información relevante que un usuario necesita ver al iniciar sesión: su perfil, su progreso general, el estado de los módulos y, crucialmente, una recomendación inteligente de la siguiente actividad a realizar.

Utiliza `flutter_riverpod` con un `FutureProvider.autoDispose` para una gestión eficiente del estado asíncrono y la liberación de recursos.

## Resumen

`menu_provider.dart` proporciona un único punto de acceso (`menuDataProvider`) para obtener todos los datos necesarios para renderizar la interfaz de usuario del menú principal. Este proveedor orquesta llamadas a varios repositorios para:

1.  Obtener el perfil del usuario activo.
2.  Calcular el progreso general del usuario y el progreso individual de cada módulo.
3.  Determinar si el usuario es nuevo en la plataforma.
4.  Generar una recomendación de actividad personalizada basada en el historial de rendimiento del usuario en diferentes habilidades.
5.  Verificar si el usuario ha completado un diagnóstico inicial.

Todo esto se encapsula en el objeto `MenuData`, que es el estado emitido por el proveedor.

## Arquitectura

### Capa de Providers (`Riverpod`)

*   **`menuDataProvider` (`FutureProvider.autoDispose<MenuData>`):**
    *   **Responsabilidad:** Es el proveedor central que agrupa y procesa la información de diversos orígenes para crear el estado del menú.
    *   **Tipo:** `FutureProvider` porque la obtención de datos es asíncrona. `autoDispose` asegura que el estado se limpia automáticamente cuando ya no hay widgets escuchándolo, optimizando el uso de memoria y CPU.
    *   **Dependencias:** Lee otros proveedores que exponen las instancias de los repositorios (`repoPerfilProvider`, `repoProgresoProvider`, `repoContenidoJsonProvider`).
    *   **Emite:** Un objeto `MenuData` que encapsula todos los detalles para la UI.

### Capa de Repositorios

El `menuDataProvider` interactúa directamente con la capa de repositorios para obtener los datos brutos:

*   **`repoPerfilProvider`:** Utilizado para obtener el objeto `Perfil` del usuario actualmente activo en la aplicación.
*   **`repoProgresoProvider`:** Responsable de consultar el progreso general, la lista de módulos del usuario y, fundamentalmente, el historial completo de intentos de actividades (`Intento`).
*   **`repoContenidoJsonProvider`:** Empleado para cargar la definición de todas las actividades disponibles desde archivos JSON. Esto es crítico para la lógica de recomendación, ya que permite asociar intentos de usuario con las habilidades definidas para cada actividad.

### Entidades/Modelos de Datos

*   **`Perfil`:** (Definido en `../../usuario/entidades/perfil.dart`) Contiene la información básica del usuario.
*   **`ModuloConProgreso`:** (Definido en `../../../core/utils.dart` o similar) Una estructura que combina un módulo con el progreso específico del usuario en ese módulo.
*   **`Actividad`:** (Asumida desde `repoContenidoJsonProvider`) Una entidad que describe una actividad, incluyendo su ID, nombre, y las `habilidad`es que desarrolla.
*   **`Intento`:** (Asumida desde `repoProgresoProvider`) Representa un registro de un intento de actividad por parte del usuario, incluyendo el `actividadId`, `aciertos`, y `total` de preguntas.
*   **`MenuData`:** El modelo de datos principal para el menú.

### Capa de UI (Implícita)

Los widgets de la pantalla de menú consumirían `menuDataProvider` mediante `ref.watch(menuDataProvider)` para:

*   Mostrar el nombre y otros datos del `usuario`.
*   Renderizar una barra de progreso basada en `progresoTotal`.
*   Listar los `modulos` con su progreso.
*   Presentar una sección destacada con la actividad recomendada (`actividadRecomendadaId`, `tituloRecomendacion`, `motivoRecomendacion`).
*   Adaptar la UI si `esNuevoUsuario` es `true`.
*   Implementar una redirección o un mensaje si el `diagnosticoCompletado` es `false`.

## Componentes Clave

### `class MenuData`

Este es el modelo de datos inmutable que el `menuDataProvider` construye y emite. Contiene toda la información necesaria para el estado del menú:

*   `usuario`: El objeto `Perfil` del usuario activo.
*   `progresoTotal`: Un `double` que representa el progreso acumulado del usuario en todos los módulos.
*   `modulos`: Una lista de `ModuloConProgreso` detallando el avance en cada módulo.
*   `esNuevoUsuario`: Un `bool` que indica si el usuario tiene un progreso total insignificante, lo que sugiere que es un usuario nuevo.
*   `actividadRecomendadaId`: El `ID` de la actividad sugerida por la lógica inteligente.
*   `tituloRecomendacion`: El título o nombre de la actividad recomendada.
*   `motivoRecomendacion`: Una breve explicación de por qué se recomienda esa actividad (e.g., "Refuerza tu Atención").

### `final menuDataProvider`

Este `FutureProvider` encapsula la lógica central para ensamblar `MenuData`.

#### Flujo de Datos y Lógica Principal:

1.  **Obtención de Datos Básicos:**
    *   Lee `repoPerfilProvider` para obtener el `usuario` activo. Si no hay usuario, lanza una excepción.
    *   Lee `repoProgresoProvider` para obtener `progresoTotal` y la lista de `modulos` del usuario.
    *   Calcula `esNuevoUsuario` si `progresoTotal` es muy bajo (menor o igual a 0.01).

2.  **Lógica de Recomendación Inteligente:**
    *   **Inicialización:** Establece una recomendación por defecto ("Empezar Aventura") para nuevos usuarios o en caso de que la lógica inteligente no pueda encontrar una mejor.
    *   **Para Usuarios Existentes (`if (!esNuevo)`):**
        *   **Recopilación de Datos:** Obtiene el `historial` completo de intentos del usuario desde `repoProgresoProvider` y todas las `todasLasActividades` disponibles desde `repoContenidoJsonProvider`.
        *   **Cálculo de Efectividad por Habilidad:**
            *   Itera sobre cada `intento` en el historial.
            *   Busca la `Actividad` correspondiente en `todasLasActividades` usando `actividadId`.
            *   Calcula un `score` (porcentaje de aciertos) para cada intento.
            *   Divide las `habilidad`es de la actividad (que pueden ser varias, separadas por comas) y mapea el `score` a cada una de ellas, acumulando los puntajes en `puntajesPorHabilidad` (e.g., `"Atención" -> [0.8, 0.5, ...]`).
        *   **Identificación de Habilidad Más Débil:**
            *   Calcula el promedio de los `scores` para cada habilidad.
            *   Identifica la `habilidadMasDebil`, que es aquella con el menor promedio de rendimiento.
        *   **Selección de Actividad Recomendada:**
            *   Si se encuentra una `habilidadMasDebil`, el `motivoRecomendacion` se actualiza para reflejar esto.
            *   Busca `candidatas` (actividades) que contengan esa `habilidadMasDebil`.
            *   Las `candidatas` se mezclan (`shuffle()`) para introducir variedad en las recomendaciones.
            *   Se selecciona la primera actividad mezclada como la recomendada, actualizando `recId` y `recTitulo`.

3.  **Verificación de Diagnóstico Inicial:**
    *   Consulta la tabla `modulosHasUsuarios` para el `moduloId.equals(0)` (asumiendo que el módulo 0 es el diagnóstico inicial).
    *   Determina si el `diagnosticoCompletado` (progreso >= 1.0).
    *   **Nota:** La línea `// Redirigir a Evaluación Diagnóstica` indica una lógica pendiente en la capa de UI. El proveedor simplemente expone el estado, y la UI debe reaccionar a él si el diagnóstico no está completo.

4.  **Construcción y Retorno:**
    *   Finalmente, todos los datos obtenidos y calculados se empaquetan en una nueva instancia de `MenuData` y se retornan.

Esta arquitectura asegura una separación clara de responsabilidades, haciendo que el código sea más mantenible, testeable y escalable. La lógica de recomendación, al estar encapsulada en el proveedor, puede ser probada independientemente de la UI.