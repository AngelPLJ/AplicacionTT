// domain/entities/child_profile.dart
class Perfil {
  final String id;
  final String tutorId;
  final String nombre;
  final String codigoAvatar; // p.ej. "fox", "robot_1"
  final bool activo;
  const Perfil({required this.id, required this.tutorId, required this.nombre, required this.codigoAvatar, required this.activo});
}