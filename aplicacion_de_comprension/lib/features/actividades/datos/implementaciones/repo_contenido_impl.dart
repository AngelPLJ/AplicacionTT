// lib\features\actividades\datos\implementaciones\repo_contenido_impl.dart
import 'dart:convert';
import 'package:drift/drift.dart'; 
import 'package:aplicacion_de_comprension/core/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:aplicacion_de_comprension/core/utils/prefs_provider.dart';
import '../../dominio/entidades/actividad.dart';
import '../../dominio/repositorios/repo_contenido.dart';

class RepoContenidoImpl implements RepoContenido {
  final AppDatabase _db; 
  final Ref _ref;
  RepoContenidoImpl(this._db, this._ref);

  final Map<String, String> _mapaHistorias = {
    "Paco el Chato": "cuentos_sep.json",
    "Saltan y saltan": "cuentos_sep.json",
    "Los animales cantores": "cuentos_sep.json",
    "La cucaracha comelona": "cuentos_sep.json",
    "¿Qué le pasó a María?": "cuentos_sep.json",
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
    "CAPÍTULO XVII": "pinocho_capitulos.json",
    "CAPÍTULO XVIII": "pinocho_capitulos.json",
    "CAPÍTULO XIX": "pinocho_capitulos.json",
    "CAPÍTULO XX": "pinocho_capitulos.json",
    "CAPÍTULO XXI": "pinocho_capitulos.json",
    "CAPÍTULO XXII": "pinocho_capitulos.json",
    "CAPÍTULO XXIII": "pinocho_capitulos.json",
    "CAPÍTULO XXIV": "pinocho_capitulos.json",
    "CAPÍTULO XXV": "pinocho_capitulos.json",
    "CAPÍTULO XXVI": "pinocho_capitulos.json",
    "CAPÍTULO XXVII": "pinocho_capitulos.json",
    "CAPÍTULO XXVIII": "pinocho_capitulos.json",
    "CAPÍTULO XXIX": "pinocho_capitulos.json",
    "CAPÍTULO XXX": "pinocho_capitulos.json",
    "CAPÍTULO XXXI": "pinocho_capitulos.json",
    "CAPÍTULO XXXII": "pinocho_capitulos.json",
    "CAPÍTULO XXXIII": "pinocho_capitulos.json",
    "CAPÍTULO XXXIV": "pinocho_capitulos.json",
    "CAPÍTULO XXXV": "pinocho_capitulos.json",
    "El principe feliz": "principe.json",
  };

  static const int versionContenido = 1; 

  @override
  Future<void> poblarBaseDeDatos() async {
    final prefs = await _ref.read(prefsProvider.future);
    
    final versionGuardada = prefs.getInt('versionContenido') ?? 0;

    if (versionGuardada < versionContenido) {
      
      // Ejecutamos las inserciones (tu lógica existente con insertOrIgnore/Replace)
      await _insertarModulos();
      await _insertarFonemas();
      await _insertarNumeros();
      await _procesarPalabrasDeHistorias();
      await _insertarCatalogoActividades();

      await _ref.read(prefsNotifierProvider.notifier).setInt('versionContenido', versionContenido);
      
    } else {
      return;
    }
  }

  Future<void> _insertarModulos() async {
    final listaModulos = [
      'Atención', 'Memoria', 'Lógica', 'Inferencia', 'Vocabulario'
    ];

    await _db.batch((batch) {
      // Usamos insertAll para insertar la lista completa de una vez
      batch.insertAll(
        _db.modulos,
        listaModulos.map((nombre) => ModulosCompanion.insert(nombre: nombre)),
        mode: InsertMode.insertOrIgnore, // <--- Aquí está el modo seguro
      );
    });
  }

  Future<void> _insertarFonemas() async {
    final listaFonemas = [
      'a', 'b', 'c', 'ch', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 
      'll', 'm', 'n', 'ñ', 'o', 'p', 'q', 'r', 'rr', 's', 't', 'u', 'v', 
      'w', 'x', 'y', 'z'
    ];

    await _db.batch((batch) {
      // CORRECCIÓN: Usar 'insertAll' en lugar de 'insert'
      batch.insertAll(
        _db.fonemas, 
        listaFonemas.map((f) => FonemasCompanion.insert(fonema: f)),
        mode: InsertMode.insertOrIgnore, // <--- Modo seguro
      );
    });
  }

