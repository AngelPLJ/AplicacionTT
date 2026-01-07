// lib\features\tutor\dominio\repositorios\repotutor.dart

abstract class RepoTutor {
  Future<bool> existeTutor();
  Future<void> crearTutor({String? usuario, required String secret}); // password o PIN
  Future<bool> autenticar(String secret);
  Future<void> setSesionRapida(bool enabled);
  Future<bool> sesionRapidaActiva();
}