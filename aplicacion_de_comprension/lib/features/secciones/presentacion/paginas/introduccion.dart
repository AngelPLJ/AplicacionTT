// lib/features/secciones/presentacion/paginas/introduccion.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/cargar_pantallas.dart';

class Introduccion extends ConsumerStatefulWidget {
  const Introduccion({super.key});

  @override
  ConsumerState<Introduccion> createState() => _IntroduccionState();
}

class _IntroduccionState extends ConsumerState<Introduccion> {
  final _controller = PageController();
  int _page = 0;

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kOnboardingSeenKey, true);

    // Forzamos que bootProvider se vuelva a calcular
    ref.invalidate(bootProvider);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = const [
      _IntroPage(
        title: 'Bienvenid@',
        text:
            'Aplico es una aplicación educativa creada para fortalecer la comprensión lectora en estudiantes de primaria.',
      ),
      _IntroPage(
        title: 'La lectura',
        text: 'La lectura no solo implica reconocer palabras, sino también dar sentido a los textos. Para lograrlo, se utilizan cuatro habilidades clave:',
      ),
      _IntroPage(
        title: 'Atención',
        text: 'Mantener el foco en el texto, ignorar distracciones, seleccionar información relevante.',
      ),
      _IntroPage(
        title: 'Memoria',
        text: 'Retener e integrar información leída para construir significado en tiempo real.',
      ),
      _IntroPage(
        title: 'Lógica',
        text: 'Ordenar ideas, identificar relaciones causa-efecto, seguir secuencias narrativas.',
      ),
      _IntroPage(
        title: 'Y la inferencia',
        text: 'Deducir significados no explícitos, anticipar contenidos y activar conocimientos previos.',
      ),
      _IntroPage(
        title: 'Diviertete',
        text: 'Cada actividad dentro de la aplicación está diseñada para estimular estas habilidades esperamos que la disfrutes.',
      ),
    ];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 22, 28),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/imagenes/fondoIntro.jpg'),
                    fit: BoxFit.cover,
                    alignment: Alignment(0.35, 0),
                  ),
                ),
              ),
              Positioned(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: pages.length,
                        onPageChanged: (i) => setState(() => _page = i),
                        itemBuilder: (_, i) => pages[i],
                      ),
                    ),
                    _Dots(count: pages.length, index: _page),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          const Spacer(),
                          FilledButton(
                            onPressed: () {
                              if (_page == pages.length - 1) {
                                _finish();
                              } else {
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut,
                                );
                              }
                            },
                            child: Text(_page == pages.length - 1 ? 'Comenzar' : 'Siguiente'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class _IntroPage extends StatelessWidget {
  final String title;
  final String text;
  const _IntroPage({
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Text(title,
              style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text(text,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int count;
  final int index;
  const _Dots({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          width: i == index ? 16 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: i == index
                ? Theme.of(context).colorScheme.primary
                : const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class Triangulo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // El 'size' viene del widget CustomPaint.
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final Offset center = Offset(centerX, centerY);
    final double radius = size.width / 2;

    // --- El Pincel para la cara (relleno amarillo) ---
    final paintCara = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    // Dibujamos el círculo de la cara
    canvas.drawCircle(center, radius, paintCara);
    
    // --- El Pincel para los ojos y la boca (contorno negro) ---
    final paintDetalles = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Dibujamos el ojo izquierdo
    canvas.drawCircle(Offset(centerX - radius / 2, centerY - radius / 2.5), radius/4, paintDetalles);

    // Dibujamos el ojo derecho
    canvas.drawCircle(Offset(centerX + radius / 2, centerY - radius / 2.5), radius/4, paintDetalles);

    // Dibujamos la boca (un arco)
    final pathBoca = Path();
    // Movemos el "lápiz" al inicio de la sonrisa
    pathBoca.moveTo(centerX - radius / 2, centerY + radius / 4);
    // Dibujamos una curva de Bézier cuadrática para la sonrisa
    pathBoca.quadraticBezierTo(
        centerX, // Punto de control X
        centerY + radius / 1.5, // Punto de control Y
        centerX + radius / 2, // Punto final X
        centerY + radius / 4); // Punto final Y
        
    canvas.drawPath(pathBoca, paintDetalles);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // En este caso, el dibujo no cambia, así que devolvemos false.
    return false;
  }
}