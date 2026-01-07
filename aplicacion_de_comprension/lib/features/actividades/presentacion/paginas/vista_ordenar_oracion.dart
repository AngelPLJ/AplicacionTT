// lib/features/actividades/presentacion/pantallas/vistas/vista_ordenar_oracion.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dominio/entidades/actividad.dart';
import '../proveedor_actividades.dart';

class VistaOrdenarOracion extends ConsumerStatefulWidget {
  final Actividad actividad;

  const VistaOrdenarOracion({super.key, required this.actividad});

  @override
  ConsumerState<VistaOrdenarOracion> createState() => _VistaOrdenarOracionState();
}

class _VistaOrdenarOracionState extends ConsumerState<VistaOrdenarOracion> {
  // Listas locales para la UI de arrastrar/seleccionar
  late List<String> bancoPalabras;
  List<String> oracionConstruida = [];

  @override
  void initState() {
    super.initState();
    // Copiamos las opciones (que vienen desordenadas en tu JSON) a una lista mutable
    bancoPalabras = List.from(widget.actividad.opciones);
  }

  void _moverPalabra(String palabra, {required bool haciaOracion}) {
    setState(() {
      if (haciaOracion) {
        bancoPalabras.remove(palabra);
        oracionConstruida.add(palabra);
      } else {
        oracionConstruida.remove(palabra);
        bancoPalabras.add(palabra);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final estado = ref.watch(actividadControllerProvider(widget.actividad));
    final controlador = ref.read(actividadControllerProvider(widget.actividad).notifier);

    return Column(
      children: [
        // 1. Área de Construcción (Donde aparecen las palabras ordenadas)
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
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: oracionConstruida.map((palabra) {
                return ActionChip(
                  label: Text(palabra, style: const TextStyle(fontSize: 18)),
                  backgroundColor: Colors.white,
                  onPressed: estado.completado 
                    ? null 
                    : () => _moverPalabra(palabra, haciaOracion: false),
                );
              }).toList(),
            ),
          ),
        ),

        const SizedBox(height: 20),
        const Text("Toca las palabras para ordenar:"),
        const SizedBox(height: 10),

        // 2. Banco de Palabras (Las desordenadas)
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
                onPressed: estado.completado 
                  ? null 
                  : () => _moverPalabra(palabra, haciaOracion: true),
              );
            }).toList(),
          ),
        ),

        // 3. Botón de Validar (Solo aparece si ya usó todas las palabras)
        if (!estado.completado)
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            onPressed: bancoPalabras.isEmpty 
                ? () {
                    // Unimos las palabras con espacios para comparar con la "solucion" string
                    final respuestaString = oracionConstruida.join(" ");
                    controlador.verificarRespuesta(respuestaString);
                  }
                : null, // Deshabilitado si faltan palabras
            icon: const Icon(Icons.check_circle),
            label: const Text("COMPROBAR"),
          ),
      ],
    );
  }
}