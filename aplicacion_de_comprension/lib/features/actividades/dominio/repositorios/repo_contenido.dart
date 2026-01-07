//lib\features\perfiles\repositorios\repo_contenido.dart
import '../../../../../core/database/database.dart';
import '../entidades/actividad.dart';

abstract class RepoContenido {
  // Inicialización (Seed)
  Future<void> poblarBaseDeDatos();

  // Consultas
  Future<List<Actividad>> getActividades();
  Future<List<Numero>> getNumeros();
  Future<List<Fonema>> getFonemas();
  Future<List<Palabra>> getPalabras();
  Future<List<Modulo>> getModulos();
}