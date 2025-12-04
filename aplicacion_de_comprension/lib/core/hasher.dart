import 'dart:convert';
import 'dart:math';
import 'package:cryptography/cryptography.dart';

abstract class PasswordHasher {
  Future<String> hash(String password, {List<int>? salt});
  Future<bool> verify(String password, String stored, {List<int>? salt});
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
  // 2. CORRECCIÓN: Aceptamos el parámetro salt aquí también
  Future<bool> verify(String password, String stored, {List<int>? salt}) async {
    List<int> saltToUse;

    if (salt != null) {
      saltToUse = salt;
    } else {
      final parts = stored.split(':');
      if (parts.length < 5) return false; 
      saltToUse = base64Decode(parts[3]); 
    }

    final calculatedHash = await this.hash(password, salt: saltToUse);

    final a = utf8.encode(calculatedHash);
    final b = utf8.encode(stored);
    
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}