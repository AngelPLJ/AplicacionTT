// lib\features\tutor\dominio\repositorios\repoconfig.dart
import 'package:aplicacion_de_comprension/features/tutor/dominio/entidades/configuracion.dart';

abstract class RepoConfig {
  Future<Configuracion> getSettings(String userId);
  Future<void> upsertSettings(Configuracion settings);
}