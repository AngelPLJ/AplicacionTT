import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/tts_helper.dart';
import '../../dominio/entidades/actividad.dart';

class VistaAudioSeleccion extends ConsumerStatefulWidget {
  final Actividad actividad;
  final Function(bool) onFinalizar;

  const VistaAudioSeleccion({
    super.key, 
    required this.actividad, 
    required this.onFinalizar
  });

  @override
  ConsumerState<VistaAudioSeleccion> createState() => _VistaAudioSeleccionState();
}

class _VistaAudioSeleccionState extends ConsumerState<VistaAudioSeleccion> {
  bool _reproduciendo = false;
  
  // 1. Declaramos la variable local para guardar la referencia al helper
  late TtsHelper _ttsHelper; 

  @override
  void initState() {
    super.initState();
    // 2. Capturamos la instancia mientras el widget está vivo
    _ttsHelper = ref.read(ttsHelperProvider);
  }

  Future<void> _reproducirSonido() async {
    if (_reproduciendo) return;
    setState(() => _reproduciendo = true);

    String textoHablar = "";
    if (widget.actividad.contenido.containsKey('audio_texto')) {
        textoHablar = widget.actividad.contenido['audio_texto'];
    } 
    else if (widget.actividad.contenido.containsKey('fonema')) {
        textoHablar = widget.actividad.contenido['fonema'];
    }
    else {
        textoHablar = widget.actividad.respuestaCorrecta; 
    }

    // Aquí puedes usar ref.read o _ttsHelper, ambos funcionan porque el widget está montado
    await _ttsHelper.decirPalabra(textoHablar);
    
    if (mounted) {
      setState(() => _reproduciendo = false);
    }
  }

  @override
  void dispose() {
    // 3. CORRECCIÓN: Usamos la variable local en lugar de ref.read()
    // Esto evita el error "Bad state: Cannot use ref after the widget was disposed"
    _ttsHelper.detener(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        GestureDetector(
          onTap: _reproducirSonido,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: _reproduciendo ? Colors.orange.shade300 : Colors.orange,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.orange.withOpacity(0.4), blurRadius: 20, spreadRadius: 5)
              ]
            ),
            child: Icon(
              _reproduciendo ? Icons.volume_up : Icons.play_arrow_rounded,
              color: Colors.white, 
              size: 60
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text("Toca para escuchar", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 40),
        
        Expanded(
          child: ListView.separated(
            itemCount: widget.actividad.opciones.length,
            separatorBuilder: (_,__) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final opcion = widget.actividad.opciones[index];
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  side: BorderSide(color: Colors.deepPurple.shade100),
                ),
                onPressed: () {
                  final esCorrecta = opcion.toLowerCase() == widget.actividad.respuestaCorrecta.toLowerCase();
                  widget.onFinalizar(esCorrecta);
                },
                child: Text(opcion, style: const TextStyle(fontSize: 18)),
              );
            },
          ),
        )
      ],
    );
  }
}