import 'package:aplicacion_de_comprension/features/dashboard/presentacion/paginas/pagina_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../proveedor_intro.dart';
import '../../../tutor/presentacion/paginas/registro.dart';
import '../../../tutor/presentacion/paginas/login.dart';
import '../../../tutor/presentacion/paginas/personajes.dart';
import 'introduccion.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(bootProvider, (previous, next) {
      next.when(
        loading: () {}, 
        error: (err, stack) {
          // Muestra un error si falla la inicialización
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al iniciar: $err')));
        },
        data: (route) {
          // ¡Aquí ocurre la magia de la navegación!
          _navegar(context, route);
        },
      );
    });

    // Mientras tanto, mostramos el diseño visual (Logo, color de fondo, etc)
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Tu color de marca
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tu logo aquí
            const Icon(Icons.school, size: 80, color: Colors.white), 
            const SizedBox(height: 20),
            const Text(
              "APLICO",
              style: TextStyle(
                color: Colors.white, 
                fontSize: 32, 
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 40),
            // Un indicador de carga bonito
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }

  void _navegar(BuildContext context, BootRoute route) {
    // Usamos pushReplacement para que el usuario no pueda volver al Splash con "Atrás"
    final Widget paginaDestino = switch (route) {
      BootRoute.introduccion => const Introduccion(),
      BootRoute.onboarding => const Registro(),
      BootRoute.login => const Login(),
      BootRoute.profiles => const CharacterSelectPage(),
      BootRoute.mainMenu => const DashboardPage(),
    };

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => paginaDestino),
    );
  }
}