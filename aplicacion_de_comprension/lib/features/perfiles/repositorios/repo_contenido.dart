//lib\features\perfiles\repositorios\repo_contenido.dart
import '../../../../core/database/database.dart';

abstract class RepoContenido {
  // Inicialización (Seed)
  Future<void> poblarBaseDeDatos();

  // Consultas
  Future<List<Numero>> getNumeros();
  Future<List<Fonema>> getFonemas();
  Future<List<Palabra>> getPalabrasPorTipo(int tipoId);
  Future<List<Modulo>> getModulos();
}