import 'dart:convert';
import 'dart:math';
import 'package:cryptography/cryptography.dart';

abstract class PasswordHasher {
  Future<String> hash(String password, {List<int>? salt});
  Future<bool> verify(String password, String stored);
  List<int> generateSalt([int length = 16]);
}

class Pbkdf2Hasher implements PasswordHasher {
  final _algo = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 210000,
    bits: 256,
  );

  @override
  List<int> generateSalt([int length = 16]) {
    final r = Random.secure();
    return List<int>.generate(length, (_) => r.nextInt(256));
  }

  @override
  Future<String> hash(String password, {List<int>? salt}) async {
    final s = salt ?? generateSalt();
    final key = await _algo.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: s,
    );
    final bytes = await key.extractBytes();
    return 'pbkdf2:sha256:i=210000:${base64Encode(s)}:${base64Encode(bytes)}';
  }

  @override
  Future<bool> verify(String password, String stored) async {
    final parts = stored.split(':');
    if (parts.length != 4) return false;
    final salt = base64Decode(parts[2].split('=')[1]); // después de i=210000,
    final hash = await this.hash(password, salt: salt);
    // Comparación tiempo-constante
    final a = utf8.encode(hash);
    final b = utf8.encode(stored);
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) { diff |= a[i] ^ b[i]; }
    return diff == 0;
  }
}