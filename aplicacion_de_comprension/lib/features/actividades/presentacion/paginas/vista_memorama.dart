// lib/features/evaluacion/presentacion/pantallas/vistas/vista_memorama.dart
import 'package:flutter/material.dart';
import '../../dominio/entidades/actividad.dart';

class VistaMemorama extends StatefulWidget {
  final Actividad actividad;
  final Function(bool) onFinalizar;

  const VistaMemorama({super.key, required this.actividad, required this.onFinalizar});

  @override
  State<VistaMemorama> createState() => _VistaMemoramaState();
}

class _VistaMemoramaState extends State<VistaMemorama> {
  List<String> cartas = [];
  List<bool> volteadas = [];
  List<bool> solucionadas = [];
  int? primerIndice;
  bool bloqueado = false;

  @override
  void initState() {
    super.initState();
    _prepararJuego();
  }

  void _prepararJuego() {
    List<String> itemsBase = [];
    
    // Intentamos sacar los pares del contenido o de las opciones
    if (widget.actividad.contenido.containsKey('pares')) {
       itemsBase = List<String>.from(widget.actividad.contenido['pares']);
    } else if (widget.actividad.opciones.isNotEmpty) {
       itemsBase = widget.actividad.opciones;
    } else {
       itemsBase = ["A", "B", "C"]; // Fallback
    }

    // Duplicamos y barajamos
    cartas = [...itemsBase, ...itemsBase];
    cartas.shuffle();

    volteadas = List.filled(cartas.length, false);
    solucionadas = List.filled(cartas.length, false);
  }

  void _onCartaTap(int index) {
    if (bloqueado || volteadas[index] || solucionadas[index]) return;

    setState(() {
      volteadas[index] = true;
    });

    if (primerIndice == null) {
      // Primera carta
      primerIndice = index;
    } else {
      // Segunda carta
      final index1 = primerIndice!;
      final index2 = index;
      bloqueado = true;

      if (cartas[index1] == cartas[index2]) {
        // Coincidencia
        solucionadas[index1] = true;
        solucionadas[index2] = true;
        primerIndice = null;
        bloqueado = false;
        _verificarVictoria();
      } else {
        // Error
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            setState(() {
              volteadas[index1] = false;
              volteadas[index2] = false;
              primerIndice = null;
              bloqueado = false;
            });
          }
        });
      }
    }
  }

  void _verificarVictoria() {
    if (solucionadas.every((s) => s)) {
      widget.onFinalizar(true); // Siempre es acierto si lo termina
    }
  }

  @override
  Widget build(BuildContext context) {
    final anchoPantalla = MediaQuery.of(context).size.width;
    
    int columnas = anchoPantalla > 600 ? 6 : 3;

    if (cartas.length < columnas) {
      columnas = cartas.length; 
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnas,
            crossAxisSpacing: 12,    
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,   
          ),
          itemCount: cartas.length,
          itemBuilder: (context, index) {
            final estaVisible = volteadas[index] || solucionadas[index];
            return GestureDetector(
              onTap: () => _onCartaTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: estaVisible ? Colors.white : Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    )
                  ],
                  border: Border.all(color: Colors.indigo.shade200, width: 2),
                ),
                child: Center(
                  child: estaVisible
                      ? FittedBox( // FittedBox ayuda a que el texto se ajuste si la carta es pequeña
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              cartas[index],
                              style: const TextStyle(
                                fontSize: 24, // Aumenté un poco la fuente base
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo, // Texto color indigo para contraste
                              ),
                            ),
                          ),
                        )
                      : const Icon(Icons.help_outline, color: Colors.white, size: 32),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}