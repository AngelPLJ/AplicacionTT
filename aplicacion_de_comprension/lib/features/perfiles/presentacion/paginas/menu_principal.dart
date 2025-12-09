import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/pantalla_carga.dart';
import '../../entidades/menu_provider.dart';
import 'evaluacion_diagnostica.dart';
import '../../../usuario/presentacion/paginas/personajes.dart';
import '../../../../core/providers/proveedor.dart';
import '../../entidades/diagnostico_provider.dart';
// Asegúrate de que este archivo contenga la clase ActivityPlayerPage que me pasaste antes
import 'pantalla_actividades.dart'; 

class MainMenuPage extends ConsumerWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuDataAsync = ref.watch(menuDataProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // Usamos RefreshIndicator para permitir recargar arrastrando hacia abajo
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(menuDataProvider),
        child: menuDataAsync.when(
          loading: () => const PantallaCarga(),
          error: (err, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ocurrió un error: $err', textAlign: TextAlign.center),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => ref.refresh(menuDataProvider),
                  child: const Text("Reintentar"),
                )
              ],
            ),
          ),
          data: (data) => _MenuContent(data: data),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 13, 0, 39),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white60,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Practicar'),
          BottomNavigationBarItem(icon: Icon(Icons.exit_to_app_outlined), label: 'Salir'),
        ],
        onTap: (idx) async {
          // --- Lógica de Salida ---
          if (idx == 3) {
            final confirmar = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('¿Cerrar sesión?'),
                content: const Text('Volverás a la pantalla de selección de perfil.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancelar'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Salir'),
                  ),
                ],
              ),
            );

            if (confirmar == true) {
              await ref.read(repoPerfilProvider).cerrarSesion();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const CharacterSelectPage()),
                  (route) => false,
                );
              }
            }
            return;
          }
          // --- Fin Lógica de Salida ---
        },
      ),
    );
  }
}

class _MenuContent extends ConsumerWidget {
  final MenuData data;
  const _MenuContent({required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        // 1. Header con el Progreso
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Hola, ${data.usuario.nombre}',
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF130027), Color(0xFF4A148C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'avatar_${data.usuario.id}',
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset('assets/imagenes/${data.usuario.codigoAvatar}.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Nivel General", style: TextStyle(color: Colors.white70)),
                          Text(
                            "${(data.progresoTotal * 100).toInt()}%",
                            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // 2. Cuerpo del Menú
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // --- BOTÓN INTELIGENTE (Logica actualizada estilo Login) ---
                if (data.esNuevoUsuario)
                  _AccionPrincipalCard(
                    titulo: 'Evaluación Diagnóstica',
                    subtitulo: '¡Descubre tus superpoderes mentales!',
                    icono: Icons.rocket_launch,
                    color: Colors.orange,
                    onTap: () async {
                      // 1. Navegamos y esperamos (await) a que la pantalla se cierre
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const EvaluacionDiagnosticaPage()),
                      );
                      
                      // 2. Al volver, refrescamos el estado
                      ref.refresh(menuDataProvider);
                    },
                  )
                else
                  _AccionPrincipalCard(
                    titulo: data.tituloRecomendacion, 
                    subtitulo: 'Recomendado: ${data.motivoRecomendacion}',
                    icono: Icons.auto_awesome,
                    color: Colors.indigoAccent,
                    onTap: () async {
                      // 1. Navegamos y esperamos (await)
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ActivityPlayerPage(actividadId: data.actividadRecomendadaId),
                        ),
                      );

                      // 2. Al volver, refrescamos el estado
                      // No necesitamos 'if (context.mounted)' aquí porque 'ref' sigue vivo
                      // y no estamos navegando de nuevo, solo actualizando datos.
                      ref.refresh(menuDataProvider);
                    },
                  ),
                // -----------------------------------------------------

                const SizedBox(height: 25),
                const Text('Tus Módulos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),

        // 3. Grid de Módulos
        if (data.modulos.isEmpty)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Center(child: Text("Cargando módulos...")),
            )
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final mod = data.modulos[index];
                  // Filtramos para NO mostrar el módulo de diagnóstico en la lista general
                  // (El ID 0 que definimos anteriormente)
                  if (mod.id == 0) return const SizedBox.shrink();

                  return _ModuloCard(
                    nombre: mod.nombre,
                    progreso: mod.porcentaje,
                    iconData: _getIconForModule(mod.nombre),
                    color: _getColorForModule(index),
                  );
                },
                childCount: data.modulos.length,
              ),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }

  // --- Helpers Visuales ---
  IconData _getIconForModule(String nombre) {
    final n = nombre.toLowerCase();
    if (n.contains('atención')) return Icons.visibility;
    if (n.contains('memoria')) return Icons.memory;
    if (n.contains('lógica')) return Icons.extension;
    if (n.contains('inferencia')) return Icons.lightbulb;
    return Icons.menu_book; 
  }

  Color _getColorForModule(int index) {
    final colors = [Colors.blue, Colors.purple, Colors.teal, Colors.amber, Colors.redAccent];
    return colors[index % colors.length];
  }
}

// --- Widgets Auxiliares ---

class _AccionPrincipalCard extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final IconData icono;
  final Color color;
  final VoidCallback onTap;

  const _AccionPrincipalCard({
    required this.titulo,
    required this.subtitulo,
    required this.icono,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: color.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white24, 
                  shape: BoxShape.circle
                ),
                child: Icon(icono, color: Colors.white, size: 36),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo, 
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitulo, 
                      style: const TextStyle(color: Colors.white70, fontSize: 14)
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 18)
            ],
          ),
        ),
      ),
    );
  }
}

class _ModuloCard extends StatelessWidget {
  final String nombre;
  final double progreso;
  final IconData iconData;
  final Color color;

  const _ModuloCard({
    required this.nombre, required this.progreso, required this.iconData, required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () { 
          // Aquí podrías navegar al detalle de un módulo específico si lo deseas
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 36, color: color),
              const SizedBox(height: 12),
              Text(
                nombre, 
                textAlign: TextAlign.center, 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              LinearProgressIndicator(
                value: progreso,
                backgroundColor: color.withOpacity(0.1),
                color: color,
                minHeight: 6,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${(progreso * 100).toInt()}%", 
                  style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.bold)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

