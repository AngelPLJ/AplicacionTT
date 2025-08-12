// lib/features/usuario/presentacion/controladores/contautenticacion.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Ajusta esta ruta a tu archivo real que expone el provider del repo:
import 'package:aplicacion_de_comprension/core/proveedor.dart'; // debe exponer: tutorRepoProvider
import '../../repositorios/repotutor.dart'; // interfaz RepoTutor (ajusta si tu ruta es otra)
import '../estados/autenticacion.dart';
// ===== Provider del controlador =====
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final repo = ref.read(repoTutorProvider); // <-- asegúrate que exista este provider
  return AuthController(repo);
});

// ===== Controlador =====
class AuthController extends StateNotifier<AuthState> {
  final RepoTutor repo; // tu interfaz de repositorio
  AuthController(this.repo) : super(const AuthInitial());

  /// Registro local del tutor (único por dispositivo).
  Future<void> crearTutor({String? nombre, required String secret}) async {
    state = const AuthLoading();
    try {
      await repo.crearTutor(usuario: nombre, secret: secret);
      await repo.setSesionRapida(true);
      state = const AuthAuthenticated();
    } catch (e) {
      state = AuthError(_toHuman(e));
    }
  }

  /// Login offline con contraseña o PIN.
  Future<bool> login({required String secret, bool remember = true}) async {
    state = const AuthLoading();
    try {
      final ok = await repo.autenticar(secret);
      if (!ok) {
        state = const AuthError('Credenciales inválidas');
        return false;
      }
      await repo.setSesionRapida(remember);
      state = const AuthAuthenticated();
      return true;
    } catch (e) {
      state = AuthError(_toHuman(e));
      return false;
    }
  }

  String _toHuman(Object e) {
    final s = e.toString();
    if (s.contains('Tutor ya existe')) return 'Ya existe una cuenta en este dispositivo.';
    return 'Ocurrió un problema. Intenta de nuevo.';
  }
}
