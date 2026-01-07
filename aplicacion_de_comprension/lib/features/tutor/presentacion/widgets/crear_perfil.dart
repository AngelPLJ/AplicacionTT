import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../proveedor_tutor.dart';

class CrearPerfilDialog extends ConsumerStatefulWidget {
  const CrearPerfilDialog({super.key});

  @override
  ConsumerState<CrearPerfilDialog> createState() => _CrearPerfilDialogState();
}

class _CrearPerfilDialogState extends ConsumerState<CrearPerfilDialog> {
  final nameCtrl = TextEditingController();
  String avatarSeleccionado = 'astronauta1';
  String? errorNombre;
  
  final avataresDisponibles = ['boy1', 'boy2', 'girl1', 'girl2', 'astronauta1', 'girl3', 'vamp1', 'boy3'];

  @override
  void dispose() {
    nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Nuevo perfil'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameCtrl,
            onChanged: (_) {
               if(errorNombre != null) setState(() => errorNombre = null);
            },
            decoration: InputDecoration(labelText: 'Nombre', errorText: errorNombre),
          ),
          const SizedBox(height: 20),
          const Text('Elige tu avatar:'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: avataresDisponibles.map((codigoAvatar) {
              final esSeleccionado = avatarSeleccionado == codigoAvatar;
              return GestureDetector(
                onTap: () => setState(() => avatarSeleccionado = codigoAvatar),
                child: Container(
                  width: 60, height: 60,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: esSeleccionado 
                        ? Border.all(color: Colors.blue, width: 3) 
                        : Border.all(color: Colors.grey.shade300),
                    color: esSeleccionado ? Colors.blue.shade50 : null,
                  ),
                  child: Image(image: AssetImage('assets/imagenes/$codigoAvatar.png')),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        FilledButton(
          onPressed: () async {
            if (nameCtrl.text.trim().isEmpty) {
              setState(() => errorNombre = 'Debes escribir un nombre');
              return;
            }
            await ref.read(repoPerfilProvider).crearPerfil(
              name: nameCtrl.text, 
              avatarCode: avatarSeleccionado
            );
            if (context.mounted) Navigator.pop(context);
          }, 
          child: const Text('Crear')
        )
      ],
    );
  }
}