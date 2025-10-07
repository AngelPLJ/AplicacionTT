// lib/features/usuario/presentacion/paginas/owner_login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controladores/contautenticacion.dart';
import '../estados/autenticacion.dart';
import 'personajes.dart'; // tu CharacterSelectPage

class Login extends ConsumerStatefulWidget {
  const Login({super.key});
  @override
  ConsumerState<Login> createState() => _S();
}

class _S extends ConsumerState<Login> {
  final secretCtrl = TextEditingController();
  bool remember = true;
  String? error;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);

    // muestra loading si el estado lo indica
    final isLoading = loading || auth is AuthLoading;
    return Scaffold(
      appBar: AppBar(title: const Text('Ingresar')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
          if (auth is AuthError) Text(auth.message, style: const TextStyle(color: Colors.red)),
          TextField(
            controller: secretCtrl,
            decoration: const InputDecoration(labelText: 'Contraseña o PIN'),
            obscureText: true,
          ),
          Row(children: [
            Checkbox(value: remember, onChanged: (v) => setState(() => remember = v ?? true)),
            const Text('Mantener sesión en este dispositivo')
          ]),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: isLoading ? null : () async {
              setState(() { loading = true; error = null; });
              final ok = await ref.read(authControllerProvider.notifier)
                  .login(secret: secretCtrl.text, remember: remember); // <-- .notifier + nombrados
              setState(() { loading = false; });
              if (!ok) { setState(() { error = 'Credenciales inválidas'; }); return; }
              if (!mounted) return;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const CharacterSelectPage()),
              );
            },
            child: isLoading ? const CircularProgressIndicator() : const Text('Entrar'),
          ),
        ]),
      ),
    );
  }
}
