// lib\features\actividades\datos\implementaciones\repo_contenido_impl.dart
import 'dart:convert';
import 'package:drift/drift.dart'; 
import 'package:aplicacion_de_comprension/core/database/database.dart';
import 'package:flutter/services.dart';
import '../../dominio/entidades/actividad.dart';
import '../../dominio/repositorios/repo_contenido.dart';
import '../modelos/modelo_actividad.dart';

class RepoContenidoImpl implements RepoContenido {
  final AppDatabase _db; // Para operaciones de Drift si es necesario
  RepoContenidoImpl(this._db);
  // Cache simple
  List<Actividad>? _cacheActividades;

  final Map<String, String> _mapaHistorias = {
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

  @override
  Future<void> poblarBaseDeDatos() async {
    final conteoFonemas = await _db.select(_db.fonemas).get();
    if (conteoFonemas.isNotEmpty) {
      return;
    }
    await _insertarFonemas();
    await _insertarNumeros();
    await _insertarModulosBase();
    await _procesarPalabrasDeHistorias();
    await _insertarCatalogoActividades();
  }

  Future<void> _insertarFonemas() async {
    final listaFonemas = [
      'a', 'b', 'c', 'ch', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 
      'll', 'm', 'n', 'ñ', 'o', 'p', 'q', 'r', 'rr', 's', 't', 'u', 'v', 
      'w', 'x', 'y', 'z'
    ];

    await _db.batch((batch) {
      batch.insertAll(_db.fonemas, listaFonemas.map((f) => 
        FonemasCompanion.insert(fonema: f)
      ));
    });
  }

  Future<void> _insertarNumeros() async {
    final numeros = List.generate(100, (index) => index + 1);
    
    await _db.batch((batch) {
      batch.insertAll(_db.numeros, numeros.map((n) => 
        NumerosCompanion.insert(numero: n)
      ));
    });
  }

  Future<void> _procesarPalabrasDeHistorias() async {
    final Set<String> palabrasUnicas = {};
    
    final stopWords = {
      'el', 'la', 'los', 'las', 'un', 'una', 'unos', 'unas', 'y', 'o', 'pero', 
      'si', 'no', 'de', 'del', 'a', 'ante', 'con', 'en', 'por', 'para', 'que', 
      'se', 'su', 'sus', 'mi', 'tu', 'es', 'son', 'fue', 'era', 'al', 'lo', 'le'
    };

    // Iteramos cada archivo JSON
    for (var ruta in _mapaHistorias.values) {
      try {
        final jsonString = await rootBundle.loadString('assets/json/$ruta');
        final List<dynamic> datos = json.decode(jsonString);

        for (var item in datos) {
          // Asumimos que el JSON tiene campo "Texto" o "contenido"
          String texto = item['Texto'] ?? item['contenido'] ?? '';
          if (texto.isEmpty) continue;

          // Limpieza: Quitar signos de puntuación, pasar a minúsculas
          final limpio = texto.toLowerCase().replaceAll(RegExp(r'[.,;:"\(\)\?¿!¡-]'), '');
          final palabras = limpio.split(' ');

          for (var p in palabras) {
            if (p.trim().length > 2 && !stopWords.contains(p.trim())) {
              palabrasUnicas.add(p.trim());
            }
          }
        }
      } catch (e) {
      }
    }

    await _db.batch((batch) {
      batch.insertAll(_db.palabras, palabrasUnicas.map((p) => 
        PalabrasCompanion.insert(
          palabra: p,
        )
      ));
    });
  }
  
  // --- D. ACTIVIDADES (Desde el JSON principal) ---
  Future<void> _insertarCatalogoActividades() async {
     try {
       final actividades = await getActividades(); // Usa tu método existente que lee el JSON
       final modulosDB = await _db.select(_db.modulos).get();

       await _db.batch((batch) {
         for (var act in actividades) {
          // A. Insertar la Actividad en sí
          batch.insert(
            _db.actividades,
            ActividadesCompanion.insert(
              id: Value(act.id),
              nombre: Value(act.nombre),
            ),
            mode: InsertMode.insertOrReplace,
          );

          for (var habilidadEnum in act.habilidades) {
            // Buscamos el ID del módulo que coincida con el nombre del enum
            final nombreHabilidad = _mapHabilidadToString(habilidadEnum);
            
            // Buscamos el módulo en la lista que trajimos de la BD
            final moduloCoincidente = modulosDB.firstWhere(
              (m) => m.nombre.toLowerCase().contains(nombreHabilidad.toLowerCase()),
              orElse: () => Modulo(id: -1, nombre: 'Desconocido'), // Fallback seguro
            );

            if (moduloCoincidente.id != -1) {
              batch.insert(
                _db.actividadesHasModulos,
                ActividadesHasModulosCompanion.insert(
                  actividadId: act.id,
                  moduloId: moduloCoincidente.id,
                ),
                mode: InsertMode.insertOrIgnore,
              );
            }
          }
        }
       });
     } catch (e) {
     }
  }

  String _mapHabilidadToString(HabilidadCognitiva h) {
    switch (h) {
      case HabilidadCognitiva.atencion: return "Atención";
      case HabilidadCognitiva.memoria: return "Memoria";
      case HabilidadCognitiva.logica: return "Lógica";
      case HabilidadCognitiva.inferencia: return "Inferencia";
    }
  }

  Future<void> _insertarModulosBase() async {
    final modulos = ["Atención", "Memoria", "Lógica", "Inferencia"];
    await _db.batch((batch) {
      for (var m in modulos) {
        batch.insert(_db.modulos, ModulosCompanion.insert(nombre: m));
      }
    });
  }

  @override
  Future<List<Actividad>> getActividades() async {
    if (_cacheActividades != null) return _cacheActividades!;

    try {
      final jsonString = await rootBundle.loadString('assets/json/actividades_educativas.json');
      final List<dynamic> list = json.decode(jsonString);
      _cacheActividades = list.map((e) => ActividadModel.fromJson(e)).toList();
      return _cacheActividades!;
    } catch (e) {
      return [];
    }
  }

  // Método adicional específico para historias (No está en la interfaz base, pero el Provider lo usará)
  Future<List<Map<String, dynamic>>> cargarCapitulosHistoria(String titulo) async {
    final archivo = _mapaHistorias[titulo];
    if (archivo == null) return [];

    try {
      final jsonString = await rootBundle.loadString('assets/json/historias/$archivo');
      final List<dynamic> list = json.decode(jsonString);
      return list.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error leyendo historia $titulo: $e");
      return [];
    }
  }

  // Métodos dummy para cumplir el contrato de RepoContenido si no usas Drift para esto aun
  @override
  Future<List<Numero>> getNumeros() async {
    // Select * from Numeros
    return _db.select(_db.numeros).get();
  }

  @override
  Future<List<Fonema>> getFonemas() async {
    // Select * from Fonemas
    return _db.select(_db.fonemas).get();
  }

  @override
  Future<List<Palabra>> getPalabras() async {
    // Select * from Palabras
    return _db.select(_db.palabras).get();
  }

  @override
  Future<List<Modulo>> getModulos() async {
    // Select * from Modulos
    return _db.select(_db.modulos).get();
  }
}