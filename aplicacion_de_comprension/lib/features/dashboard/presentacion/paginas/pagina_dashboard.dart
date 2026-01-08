import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dominio/entidades/dashboard.dart';
import '../proveedor_dashboard.dart';
import '../../../../core/utils/fondo_geometrico.dart';
import '../../../actividades/presentacion/paginas/pagina_actividades.dart';
import '../../../actividades/presentacion/proveedor_actividades.dart';
import '../../../actividades/presentacion/paginas/pagina_evaluacion_diagnostica.dart';
import '../../../tutor/presentacion/proveedor_tutor.dart';
import '../../../introduccion/presentacion/proveedor_intro.dart';
import '../../../introduccion/presentacion/paginas/pantalla_carga.dart';

import '../widgets/header_dashboard.dart';
import '../widgets/boton_diagnostico.dart';
import '../widgets/boton_play_gigante.dart';

import 'pagina_estadisticas.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  void _navegarADiagnostico(BuildContext context, WidgetRef ref) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaEvaluacionDiagnostica(),
      ),
    ).then((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      ref.invalidate(dashboardInfoProvider);
    });
  }

  void _navegarAActividad(BuildContext context, int actividadId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PantallaDetalleActividad(actividadId: actividadId)),
    );
  }

  Future<void> _gestionarTapModulo(BuildContext context, WidgetRef ref, int moduloId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator())
    );

    try {
      final actividad = await ref.read(recomendacionPorModuloProvider(moduloId).future);
      if (context.mounted) Navigator.pop(context);

      if (actividad != null && context.mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PantallaDetalleActividad(actividadId: actividad.id)),
        );
        ref.invalidate(dashboardInfoProvider);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No hay actividades disponibles para este módulo aún.")),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.pop(context);
    }
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
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  ref.invalidate(bootProvider);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SplashScreen()),
                    (route) => false,
                  );
                },
                child: const Text("Volver al Inicio")
              ),
            );
          }

          return _DashboardContent(
            data: data,
            onCerrarSesion: () async {
              await ref.read(repoPerfilProvider).cerrarSesion();
              ref.invalidate(bootProvider);
              ref.invalidate(dashboardInfoProvider);
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                  (route) => false,
                );
              }
            },
            // Lógica principal del botón grande (Diagnóstico inicial o Play)
            onIniciarDiagnostico: () async {
              if (data.necesitaDiagnostico) {
                _navegarADiagnostico(context, ref);
              } else {
                final actividad = await ref.read(siguienteActividadProvider.future);
                if (actividad != null && context.mounted) {
                  _navegarAActividad(context, actividad.id);
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("¡Felicidades! No hay actividades pendientes.")),
                  );
                }
              }
            },
            // NUEVO: Pasamos la función para forzar el diagnóstico nuevamente
            onRetomarDiagnostico: () => _navegarADiagnostico(context, ref), // <--- NUEVO
            onModuloTap: (moduloId) => _gestionarTapModulo(context, ref, moduloId),
          );
        },
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final MenuData data;
  final VoidCallback onIniciarDiagnostico;
  final VoidCallback onRetomarDiagnostico; // <--- NUEVO: Declaramos el callback
  final Function(int) onModuloTap;
  final VoidCallback onCerrarSesion;

  const _DashboardContent({
    required this.data,
    required this.onIniciarDiagnostico,
    required this.onRetomarDiagnostico, // <--- NUEVO: Requerido en constructor
    required this.onModuloTap,
    required this.onCerrarSesion,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(painter: FondoGeometricoPainter()),
        ),
        Column(
          children: [
            DashboardHeader(
              data: data, 
              onCerrarSesion: onCerrarSesion,
              // Agregamos la navegación
              onVerEstadisticas: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaginaEstadisticas())
                );
              },
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: data.necesitaDiagnostico
                    ? BotonDiagnostico(onPressed: onIniciarDiagnostico)
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "ACTIVIDAD RECOMENDADA",
                            style: TextStyle(
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          BotonPlayGigante(onPressed: onIniciarDiagnostico),
                          
                          const SizedBox(height: 20),
                          Text(
                            "¡Aprende jugando!",
                            style: TextStyle(
                              color: Colors.deepPurple.shade300,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          
                          const SizedBox(height: 40), 

                          BotonDiagnostico(
                            onPressed: onRetomarDiagnostico,
                            titulo: "Volver a realizar diagnóstico",
                            subtitulo: "Actualiza tu nivel de progreso",
                          ),
                        ],
                      ),
                )
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          ],
        ),
      ],
    );
  }
}