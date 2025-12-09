import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplicacion_de_comprension/core/widgets/pantalla_carga.dart';
import '../../../../core/providers/proveedor.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/providers/proveedor_perfiles.dart';
import '../../../perfiles/presentacion/paginas/menu_principal.dart';
import '../widgets/tarjetas_perfiles.dart';
import '../widgets/crear_perfil.dart';
import '../widgets/borrar_perfil.dart';

class CharacterSelectPage extends ConsumerWidget {
  const CharacterSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Asumiendo que dejaste el provider en este archivo o lo importaste
    final async = ref.watch(profilesStreamProvider); 
    final backgroundPath = obtenerFondoEstacion();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('APLICO - Selección de perfil', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundPath),
                fit: BoxFit.cover,
                alignment: const Alignment(-0.1, 0),
              ),
            ),
          ),
          
          Center(
            child: async.when(
              loading: () => const PantallaCarga(),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (profiles) => GridView.extent(
                maxCrossAxisExtent: 250,
                childAspectRatio: 0.85,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                padding: const EdgeInsets.all(24),
                children: [
                  ...profiles.map((p) => TarjetasPerfiles(
                    perfil: p,
                    onTap: () async {
                      await ref.read(repoPerfilProvider).elegirActivo(p.id);
                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const MainMenuPage()),
                        );
                      }
                    },
                    onDelete: () => showDialog(
                      context: context,
                      builder: (_) => BorrarPerfilDialog(perfil: p),
                    ),
                  )),

                  if (profiles.length < 7)
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => const CrearPerfilDialog(),
                      ),
                      child: const Card(
                        elevation: 4,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
            ),
          )
        ],
      ),
    );
  }
}