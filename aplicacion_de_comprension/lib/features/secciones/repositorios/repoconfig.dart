// domain/repositories/settings_repository.dart
import 'package:aplicacion_de_comprension/features/usuario/entidades/configuracion.dart';

abstract class RepoConfig {
  Future<Configuracion> getSettings(String userId);
  Future<void> upsertSettings(Configuracion settings);
}