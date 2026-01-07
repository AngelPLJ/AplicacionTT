// lib/features/perfiles/repositorios/repo_contenido_json.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../casos_de_uso/modelos_json.dart';


/*
C:\Users\dj-ti\Documents\AplicacionTT\aplicacion_de_comprension\assets\json\historias\alicia_capitulos.json
C:\Users\dj-ti\Documents\AplicacionTT\aplicacion_de_comprension\assets\json\historias\bella_y_la_bestia.json
C:\Users\dj-ti\Documents\AplicacionTT\aplicacion_de_comprension\assets\json\historias\gato_con_botas.json
C:\Users\dj-ti\Documents\AplicacionTT\aplicacion_de_comprension\assets\json\historias\la_cucaracha_comelona.json
C:\Users\dj-ti\Documents\AplicacionTT\aplicacion_de_comprension\assets\json\historias\los_animales_cantores.json
C:\Users\dj-ti\Documents\AplicacionTT\aplicacion_de_comprension\assets\json\historias\maria.json
C:\Users\dj-ti\Documents\AplicacionTT\aplicacion_de_comprension\assets\json\historias\paco_el_chato.json
C:\Users\dj-ti\Documents\AplicacionTT\aplicacion_de_comprension\assets\json\historias\patito_feo.json
C:\Users\dj-ti\Documents\AplicacionTT\aplicacion_de_comprension\assets\json\historias\pinocho_capitulos.json
C:\Users\dj-ti\Documents\AplicacionTT\aplicacion_de_comprension\assets\json\historias\principe.json
C:\Users\dj-ti\Documents\AplicacionTT\aplicacion_de_comprension\assets\json\historias\saltan_y_saltan.json
*/ 
class RepoContenidoJson {
  // MAPA MAESTRO: Vincula el nombre en el JSON de actividades con el archivo real
  final Map<String, String> _mapaArchivos = {
    "Paco el Chato": "paco_el_chato.json",
    "Saltan y saltan": "saltan_y_saltan.json",
    "Los animales cantores": "los_animales_cantores.json",
    "La cucaracha comelona": "la_cucaracha_comelona.json",
    "¿Qué le pasó a María?": "maria.json",
    "Poema Introductorio": "alicia_capitulos.json",
    "Capítulo 1 - EN LA MADRIGUERA DEL CONEJO": "alicia_capitulos.json",
    "Capítulo 2 - EL CHARCO DE LÁGRIMAS": "alicia_capitulos.json",
    "Capítulo 3 - UNA CARRERA LOCA Y UNA LARGA": "alicia_capitulos.json",
    "Capítulo 4 - LA CASA DEL CONEJO": "alicia_capitulos.json",
    "Capítulo 5 - CONSEJOS DE UNA ORUGA": "alicia_capitulos.json",
    "Capítulo 6 - CERDO Y PIMIENTA": "alicia_capitulos.json",
    "Capítulo 7 - UNA MERIENDA DE LOCOS": "alicia_capitulos.json",
    "Capítulo 8 - EL CROQUET DE LA REINA": "alicia_capitulos.json",
    "Capítulo 9 - LA HISTORIA DE LA FALSA TORTUGA": "alicia_capitulos.json",
    "Capítulo 10 - EL BAILE DE LA LANGOSTA": "alicia_capitulos.json",
    "Capítulo 11 - ¿QUIEN ROBO LAS TARTAS?": "alicia_capitulos.json",
    "Capítulo 12 - LA DECLARACION DE ALICIA": "alicia_capitulos.json",
    "La bella y la bestia": "bella_y_la_bestia.json",
    "El gato con botas": "gato_con_botas.json",
    "El patito feo": "patito_feo.json",
    "Las aventuras de Pinocho": "pinocho_capitulos.json",
    "CAPITULO II": "pinocho_capitulos.json",
    "CAPÍTULO III": "pinocho_capitulos.json",
    "CAPÍTULO IV": "pinocho_capitulos.json",
    "CAPÍTULO V": "pinocho_capitulos.json",
    "CAPÍTULO VI": "pinocho_capitulos.json",
    "CAPÍTULO VII": "pinocho_capitulos.json",
    "CAPÍTULO VIII": "pinocho_capitulos.json",
    "CAPÍTULO IX": "pinocho_capitulos.json",
    "CAPÍTULO X": "pinocho_capitulos.json",
    "CAPÍTULO XI": "pinocho_capitulos.json",
    "CAPÍTULO XII": "pinocho_capitulos.json",
    "CAPÍTULO XIII": "pinocho_capitulos.json",
    "CAPÍTULO XIV": "pinocho_capitulos.json",
    "CAPÍTULO XVI": "pinocho_capitulos.json",
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