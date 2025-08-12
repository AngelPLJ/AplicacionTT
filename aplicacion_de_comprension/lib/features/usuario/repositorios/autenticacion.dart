// domain/repositories/auth_repository.dart
import 'package:aplicacion_de_comprension/features/usuario/entidades/usuario.dart';

abstract class AuthRepository {
  Future<Usuario> register({required String nombre, required String contrasenia});
  Future<Usuario> login({required String nombre, required String contrasenia});
  Future<void> logout();
  Future<Usuario?> currentUser();
}
