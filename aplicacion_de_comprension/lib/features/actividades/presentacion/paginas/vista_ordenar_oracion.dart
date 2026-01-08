import 'package:flutter/material.dart';
import '../../dominio/entidades/actividad.dart';

class VistaOrdenarOracion extends StatefulWidget {
  final Actividad actividad;
  final Function(bool) onFinalizar;

  const VistaOrdenarOracion({super.key, required this.actividad, required this.onFinalizar});

  @override
  State<VistaOrdenarOracion> createState() => _VistaOrdenarOracionState();
}

class _VistaOrdenarOracionState extends State<VistaOrdenarOracion> {
  List<String> bancoPalabras = [];
  List<String> oracionConstruida = [];

  @override
  void initState() {
    super.initState();
    _cargarPalabras();
  }

  String _normalizar(String texto) {
    return texto
        .toLowerCase() // 1. Convertir a minúsculas
        .trim()        // 2. Quitar espacios al inicio y final
        .replaceAll(RegExp(r'[.,;¡!¿?]'), '') // 3. Quitar signos de puntuación comunes
        .replaceAll(RegExp(r'\s+'), ' ');     // 4. Reducir espacios dobles a uno solo (por seguridad)
  }

  void _cargarPalabras() {
    List<String> palabrasIniciales = [];

    // 1. Intentamos leer de 'opciones'
    if (widget.actividad.opciones.isNotEmpty) {
      palabrasIniciales = List.from(widget.actividad.opciones);
    } 
    // 2. Si no, buscamos en 'contenido["desordenada"]'
    else if (widget.actividad.contenido.containsKey('desordenada')) {
      final listaDinamica = widget.actividad.contenido['desordenada'];
      if (listaDinamica is List) {
        palabrasIniciales = listaDinamica.map((e) => e.toString()).toList();
      }
    }

    bancoPalabras = palabrasIniciales;
    bancoPalabras.shuffle(); 
  }

  // Función para reiniciar el estado cuando se equivocan
  void _reiniciarIntento() {
    setState(() {
      // Devolvemos las palabras usadas al banco
      bancoPalabras.addAll(oracionConstruida);
      // Limpiamos la oración construida
      oracionConstruida.clear();
      // Opcional: Volvemos a barajar para que no sea mecánico
      bancoPalabras.shuffle(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Zona de Construcción (Drop Zone visual)
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.shade200, width: 2),
            ),
            child: oracionConstruida.isEmpty 
              ? Center(
                  child: Text(
                    "Arrastra las palabras aquí",
                    style: TextStyle(color: Colors.blue.shade300, fontStyle: FontStyle.italic),
                  ),
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: oracionConstruida.map((palabra) {
                    return ActionChip(
                      label: Text(palabra, style: const TextStyle(fontSize: 18)),
                      backgroundColor: Colors.white,
                      elevation: 2,
                      onPressed: () {
                        setState(() {
                          oracionConstruida.remove(palabra);
                          bancoPalabras.add(palabra);
                        });
                      },
                    );
                  }).toList(),
                ),
          ),
        ),
        
        const SizedBox(height: 20),
        // Usamos color blanco/claro para que se vea en fondo oscuro
        const Text(
          "Toca las palabras para ordenar:", 
          style: TextStyle(color: Colors.white70, fontSize: 16)
        ),
        const SizedBox(height: 10),

        // Banco de palabras
        Expanded(
          flex: 3,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: bancoPalabras.map((palabra) {
              return ActionChip(
                label: Text(palabra, style: const TextStyle(fontSize: 16)),
                backgroundColor: Colors.grey.shade200,
                onPressed: () {
                  setState(() {
                    bancoPalabras.remove(palabra);
                    oracionConstruida.add(palabra);
                  });
                },
              );
            }).toList(),
          ),
        ),

        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          // Solo habilitamos el botón si ya usó todas las palabras
          onPressed: bancoPalabras.isEmpty 
              ? () {
                  final oracionUsuario = _normalizar(oracionConstruida.join(" "));
                  final correcta = _normalizar(widget.actividad.respuestaCorrecta);
                  
                  // Normalizamos quitando signos de puntuación finales si es necesario para comparar
                  // o simplemente comparamos strings
                  final esCorrecta = oracionUsuario.toLowerCase() == correcta.toLowerCase();
                  
                  if (esCorrecta) {
                    widget.onFinalizar(true);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Row(
                          children: [
                            Icon(Icons.error_outline, color: Colors.white),
                            SizedBox(width: 10),
                            Expanded(child: Text("Orden incorrecto. ¡Inténtalo de nuevo!")),
                          ],
                        ),
                        backgroundColor: Colors.red.shade400,
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );

                    // 2. Reiniciar las palabras
                    _reiniciarIntento();
                  }
                } 
              : null, 
          icon: const Icon(Icons.check_circle_outline),
          label: const Text("COMPROBAR", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}