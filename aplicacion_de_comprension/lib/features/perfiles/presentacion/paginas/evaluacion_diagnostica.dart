import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/entidades_diagnostico.dart';
import '../../entidades/diagnostico_provider.dart';

class EvaluacionDiagnosticaPage extends ConsumerWidget {
  const EvaluacionDiagnosticaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(diagnosticoProvider);

    if (estado.completado) {
      return _PantallaResultados(puntajes: estado.puntajes);
    }

    final item = estado.items[estado.indiceActual];
    final progreso = (estado.indiceActual + 1) / estado.items.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluación (${estado.indiceActual + 1}/${estado.items.length})'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(value: progreso, color: Colors.green),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. Instrucción
            Text(
              item.instruccion,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // 2. Contenido Dinámico (Juego)
            Expanded(
              child: _construirJuego(item, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirJuego(ItemDiagnostico item, WidgetRef ref) {
    // Aquí es donde mostramos diferentes widgets según el tipo de actividad
    switch (item.tipo) {
      case TipoActividad.encuentraLetraDistinta:
        return _JuegoSeleccionTexto(item: item, ref: ref);
        
      case TipoActividad.palabraEscuchada:
        return _JuegoAudioSeleccion(item: item, ref: ref); // Requiere paquete audioplayers idealmente
        
      case TipoActividad.ordenaOracion:
        return _JuegoOrdenar(item: item, ref: ref);
        
      default:
        // Por defecto usamos selección simple (para Inferencia, Memoria simple, etc.)
        return _JuegoSeleccionOpciones(item: item, ref: ref);
    }
  }
}

// --- WIDGETS DE LOS MINI-JUEGOS ---

// 1. Juego Genérico de Selección (Botones)
class _JuegoSeleccionOpciones extends StatelessWidget {
  final ItemDiagnostico item;
  final WidgetRef ref;
  const _JuegoSeleccionOpciones({required this.item, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (item.contenido.toString().endsWith('.png')) 
           const Icon(Icons.image, size: 100, color: Colors.grey), // Placeholder imagen
           
        const SizedBox(height: 20),
        ...item.opciones.map((opcion) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
              onPressed: () => ref.read(diagnosticoProvider.notifier).responder(opcion),
              child: Text(opcion.toString(), style: const TextStyle(fontSize: 18)),
            ),
          ),
        )),
      ],
    );
  }
}

// 2. Juego de Atención Visual (Texto grande)
class _JuegoSeleccionTexto extends StatelessWidget {
  final ItemDiagnostico item;
  final WidgetRef ref;
  const _JuegoSeleccionTexto({required this.item, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          color: Colors.grey[200],
          child: Text(
            item.contenido, // Ej: "QQQQOQQ"
            style: const TextStyle(fontSize: 32, letterSpacing: 4, fontFamily: 'Monospace'),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: item.opciones.map((opcion) => ElevatedButton(
             onPressed: () => ref.read(diagnosticoProvider.notifier).responder(opcion),
             child: Text('Es la $opcion', style: const TextStyle(fontSize: 20)),
          )).toList(),
        ),
        const Spacer(),
      ],
    );
  }
}

// 3. Juego de Ordenar Oración
class _JuegoOrdenar extends StatefulWidget {
  final ItemDiagnostico item;
  final WidgetRef ref;
  const _JuegoOrdenar({required this.item, required this.ref});
  @override
  State<_JuegoOrdenar> createState() => _JuegoOrdenarState();
}
class _JuegoOrdenarState extends State<_JuegoOrdenar> {
  late List<String> palabras;
  
  @override
  void initState() {
    super.initState();
    palabras = List<String>.from(widget.item.opciones);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          children: palabras.map((p) => Chip(
            label: Text(p),
            backgroundColor: Colors.blue[100],
            onDeleted: () {
               // Lógica simple: al hacer clic, lo movemos al final o quitamos (simplificado)
            },
          )).toList(),
        ),
        const Spacer(),
        // Para simplificar, usamos ReorderableListView en una implementación completa.
        // Aquí mostramos botones para que el usuario "construya" la respuesta en su mente
        // O un botón simple de "Validar" simulado.
        const Text('Arrastra para ordenar (Simulación)'),
        const Spacer(),
        FilledButton(
          onPressed: () {
             // Enviamos la lista tal cual está ordenada
             widget.ref.read(diagnosticoProvider.notifier).responder(palabras.toString());
          },
          child: const Text('Confirmar Orden'),
        )
      ],
    );
  }
}

// 4. Placeholder Audio
class _JuegoAudioSeleccion extends StatelessWidget {
  final ItemDiagnostico item;
  final WidgetRef ref;
  const _JuegoAudioSeleccion({required this.item, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.volume_up, size: 80, color: Colors.blue),
          onPressed: () {
            // Reproducir sonido (item.contenido)
          },
        ),
        const Text('Toca para escuchar'),
        const SizedBox(height: 40),
        _JuegoSeleccionOpciones(item: item, ref: ref), // Reutilizamos los botones
      ],
    );
  }
}

// --- PANTALLA DE RESULTADOS ---
class _PantallaResultados extends StatelessWidget {
  final Map<HabilidadCognitiva, int> puntajes;
  const _PantallaResultados({required this.puntajes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              const Text('¡Diagnóstico Completado!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('Hemos creado tu ruta personalizada basada en estos resultados:', textAlign: TextAlign.center),
              const SizedBox(height: 30),
              // Lista de resultados
              ...puntajes.entries.map((entry) => ListTile(
                title: Text(entry.key.toString().split('.').last.toUpperCase()),
                trailing: Text('${entry.value} pts', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                leading: _getIconForSkill(entry.key),
              )),
              const SizedBox(height: 40),
              FilledButton(
                onPressed: () {
                   Navigator.pop(context); // Volver al menú (que ahora debería mostrar la ruta)
                },
                child: const Text('Ver mi Ruta de Aprendizaje'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Icon _getIconForSkill(HabilidadCognitiva h) {
    switch (h) {
      case HabilidadCognitiva.atencion: return const Icon(Icons.visibility, color: Colors.blue);
      case HabilidadCognitiva.memoriaTrabajo: return const Icon(Icons.memory, color: Colors.purple);
      case HabilidadCognitiva.logica: return const Icon(Icons.account_tree, color: Colors.teal);
      case HabilidadCognitiva.inferencia: return const Icon(Icons.lightbulb, color: Colors.amber);
    }
  }
}