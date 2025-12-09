import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../entidades/modelos_json.dart';
import '../../repositorios/repo_contenido_json.dart';
import '../../../../core/widgets/widgets_juegos.dart';
import '../../../../core/widgets/pantalla_carga.dart';
import '../../../../core/providers/proveedor.dart'; // Para repoProgresoProvider y repoPerfilProvider

class ActivityPlayerPage extends ConsumerStatefulWidget {
  final int actividadId;
  const ActivityPlayerPage({super.key, required this.actividadId});

  @override
  ConsumerState<ActivityPlayerPage> createState() => _ActivityPlayerPageState();
}

class _ActivityPlayerPageState extends ConsumerState<ActivityPlayerPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // 1. Cargar la actividad
    final actividadAsync = ref.watch(actividadPorIdProvider(widget.actividadId));

    return actividadAsync.when(
      loading: () => const PantallaCarga(),
      error: (e, _) => Scaffold(body: Center(child: Text("Error: $e"))),
      data: (actividad) {
        return Scaffold(
          appBar: AppBar(
            title: Text(actividad.nombre),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.menu_book), text: "Lectura"),
                Tab(icon: Icon(Icons.videogame_asset), text: "Actividad"),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // PESTAÑA 1: VISOR DE HISTORIA
              _HistoriaViewer(tituloHistoria: actividad.fuenteTexto),
              
              // PESTAÑA 2: JUEGO
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildJuego(actividad),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildJuego(ActividadModelo actividad) {
    switch (actividad.tipo) {
      case TipoActividadJuego.ordenarOracion:
        return JuegoOrdenarOracion(
            actividad: actividad, 
            onTerminar: (ok) => _procesarResultado(ok, actividad.id));
      case TipoActividadJuego.trivia:
        return JuegoTrivia(
            actividad: actividad, 
            onTerminar: (ok) => _procesarResultado(ok, actividad.id));
      default:
        return const Center(child: Text("Juego no configurado"));
    }
  }

  // Importante: Cambia 'void' por 'Future<void>' y agrega 'async'
  Future<void> _procesarResultado(bool acierto, int id) async {
    if (acierto) {
      
      try {
        final usuario = await ref.read(repoPerfilProvider).getActivo();
        
        if (usuario != null) {
          await ref.read(repoProgresoProvider).guardarProgresoActividad(
            usuarioId: usuario.id,
            actividadId: id,
            esAcierto: true,
          );
        }
      } catch (e) {
        debugPrint("Error guardando progreso: $e");
      }
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("¡Correcto!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.star, size: 80, color: Colors.amber),
              SizedBox(height: 10),
              Text("¡Actividad completada!"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
                if (mounted) Navigator.pop(context); 
              },
              child: const Text("Ok"),
            )
          ],
        ),
      );
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Inténtalo de nuevo"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 1),
        )
      );
    }
  }
}

class _HistoriaViewer extends ConsumerWidget {
  final String tituloHistoria;
  const _HistoriaViewer({required this.tituloHistoria});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historiaAsync = ref.watch(historiaDeActividadProvider(tituloHistoria));

    return historiaAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("No se encontró el texto '$tituloHistoria'.\nVerifica el mapa en repo_contenido_json.dart"),
      )),
      data: (capitulos) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: capitulos.length,
          itemBuilder: (context, index) {
            final cap = capitulos[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (cap.titulo.isNotEmpty)
                      Text(cap.titulo, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                    const SizedBox(height: 10),
                    Text(cap.texto, style: const TextStyle(fontSize: 18, height: 1.5)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}