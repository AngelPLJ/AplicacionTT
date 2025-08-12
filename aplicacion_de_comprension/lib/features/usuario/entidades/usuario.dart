// domain/entities/user.dart
class Usuario {
  final String id;         // uuid
  final String nombre;
  final DateTime fechaCreacion;
  const Usuario({required this.id, required this.nombre, required this.fechaCreacion});
}