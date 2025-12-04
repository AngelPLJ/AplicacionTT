import 'package:aplicacion_de_comprension/core/widgets/pantalla_carga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../entidades/perfil.dart';
import '../../../../core/proveedor.dart';
import '../../../../core/utils.dart';
import '../../../perfiles/presentacion/paginas/menu_principal.dart';

final profilesStreamProvider = StreamProvider<List<Perfil>>((ref) =>
  ref.read(repoPerfilProvider).mirarPerfiles());

class CharacterSelectPage extends ConsumerWidget {
  const CharacterSelectPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(profilesStreamProvider);
    final backgroundPath = obtenerFondoEstacion();
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor, title: const Text('APLICO - Selección de perfil', style: TextStyle(color: Colors.white)),),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundPath),
              fit: BoxFit.cover,
              alignment: Alignment(-0.1, 0),
            ),
          ),
        ),
        Center(
          child: async.when(
            data: (profiles) => GridView.extent(
              // CAMBIO CLAVE: Usamos extent en lugar de count
              maxCrossAxisExtent: 250, // Cada tarjeta tendrá máximo 250px de ancho
              childAspectRatio: 0.85, // Ajusta la proporción (Ancho / Alto) para que no sean muy altas
              mainAxisSpacing: 20, // Espacio vertical entre tarjetas
              crossAxisSpacing: 20, // Espacio horizontal entre tarjetas
              padding: const EdgeInsets.all(24), // Un poco más de margen externo
              
              children: [
                ...profiles.map((p) => Card( 
                  elevation: 4, // Un poco de sombra para que resalte
                  clipBehavior: Clip.antiAlias, 
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: InkWell(
                          onTap: () async {
                            await ref.read(repoPerfilProvider).elegirActivo(p.id);
                            if (context.mounted) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => const MainMenuPage()),
                              );
                            }
                          }, 
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  image: AssetImage('assets/imagenes/${p.codigoAvatar}.png'),
                                  width: 90, // Un poco más grande para tablet
                                  height: 90,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  p.nombre, 
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // El botón de eliminar
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
                          onPressed: () => _mostrarDialogoEliminar(context, ref, p),
                        ),
                      ),
                    ],
                  ),
                )),
                
                // Botón de crear (con el límite de 7)
                if (profiles.length < 7)
                  GestureDetector(
                    onTap: () => _createProfileDialog(context, ref),
                    child: Card(
                      elevation: 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add, size: 50, color: Colors.grey),
                            SizedBox(height: 8),
                            Text("Nuevo", style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            loading: () => const PantallaCarga(),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        )
      ])
    );
  }

  Future<void> _createProfileDialog(BuildContext c, WidgetRef ref) async {
    final nameCtrl = TextEditingController();
    String avatarSeleccionado = 'astronauta1'; // Valor por defecto
    final avataresDisponibles = ['boy1', 'boy2', 'girl1', 'girl2', 'astronauta1', 'girl3', 'vamp1', 'boy3'];
    String? errorNombre;
    await showDialog(context: c, builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Nuevo perfil'),
            content: Column(
              mainAxisSize: MainAxisSize.min, // Para que no ocupe toda la pantalla
              children: [
                TextField(
                  controller: nameCtrl,
                  onChanged: (value){
                    if(errorNombre != null){
                      setStateDialog(() {
                        errorNombre = null;
                      });
                    }
                  },
                  decoration: InputDecoration(labelText: 'Nombre', errorText: errorNombre),
                ),
                const SizedBox(height: 20),
                const Text('Elige tu avatar:'),
                const SizedBox(height: 10),
                
                // 3. Grid o Row para mostrar los iconos
                Wrap(
                  spacing: 10, // Espacio horizontal entre iconos
                  runSpacing: 10, // Espacio vertical entre lineas
                  children: avataresDisponibles.map((codigoAvatar) {
                    final esElSeleccionado = avatarSeleccionado == codigoAvatar;
                    
                    return GestureDetector(
                      onTap: () {
                        // Actualizamos la variable DENTRO del diálogo
                        setStateDialog(() {
                          avatarSeleccionado = codigoAvatar;
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // Si está seleccionado, le ponemos borde azul y fondo claro
                          border: esElSeleccionado 
                              ? Border.all(color: Colors.blue, width: 3) 
                              : Border.all(color: Colors.grey.shade300),
                          color: esElSeleccionado ? Colors.blue.shade50 : null,
                        ),
                        // AQUÍ CARGAS TU IMAGEN REAL
                        // Usamos un Icon como placeholder, pero tú usarías:
                        // child: Image.asset('assets/imagenes/$codigoAvatar.png')
                        child: Image(
                          image: AssetImage('assets/imagenes/$codigoAvatar.png')
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancelar')),
              FilledButton(onPressed: () async {
                final nombre = nameCtrl.text.trim();
                if (nombre.isEmpty) {
                  setStateDialog(() {
                    errorNombre = 'Debes escribir un nombre';
                  });
                  return;
                }
                await ref.read(repoPerfilProvider).crearPerfil(name: nameCtrl.text, avatarCode: avatarSeleccionado);
                if (context.mounted) Navigator.pop(context);
              }, child: const Text('Crear'))
            ],
          );
        },
      );
    },
  );
  }
  Future<void> _mostrarDialogoEliminar(BuildContext context, WidgetRef ref, Perfil perfil) async {
    final pinCtrl = TextEditingController();
    String? errorNombre;

    await showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text('Eliminar a ${perfil.nombre}?'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Esta acción no se puede deshacer. Ingresa el PIN del tutor para confirmar.'),
                  const SizedBox(height: 10),
                  TextField(
                    controller: pinCtrl,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'PIN del Tutor',
                      errorText: errorNombre, // Muestra error si falla
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    
                    final pinLimpio = pinCtrl.text.trim();
                    final esCorrecto = await ref.read(repoTutorProvider).autenticar(pinLimpio);

                    if (esCorrecto) {
                      // 2. Si es correcto, eliminamos
                      await ref.read(repoPerfilProvider).eliminarPerfil(perfil.id);
                      if (context.mounted) Navigator.pop(ctx); // Cierra diálogo
                    } else {
                      // 3. Si falla, mostramos error en el TextField
                      setStateDialog(() {
                        errorNombre = 'PIN Incorrecto';
                      });
                    }
                  },
                  child: const Text('Eliminar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
