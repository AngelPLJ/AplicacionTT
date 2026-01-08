// lib/features/evaluacion/presentacion/pantallas/vistas/vista_encuentra_letra.dart
import 'package:flutter/material.dart';
import '../../dominio/entidades/actividad.dart';

class VistaEncuentraLetra extends StatelessWidget {
  final Actividad actividad;
  final Function(bool) onFinalizar;

  const VistaEncuentraLetra({super.key, required this.actividad, required this.onFinalizar});

  @override
  Widget build(BuildContext context) {
    // 1. Extraer datos del mapa de contenido de forma segura
    final contenido = actividad.contenido;
    String rawGrid = "";
    
    if (contenido.containsKey('cuadricula')) {
      rawGrid = contenido['cuadricula'].toString();
    } else {
      // Fallback por si acaso
      rawGrid = "XXXXOXXXX"; 
    }

    // Limpiamos saltos de línea y creamos lista de caracteres
    final List<String> items = rawGrid.replaceAll('\n', '').split('');

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
            // Calculamos columnas basado en longitud (raíz cuadrada aproximada)
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, 
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final letra = items[index];
              return GestureDetector(
                onTap: () {
                  // Validamos contra la respuesta correcta
                  final esCorrecta = letra == actividad.respuestaCorrecta;
                  onFinalizar(esCorrecta);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: const Offset(2,2))]
                  ),
                  child: Center(
                    child: Text(
                      letra,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo.shade900),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}