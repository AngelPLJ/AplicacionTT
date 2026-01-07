import 'progreso.dart';

class MenuData {
  final String usuario;
  final String usuarioAvatar;
  final double progresoTotal;
  final List<ModuloConProgreso> modulos;
  final bool necesitaDiagnostico;

  MenuData({
    required this.usuario,
    required this.usuarioAvatar,
    required this.progresoTotal,
    required this.modulos,
    required this.necesitaDiagnostico, 
  });
}