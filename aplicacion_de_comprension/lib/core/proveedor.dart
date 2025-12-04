import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './database/database.dart';
import './hasher.dart';
import './seguridad.dart';

import '../infraestructura/repotutorimpl.dart';
import '../infraestructura/repoconfigimpl.dart';
import '../infraestructura/repoperfilimpl.dart';
import '../infraestructura/repoprogresoimpl.dart';
import '../infraestructura/repocontimpl.dart';

import '../features/perfiles/repositorios/repo_contenido.dart';
import '../features/perfiles/repositorios/repo_progreso.dart';
import '../features/usuario/repositorios/repotutor.dart';
import '../features/usuario/repositorios/repoperfil.dart';
import '../features/usuario/repositorios/repoconfig.dart';

final dbProvider = Provider<AppDatabase>((ref) => throw UnimplementedError('Init in main'));

final prefsProvider = FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});

final secureStorageProvider = Provider<SecureStorage>((_) => SecureStorageImpl());
final hasherProvider = Provider<PasswordHasher>((_) => Pbkdf2Hasher());

final repoTutorProvider = Provider<RepoTutor>((ref) =>
    RepoTutorImpl(ref.read(dbProvider), ref.read(secureStorageProvider), ref.read(hasherProvider)));

final repoPerfilProvider = Provider<RepoPerfil>((ref) =>
    ProfileRepositoryImpl(ref.read(dbProvider)));

final repoConfigProvider = Provider<RepoConfig>((ref) =>
    RepoConfImpl(ref.read(dbProvider)));

// PROVEEDOR DE CONTENIDO (Estático)
final repoContenidoProvider = Provider<RepoContenido>((ref) => 
    RepoContenidoImpl(ref.read(dbProvider)));

// PROVEEDOR DE PROGRESO (Dinámico/Estadísticas)
final repoProgresoProvider = Provider<RepoProgreso>((ref) => 
    RepoProgresoImpl(ref.read(dbProvider)));

// PROVEEDOR FUTURO PARA INICIALIZAR LA DB (SEED)
// Puedes llamar a esto en tu main.dart o en la pantalla de carga
final databaseInitializerProvider = FutureProvider<void>((ref) async {
  final contenido = ref.read(repoContenidoProvider);
  await contenido.poblarBaseDeDatos();
});