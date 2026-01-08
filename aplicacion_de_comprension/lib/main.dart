// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/proveedor.dart';
import 'core/database/database.dart';
import 'features/introduccion/presentacion/paginas/pantalla_carga.dart ';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplico',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
        primaryColor: Colors.green,
        hintColor: Colors.lightGreen,
        scaffoldBackgroundColor: const Color.fromARGB(255, 218, 200, 255),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 24.0, fontFamily: 'Roboto Slab'),
          bodyMedium: TextStyle(fontSize: 20.0, fontFamily: 'Roboto Slab'),
          bodySmall: TextStyle(fontSize: 16.0, fontFamily: 'Roboto Slab'),
          titleLarge: TextStyle(fontSize: 30.0, fontFamily: 'Roboto Slab', fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 26.0, fontFamily: 'Roboto Slab', fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 22.0, fontFamily: 'Roboto Slab', fontWeight: FontWeight.bold),
        ),
      ), 
      home: const SplashScreen(),
    );
  }
}
