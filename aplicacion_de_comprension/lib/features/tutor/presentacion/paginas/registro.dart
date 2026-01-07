// lib/features/usuario/presentacion/paginas/register_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controladores/controlador_autenticacion.dart';
import '../estados/autenticacion.dart';
import '../widgets/form_registro.dart';
import 'personajes.dart';

class Registro extends ConsumerWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(authControllerProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        // Navegar a la pantalla de selección de personajes después del registro exitoso
        if(context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const CharacterSelectPage()),
          );
        }
      }

      if(next is AuthError) {
        if(context.mounted) {
          final snackBar = SnackBar(content: Text(next.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    });
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: switch (authState) {
        AuthLoading() => const Center(child: CircularProgressIndicator()),
        AuthError(message: final m) => FormRegistro(errorText: m),
        AuthAuthenticated() => const Center(child: Text('¡Cuenta creada!', style: TextStyle(color: Colors.white, fontSize: 24))),
        _ => const FormRegistro(),
      },
    );
  }
}

