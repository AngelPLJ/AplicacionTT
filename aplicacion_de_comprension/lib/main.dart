import 'package:aplicacion_de_comprension/core/widgets/pantalla_carga.dart';
import 'package:aplicacion_de_comprension/features/perfiles/presentacion/paginas/menu_principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/proveedor.dart';
import 'core/database/database.dart';
import 'core/cargar_pantallas.dart';
import './features/usuario/presentacion/paginas/registro.dart';
import './features/usuario/presentacion/paginas/login.dart';
import './features/usuario/presentacion/paginas/personajes.dart';
import './features/secciones/presentacion/paginas/introduccion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await AppDatabase.open();
  runApp(ProviderScope(
    overrides: [dbProvider.overrideWithValue(db)],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boot = ref.watch(bootProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplico',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
        primaryColor: Colors.green,
        hintColor: Colors.lightGreen,
        scaffoldBackgroundColor: const Color.fromARGB(255, 13, 0, 39),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 24.0, fontFamily: 'Roboto Slab'),
          bodyMedium: TextStyle(fontSize: 20.0, fontFamily: 'Roboto Slab'),
          bodySmall: TextStyle(fontSize: 16.0, fontFamily: 'Roboto Slab'),
          titleLarge: TextStyle(fontSize: 30.0, fontFamily: 'Roboto Slab', fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 26.0, fontFamily: 'Roboto Slab', fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 22.0, fontFamily: 'Roboto Slab', fontWeight: FontWeight.bold),
        ),
      ), 
      home: boot.when(
        data: (r) => switch (r) {
          BootRoute.introduccion => const Introduccion(),
          BootRoute.onboarding => const Registro(),
          BootRoute.login => const Login(),
          BootRoute.profiles => const CharacterSelectPage(),
          BootRoute.mainMenu => const MainMenuPage(),
        },
        loading: () => const Scaffold(body:  PantallaCarga()),
        error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      ),
    );
  }
}
