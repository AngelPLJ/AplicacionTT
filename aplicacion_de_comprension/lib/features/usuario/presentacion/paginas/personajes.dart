import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../entidades/perfil.dart';
import '../../../../core/proveedor.dart';

final profilesStreamProvider = StreamProvider<List<Perfil>>((ref) =>
  ref.read(repoPerfilProvider).mirarPerfiles());

class CharacterSelectPage extends ConsumerWidget {
  const CharacterSelectPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(profilesStreamProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('¿Quién va a jugar?')),
      body: async.when(
        data: (profiles) => GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16),
          children: [
            ...profiles.map((p) => GestureDetector(
              onTap: () => ref.read(repoPerfilProvider).elegirActivo(p.id),
              child: Card(child: Center(child: Text(p.nombre))),
            )),
            GestureDetector(
              onTap: () => _createProfileDialog(context, ref),
              child: const Card(child: Center(child: Icon(Icons.add))),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<void> _createProfileDialog(BuildContext c, WidgetRef ref) async {
    final nameCtrl = TextEditingController();
    await showDialog(context: c, builder: (_) => AlertDialog(
      title: const Text('Nuevo perfil'),
      content: TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nombre')),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancelar')),
        FilledButton(onPressed: () async {
          await ref.read(repoPerfilProvider).crearPerfil(name: nameCtrl.text, avatarCode: 'fox');
          if (c.mounted) Navigator.pop(c);
        }, child: const Text('Crear'))
      ],
    ));
  }
}
