import 'package:flutter_riverpod/flutter_riverpod.dart';
import './database/database.dart';
import './hasher.dart';
import './seguridad.dart';

import '../infraestructura/repotutorimpl.dart';
import '../infraestructura/repoconfigimpl.dart';
import '../infraestructura/repoperfilimpl.dart';
import '../features/usuario/repositorios/repotutor.dart';
import '../features/usuario/repositorios/repoperfil.dart';
import '../features/usuario/repositorios/repoconfig.dart';

final dbProvider = Provider<AppDatabase>((ref) => throw UnimplementedError('Init in main'));

final secureStorageProvider = Provider<SecureStorage>((_) => SecureStorageImpl());
final hasherProvider = Provider<PasswordHasher>((_) => Pbkdf2Hasher());

final repoTutorProvider = Provider<RepoTutor>((ref) =>
    RepoTutorImpl(ref.read(dbProvider), ref.read(secureStorageProvider), ref.read(hasherProvider)));

final repoPerfilProvider = Provider<RepoPerfil>((ref) =>
    ProfileRepositoryImpl(ref.read(dbProvider)));

final repoConfigProvider = Provider<RepoConfig>((ref) =>
    RepoConfImpl(ref.read(dbProvider)));