  Future<void> _insertarNumeros() async {
    final numeros = List.generate(100, (index) => index + 1);
    
    await _db.batch((batch) {
      batch.insertAll(
        _db.numeros, 
        numeros.map((n) => NumerosCompanion.insert(numero: n)),
        mode: InsertMode.insertOrIgnore, // <--- Faltaba agregar esto aquí
      );
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
        final jsonString = await rootBundle.loadString('assets/json/historias/$ruta');
        final List<dynamic> datos = json.decode(jsonString);

        for (var item in datos) {
          String texto = item['Texto'] ?? item['contenido'] ?? '';
          if (texto.isEmpty) continue;

          texto = texto.replaceAll('\n', ' ');

          final limpio = texto.toLowerCase()
              .replaceAll(RegExp(r'[.,;:"\(\)\?¿!¡\-\—_]'), ' '); 

          final palabras = limpio.split(RegExp(r'\s+'));

          for (var p in palabras) {
            final pTrim = p.trim();
            
            if (pTrim.length > 2 && 
                pTrim.length <= 24 && 
                !stopWords.contains(pTrim)) {
              
              palabrasUnicas.add(pTrim);
            }
          }
        }
      } catch (e) {
        throw Exception("Error procesando archivo $ruta: $e");
      }
    }

    await _db.batch((batch) {
      batch.insertAll(
        _db.palabras, 
        palabrasUnicas.map((p) => 
          PalabrasCompanion.insert(
            palabra: p,
          )
        ), 
        mode: InsertMode.insertOrIgnore // Este ya lo tenías bien
      ); 
    });
  }
  
  Future<void> _insertarCatalogoActividades() async {
    try {
      // 1. Cargar el JSON generado por Python
      final jsonString = await rootBundle.loadString('assets/json/actividades_educativas.json');
      final List<dynamic> listaJson = json.decode(jsonString);
      
      final modulosDB = await _db.select(_db.modulos).get();

      await _db.batch((batch) {
        for (var item in listaJson) {
          
          // MAPEO ROBUSTO: De String JSON a Enum Dart
          final String nombreActividad = item['Nombre'] ?? '';
          final TipoActividad tipoEnum = _mapNombreToTipo(nombreActividad);
          
          final Map<String, dynamic> contenidoData = item['Contenido'] ?? {};
          contenidoData['Titulo Fuente'] = item['Titulo Fuente'];
          List<String> opciones = [];
          String respuestaCorrecta = '';

          if (contenidoData.containsKey('opciones')) {
             opciones = List<String>.from(contenidoData['opciones']);
          } else if (contenidoData.containsKey('distractores')) {
             opciones = List<String>.from(contenidoData['distractores']);
             // A veces queremos incluir la correcta en las opciones para la UI
             if (contenidoData.containsKey('palabra_correcta')) {
                opciones.add(contenidoData['palabra_correcta']);
                opciones.shuffle(); // Mezclar para que no siempre esté al final
             }
          }

          if (contenidoData.containsKey('correcta')) {
            respuestaCorrecta = contenidoData['correcta'];
          } else if (contenidoData.containsKey('palabra_correcta')) {
            respuestaCorrecta = contenidoData['palabra_correcta'];
          } else if (contenidoData.containsKey('solucion')) {
            respuestaCorrecta = contenidoData['solucion'];
          }

          // Insertar Actividad
          batch.insert(
            _db.actividades,
            ActividadesCompanion.insert(
              id: Value(item['Numero']), 
              nombre: nombreActividad, 
              tipo: Value(tipoEnum.name), 
              habilidades: Value(_normalizarHabilidades(item['Habilidad(es)'])), 
              instruccion: Value(_generarInstruccion(tipoEnum)), // Generamos instrucción si no viene
              contenidoVisual: Value(contenidoData), 
              opciones: opciones,
              respuestaCorrecta: Value(respuestaCorrecta),
              esDiagnostico: Value(item['EsDiagnostico'] ?? false),
            ),
            mode: InsertMode.insertOrReplace,
          );

          final habilidadesString = item['Habilidad(es)'] as String? ?? "";
          final listaHabilidades = habilidadesString.split(',').map((e) => e.trim()).toList();

          for (var nombreHab in listaHabilidades) {
            final moduloCoincidente = modulosDB.firstWhere(
              (m) {
                final modName = m.nombre.toLowerCase(); // Ej: "memoria"
                final habName = nombreHab.toLowerCase(); // Ej: "memoria de trabajo"
                
                return modName.contains(habName) || habName.contains(modName);
              },
              orElse: () => Modulo(id: -1, nombre: 'Genérico'),
            );

            if (moduloCoincidente.id != -1) {
              batch.insert(
                _db.actividadesHasModulos,
                ActividadesHasModulosCompanion.insert(
                  actividadId: item['Numero'],
                  moduloId: moduloCoincidente.id,
                ),
                mode: InsertMode.insertOrIgnore,
              );
            }
          }
        }
      });
    } catch (e) {
      throw Exception("Error insertando catálogo de actividades: $e");
    }
  }

  TipoActividad _mapNombreToTipo(String nombre) {
    final n = nombre.toLowerCase();
    if (n.contains("fonema inicial")) return TipoActividad.identificacionFonema;
    if (n.contains("correspondencia")) return TipoActividad.correspondenciaFonemaGrafema;
    if (n.contains("letra distinta")) return TipoActividad.encuentraLetraDistinta;
    if (n.contains("memorama")) return TipoActividad.memorama;
    if (n.contains("palabra escuchaste")) return TipoActividad.palabraEscuchada;
    if (n.contains("ordena la oración")) return TipoActividad.ordenaOracion;
    if (n.contains("pasará después")) return TipoActividad.quePasaraDespues;
    if (n.contains("comprensión")) return TipoActividad.comprensionLectora;
    
    return TipoActividad.comprensionLectora; // Default
  }

