import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../proveedor_estadisticas.dart'; 
import '../../dominio/entidades/progreso.dart';

class PaginaEstadisticas extends ConsumerWidget {
  const PaginaEstadisticas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadisticasAsync = ref.watch(estadisticasProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Mis Logros", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
      ),
      body: estadisticasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (data) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Tarjeta Principal (Progreso Circular)
                _TarjetaResumenGeneral(
                  progreso: data.progresoGeneral,
                  estrellas: data.totalEstrellas,
                ),
                
                const SizedBox(height: 30),
                const Text(
                  "Progreso por Áreas",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 15),

                // 2. Lista de Barras de Progreso por Módulo
                ...data.modulos.map((modulo) => _ItemProgresoModulo(modulo: modulo)),

                const SizedBox(height: 30),
                
                // 3. (Opcional) Un mensaje motivacional
                if (data.progresoGeneral > 0.5)
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.orange.shade300)
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.emoji_events, color: Colors.orange, size: 40),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            "¡Vas muy bien! Ya has superado la mitad del curso.",
                            style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// --- WIDGETS AUXILIARES ---

class _TarjetaResumenGeneral extends StatelessWidget {
  final double progreso;
  final int estrellas;

  const _TarjetaResumenGeneral({required this.progreso, required this.estrellas});

  @override
  Widget build(BuildContext context) {
    // Convertimos 0.0 - 1.0 a porcentaje entero (0 - 100)
    final porcentajeInt = (progreso * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.deepPurple.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 10))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nivel General",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                "$porcentajeInt%",
                style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      "$estrellas Actividades",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
          // Gráfico circular simple
          SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progreso,
                  strokeWidth: 10,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation(Colors.orangeAccent),
                ),
                Center(
                  child: Icon(
                    progreso == 1.0 ? Icons.check_circle : Icons.trending_up,
                    color: Colors.white,
                    size: 40,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ItemProgresoModulo extends StatelessWidget {
  final ModuloConProgreso modulo;

  const _ItemProgresoModulo({required this.modulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                modulo.nombre,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "${(modulo.porcentaje * 100).toInt()}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: modulo.porcentaje == 1.0 ? Colors.green : Colors.grey
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Barra de progreso personalizada
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: modulo.porcentaje,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              // Cambia de color según el avance: Rojo -> Naranja -> Verde
              valueColor: AlwaysStoppedAnimation(
                modulo.porcentaje < 0.3 ? Colors.redAccent 
                : modulo.porcentaje < 0.7 ? Colors.orangeAccent 
                : Colors.green
              ),
            ),
          ),
        ],
      ),
    );
  }
}