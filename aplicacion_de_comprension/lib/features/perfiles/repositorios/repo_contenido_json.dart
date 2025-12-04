import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entidades/modelos_json.dart';

class RepoContenidoJson {
  // MAPA MAESTRO: Vincula el nombre en el JSON de actividades con el archivo real
  final Map<String, String> _mapaArchivos = {
    "Las aventuras de Pinocho": "pinocho_capitulos.json",
    "Saltan y saltan": "saltan_y_saltan.json", // Asumiendo que existe
    "Los animales cantores": "animales_cantores.json",
    // Agrega aquí los demás: "El Gato con Botas": "gato_con_botas.json", etc.
  };

  // 1. Cargar todas las actividades del JSON principal
  Future<List<ActividadModelo>> cargarActividades() async {
    try {
      final jsonString = await rootBundle.loadString('assets/json/actividades_educativas.json');
      final List<dynamic> list = json.decode(jsonString);
      return list.map((e) => ActividadModelo.fromJson(e)).toList();
    } catch (e) {
      print("Error cargando actividades: $e");
      return [];
    }
  }

  // 2. Cargar la historia completa (lista de capítulos)
  Future<List<CapituloModelo>> cargarHistoria(String tituloTexto) async {
    final nombreArchivo = _mapaArchivos[tituloTexto];
    
    if (nombreArchivo == null) {
      // Si no tenemos el archivo mapeado, regresamos una lista vacía o error
      return [CapituloModelo(titulo: "Error", texto: "Texto no encontrado para: $tituloTexto")];
    }

    try {
      final jsonString = await rootBundle.loadString('assets/json/historias/$nombreArchivo');
      final List<dynamic> list = json.decode(jsonString);
      return list.map((e) => CapituloModelo.fromJson(e)).toList();
    } catch (e) {
      return [CapituloModelo(titulo: "Error", texto: "No se pudo leer el archivo $nombreArchivo")];
    }
  }
}

final repoContenidoJsonProvider = Provider<RepoContenidoJson>((ref) => RepoContenidoJson());

// Provider auxiliar para obtener UNA actividad específica por ID
final actividadPorIdProvider = FutureProvider.family<ActividadModelo, int>((ref, id) async {
  final repo = ref.read(repoContenidoJsonProvider);
  final todas = await repo.cargarActividades();
  return todas.firstWhere((a) => a.id == id);
});

// Provider familia para cargar la historia de una actividad
final historiaDeActividadProvider = FutureProvider.family<List<CapituloModelo>, String>((ref, tituloHistoria) async {
  final repo = ref.read(repoContenidoJsonProvider);
  return repo.cargarHistoria(tituloHistoria);
});