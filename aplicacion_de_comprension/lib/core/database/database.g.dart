// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TutorTable extends Tutor with TableInfo<$TutorTable, TutorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TutorTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usuarioMeta = const VerificationMeta(
    'usuario',
  );
  @override
  late final GeneratedColumn<String> usuario = GeneratedColumn<String>(
    'usuario',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contraseniaMeta = const VerificationMeta(
    'contrasenia',
  );
  @override
  late final GeneratedColumn<String> contrasenia = GeneratedColumn<String>(
    'contrasenia',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaCreacionMeta = const VerificationMeta(
    'fechaCreacion',
  );
  @override
  late final GeneratedColumn<DateTime> fechaCreacion =
      GeneratedColumn<DateTime>(
        'fecha_creacion',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    usuario,
    contrasenia,
    fechaCreacion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tutor';
  @override
  VerificationContext validateIntegrity(
    Insertable<TutorData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('usuario')) {
      context.handle(
        _usuarioMeta,
        usuario.isAcceptableOrUnknown(data['usuario']!, _usuarioMeta),
      );
    }
    if (data.containsKey('contrasenia')) {
      context.handle(
        _contraseniaMeta,
        contrasenia.isAcceptableOrUnknown(
          data['contrasenia']!,
          _contraseniaMeta,
        ),
      );
    }
    if (data.containsKey('fecha_creacion')) {
      context.handle(
        _fechaCreacionMeta,
        fechaCreacion.isAcceptableOrUnknown(
          data['fecha_creacion']!,
          _fechaCreacionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaCreacionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TutorData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TutorData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      usuario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario'],
      ),
      contrasenia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contrasenia'],
      ),
      fechaCreacion: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_creacion'],
      )!,
    );
  }

  @override
  $TutorTable createAlias(String alias) {
    return $TutorTable(attachedDatabase, alias);
  }
}

class TutorData extends DataClass implements Insertable<TutorData> {
  final String id;
  final String? usuario;
  final String? contrasenia;
  final DateTime fechaCreacion;
  const TutorData({
    required this.id,
    this.usuario,
    this.contrasenia,
    required this.fechaCreacion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || usuario != null) {
      map['usuario'] = Variable<String>(usuario);
    }
    if (!nullToAbsent || contrasenia != null) {
      map['contrasenia'] = Variable<String>(contrasenia);
    }
    map['fecha_creacion'] = Variable<DateTime>(fechaCreacion);
    return map;
  }

  TutorCompanion toCompanion(bool nullToAbsent) {
    return TutorCompanion(
      id: Value(id),
      usuario: usuario == null && nullToAbsent
          ? const Value.absent()
          : Value(usuario),
      contrasenia: contrasenia == null && nullToAbsent
          ? const Value.absent()
          : Value(contrasenia),
      fechaCreacion: Value(fechaCreacion),
    );
  }

