//lib\infraestructura\repocontimpl.dart
import 'package:drift/drift.dart';
import '../../core/database/database.dart';
import '../features/perfiles/repositorios/repo_contenido.dart';
import '../features/perfiles/repositorios/repo_contenido_json.dart';

class RepoContenidoImpl implements RepoContenido {
  final AppDatabase db;
  
  // Instanciamos el lector de JSON internamente o podrías pasarlo por constructor
  final _lectorJson = RepoContenidoJson(); 

  RepoContenidoImpl(this.db);

  @override
  Future<void> poblarBaseDeDatos() async {
    // 1. Verificar si ya existen actividades
    final conteo = await db.select(db.actividades).get();
    
    // Si ya hay datos, no hacemos nada (return)
    if (conteo.isNotEmpty) return;

    // 2. CORRECCIÓN: Cargamos la lista usando el RepoContenidoJson
    // Aquí es donde obtenemos la lista real, reemplazando la variable que te daba error.
    final actividades = await _lectorJson.cargarActividades();

    // 3. Insertamos en la BD
    await db.batch((batch) {
      for (var act in actividades) {
        batch.insert(
          db.actividades,
          ActividadesCompanion.insert(
            id: Value(act.id), 
            nombre: Value(act.nombre),
          ),
          mode: InsertMode.insertOrIgnore // Si hay conflicto, lo ignoramos
        );
      }
      batch.insert(
          db.modulos,
          const ModulosCompanion.insert(
            id: Value(0), // ID 0 reservado para Diagnóstico
            nombre: Value("Evaluación Diagnóstica"),
          ),
          mode: InsertMode.insertOrIgnore
        );

        // 3. NUEVO: RELACIONAR ACTIVIDADES AL MÓDULO (Ejemplo)
        // Si tus actividades del diagnóstico son las IDs 1, 2, 3, 4...
        // Las vinculamos al módulo 0
        for (var act in actividades) {
          // Aquí podrías filtrar: si la actividad es de tipo diagnóstico, la vinculas
          // Por ahora vinculamos todas al módulo 0 como ejemplo, o puedes crear Módulos 1, 2, 3...
          batch.insert(
            db.actividadesHasModulos,
            ActividadesHasModulosCompanion.insert(
              actividadId: act.id, 
              moduloId: 0 
            ),
            mode: InsertMode.insertOrIgnore
          );
        }
    });
  }

  // Las funciones de consulta se quedan igual
  @override
  Future<List<Numero>> getNumeros() => db.select(db.numeros).get();

  @override
  Future<List<Fonema>> getFonemas() => db.select(db.fonemas).get();

  @override
  Future<List<Palabra>> getPalabrasPorTipo(int tipoId) {
    return (db.select(db.palabras)..where((t) => t.tipoDePalabraId.equals(tipoId))).get();
  }

  @override
  Future<List<Modulo>> getModulos() => db.select(db.modulos).get();
}