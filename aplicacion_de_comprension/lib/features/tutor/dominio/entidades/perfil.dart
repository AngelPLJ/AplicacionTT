// lib\features\tutor\dominio\entidades\perfil.dart
class Perfil {
  final String id;
  final String tutorId;
  final String nombre;
  final String codigoAvatar;
  final bool activo;
  const Perfil({required this.id, required this.tutorId, required this.nombre, required this.codigoAvatar, required this.activo});
}