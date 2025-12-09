import 'package:flutter/material.dart';
import '../../features/perfiles/entidades/modelos_json.dart';

// WIDGET 1: ORDENAR ORACIÓN
class JuegoOrdenarOracion extends StatefulWidget {
  final ActividadModelo actividad;
  final Function(bool) onTerminar;

  const JuegoOrdenarOracion({super.key, required this.actividad, required this.onTerminar});

  @override
  State<JuegoOrdenarOracion> createState() => _JuegoOrdenarOracionState();
}

class _JuegoOrdenarOracionState extends State<JuegoOrdenarOracion> {
  late List<String> palabrasDisponibles;
  late List<String> oracionArmada;
  late String solucion;

  @override
  void initState() {
    super.initState();
    final contenido = widget.actividad.contenido;
    // Creamos una copia de la lista para poder modificarla
    palabrasDisponibles = List<String>.from(contenido['oracion_desordenada']);
    palabrasDisponibles.shuffle(); 
    oracionArmada = [];
    solucion = contenido['solucion'];
  }

  void _validar() {
    String armada = oracionArmada.join(" ").toLowerCase().replaceAll('.', '');
    String correcta = solucion.toLowerCase().replaceAll('.', '');
    
    bool esCorrecto = armada.trim() == correcta.trim();
    widget.onTerminar(esCorrecto);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Toca las palabras en el orden correcto:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        
        // --- ZONA DE LA ORACIÓN ARMADA ---
        Container(
          width: double.infinity,
          // Agregamos altura mínima para que se vea el recuadro aunque esté vacío
          constraints: const BoxConstraints(minHeight: 100), 
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, offset: const Offset(0, 3))
            ]
          ),
          child: oracionArmada.isEmpty 
            ? const Center(child: Text("Las palabras aparecerán aquí...", style: TextStyle(color: Colors.grey)))
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: oracionArmada.map((p) => ActionChip(
                  avatar: const Icon(Icons.remove_circle_outline, size: 16),
                  label: Text(p, style: const TextStyle(fontSize: 16)),
                  backgroundColor: Colors.blue.shade100,
                  onPressed: () {
                    setState(() {
                      oracionArmada.remove(p);
                      palabrasDisponibles.add(p);
                    });
                  },
                )).toList(),
              ),
        ),

        const Divider(height: 30, thickness: 1),
        const Text("Palabras disponibles:"),
        const SizedBox(height: 10),

        // --- ZONA DE PALABRAS DISPONIBLES ---
        Expanded( // Usamos Expanded para que ocupe el espacio restante si hay muchas palabras
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: palabrasDisponibles.map((p) => ActionChip( // <--- CAMBIO AQUÍ: ActionChip
                label: Text(p, style: const TextStyle(fontSize: 16)),
                elevation: 2,
                backgroundColor: Colors.grey.shade200,
                // ActionChip usa 'onPressed', no 'onSelected'. Es más directo.
                onPressed: () { 
                  setState(() {
                    palabrasDisponibles.remove(p);
                    oracionArmada.add(p);
                  });
                },
              )).toList(),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              // Deshabilitar botón si no ha usado todas las palabras
              onPressed: palabrasDisponibles.isEmpty ? _validar : null,
              icon: const Icon(Icons.check_circle),
              label: const Text("Comprobar Respuesta", style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ],
    );
  }
}

// WIDGET 2: TRIVIA / INFERENCIA
class JuegoTrivia extends StatelessWidget {
  final ActividadModelo actividad;
  final Function(bool) onTerminar;

  const JuegoTrivia({super.key, required this.actividad, required this.onTerminar});

  @override
  Widget build(BuildContext context) {
    final contenido = actividad.contenido;
    final String? fragmento = contenido['fragmento_contexto'];
    final String pregunta = contenido['pregunta'];
    final List<dynamic> opciones = contenido['opciones'];
    final String correcta = contenido['respuesta_correcta'];

    return Column(
      children: [
        if (fragmento != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Text(fragmento, style: const TextStyle(fontStyle: FontStyle.italic)),
          ),
          const SizedBox(height: 10),
        ],
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            pregunta,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white, // <--- Aquí cambiamos el color a blanco
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        ...opciones.map((opc) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
              onPressed: () {
                bool acerto = opc == correcta;
                onTerminar(acerto);
              },
              child: Text(opc.toString()),
            ),
          ),
        )),
        const Spacer(),
      ],
    );
  }
}