// lib\features\tutor\dominio\repositorios\repoperfil.dart
import 'package:aplicacion_de_comprension/features/tutor/dominio/entidades/perfil.dart';

abstract class RepoPerfil {
  Future<Perfil> crearPerfil({required String name, required String avatarCode});
  Stream<List<Perfil>> mirarPerfiles();
  Future<void> elegirActivo(String profileId);
  Future<Perfil?> getActivo();
  Future<void> eliminarPerfil(String id);
  Future<void> cerrarSesion();
}
