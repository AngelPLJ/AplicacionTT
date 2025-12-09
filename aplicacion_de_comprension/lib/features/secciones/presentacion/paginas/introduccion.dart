// lib/features/secciones/presentacion/datosIntroduccion/introduccion.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/paginas_introduccion.dart';
import '../widgets/puntos_de_pagina.dart';
import '../../repositorios/modelo_introduccion.dart';
import '../../../../core/providers/cargar_pantallas.dart';

class Introduccion extends ConsumerStatefulWidget {
  const Introduccion({super.key});

  @override
  ConsumerState<Introduccion> createState() => _IntroduccionState();
}

class _IntroduccionState extends ConsumerState<Introduccion> {
  final _controller = PageController();
  int _pagina = 0;

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
                        itemCount: datosIntroduccion.length,
                        onPageChanged: (i) => setState(() => _pagina = i),
                        itemBuilder: (_, i) {
                          final datos = datosIntroduccion[i];
                          return PaginaIntroduccion(datos: datos);
                        },
                      ),
                    ),
                    PuntosDePagina(count: datosIntroduccion.length, index: _pagina),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          const Spacer(),
                          FilledButton(
                            onPressed: () {
                              if (_pagina == datosIntroduccion.length - 1) {
                                _finish();
                              } else {
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut,
                                );
                              }
                            },
                            child: Text(_pagina == datosIntroduccion.length - 1 ? 'Comenzar' : 'Siguiente'),
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

