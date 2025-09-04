// lib/features/secciones/presentacion/paginas/introduccion.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../features/usuario/presentacion/controladores/cargar.dart';

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
        title: '✨ Bienvenidos a Aplico ✨',
        text:
            'Aplico es una aplicación educativa creada para fortalecer la comprensión lectora en estudiantes de primaria.',
      ),
      _IntroPage(
        title: 'La lectura',
        text: 'La lectura no solo implica reconocer palabras, sino también comprender y dar sentido a los textos. Para lograrlo, se apoyan cuatro habilidades clave:',
      ),
      _IntroPage(
        title: 'Atención',
        text: 'Mantener el foco en el texto, ignorar distracciones, seleccionar información relevante.',
      ),
      _IntroPage(
        title: 'Memoria de trabajo',
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
        text: 'Cada actividad dentro de la aplicación está diseñada para estimular estas habilidades de manera lúdica e interactiva, promoviendo un aprendizaje significativo y divertido.',
      ),
    ];

    return Scaffold(
      body: SafeArea(
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
                  TextButton(onPressed: _finish, child: const Text('Saltar')),
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
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(text,
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center),
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
                : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
