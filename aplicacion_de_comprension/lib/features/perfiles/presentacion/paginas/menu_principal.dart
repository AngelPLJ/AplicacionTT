import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/pantalla_carga.dart'; 
import '../../entidades/menu_provider.dart';
import 'evaluacion_diagnostica.dart';
import '../../../usuario/presentacion/paginas/personajes.dart';
import '../../../../core/proveedor.dart';
import 'pantalla_actividades.dart';

class MainMenuPage extends ConsumerWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuDataAsync = ref.watch(menuDataProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: menuDataAsync.when(
        loading: () => const PantallaCarga(),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (data) => _MenuContent(data: data),
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

          switch (idx) {
            case 0:
              // Ir a Inicio
              break;
            case 1:
              // Ir a Ajustes
              break;
            case 2:
              // Ir a Practicar
              break;
          }
        },
      ),
    );
  }
}

class _MenuContent extends StatelessWidget {
  final MenuData data;
  const _MenuContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Hola, ${data.usuario.nombre}'),
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
                  padding: const EdgeInsets.only(bottom: 40.0), // Espacio para el título
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Avatar desde assets
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset('assets/imagenes/${data.usuario.codigoAvatar}.png'),
                          
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Indicador circular de progreso general
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Nivel General", style: TextStyle(color: Colors.white70)),
                          Text(
                            "${(data.progresoTotal * 100).toInt()}%", 
                            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)
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
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.esNuevoUsuario)
                  _AccionPrincipalCard(
                    titulo: 'Evaluación Diagnóstica',
                    subtitulo: '¡Descubre tus superpoderes mentales!',
                    icono: Icons.rocket_launch,
                    color: Colors.orange,
                    onTap: () => Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (_) => const EvaluacionDiagnosticaPage())
                    ),
                  )
                else
                  // --- AQUÍ ESTÁ EL CAMBIO PARA LA RECOMENDACIÓN ---
                  _AccionPrincipalCard(
                    titulo: data.tituloRecomendacion, // Ej: "Ordena la oración"
                    subtitulo: 'Recomendado: ${data.motivoRecomendacion}', // Ej: "Refuerza tu lógica"
                    icono: Icons.auto_awesome, // Icono de "magia" o recomendación
                    color: Colors.indigoAccent,
                    onTap: () {
                       // Navegamos al Player con el ID calculado
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ActivityPlayerPage(actividadId: data.actividadRecomendadaId)
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),

        // GRID DE MÓDULOS DESDE LA BASE DE DATOS
        if (data.modulos.isEmpty)
           const SliverToBoxAdapter(child: Center(child: Text("Cargando módulos...")))
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
                  return _ModuloCard(
                    nombre: mod.nombre,
                    progreso: mod.porcentaje,
                    // Puedes asignar iconos basados en el ID o nombre
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

  // Helpers visuales sencillos
  IconData _getIconForModule(String nombre) {
    if (nombre.toLowerCase().contains('atención')) return Icons.visibility;
    if (nombre.toLowerCase().contains('memoria')) return Icons.memory;
    if (nombre.toLowerCase().contains('lógica')) return Icons.extension;
    return Icons.menu_book; // Default
  }

  Color _getColorForModule(int index) {
    final colors = [Colors.blue, Colors.purple, Colors.teal, Colors.amber, Colors.redAccent];
    return colors[index % colors.length];
  }
}

// WIDGETS AUXILIARES PARA LIMPIEZA DEL CÓDIGO

class _AccionPrincipalCard extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final IconData icono;
  final Color color;
  final VoidCallback onTap;

  const _AccionPrincipalCard({
    required this.titulo, required this.subtitulo, required this.icono, required this.color, required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                child: Icon(icono, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titulo, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(subtitulo, style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () { /* Navegar al detalle del módulo */ },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 32, color: color),
              const SizedBox(height: 8),
              Text(nombre, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progreso,
                backgroundColor: Colors.grey[300],
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 4),
              Text("${(progreso * 100).toInt()}%", style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}