  factory TutorData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TutorData(
      id: serializer.fromJson<String>(json['id']),
      usuario: serializer.fromJson<String?>(json['usuario']),
      contrasenia: serializer.fromJson<String?>(json['contrasenia']),
      fechaCreacion: serializer.fromJson<DateTime>(json['fechaCreacion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'usuario': serializer.toJson<String?>(usuario),
      'contrasenia': serializer.toJson<String?>(contrasenia),
      'fechaCreacion': serializer.toJson<DateTime>(fechaCreacion),
    };
  }

  TutorData copyWith({
    String? id,
    Value<String?> usuario = const Value.absent(),
    Value<String?> contrasenia = const Value.absent(),
    DateTime? fechaCreacion,
  }) => TutorData(
    id: id ?? this.id,
    usuario: usuario.present ? usuario.value : this.usuario,
    contrasenia: contrasenia.present ? contrasenia.value : this.contrasenia,
    fechaCreacion: fechaCreacion ?? this.fechaCreacion,
  );
  TutorData copyWithCompanion(TutorCompanion data) {
    return TutorData(
      id: data.id.present ? data.id.value : this.id,
      usuario: data.usuario.present ? data.usuario.value : this.usuario,
      contrasenia: data.contrasenia.present
          ? data.contrasenia.value
          : this.contrasenia,
      fechaCreacion: data.fechaCreacion.present
          ? data.fechaCreacion.value
          : this.fechaCreacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TutorData(')
          ..write('id: $id, ')
          ..write('usuario: $usuario, ')
          ..write('contrasenia: $contrasenia, ')
          ..write('fechaCreacion: $fechaCreacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, usuario, contrasenia, fechaCreacion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TutorData &&
          other.id == this.id &&
          other.usuario == this.usuario &&
          other.contrasenia == this.contrasenia &&
          other.fechaCreacion == this.fechaCreacion);
}

class TutorCompanion extends UpdateCompanion<TutorData> {
  final Value<String> id;
  final Value<String?> usuario;
  final Value<String?> contrasenia;
  final Value<DateTime> fechaCreacion;
  final Value<int> rowid;
  const TutorCompanion({
    this.id = const Value.absent(),
    this.usuario = const Value.absent(),
    this.contrasenia = const Value.absent(),
    this.fechaCreacion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TutorCompanion.insert({
    required String id,
    this.usuario = const Value.absent(),
    this.contrasenia = const Value.absent(),
    required DateTime fechaCreacion,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fechaCreacion = Value(fechaCreacion);
  static Insertable<TutorData> custom({
    Expression<String>? id,
    Expression<String>? usuario,
    Expression<String>? contrasenia,
    Expression<DateTime>? fechaCreacion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuario != null) 'usuario': usuario,
      if (contrasenia != null) 'contrasenia': contrasenia,
      if (fechaCreacion != null) 'fecha_creacion': fechaCreacion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TutorCompanion copyWith({
    Value<String>? id,
    Value<String?>? usuario,
    Value<String?>? contrasenia,
    Value<DateTime>? fechaCreacion,
    Value<int>? rowid,
  }) {
    return TutorCompanion(
      id: id ?? this.id,
      usuario: usuario ?? this.usuario,
      contrasenia: contrasenia ?? this.contrasenia,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (usuario.present) {
      map['usuario'] = Variable<String>(usuario.value);
    }
    if (contrasenia.present) {
      map['contrasenia'] = Variable<String>(contrasenia.value);
    }
    if (fechaCreacion.present) {
      map['fecha_creacion'] = Variable<DateTime>(fechaCreacion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TutorCompanion(')
          ..write('id: $id, ')
          ..write('usuario: $usuario, ')
          ..write('contrasenia: $contrasenia, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PerfilesTable extends Perfiles with TableInfo<$PerfilesTable, Perfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PerfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tutorIdMeta = const VerificationMeta(
    'tutorId',
  );
  @override
  late final GeneratedColumn<String> tutorId = GeneratedColumn<String>(
    'tutor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tutor (id)',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codigoAvatarMeta = const VerificationMeta(
    'codigoAvatar',
  );
  @override
  late final GeneratedColumn<String> codigoAvatar = GeneratedColumn<String>(
    'codigo_avatar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tutorId,
    nombre,
    codigoAvatar,
    activo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'perfiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Perfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tutor_id')) {
      context.handle(
        _tutorIdMeta,
        tutorId.isAcceptableOrUnknown(data['tutor_id']!, _tutorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tutorIdMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('codigo_avatar')) {
      context.handle(
        _codigoAvatarMeta,
        codigoAvatar.isAcceptableOrUnknown(
          data['codigo_avatar']!,
          _codigoAvatarMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_codigoAvatarMeta);
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Perfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Perfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tutorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tutor_id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      codigoAvatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo_avatar'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
    );
  }

  @override
  $PerfilesTable createAlias(String alias) {
    return $PerfilesTable(attachedDatabase, alias);
  }
}

class Perfile extends DataClass implements Insertable<Perfile> {
  final String id;
  final String tutorId;
  final String nombre;
  final String codigoAvatar;
  final bool activo;
  const Perfile({
    required this.id,
    required this.tutorId,
    required this.nombre,
    required this.codigoAvatar,
    required this.activo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tutor_id'] = Variable<String>(tutorId);
    map['nombre'] = Variable<String>(nombre);
    map['codigo_avatar'] = Variable<String>(codigoAvatar);
    map['activo'] = Variable<bool>(activo);
    return map;
  }

  PerfilesCompanion toCompanion(bool nullToAbsent) {
    return PerfilesCompanion(
      id: Value(id),
      tutorId: Value(tutorId),
      nombre: Value(nombre),
      codigoAvatar: Value(codigoAvatar),
      activo: Value(activo),
    );
  }

  factory Perfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Perfile(
      id: serializer.fromJson<String>(json['id']),
      tutorId: serializer.fromJson<String>(json['tutorId']),
      nombre: serializer.fromJson<String>(json['nombre']),
      codigoAvatar: serializer.fromJson<String>(json['codigoAvatar']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tutorId': serializer.toJson<String>(tutorId),
      'nombre': serializer.toJson<String>(nombre),
      'codigoAvatar': serializer.toJson<String>(codigoAvatar),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  Perfile copyWith({
    String? id,
    String? tutorId,
    String? nombre,
    String? codigoAvatar,
    bool? activo,
  }) => Perfile(
    id: id ?? this.id,
    tutorId: tutorId ?? this.tutorId,
    nombre: nombre ?? this.nombre,
    codigoAvatar: codigoAvatar ?? this.codigoAvatar,
    activo: activo ?? this.activo,
  );
  Perfile copyWithCompanion(PerfilesCompanion data) {
    return Perfile(
      id: data.id.present ? data.id.value : this.id,
      tutorId: data.tutorId.present ? data.tutorId.value : this.tutorId,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      codigoAvatar: data.codigoAvatar.present
          ? data.codigoAvatar.value
          : this.codigoAvatar,
      activo: data.activo.present ? data.activo.value : this.activo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Perfile(')
          ..write('id: $id, ')
          ..write('tutorId: $tutorId, ')
          ..write('nombre: $nombre, ')
          ..write('codigoAvatar: $codigoAvatar, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tutorId, nombre, codigoAvatar, activo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Perfile &&
          other.id == this.id &&
          other.tutorId == this.tutorId &&
          other.nombre == this.nombre &&
          other.codigoAvatar == this.codigoAvatar &&
          other.activo == this.activo);
}

class PerfilesCompanion extends UpdateCompanion<Perfile> {
  final Value<String> id;
  final Value<String> tutorId;
  final Value<String> nombre;
  final Value<String> codigoAvatar;
  final Value<bool> activo;
  final Value<int> rowid;
  const PerfilesCompanion({
    this.id = const Value.absent(),
    this.tutorId = const Value.absent(),
    this.nombre = const Value.absent(),
    this.codigoAvatar = const Value.absent(),
    this.activo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PerfilesCompanion.insert({
    required String id,
    required String tutorId,
    required String nombre,
    required String codigoAvatar,
    this.activo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tutorId = Value(tutorId),
       nombre = Value(nombre),
       codigoAvatar = Value(codigoAvatar);
  static Insertable<Perfile> custom({
    Expression<String>? id,
    Expression<String>? tutorId,
    Expression<String>? nombre,
    Expression<String>? codigoAvatar,
    Expression<bool>? activo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tutorId != null) 'tutor_id': tutorId,
      if (nombre != null) 'nombre': nombre,
      if (codigoAvatar != null) 'codigo_avatar': codigoAvatar,
      if (activo != null) 'activo': activo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PerfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? tutorId,
    Value<String>? nombre,
    Value<String>? codigoAvatar,
    Value<bool>? activo,
    Value<int>? rowid,
  }) {
    return PerfilesCompanion(
      id: id ?? this.id,
      tutorId: tutorId ?? this.tutorId,
      nombre: nombre ?? this.nombre,
      codigoAvatar: codigoAvatar ?? this.codigoAvatar,
      activo: activo ?? this.activo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tutorId.present) {
      map['tutor_id'] = Variable<String>(tutorId.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (codigoAvatar.present) {
      map['codigo_avatar'] = Variable<String>(codigoAvatar.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PerfilesCompanion(')
          ..write('id: $id, ')
          ..write('tutorId: $tutorId, ')
          ..write('nombre: $nombre, ')
          ..write('codigoAvatar: $codigoAvatar, ')
          ..write('activo: $activo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConfiguracionesTable extends Configuraciones
    with TableInfo<$ConfiguracionesTable, Configuracione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfiguracionesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tutorIdMeta = const VerificationMeta(
    'tutorId',
  );
  @override
  late final GeneratedColumn<String> tutorId = GeneratedColumn<String>(
    'tutor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tutor (id)',
    ),
  );
  static const VerificationMeta _ttsHabilitadoMeta = const VerificationMeta(
    'ttsHabilitado',
  );
  @override
  late final GeneratedColumn<bool> ttsHabilitado = GeneratedColumn<bool>(
    'tts_habilitado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("tts_habilitado" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _ttsFrecuenciaMeta = const VerificationMeta(
    'ttsFrecuencia',
  );
  @override
  late final GeneratedColumn<double> ttsFrecuencia = GeneratedColumn<double>(
    'tts_frecuencia',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.5),
  );
  static const VerificationMeta _ttsTonoMeta = const VerificationMeta(
    'ttsTono',
  );
  @override
  late final GeneratedColumn<double> ttsTono = GeneratedColumn<double>(
    'tts_tono',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _parentalLockMeta = const VerificationMeta(
    'parentalLock',
  );
  @override
  late final GeneratedColumn<bool> parentalLock = GeneratedColumn<bool>(
    'parental_lock',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("parental_lock" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    tutorId,
    ttsHabilitado,
    ttsFrecuencia,
    ttsTono,
    parentalLock,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'configuraciones';
  @override
  VerificationContext validateIntegrity(
    Insertable<Configuracione> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tutor_id')) {
      context.handle(
        _tutorIdMeta,
        tutorId.isAcceptableOrUnknown(data['tutor_id']!, _tutorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tutorIdMeta);
    }
    if (data.containsKey('tts_habilitado')) {
      context.handle(
        _ttsHabilitadoMeta,
        ttsHabilitado.isAcceptableOrUnknown(
          data['tts_habilitado']!,
          _ttsHabilitadoMeta,
        ),
      );
    }
    if (data.containsKey('tts_frecuencia')) {
      context.handle(
        _ttsFrecuenciaMeta,
        ttsFrecuencia.isAcceptableOrUnknown(
          data['tts_frecuencia']!,
          _ttsFrecuenciaMeta,
        ),
      );
    }
    if (data.containsKey('tts_tono')) {
      context.handle(
        _ttsTonoMeta,
        ttsTono.isAcceptableOrUnknown(data['tts_tono']!, _ttsTonoMeta),
      );
    }
    if (data.containsKey('parental_lock')) {
      context.handle(
        _parentalLockMeta,
        parentalLock.isAcceptableOrUnknown(
          data['parental_lock']!,
          _parentalLockMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tutorId};
  @override
  Configuracione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Configuracione(
      tutorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tutor_id'],
      )!,
      ttsHabilitado: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}tts_habilitado'],
      )!,
      ttsFrecuencia: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tts_frecuencia'],
      )!,
      ttsTono: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tts_tono'],
      )!,
      parentalLock: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}parental_lock'],
      )!,
    );
  }

  @override
  $ConfiguracionesTable createAlias(String alias) {
    return $ConfiguracionesTable(attachedDatabase, alias);
  }
}

class Configuracione extends DataClass implements Insertable<Configuracione> {
  final String tutorId;
  final bool ttsHabilitado;
  final double ttsFrecuencia;
  final double ttsTono;
  final bool parentalLock;
  const Configuracione({
    required this.tutorId,
    required this.ttsHabilitado,
    required this.ttsFrecuencia,
    required this.ttsTono,
    required this.parentalLock,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tutor_id'] = Variable<String>(tutorId);
    map['tts_habilitado'] = Variable<bool>(ttsHabilitado);
    map['tts_frecuencia'] = Variable<double>(ttsFrecuencia);
    map['tts_tono'] = Variable<double>(ttsTono);
    map['parental_lock'] = Variable<bool>(parentalLock);
    return map;
  }

  ConfiguracionesCompanion toCompanion(bool nullToAbsent) {
    return ConfiguracionesCompanion(
      tutorId: Value(tutorId),
      ttsHabilitado: Value(ttsHabilitado),
      ttsFrecuencia: Value(ttsFrecuencia),
      ttsTono: Value(ttsTono),
      parentalLock: Value(parentalLock),
    );
  }

  factory Configuracione.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Configuracione(
      tutorId: serializer.fromJson<String>(json['tutorId']),
      ttsHabilitado: serializer.fromJson<bool>(json['ttsHabilitado']),
      ttsFrecuencia: serializer.fromJson<double>(json['ttsFrecuencia']),
      ttsTono: serializer.fromJson<double>(json['ttsTono']),
      parentalLock: serializer.fromJson<bool>(json['parentalLock']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tutorId': serializer.toJson<String>(tutorId),
      'ttsHabilitado': serializer.toJson<bool>(ttsHabilitado),
      'ttsFrecuencia': serializer.toJson<double>(ttsFrecuencia),
      'ttsTono': serializer.toJson<double>(ttsTono),
      'parentalLock': serializer.toJson<bool>(parentalLock),
    };
  }

  Configuracione copyWith({
    String? tutorId,
    bool? ttsHabilitado,
    double? ttsFrecuencia,
    double? ttsTono,
    bool? parentalLock,
  }) => Configuracione(
    tutorId: tutorId ?? this.tutorId,
    ttsHabilitado: ttsHabilitado ?? this.ttsHabilitado,
    ttsFrecuencia: ttsFrecuencia ?? this.ttsFrecuencia,
    ttsTono: ttsTono ?? this.ttsTono,
    parentalLock: parentalLock ?? this.parentalLock,
  );
  Configuracione copyWithCompanion(ConfiguracionesCompanion data) {
    return Configuracione(
      tutorId: data.tutorId.present ? data.tutorId.value : this.tutorId,
      ttsHabilitado: data.ttsHabilitado.present
          ? data.ttsHabilitado.value
          : this.ttsHabilitado,
      ttsFrecuencia: data.ttsFrecuencia.present
          ? data.ttsFrecuencia.value
          : this.ttsFrecuencia,
      ttsTono: data.ttsTono.present ? data.ttsTono.value : this.ttsTono,
      parentalLock: data.parentalLock.present
          ? data.parentalLock.value
          : this.parentalLock,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Configuracione(')
          ..write('tutorId: $tutorId, ')
          ..write('ttsHabilitado: $ttsHabilitado, ')
          ..write('ttsFrecuencia: $ttsFrecuencia, ')
          ..write('ttsTono: $ttsTono, ')
          ..write('parentalLock: $parentalLock')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(tutorId, ttsHabilitado, ttsFrecuencia, ttsTono, parentalLock);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Configuracione &&
          other.tutorId == this.tutorId &&
          other.ttsHabilitado == this.ttsHabilitado &&
          other.ttsFrecuencia == this.ttsFrecuencia &&
          other.ttsTono == this.ttsTono &&
          other.parentalLock == this.parentalLock);
}

class ConfiguracionesCompanion extends UpdateCompanion<Configuracione> {
  final Value<String> tutorId;
  final Value<bool> ttsHabilitado;
  final Value<double> ttsFrecuencia;
  final Value<double> ttsTono;
  final Value<bool> parentalLock;
  final Value<int> rowid;
  const ConfiguracionesCompanion({
    this.tutorId = const Value.absent(),
    this.ttsHabilitado = const Value.absent(),
    this.ttsFrecuencia = const Value.absent(),
    this.ttsTono = const Value.absent(),
    this.parentalLock = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConfiguracionesCompanion.insert({
    required String tutorId,
    this.ttsHabilitado = const Value.absent(),
    this.ttsFrecuencia = const Value.absent(),
    this.ttsTono = const Value.absent(),
    this.parentalLock = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : tutorId = Value(tutorId);
  static Insertable<Configuracione> custom({
    Expression<String>? tutorId,
    Expression<bool>? ttsHabilitado,
    Expression<double>? ttsFrecuencia,
    Expression<double>? ttsTono,
    Expression<bool>? parentalLock,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tutorId != null) 'tutor_id': tutorId,
      if (ttsHabilitado != null) 'tts_habilitado': ttsHabilitado,
      if (ttsFrecuencia != null) 'tts_frecuencia': ttsFrecuencia,
      if (ttsTono != null) 'tts_tono': ttsTono,
      if (parentalLock != null) 'parental_lock': parentalLock,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConfiguracionesCompanion copyWith({
    Value<String>? tutorId,
    Value<bool>? ttsHabilitado,
    Value<double>? ttsFrecuencia,
    Value<double>? ttsTono,
    Value<bool>? parentalLock,
    Value<int>? rowid,
  }) {
    return ConfiguracionesCompanion(
      tutorId: tutorId ?? this.tutorId,
      ttsHabilitado: ttsHabilitado ?? this.ttsHabilitado,
      ttsFrecuencia: ttsFrecuencia ?? this.ttsFrecuencia,
      ttsTono: ttsTono ?? this.ttsTono,
      parentalLock: parentalLock ?? this.parentalLock,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tutorId.present) {
      map['tutor_id'] = Variable<String>(tutorId.value);
    }
    if (ttsHabilitado.present) {
      map['tts_habilitado'] = Variable<bool>(ttsHabilitado.value);
    }
    if (ttsFrecuencia.present) {
      map['tts_frecuencia'] = Variable<double>(ttsFrecuencia.value);
    }
    if (ttsTono.present) {
      map['tts_tono'] = Variable<double>(ttsTono.value);
    }
    if (parentalLock.present) {
      map['parental_lock'] = Variable<bool>(parentalLock.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfiguracionesCompanion(')
          ..write('tutorId: $tutorId, ')
          ..write('ttsHabilitado: $ttsHabilitado, ')
          ..write('ttsFrecuencia: $ttsFrecuencia, ')
          ..write('ttsTono: $ttsTono, ')
          ..write('parentalLock: $parentalLock, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KvStoreTable extends KvStore with TableInfo<$KvStoreTable, KvStoreData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KvStoreTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kv_store';
  @override
  VerificationContext validateIntegrity(
    Insertable<KvStoreData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  KvStoreData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KvStoreData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $KvStoreTable createAlias(String alias) {
    return $KvStoreTable(attachedDatabase, alias);
  }
}

class KvStoreData extends DataClass implements Insertable<KvStoreData> {
  final String key;
  final String value;
  const KvStoreData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  KvStoreCompanion toCompanion(bool nullToAbsent) {
    return KvStoreCompanion(key: Value(key), value: Value(value));
  }

  factory KvStoreData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KvStoreData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  KvStoreData copyWith({String? key, String? value}) =>
      KvStoreData(key: key ?? this.key, value: value ?? this.value);
  KvStoreData copyWithCompanion(KvStoreCompanion data) {
    return KvStoreData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KvStoreData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KvStoreData &&
          other.key == this.key &&
          other.value == this.value);
}

class KvStoreCompanion extends UpdateCompanion<KvStoreData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const KvStoreCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KvStoreCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<KvStoreData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KvStoreCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return KvStoreCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KvStoreCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TutorTable tutor = $TutorTable(this);
  late final $PerfilesTable perfiles = $PerfilesTable(this);
  late final $ConfiguracionesTable configuraciones = $ConfiguracionesTable(
    this,
  );
  late final $KvStoreTable kvStore = $KvStoreTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tutor,
    perfiles,
    configuraciones,
    kvStore,
  ];
}

typedef $$TutorTableCreateCompanionBuilder =
    TutorCompanion Function({
      required String id,
      Value<String?> usuario,
      Value<String?> contrasenia,
      required DateTime fechaCreacion,
      Value<int> rowid,
    });
typedef $$TutorTableUpdateCompanionBuilder =
    TutorCompanion Function({
      Value<String> id,
      Value<String?> usuario,
      Value<String?> contrasenia,
      Value<DateTime> fechaCreacion,
      Value<int> rowid,
    });

final class $$TutorTableReferences
    extends BaseReferences<_$AppDatabase, $TutorTable, TutorData> {
  $$TutorTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PerfilesTable, List<Perfile>> _perfilesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.perfiles,
    aliasName: $_aliasNameGenerator(db.tutor.id, db.perfiles.tutorId),
  );

  $$PerfilesTableProcessedTableManager get perfilesRefs {
    final manager = $$PerfilesTableTableManager(
      $_db,
      $_db.perfiles,
    ).filter((f) => f.tutorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_perfilesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ConfiguracionesTable, List<Configuracione>>
  _configuracionesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.configuraciones,
    aliasName: $_aliasNameGenerator(db.tutor.id, db.configuraciones.tutorId),
  );

  $$ConfiguracionesTableProcessedTableManager get configuracionesRefs {
    final manager = $$ConfiguracionesTableTableManager(
      $_db,
      $_db.configuraciones,
    ).filter((f) => f.tutorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _configuracionesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TutorTableFilterComposer extends Composer<_$AppDatabase, $TutorTable> {
  $$TutorTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usuario => $composableBuilder(
    column: $table.usuario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contrasenia => $composableBuilder(
    column: $table.contrasenia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> perfilesRefs(
    Expression<bool> Function($$PerfilesTableFilterComposer f) f,
  ) {
    final $$PerfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.perfiles,
      getReferencedColumn: (t) => t.tutorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PerfilesTableFilterComposer(
            $db: $db,
            $table: $db.perfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> configuracionesRefs(
    Expression<bool> Function($$ConfiguracionesTableFilterComposer f) f,
  ) {
    final $$ConfiguracionesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.configuraciones,
      getReferencedColumn: (t) => t.tutorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConfiguracionesTableFilterComposer(
            $db: $db,
            $table: $db.configuraciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TutorTableOrderingComposer
    extends Composer<_$AppDatabase, $TutorTable> {
  $$TutorTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usuario => $composableBuilder(
    column: $table.usuario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contrasenia => $composableBuilder(
    column: $table.contrasenia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TutorTableAnnotationComposer
    extends Composer<_$AppDatabase, $TutorTable> {
  $$TutorTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get usuario =>
      $composableBuilder(column: $table.usuario, builder: (column) => column);

  GeneratedColumn<String> get contrasenia => $composableBuilder(
    column: $table.contrasenia,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => column,
  );

  Expression<T> perfilesRefs<T extends Object>(
    Expression<T> Function($$PerfilesTableAnnotationComposer a) f,
  ) {
    final $$PerfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.perfiles,
      getReferencedColumn: (t) => t.tutorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PerfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.perfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> configuracionesRefs<T extends Object>(
    Expression<T> Function($$ConfiguracionesTableAnnotationComposer a) f,
  ) {
    final $$ConfiguracionesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.configuraciones,
      getReferencedColumn: (t) => t.tutorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConfiguracionesTableAnnotationComposer(
            $db: $db,
            $table: $db.configuraciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TutorTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TutorTable,
          TutorData,
          $$TutorTableFilterComposer,
          $$TutorTableOrderingComposer,
          $$TutorTableAnnotationComposer,
          $$TutorTableCreateCompanionBuilder,
          $$TutorTableUpdateCompanionBuilder,
          (TutorData, $$TutorTableReferences),
          TutorData,
          PrefetchHooks Function({bool perfilesRefs, bool configuracionesRefs})
        > {
  $$TutorTableTableManager(_$AppDatabase db, $TutorTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TutorTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TutorTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TutorTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> usuario = const Value.absent(),
                Value<String?> contrasenia = const Value.absent(),
                Value<DateTime> fechaCreacion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TutorCompanion(
                id: id,
                usuario: usuario,
                contrasenia: contrasenia,
                fechaCreacion: fechaCreacion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> usuario = const Value.absent(),
                Value<String?> contrasenia = const Value.absent(),
                required DateTime fechaCreacion,
                Value<int> rowid = const Value.absent(),
              }) => TutorCompanion.insert(
                id: id,
                usuario: usuario,
                contrasenia: contrasenia,
                fechaCreacion: fechaCreacion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TutorTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({perfilesRefs = false, configuracionesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (perfilesRefs) db.perfiles,
                    if (configuracionesRefs) db.configuraciones,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (perfilesRefs)
                        await $_getPrefetchedData<
                          TutorData,
                          $TutorTable,
                          Perfile
                        >(
                          currentTable: table,
                          referencedTable: $$TutorTableReferences
                              ._perfilesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TutorTableReferences(
                                db,
                                table,
                                p0,
                              ).perfilesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tutorId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (configuracionesRefs)
                        await $_getPrefetchedData<
                          TutorData,
                          $TutorTable,
                          Configuracione
                        >(
                          currentTable: table,
                          referencedTable: $$TutorTableReferences
                              ._configuracionesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TutorTableReferences(
                                db,
                                table,
                                p0,
                              ).configuracionesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tutorId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TutorTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TutorTable,
      TutorData,
      $$TutorTableFilterComposer,
      $$TutorTableOrderingComposer,
      $$TutorTableAnnotationComposer,
      $$TutorTableCreateCompanionBuilder,
      $$TutorTableUpdateCompanionBuilder,
      (TutorData, $$TutorTableReferences),
      TutorData,
      PrefetchHooks Function({bool perfilesRefs, bool configuracionesRefs})
    >;
typedef $$PerfilesTableCreateCompanionBuilder =
    PerfilesCompanion Function({
      required String id,
      required String tutorId,
      required String nombre,
      required String codigoAvatar,
      Value<bool> activo,
      Value<int> rowid,
    });
typedef $$PerfilesTableUpdateCompanionBuilder =
    PerfilesCompanion Function({
      Value<String> id,
      Value<String> tutorId,
      Value<String> nombre,
      Value<String> codigoAvatar,
      Value<bool> activo,
      Value<int> rowid,
    });

final class $$PerfilesTableReferences
    extends BaseReferences<_$AppDatabase, $PerfilesTable, Perfile> {
  $$PerfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TutorTable _tutorIdTable(_$AppDatabase db) => db.tutor.createAlias(
    $_aliasNameGenerator(db.perfiles.tutorId, db.tutor.id),
  );

  $$TutorTableProcessedTableManager get tutorId {
    final $_column = $_itemColumn<String>('tutor_id')!;

    final manager = $$TutorTableTableManager(
      $_db,
      $_db.tutor,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tutorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PerfilesTableFilterComposer
    extends Composer<_$AppDatabase, $PerfilesTable> {
  $$PerfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigoAvatar => $composableBuilder(
    column: $table.codigoAvatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  $$TutorTableFilterComposer get tutorId {
    final $$TutorTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tutorId,
      referencedTable: $db.tutor,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TutorTableFilterComposer(
            $db: $db,
            $table: $db.tutor,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PerfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $PerfilesTable> {
  $$PerfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigoAvatar => $composableBuilder(
    column: $table.codigoAvatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  $$TutorTableOrderingComposer get tutorId {
    final $$TutorTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tutorId,
      referencedTable: $db.tutor,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TutorTableOrderingComposer(
            $db: $db,
            $table: $db.tutor,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PerfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PerfilesTable> {
  $$PerfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get codigoAvatar => $composableBuilder(
    column: $table.codigoAvatar,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  $$TutorTableAnnotationComposer get tutorId {
    final $$TutorTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tutorId,
      referencedTable: $db.tutor,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TutorTableAnnotationComposer(
            $db: $db,
            $table: $db.tutor,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PerfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PerfilesTable,
          Perfile,
          $$PerfilesTableFilterComposer,
          $$PerfilesTableOrderingComposer,
          $$PerfilesTableAnnotationComposer,
          $$PerfilesTableCreateCompanionBuilder,
          $$PerfilesTableUpdateCompanionBuilder,
          (Perfile, $$PerfilesTableReferences),
          Perfile,
          PrefetchHooks Function({bool tutorId})
        > {
  $$PerfilesTableTableManager(_$AppDatabase db, $PerfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PerfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PerfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PerfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tutorId = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> codigoAvatar = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PerfilesCompanion(
                id: id,
                tutorId: tutorId,
                nombre: nombre,
                codigoAvatar: codigoAvatar,
                activo: activo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tutorId,
                required String nombre,
                required String codigoAvatar,
                Value<bool> activo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PerfilesCompanion.insert(
                id: id,
                tutorId: tutorId,
                nombre: nombre,
                codigoAvatar: codigoAvatar,
                activo: activo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PerfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tutorId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tutorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tutorId,
                                referencedTable: $$PerfilesTableReferences
                                    ._tutorIdTable(db),
                                referencedColumn: $$PerfilesTableReferences
                                    ._tutorIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PerfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PerfilesTable,
      Perfile,
      $$PerfilesTableFilterComposer,
      $$PerfilesTableOrderingComposer,
      $$PerfilesTableAnnotationComposer,
      $$PerfilesTableCreateCompanionBuilder,
      $$PerfilesTableUpdateCompanionBuilder,
      (Perfile, $$PerfilesTableReferences),
      Perfile,
      PrefetchHooks Function({bool tutorId})
    >;
typedef $$ConfiguracionesTableCreateCompanionBuilder =
    ConfiguracionesCompanion Function({
      required String tutorId,
      Value<bool> ttsHabilitado,
      Value<double> ttsFrecuencia,
      Value<double> ttsTono,
      Value<bool> parentalLock,
      Value<int> rowid,
    });
typedef $$ConfiguracionesTableUpdateCompanionBuilder =
    ConfiguracionesCompanion Function({
      Value<String> tutorId,
      Value<bool> ttsHabilitado,
      Value<double> ttsFrecuencia,
      Value<double> ttsTono,
      Value<bool> parentalLock,
      Value<int> rowid,
    });

final class $$ConfiguracionesTableReferences
    extends
        BaseReferences<_$AppDatabase, $ConfiguracionesTable, Configuracione> {
  $$ConfiguracionesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TutorTable _tutorIdTable(_$AppDatabase db) => db.tutor.createAlias(
    $_aliasNameGenerator(db.configuraciones.tutorId, db.tutor.id),
  );

  $$TutorTableProcessedTableManager get tutorId {
    final $_column = $_itemColumn<String>('tutor_id')!;

    final manager = $$TutorTableTableManager(
      $_db,
      $_db.tutor,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tutorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ConfiguracionesTableFilterComposer
    extends Composer<_$AppDatabase, $ConfiguracionesTable> {
  $$ConfiguracionesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get ttsHabilitado => $composableBuilder(
    column: $table.ttsHabilitado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ttsFrecuencia => $composableBuilder(
    column: $table.ttsFrecuencia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ttsTono => $composableBuilder(
    column: $table.ttsTono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get parentalLock => $composableBuilder(
    column: $table.parentalLock,
    builder: (column) => ColumnFilters(column),
  );

  $$TutorTableFilterComposer get tutorId {
    final $$TutorTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tutorId,
      referencedTable: $db.tutor,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TutorTableFilterComposer(
            $db: $db,
            $table: $db.tutor,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConfiguracionesTableOrderingComposer
    extends Composer<_$AppDatabase, $ConfiguracionesTable> {
  $$ConfiguracionesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get ttsHabilitado => $composableBuilder(
    column: $table.ttsHabilitado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ttsFrecuencia => $composableBuilder(
    column: $table.ttsFrecuencia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ttsTono => $composableBuilder(
    column: $table.ttsTono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get parentalLock => $composableBuilder(
    column: $table.parentalLock,
    builder: (column) => ColumnOrderings(column),
  );

  $$TutorTableOrderingComposer get tutorId {
    final $$TutorTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tutorId,
      referencedTable: $db.tutor,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TutorTableOrderingComposer(
            $db: $db,
            $table: $db.tutor,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConfiguracionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConfiguracionesTable> {
  $$ConfiguracionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get ttsHabilitado => $composableBuilder(
    column: $table.ttsHabilitado,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ttsFrecuencia => $composableBuilder(
    column: $table.ttsFrecuencia,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ttsTono =>
      $composableBuilder(column: $table.ttsTono, builder: (column) => column);

  GeneratedColumn<bool> get parentalLock => $composableBuilder(
    column: $table.parentalLock,
    builder: (column) => column,
  );

  $$TutorTableAnnotationComposer get tutorId {
    final $$TutorTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tutorId,
      referencedTable: $db.tutor,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TutorTableAnnotationComposer(
            $db: $db,
            $table: $db.tutor,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConfiguracionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConfiguracionesTable,
          Configuracione,
          $$ConfiguracionesTableFilterComposer,
          $$ConfiguracionesTableOrderingComposer,
          $$ConfiguracionesTableAnnotationComposer,
          $$ConfiguracionesTableCreateCompanionBuilder,
          $$ConfiguracionesTableUpdateCompanionBuilder,
          (Configuracione, $$ConfiguracionesTableReferences),
          Configuracione,
          PrefetchHooks Function({bool tutorId})
        > {
  $$ConfiguracionesTableTableManager(
    _$AppDatabase db,
    $ConfiguracionesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConfiguracionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConfiguracionesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConfiguracionesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> tutorId = const Value.absent(),
                Value<bool> ttsHabilitado = const Value.absent(),
                Value<double> ttsFrecuencia = const Value.absent(),
                Value<double> ttsTono = const Value.absent(),
                Value<bool> parentalLock = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConfiguracionesCompanion(
                tutorId: tutorId,
                ttsHabilitado: ttsHabilitado,
                ttsFrecuencia: ttsFrecuencia,
                ttsTono: ttsTono,
                parentalLock: parentalLock,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String tutorId,
                Value<bool> ttsHabilitado = const Value.absent(),
                Value<double> ttsFrecuencia = const Value.absent(),
                Value<double> ttsTono = const Value.absent(),
                Value<bool> parentalLock = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConfiguracionesCompanion.insert(
                tutorId: tutorId,
                ttsHabilitado: ttsHabilitado,
                ttsFrecuencia: ttsFrecuencia,
                ttsTono: ttsTono,
                parentalLock: parentalLock,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ConfiguracionesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tutorId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tutorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tutorId,
                                referencedTable:
                                    $$ConfiguracionesTableReferences
                                        ._tutorIdTable(db),
                                referencedColumn:
                                    $$ConfiguracionesTableReferences
                                        ._tutorIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ConfiguracionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConfiguracionesTable,
      Configuracione,
      $$ConfiguracionesTableFilterComposer,
      $$ConfiguracionesTableOrderingComposer,
      $$ConfiguracionesTableAnnotationComposer,
      $$ConfiguracionesTableCreateCompanionBuilder,
      $$ConfiguracionesTableUpdateCompanionBuilder,
      (Configuracione, $$ConfiguracionesTableReferences),
      Configuracione,
      PrefetchHooks Function({bool tutorId})
    >;
typedef $$KvStoreTableCreateCompanionBuilder =
    KvStoreCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$KvStoreTableUpdateCompanionBuilder =
    KvStoreCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$KvStoreTableFilterComposer
    extends Composer<_$AppDatabase, $KvStoreTable> {
  $$KvStoreTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KvStoreTableOrderingComposer
    extends Composer<_$AppDatabase, $KvStoreTable> {
  $$KvStoreTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KvStoreTableAnnotationComposer
    extends Composer<_$AppDatabase, $KvStoreTable> {
  $$KvStoreTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$KvStoreTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KvStoreTable,
          KvStoreData,
          $$KvStoreTableFilterComposer,
          $$KvStoreTableOrderingComposer,
          $$KvStoreTableAnnotationComposer,
          $$KvStoreTableCreateCompanionBuilder,
          $$KvStoreTableUpdateCompanionBuilder,
          (
            KvStoreData,
            BaseReferences<_$AppDatabase, $KvStoreTable, KvStoreData>,
          ),
          KvStoreData,
          PrefetchHooks Function()
        > {
  $$KvStoreTableTableManager(_$AppDatabase db, $KvStoreTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KvStoreTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KvStoreTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KvStoreTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KvStoreCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) =>
                  KvStoreCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KvStoreTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KvStoreTable,
      KvStoreData,
      $$KvStoreTableFilterComposer,
      $$KvStoreTableOrderingComposer,
      $$KvStoreTableAnnotationComposer,
      $$KvStoreTableCreateCompanionBuilder,
      $$KvStoreTableUpdateCompanionBuilder,
      (KvStoreData, BaseReferences<_$AppDatabase, $KvStoreTable, KvStoreData>),
      KvStoreData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TutorTableTableManager get tutor =>
      $$TutorTableTableManager(_db, _db.tutor);
  $$PerfilesTableTableManager get perfiles =>
      $$PerfilesTableTableManager(_db, _db.perfiles);
  $$ConfiguracionesTableTableManager get configuraciones =>
      $$ConfiguracionesTableTableManager(_db, _db.configuraciones);
  $$KvStoreTableTableManager get kvStore =>
      $$KvStoreTableTableManager(_db, _db.kvStore);
}
