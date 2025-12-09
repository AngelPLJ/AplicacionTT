import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
}

class SecureStorageImpl implements SecureStorage {
  final _s = const FlutterSecureStorage();
  @override Future<void> write(String key, String value) => _s.write(key: key, value: value);
  @override Future<String?> read(String key) => _s.read(key: key);
}