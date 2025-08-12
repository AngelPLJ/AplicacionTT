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
      appBar: AppBar(title: const Text('Crear cuenta')),
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        if (widget.errorText != null)
          Text(widget.errorText!, style: const TextStyle(color: Colors.red)),
        TextField(controller: nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre (opcional)')),
        TextField(controller: passCtrl, decoration: const InputDecoration(labelText: 'Contraseña o PIN'), obscureText: true),
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
    );
  }
}
