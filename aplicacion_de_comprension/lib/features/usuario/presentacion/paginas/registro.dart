// lib/features/usuario/presentacion/paginas/register_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controladores/contautenticacion.dart';
import '../estados/autenticacion.dart';

class Registro extends ConsumerWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: switch (authState) {
        AuthLoading() => const Center(child: CircularProgressIndicator()),
        AuthError(message: final m) => _Form(errorText: m),
        AuthAuthenticated() => const Center(child: Text('¡Cuenta creada!')),
        _ => const _Form(),
      },
    );
  }
}

class _Form extends ConsumerStatefulWidget {
  final String? errorText;
  const _Form({this.errorText});
  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final nombreCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 
    Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imagenes/valentina-remenar-make-a-wish-by-valentina-remenar.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment(0.3, 0),
            ),
          ),
        ),
        Center(
          child: Padding(
          padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              mainAxisAlignment: MainAxisAlignment.center, 
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              if (widget.errorText != null)
                Text(widget.errorText!, style: const TextStyle(color: Colors.red)),
              Padding(padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: TextField(
                  controller: nombreCtrl, 
                  style: const TextStyle(
                    fontSize: 25,
                    fontFamily: 'Roboto', // Fuente monoespaciada para mejor apariencia
                    fontWeight: FontWeight.bold                
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: TextStyle(
                      fontFamily: 'Roboto',
                      letterSpacing: 0, // Restablecer el espaciado para la etiqueta
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 182, 220, 225),
                  ),
                ),
              ),

              Padding(padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: TextField(
                  controller: passCtrl, 
                  style: const TextStyle(
                    fontSize: 25,
                    letterSpacing: 8, // Espaciado entre caracteres para simular un PIN
                    fontFamily: 'Roboto', // Fuente monoespaciada para mejor apariencia
                    fontWeight: FontWeight.bold
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Contraseña o PIN',
                    labelStyle: TextStyle(
                      fontFamily: 'Roboto',
                      letterSpacing: 0, // Restablecer el espaciado para la etiqueta
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 182, 220, 225),
                  ), 
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).crearTutor(
                    nombre: nombreCtrl.text.isEmpty ? null : nombreCtrl.text, // <-- nombrado
                    secret: passCtrl.text,                                    // <-- nombrado
                  );
                },
                child: const Text('Registrar'),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}