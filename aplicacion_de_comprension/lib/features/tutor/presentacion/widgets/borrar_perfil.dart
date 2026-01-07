import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../proveedor_tutor.dart';
import '../../dominio/entidades/perfil.dart';

class BorrarPerfilDialog extends ConsumerStatefulWidget {
  final Perfil perfil;
  const BorrarPerfilDialog({super.key, required this.perfil});

  @override
  ConsumerState<BorrarPerfilDialog> createState() => _BorrarPerfilDialogState();
}

class _BorrarPerfilDialogState extends ConsumerState<BorrarPerfilDialog> {
  final pinCtrl = TextEditingController();
  String? errorPin;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Eliminar a ${widget.perfil.nombre}?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Esta acción no se puede deshacer. Ingresa el PIN del tutor.'),
          const SizedBox(height: 10),
          TextField(
            controller: pinCtrl,
            obscureText: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'PIN del Tutor',
              errorText: errorPin,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            final esCorrecto = await ref.read(repoTutorProvider).autenticar(pinCtrl.text.trim());
            if (esCorrecto) {
              await ref.read(repoPerfilProvider).eliminarPerfil(widget.perfil.id);
              if (context.mounted) Navigator.pop(context);
            } else {
              setState(() => errorPin = 'PIN Incorrecto');
            }
          },
          child: const Text('Eliminar'),
        ),
      ],
    );
  }
}