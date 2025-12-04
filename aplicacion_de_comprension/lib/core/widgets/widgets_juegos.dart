import 'package:flutter/material.dart';
import '../../features/perfiles/entidades/modelos_json.dart';

// WIDGET 1: ORDENAR ORACIÓN
class JuegoOrdenarOracion extends StatefulWidget {
  final ActividadModelo actividad;
  final Function(bool) onTerminar; // Callback para reportar resultado

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
    palabrasDisponibles = List<String>.from(contenido['oracion_desordenada']);
    palabrasDisponibles.shuffle(); // Mezclar
    oracionArmada = [];
    solucion = contenido['solucion'];
  }

  void _validar() {
    // Normalizamos quitando puntos y mayúsculas para comparar fácil
    String armada = oracionArmada.join(" ").toLowerCase().replaceAll('.', '');
    String correcta = solucion.toLowerCase().replaceAll('.', '');
    
    bool esCorrecto = armada == correcta;
    widget.onTerminar(esCorrecto);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Toca las palabras en orden:", style: TextStyle(fontSize: 18)),
        ),
        
        // Zona de la oración armada
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Wrap(
            spacing: 8,
            children: oracionArmada.map((p) => ActionChip(
              label: Text(p),
              onPressed: () {
                setState(() {
                  oracionArmada.remove(p);
                  palabrasDisponibles.add(p);
                });
              },
            )).toList(),
          ),
        ),

        const Divider(),

        // Zona de palabras disponibles
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: palabrasDisponibles.map((p) => FilterChip(
            label: Text(p),
            onSelected: (_) {
              setState(() {
                palabrasDisponibles.remove(p);
                oracionArmada.add(p);
              });
            },
          )).toList(),
        ),

        const Spacer(),
        FilledButton(
          onPressed: palabrasDisponibles.isEmpty ? _validar : null,
          child: const Text("Comprobar"),
        ),
        const SizedBox(height: 20),
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
          child: Text(pregunta, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
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