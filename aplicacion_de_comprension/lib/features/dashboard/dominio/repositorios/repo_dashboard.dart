import '../entidades/dashboard.dart';
import '../../../tutor/dominio/entidades/perfil.dart';

abstract class RepoDashboard {
  Future<MenuData> getMenuData(Perfil? perfil);
}