  String _normalizarHabilidades(String? raw) {
    if (raw == null) return "";
    // Mapeo simple para guardar en BD formato limpio
    // Entrada: "Atención, memoria de trabajo" -> Salida: "atencion,memoria"
    List<String> out = [];
    final lower = raw.toLowerCase();
    if (lower.contains("atención")) out.add("atencion");
    if (lower.contains("memoria")) out.add("memoria");
    if (lower.contains("lógica")) out.add("logica");
    if (lower.contains("inferencia")) out.add("inferencia");
    if (lower.contains("vocabulario")) out.add("vocabulario");
    return out.join(",");
  }

  String _generarInstruccion(TipoActividad tipo) {
    switch (tipo) {
      case TipoActividad.identificacionFonema: return "Escucha el sonido y elige la palabra que empieza igual.";
      case TipoActividad.comprensionLectora: return "Escucha las palabras, recuérdalas y selecciónalas.";
      case TipoActividad.encuentraLetraDistinta: return "Encuentra la letra que es diferente.";
      case TipoActividad.ordenaOracion: return "Arrastra las palabras para formar la oración correcta.";
      case TipoActividad.memorama: return "Encuentra los pares.";
      default: return "Responde correctamente.";
    }
  }

  @override
  Future<List<Actividad>> getActividades() async {
      // Ahora leemos directo de la BD, ya no del JSON cada vez
      final filas = await _db.select(_db.actividades).get();
      
      // Convertimos las filas de Drift (que ya traen los Mapas y Listas) a tu Entidad
      return filas.map((fila) {
          
          return Actividad(
              id: fila.id,
              nombre: fila.nombre,
              habilidades: _parsearHabilidadesDesdeString(fila.habilidades),
              tipo: _stringToTipo(fila.tipo), // Necesitas un helper inverso
              instruccion: fila.instruccion,
              contenido: fila.contenidoVisual!,
              opciones: fila.opciones,
              respuestaCorrecta: fila.respuestaCorrecta,
          );
      }).toList();
  }
  
  TipoActividad _stringToTipo(String t) {
      return TipoActividad.values.firstWhere(
          (e) => e.name == t, 
          orElse: () => TipoActividad.comprensionLectora
      );
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
      throw Exception("Error cargando historia $titulo: $e");
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

  @override
  Future<List<Actividad>> getActividadesDiagnosticas() async {
    // Usamos Drift para filtrar donde 'esDiagnostico' sea true
    final query = _db.select(_db.actividades)
      ..where((tbl) => tbl.esDiagnostico.equals(true));
      
    final filas = await query.get();

    // Convertimos de Filas de BD a Entidades de Dominio
    return filas.map((fila) {
      return Actividad(
        id: fila.id,
        nombre: fila.nombre,
        // Convertimos el string "Atención,Memoria" a Lista de Enums
        habilidades: _parsearHabilidadesDesdeString(fila.habilidades), 
        // Convertimos el string "ordenaOracion" a Enum
        tipo: _stringToTipo(fila.tipo),
        instruccion: fila.instruccion,
        // Drift ya nos da el Map y la List gracias a los converters
        contenido: fila.contenidoVisual!, 
        opciones: fila.opciones,
        respuestaCorrecta: fila.respuestaCorrecta,
      );
    }).toList();
  }

  List<HabilidadCognitiva> _parsearHabilidadesDesdeString(String str) {
    if (str.isEmpty) return [];
    
    return str.split(',').map((s) {
        final key = s.trim(); // Limpiamos espacios
        
        // Mapeamos las claves normalizadas que guardamos en BD
        if (key == 'atencion') return HabilidadCognitiva.atencion;
        if (key == 'memoria') return HabilidadCognitiva.memoria;
        if (key == 'logica') return HabilidadCognitiva.logica;
        if (key == 'inferencia') return HabilidadCognitiva.inferencia;
        if (key == 'vocabulario') return HabilidadCognitiva.vocabulario; // Faltaba este
        
        return HabilidadCognitiva.atencion; // Default por si falla
    }).toList();
  }

  @override
  Future<String?> obtenerTextoHistoria(String titulo) async {
    // 1. Buscamos en qué archivo está este título
    final archivo = _mapaHistorias[titulo];
    
    // Si no está en el mapa exacto, intentamos buscar si es un capítulo de alguno conocido
    // O simplemente regresamos null si no existe mapeo.
    if (archivo == null) {
      // Intento de fallback: buscar en cuentos_sep.json por defecto o retornar null
      return null;
    }

    try {
      // 2. Cargamos el JSON
      final jsonString = await rootBundle.loadString('assets/json/historias/$archivo');
      final List<dynamic> lista = json.decode(jsonString);

      // 3. Buscamos el objeto que tenga ese Titulo
      // Normalizamos strings para evitar errores por espacios o mayúsculas
      final historia = lista.firstWhere(
        (item) => item['Titulo']?.toString().trim() == titulo.trim(),
        orElse: () => null,
      );

      if (historia != null) {
        return historia['Texto'] ?? historia['contenido'] ?? '';
      }
    } catch (e) {
      throw Exception("Error obteniendo texto de historia $titulo: $e");
    }
    return null;
  }
}