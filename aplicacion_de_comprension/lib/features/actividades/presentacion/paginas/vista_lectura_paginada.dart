import 'package:flutter/material.dart';
import '../../dominio/entidades/actividad.dart';
import 'vista_seleccion_multiple.dart';

class VistaLecturaPaginada extends StatefulWidget {
  final String tituloHistoria;
  final String textoHistoria;
  final List<Actividad> preguntas;
  
  // CAMBIO CLAVE: Ya no recibimos paginaInicial ni onResponder simple.
  // Recibimos un callback que devuelve TODAS las respuestas al final.
  final Function(Map<int, bool>) onLecturaTerminada;

  const VistaLecturaPaginada({
    super.key,
    required this.tituloHistoria,
    required this.textoHistoria,
    required this.preguntas,
    required this.onLecturaTerminada,
  });

  @override
  State<VistaLecturaPaginada> createState() => _VistaLecturaPaginadaState();
}

class _VistaLecturaPaginadaState extends State<VistaLecturaPaginada> {
  late PageController _pageController;
  int _paginaActual = 0; 
  final Map<int, bool> _respuestasLocales = {};
  final Set<int> _preguntasRespondidasIds = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _registrarRespuestaInterna(int idPregunta, bool esCorrecta) {
    if (_preguntasRespondidasIds.contains(idPregunta)) return;

    setState(() {
      _respuestasLocales[idPregunta] = esCorrecta;
      _preguntasRespondidasIds.add(idPregunta);
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (_paginaActual < widget.preguntas.length) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _finalizarLectura();
      }
    });
  }

  void _finalizarLectura() {
    widget.onLecturaTerminada(_respuestasLocales);
  }

  @override
  Widget build(BuildContext context) {
    // Total de páginas = 1 (Texto) + N (Preguntas)
    final totalPaginas = 1 + widget.preguntas.length;

    return Column(
      children: [
        // Barra de navegación superior
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.grey.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_paginaActual > 0)
                TextButton.icon(
                  onPressed: () => _pageController.animateToPage(
                    0, 
                    duration: const Duration(milliseconds: 500), 
                    curve: Curves.easeInOut
                  ),
                  icon: const Icon(Icons.import_contacts, size: 20),
                  label: const Text("Ver Texto"),
                )
              else
                const SizedBox(width: 100),
                
              Text(
                _paginaActual == 0 
                    ? "Lectura" 
                    : "Pregunta $_paginaActual de ${widget.preguntas.length}",
                style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            // Usamos Bouncing para dar feedback, pero el avance principal es automático al responder
            physics: const BouncingScrollPhysics(),
            onPageChanged: (idx) {
              setState(() => _paginaActual = idx);
            },
            itemCount: totalPaginas,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _PaginaTexto(
                  titulo: widget.tituloHistoria, 
                  texto: widget.textoHistoria
                );
              } else {
                // index 1 del PageView = pregunta 0 de la lista
                final pregunta = widget.preguntas[index - 1];
                
                return _PaginaPregunta(
                  actividad: pregunta,
                  onResponder: (esCorrecta) => _registrarRespuestaInterna(pregunta.id, esCorrecta),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class _PaginaTexto extends StatelessWidget {
  final String titulo;
  final String texto;
  const _PaginaTexto({required this.titulo, required this.texto});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(titulo, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 5))],
              border: Border.all(color: Colors.orange.shade100),
            ),
            child: Text(
              texto.isEmpty ? "Texto no disponible." : texto,
              style: const TextStyle(fontSize: 18, height: 1.6, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 50), 
          // Indicador visual para deslizar
          const Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text("Desliza para comenzar", style: TextStyle(color: Colors.grey)),
               Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey)
             ],
          )
        ],
      ),
    );
  }
}

class _PaginaPregunta extends StatelessWidget {
  final Actividad actividad;
  final Function(bool) onResponder; 

  const _PaginaPregunta({required this.actividad, required this.onResponder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            actividad.contenido['pregunta'] ?? actividad.instruccion,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.indigo),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: VistaSeleccionMultiple(
              actividad: actividad,
              onFinalizar: onResponder,
            ),
          ),
        ],
      ),
    );
  }
}