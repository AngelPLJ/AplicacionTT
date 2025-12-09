import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/entidades_diagnostico.dart';
import '../../entidades/diagnostico_provider.dart';
import '../../../../infraestructura/repoprogresoimpl.dart';
import '../../../../core/providers/proveedor.dart';

class EvaluacionDiagnosticaPage extends ConsumerWidget {
  const EvaluacionDiagnosticaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(diagnosticoProvider);

    // 1. CARGA
    if (estado.isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF130027), // Fondo oscuro consistente
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    // 2. ERROR
    if (estado.items.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF130027),
        appBar: AppBar(title: const Text("Error"), backgroundColor: Colors.transparent),
        body: const Center(
          child: Text(
            "No se pudieron cargar las actividades.", 
            style: TextStyle(color: Colors.white)
          )
        ),
      );
    }

    // 3. RESULTADOS
    if (estado.completado) {
      return _PantallaResultados(puntajes: estado.puntajes);
    }

    // 4. JUEGO ACTIVO
    final item = estado.items[estado.indiceActual];
    final progreso = (estado.indiceActual + 1) / estado.items.length;

    return Scaffold(
      backgroundColor: const Color(0xFF130027), // Fondo oscuro
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // Flecha blanca
        title: Text(
          'Evaluación (${estado.indiceActual + 1}/${estado.items.length})',
          style: const TextStyle(color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: progreso, 
            color: Colors.greenAccent, 
            backgroundColor: Colors.white24
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Instrucción en BLANCO
            Text(
              item.instruccion,
              style: const TextStyle(
                fontSize: 22, 
                fontWeight: FontWeight.bold, 
                color: Colors.white // <--- CORRECCIÓN CLAVE
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

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
          const Icon(Icons.image, size: 100, color: Colors.grey),
        
        const SizedBox(height: 20),
        
        ...item.opciones.map((opcion) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                // Opcional: Si quieres asegurar que el botón tenga un color que contraste con el blanco
                // backgroundColor: Colors.blue, 
              ),
              onPressed: () => ref.read(diagnosticoProvider.notifier).responder(opcion),
              child: Text(
                opcion.toString(),
                style: const TextStyle(
                  fontSize: 18, 
                  color: Colors.white // <--- TEXTO BLANCO
                ),
              ),
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
          // CAMBIO IMPORTANTE: Usamos un color oscuro para que el texto blanco resalte
          color: Colors.black54, 
          child: Text(
            item.contenido, // Ej: "QQQQOQQ"
            style: const TextStyle(
              fontSize: 32, 
              letterSpacing: 4, 
              fontFamily: 'Monospace',
              color: Colors.white // <--- TEXTO BLANCO
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: item.opciones.map((opcion) => ElevatedButton(
              onPressed: () => ref.read(diagnosticoProvider.notifier).responder(opcion),
              child: Text(
                'Es la $opcion',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white // <--- TEXTO BLANCO
                ),
              ),
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

  const _JuegoOrdenar({Key? key, required this.item, required this.ref}) : super(key: key);

  @override
  State<_JuegoOrdenar> createState() => _JuegoOrdenarState();
}

class _JuegoOrdenarState extends State<_JuegoOrdenar> {
  late List<String> palabras;

  @override
  void initState() {
    super.initState();
    // Creamos una copia de la lista para poder modificarla localmente
    palabras = List<String>.from(widget.item.opciones);
  }

  // Esta es la lógica mágica que actualiza la lista cuando arrastras
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      // Ajuste necesario en Flutter: si mueves un ítem hacia abajo, 
      // el índice de destino cambia porque el ítem original se "elimina" antes.
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String item = palabras.removeAt(oldIndex);
      palabras.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Arrastra las palabras para formar la frase correcta:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        
        // Usamos Expanded para que la lista ocupe el espacio disponible
        Expanded(
          child: ReorderableListView(
            // Key única para mejorar rendimiento
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onReorder: _onReorder,
            children: [
              for (int index = 0; index < palabras.length; index++)
                Card(
                  // IMPORTANTE: Cada ítem necesita una Key ÚNICA. 
                  // Usamos ValueKey con la palabra (si hay palabras repetidas, 
                  // es mejor usar un ID único o el index concatenado).
                  key: ValueKey('${palabras[index]}_$index'),
                  color: Colors.blue[50],
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text(
                      palabras[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    leading: const Icon(Icons.drag_indicator, color: Colors.grey),
                    // Eliminamos el trailing de borrado para enfocarnos en ordenar
                  ),
                ),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        FilledButton.icon(
          onPressed: () {
            // Unimos las palabras con espacios para enviar la respuesta
            final respuesta = palabras.join(' '); 
            // print("Respuesta enviada: $respuesta"); // Debug
            
            // Tu lógica original:
            // widget.ref.read(diagnosticoProvider.notifier).responder(respuesta);
          },
          icon: const Icon(Icons.check),
          label: const Text('Confirmar Orden'),
        ),
        const SizedBox(height: 20),
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


class _PantallaResultados extends ConsumerWidget {
  final Map<HabilidadCognitiva, int> puntajes;

  const _PantallaResultados({required this.puntajes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Calculamos el puntaje total para mostrar un resumen
    final totalPuntos = puntajes.values.reduce((a, b) => a + b);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // 1. Icono de Celebración
              const Icon(Icons.psychology_alt, size: 80, color: Colors.indigo),
              const SizedBox(height: 16),
              
              // 2. Título
              const Text(
                '¡Diagnóstico Completado!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Has conseguido $totalPuntos puntos en total.\nHemos diseñado una ruta especial para ti.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              
              const SizedBox(height: 30),
              
              // 3. Lista de Habilidades (Resultados)
              Expanded(
                child: ListView(
                  children: puntajes.entries.map((entry) {
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getColor(entry.key).withOpacity(0.1),
                          child: Icon(_getIcon(entry.key), color: _getColor(entry.key)),
                        ),
                        title: Text(
                          _getNombreHabilidad(entry.key),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getColor(entry.key),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${entry.value} pts',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // 4. Botón de Acción
              const SizedBox(height: 20),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF4A148C), // Morado del tema
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => _finalizarDiagnostico(context, ref),
                child: const Text(
                  'Ver mi Ruta de Aprendizaje',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- Lógica para guardar que ya terminó ---
  Future<void> _finalizarDiagnostico(BuildContext context, WidgetRef ref) async {
    final usuario = await ref.read(repoPerfilProvider).getActivo();
    
    if (usuario != null) {
      // USAR EL NUEVO MÉTODO DEL REPOSITORIO
      await ref.read(repoProgresoProvider).actualizarProgresoModulo(
        usuarioId: usuario.id,
        moduloId: 0,   // ID 0 = Diagnóstico
        progreso: 1.0  // 1.0 = 100% completado
      );
    }

    if (context.mounted) {
      Navigator.pop(context); 
    }
  }

  // --- Helpers Visuales ---
  String _getNombreHabilidad(HabilidadCognitiva h) {
    switch (h) {
      case HabilidadCognitiva.atencion: return "Atención";
      case HabilidadCognitiva.memoriaTrabajo: return "Memoria";
      case HabilidadCognitiva.logica: return "Lógica";
      case HabilidadCognitiva.inferencia: return "Inferencia";
    }
  }

  IconData _getIcon(HabilidadCognitiva h) {
    switch (h) {
      case HabilidadCognitiva.atencion: return Icons.visibility;
      case HabilidadCognitiva.memoriaTrabajo: return Icons.memory;
      case HabilidadCognitiva.logica: return Icons.extension; // Pieza de rompecabezas
      case HabilidadCognitiva.inferencia: return Icons.lightbulb;
    }
  }

  Color _getColor(HabilidadCognitiva h) {
    switch (h) {
      case HabilidadCognitiva.atencion: return Colors.blue;
      case HabilidadCognitiva.memoriaTrabajo: return Colors.purple;
      case HabilidadCognitiva.logica: return Colors.teal;
      case HabilidadCognitiva.inferencia: return Colors.orange;
    }
  }
}