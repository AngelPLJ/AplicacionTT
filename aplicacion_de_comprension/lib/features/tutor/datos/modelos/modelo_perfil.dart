import 'package:aplicacion_de_comprension/core/database/database.dart';
import '../../dominio/entidades/perfil.dart';

class PerfilModel extends Perfil {
  const PerfilModel({
    required super.id,
    required super.tutorId,
    required super.nombre,
    required super.codigoAvatar,
    required super.activo,
  });

  factory PerfilModel.fromDrift(Usuario row) { 
    return PerfilModel(
      id: row.id,
      tutorId: row.tutorId,
      nombre: row.nombre,
      codigoAvatar: row.icono,
      activo: row.activo,
    );
  }
}