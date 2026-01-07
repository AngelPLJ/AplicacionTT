import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dominio/entidades/dashboard.dart';
import '../proveedor_dashboard.dart';
import '../../../actividades/presentacion/paginas/pagina_actividades.dart';
import '../../../actividades/presentacion/proveedor_actividades.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  void _navegarAActividad(BuildContext context, int actividadId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaDetalleActividad(actividadId: actividadId),
      ),
    ).then((_) {
      // Aquí podrías refrescar el estado del dashboard si es necesario

    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardInfoProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: dashboardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (data) {
          if (data == null) {
            return const Center(child: Text("No hay usuario activo seleccionado"));
          }
          return _DashboardContent(
            data: data,
            // Pasamos las funciones de acción hacia abajo
            onIniciarDiagnostico: () async {
              // Lógica: Buscar la actividad #1 o la recomendada
              final actividad = await ref.read(siguienteActividadProvider.future);
              if (actividad != null && context.mounted) {
                _navegarAActividad(context, actividad.id);
              } else {
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text("No hay actividades disponibles"))
                 );
              }
            },
            onModuloTap: (moduloId) {
              // Aquí podrías navegar a una lista de actividades de ese módulo
              print("Navegar al módulo $moduloId");
            },
          );
        },
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final MenuData data;
  final VoidCallback onIniciarDiagnostico; 
  final Function(int) onModuloTap;         

  const _DashboardContent({
    required this.data,
    required this.onIniciarDiagnostico,
    required this.onModuloTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 190.0,
          pinned: true,
          backgroundColor: Colors.deepPurple,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Hola, ${data.usuario}"),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      // Aquí cargarías la imagen real o asset según tu lógica
                      child: Image(
                        image: AssetImage('assets/imagenes/${data.usuarioAvatar}.png'),
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Progreso Global: ${(data.progresoTotal * 100).toInt()}%",
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

        // 2. Sección Principal (Diagnóstico o Recomendación)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.necesitaDiagnostico)
                  _BotonDiagnostico(onPressed: onIniciarDiagnostico)
                else
                  _TarjetaRecomendacion(onPressed: onIniciarDiagnostico),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange),
                        SizedBox(width: 10),
                        Expanded(child: Text("¡Sigue practicando! Tu cerebro está creciendo.")),
                      ],
                    ),
                  ),
                
                const SizedBox(height: 20),
                const Text(
                  "Tus Módulos",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),

        // 3. Grid de Módulos
        if (data.modulos.isEmpty)
          const SliverToBoxAdapter(
            child: Center(child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("No hay módulos disponibles aún."),
            )),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final modulo = data.modulos[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.book, size: 30, color: Colors.deepPurple.shade300),
                          const SizedBox(height: 8),
                          Text(
                            modulo.nombre,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          LinearProgressIndicator(
                            value: modulo.porcentaje,
                            backgroundColor: Colors.grey.shade200,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${(modulo.porcentaje * 100).toInt()}%",
                            style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: data.modulos.length,
              ),
            ),
          ),
          
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }
}

class _BotonDiagnostico extends StatelessWidget {
  final VoidCallback onPressed;
  const _BotonDiagnostico({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.orange.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.rocket_launch, color: Colors.white, size: 30),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Comenzar Diagnóstico",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Descubre tu nivel inicial",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TarjetaRecomendacion extends StatelessWidget {
  final VoidCallback onPressed;

  const _TarjetaRecomendacion({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.orange, size: 30),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("¡Sigue practicando!", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Tu próxima actividad está lista."),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
            ),
            onPressed: onPressed, // Llama a la misma lógica de "Siguiente Actividad"
            child: const Icon(Icons.play_arrow),
          )
        ],
      ),
    );
  }
}