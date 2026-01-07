import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../utils/hasher.dart';
import '../utils/seguridad.dart';

final dbProvider = Provider<AppDatabase>((ref) => throw UnimplementedError('Init in main'));


final secureStorageProvider = Provider<SecureStorage>((_) => SecureStorageImpl());
final hasherProvider = Provider<PasswordHasher>((_) => Pbkdf2Hasher());

