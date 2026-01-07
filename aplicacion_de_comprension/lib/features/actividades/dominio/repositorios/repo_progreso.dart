//lib\features\perfiles\repositorios\repo_progreso.dart
import '../../../../../core/database/database.dart';
import '../../../dashboard/dominio/entidades/progreso.dart';

abstract class RepoProgreso {
  
  Future<double> getProgresoGeneral(String usuarioId);
  Future<List<ModuloConProgreso>> getModulosDelUsuario(String usuarioId);
  Future<void> guardarProgresoNumero({
    required String usuarioId, 
    required int numeroId, 
    required bool fueAcierto
  });

  Future<void> guardarProgresoFonema({
    required String usuarioId, 
    required int fonemaId, 
    required bool fueAcierto
  });

  // Consultas de estadísticas
  Future<List<UsuariosHasNumero>> getProgresoNumeros(String usuarioId);
  Future<void> guardarProgresoActividad({
    required String usuarioId, 
    required int actividadId, 
    required bool esAcierto
  });
  Future<List<ProgresoActividad>> getHistorialCompleto(String usuarioId);
  Future<void> actualizarProgresoModulo({
    required String usuarioId, 
    required int moduloId, 
    required double progreso
  });
}