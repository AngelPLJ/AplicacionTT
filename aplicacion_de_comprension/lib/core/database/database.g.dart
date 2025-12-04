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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinSeguridadMeta = const VerificationMeta(
    'pinSeguridad',
  );
  @override
  late final GeneratedColumn<String> pinSeguridad = GeneratedColumn<String>(
    'pin_seguridad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
        requiredDuringInsert: false,
        defaultValue: currentDate,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    usuario,
    pinSeguridad,
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
    } else if (isInserting) {
      context.missing(_usuarioMeta);
    }
    if (data.containsKey('pin_seguridad')) {
      context.handle(
        _pinSeguridadMeta,
        pinSeguridad.isAcceptableOrUnknown(
          data['pin_seguridad']!,
          _pinSeguridadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pinSeguridadMeta);
    }
    if (data.containsKey('fecha_creacion')) {
      context.handle(
        _fechaCreacionMeta,
        fechaCreacion.isAcceptableOrUnknown(
          data['fecha_creacion']!,
          _fechaCreacionMeta,
        ),
      );
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
      )!,
      pinSeguridad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_seguridad'],
      )!,
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
  final String usuario;
  final String pinSeguridad;
  final DateTime fechaCreacion;
  const TutorData({
    required this.id,
    required this.usuario,
    required this.pinSeguridad,
    required this.fechaCreacion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['usuario'] = Variable<String>(usuario);
    map['pin_seguridad'] = Variable<String>(pinSeguridad);
    map['fecha_creacion'] = Variable<DateTime>(fechaCreacion);
    return map;
  }

  TutorCompanion toCompanion(bool nullToAbsent) {
    return TutorCompanion(
      id: Value(id),
      usuario: Value(usuario),
      pinSeguridad: Value(pinSeguridad),
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
      usuario: serializer.fromJson<String>(json['usuario']),
      pinSeguridad: serializer.fromJson<String>(json['pinSeguridad']),
      fechaCreacion: serializer.fromJson<DateTime>(json['fechaCreacion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'usuario': serializer.toJson<String>(usuario),
      'pinSeguridad': serializer.toJson<String>(pinSeguridad),
      'fechaCreacion': serializer.toJson<DateTime>(fechaCreacion),
    };
  }

  TutorData copyWith({
    String? id,
    String? usuario,
    String? pinSeguridad,
    DateTime? fechaCreacion,
  }) => TutorData(
    id: id ?? this.id,
    usuario: usuario ?? this.usuario,
    pinSeguridad: pinSeguridad ?? this.pinSeguridad,
    fechaCreacion: fechaCreacion ?? this.fechaCreacion,
  );
  TutorData copyWithCompanion(TutorCompanion data) {
    return TutorData(
      id: data.id.present ? data.id.value : this.id,
      usuario: data.usuario.present ? data.usuario.value : this.usuario,
      pinSeguridad: data.pinSeguridad.present
          ? data.pinSeguridad.value
          : this.pinSeguridad,
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
          ..write('pinSeguridad: $pinSeguridad, ')
          ..write('fechaCreacion: $fechaCreacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, usuario, pinSeguridad, fechaCreacion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TutorData &&
          other.id == this.id &&
          other.usuario == this.usuario &&
          other.pinSeguridad == this.pinSeguridad &&
          other.fechaCreacion == this.fechaCreacion);
}

class TutorCompanion extends UpdateCompanion<TutorData> {
  final Value<String> id;
  final Value<String> usuario;
  final Value<String> pinSeguridad;
  final Value<DateTime> fechaCreacion;
  final Value<int> rowid;
  const TutorCompanion({
    this.id = const Value.absent(),
    this.usuario = const Value.absent(),
    this.pinSeguridad = const Value.absent(),
    this.fechaCreacion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TutorCompanion.insert({
    required String id,
    required String usuario,
    required String pinSeguridad,
    this.fechaCreacion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       usuario = Value(usuario),
       pinSeguridad = Value(pinSeguridad);
  static Insertable<TutorData> custom({
    Expression<String>? id,
    Expression<String>? usuario,
    Expression<String>? pinSeguridad,
    Expression<DateTime>? fechaCreacion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuario != null) 'usuario': usuario,
      if (pinSeguridad != null) 'pin_seguridad': pinSeguridad,
      if (fechaCreacion != null) 'fecha_creacion': fechaCreacion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TutorCompanion copyWith({
    Value<String>? id,
    Value<String>? usuario,
    Value<String>? pinSeguridad,
    Value<DateTime>? fechaCreacion,
    Value<int>? rowid,
  }) {
    return TutorCompanion(
      id: id ?? this.id,
      usuario: usuario ?? this.usuario,
      pinSeguridad: pinSeguridad ?? this.pinSeguridad,
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
    if (pinSeguridad.present) {
      map['pin_seguridad'] = Variable<String>(pinSeguridad.value);
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
          ..write('pinSeguridad: $pinSeguridad, ')
          ..write('fechaCreacion: $fechaCreacion, ')
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

class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconoMeta = const VerificationMeta('icono');
  @override
  late final GeneratedColumn<String> icono = GeneratedColumn<String>(
    'icono',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
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
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, tutorId, nombre, icono, activo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Usuario> instance, {
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
    if (data.containsKey('icono')) {
      context.handle(
        _iconoMeta,
        icono.isAcceptableOrUnknown(data['icono']!, _iconoMeta),
      );
    } else if (isInserting) {
      context.missing(_iconoMeta);
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
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
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
      icono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icono'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final String id;
  final String tutorId;
  final String nombre;
  final String icono;
  final bool activo;
  const Usuario({
    required this.id,
    required this.tutorId,
    required this.nombre,
    required this.icono,
    required this.activo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tutor_id'] = Variable<String>(tutorId);
    map['nombre'] = Variable<String>(nombre);
    map['icono'] = Variable<String>(icono);
    map['activo'] = Variable<bool>(activo);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      id: Value(id),
      tutorId: Value(tutorId),
      nombre: Value(nombre),
      icono: Value(icono),
      activo: Value(activo),
    );
  }

  factory Usuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      id: serializer.fromJson<String>(json['id']),
      tutorId: serializer.fromJson<String>(json['tutorId']),
      nombre: serializer.fromJson<String>(json['nombre']),
      icono: serializer.fromJson<String>(json['icono']),
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
      'icono': serializer.toJson<String>(icono),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  Usuario copyWith({
    String? id,
    String? tutorId,
    String? nombre,
    String? icono,
    bool? activo,
  }) => Usuario(
    id: id ?? this.id,
    tutorId: tutorId ?? this.tutorId,
    nombre: nombre ?? this.nombre,
    icono: icono ?? this.icono,
    activo: activo ?? this.activo,
  );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      id: data.id.present ? data.id.value : this.id,
      tutorId: data.tutorId.present ? data.tutorId.value : this.tutorId,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      icono: data.icono.present ? data.icono.value : this.icono,
      activo: data.activo.present ? data.activo.value : this.activo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('id: $id, ')
          ..write('tutorId: $tutorId, ')
          ..write('nombre: $nombre, ')
          ..write('icono: $icono, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tutorId, nombre, icono, activo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.id == this.id &&
          other.tutorId == this.tutorId &&
          other.nombre == this.nombre &&
          other.icono == this.icono &&
          other.activo == this.activo);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<String> id;
  final Value<String> tutorId;
  final Value<String> nombre;
  final Value<String> icono;
  final Value<bool> activo;
  final Value<int> rowid;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.tutorId = const Value.absent(),
    this.nombre = const Value.absent(),
    this.icono = const Value.absent(),
    this.activo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsuariosCompanion.insert({
    required String id,
    required String tutorId,
    required String nombre,
    required String icono,
    this.activo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tutorId = Value(tutorId),
       nombre = Value(nombre),
       icono = Value(icono);
  static Insertable<Usuario> custom({
    Expression<String>? id,
    Expression<String>? tutorId,
    Expression<String>? nombre,
    Expression<String>? icono,
    Expression<bool>? activo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tutorId != null) 'tutor_id': tutorId,
      if (nombre != null) 'nombre': nombre,
      if (icono != null) 'icono': icono,
      if (activo != null) 'activo': activo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsuariosCompanion copyWith({
    Value<String>? id,
    Value<String>? tutorId,
    Value<String>? nombre,
    Value<String>? icono,
    Value<bool>? activo,
    Value<int>? rowid,
  }) {
    return UsuariosCompanion(
      id: id ?? this.id,
      tutorId: tutorId ?? this.tutorId,
      nombre: nombre ?? this.nombre,
      icono: icono ?? this.icono,
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
    if (icono.present) {
      map['icono'] = Variable<String>(icono.value);
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
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('tutorId: $tutorId, ')
          ..write('nombre: $nombre, ')
          ..write('icono: $icono, ')
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
  static const VerificationMeta _ttsVelocidadMeta = const VerificationMeta(
    'ttsVelocidad',
  );
  @override
  late final GeneratedColumn<double> ttsVelocidad = GeneratedColumn<double>(
    'tts_velocidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.5),
  );
  static const VerificationMeta _musicaFondoMeta = const VerificationMeta(
    'musicaFondo',
  );
  @override
  late final GeneratedColumn<bool> musicaFondo = GeneratedColumn<bool>(
    'musica_fondo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("musica_fondo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    tutorId,
    ttsHabilitado,
    ttsVelocidad,
    musicaFondo,
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
    if (data.containsKey('tts_velocidad')) {
      context.handle(
        _ttsVelocidadMeta,
        ttsVelocidad.isAcceptableOrUnknown(
          data['tts_velocidad']!,
          _ttsVelocidadMeta,
        ),
      );
    }
    if (data.containsKey('musica_fondo')) {
      context.handle(
        _musicaFondoMeta,
        musicaFondo.isAcceptableOrUnknown(
          data['musica_fondo']!,
          _musicaFondoMeta,
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
      ttsVelocidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tts_velocidad'],
      )!,
      musicaFondo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}musica_fondo'],
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
  final double ttsVelocidad;
  final bool musicaFondo;
  const Configuracione({
    required this.tutorId,
    required this.ttsHabilitado,
    required this.ttsVelocidad,
    required this.musicaFondo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tutor_id'] = Variable<String>(tutorId);
    map['tts_habilitado'] = Variable<bool>(ttsHabilitado);
    map['tts_velocidad'] = Variable<double>(ttsVelocidad);
    map['musica_fondo'] = Variable<bool>(musicaFondo);
    return map;
  }

  ConfiguracionesCompanion toCompanion(bool nullToAbsent) {
    return ConfiguracionesCompanion(
      tutorId: Value(tutorId),
      ttsHabilitado: Value(ttsHabilitado),
      ttsVelocidad: Value(ttsVelocidad),
      musicaFondo: Value(musicaFondo),
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
      ttsVelocidad: serializer.fromJson<double>(json['ttsVelocidad']),
      musicaFondo: serializer.fromJson<bool>(json['musicaFondo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tutorId': serializer.toJson<String>(tutorId),
      'ttsHabilitado': serializer.toJson<bool>(ttsHabilitado),
      'ttsVelocidad': serializer.toJson<double>(ttsVelocidad),
      'musicaFondo': serializer.toJson<bool>(musicaFondo),
    };
  }

  Configuracione copyWith({
    String? tutorId,
    bool? ttsHabilitado,
    double? ttsVelocidad,
    bool? musicaFondo,
  }) => Configuracione(
    tutorId: tutorId ?? this.tutorId,
    ttsHabilitado: ttsHabilitado ?? this.ttsHabilitado,
    ttsVelocidad: ttsVelocidad ?? this.ttsVelocidad,
    musicaFondo: musicaFondo ?? this.musicaFondo,
  );
  Configuracione copyWithCompanion(ConfiguracionesCompanion data) {
    return Configuracione(
      tutorId: data.tutorId.present ? data.tutorId.value : this.tutorId,
      ttsHabilitado: data.ttsHabilitado.present
          ? data.ttsHabilitado.value
          : this.ttsHabilitado,
      ttsVelocidad: data.ttsVelocidad.present
          ? data.ttsVelocidad.value
          : this.ttsVelocidad,
      musicaFondo: data.musicaFondo.present
          ? data.musicaFondo.value
          : this.musicaFondo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Configuracione(')
          ..write('tutorId: $tutorId, ')
          ..write('ttsHabilitado: $ttsHabilitado, ')
          ..write('ttsVelocidad: $ttsVelocidad, ')
          ..write('musicaFondo: $musicaFondo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(tutorId, ttsHabilitado, ttsVelocidad, musicaFondo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Configuracione &&
          other.tutorId == this.tutorId &&
          other.ttsHabilitado == this.ttsHabilitado &&
          other.ttsVelocidad == this.ttsVelocidad &&
          other.musicaFondo == this.musicaFondo);
}

class ConfiguracionesCompanion extends UpdateCompanion<Configuracione> {
  final Value<String> tutorId;
  final Value<bool> ttsHabilitado;
  final Value<double> ttsVelocidad;
  final Value<bool> musicaFondo;
  final Value<int> rowid;
  const ConfiguracionesCompanion({
    this.tutorId = const Value.absent(),
    this.ttsHabilitado = const Value.absent(),
    this.ttsVelocidad = const Value.absent(),
    this.musicaFondo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConfiguracionesCompanion.insert({
    required String tutorId,
    this.ttsHabilitado = const Value.absent(),
    this.ttsVelocidad = const Value.absent(),
    this.musicaFondo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : tutorId = Value(tutorId);
  static Insertable<Configuracione> custom({
    Expression<String>? tutorId,
    Expression<bool>? ttsHabilitado,
    Expression<double>? ttsVelocidad,
    Expression<bool>? musicaFondo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tutorId != null) 'tutor_id': tutorId,
      if (ttsHabilitado != null) 'tts_habilitado': ttsHabilitado,
      if (ttsVelocidad != null) 'tts_velocidad': ttsVelocidad,
      if (musicaFondo != null) 'musica_fondo': musicaFondo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConfiguracionesCompanion copyWith({
    Value<String>? tutorId,
    Value<bool>? ttsHabilitado,
    Value<double>? ttsVelocidad,
    Value<bool>? musicaFondo,
    Value<int>? rowid,
  }) {
    return ConfiguracionesCompanion(
      tutorId: tutorId ?? this.tutorId,
      ttsHabilitado: ttsHabilitado ?? this.ttsHabilitado,
      ttsVelocidad: ttsVelocidad ?? this.ttsVelocidad,
      musicaFondo: musicaFondo ?? this.musicaFondo,
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
    if (ttsVelocidad.present) {
      map['tts_velocidad'] = Variable<double>(ttsVelocidad.value);
    }
    if (musicaFondo.present) {
      map['musica_fondo'] = Variable<bool>(musicaFondo.value);
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
          ..write('ttsVelocidad: $ttsVelocidad, ')
          ..write('musicaFondo: $musicaFondo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NumerosTable extends Numeros with TableInfo<$NumerosTable, Numero> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NumerosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<int> numero = GeneratedColumn<int>(
    'numero',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, numero];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'numeros';
  @override
  VerificationContext validateIntegrity(
    Insertable<Numero> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('numero')) {
      context.handle(
        _numeroMeta,
        numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta),
      );
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Numero map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Numero(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      numero: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero'],
      )!,
    );
  }

  @override
  $NumerosTable createAlias(String alias) {
    return $NumerosTable(attachedDatabase, alias);
  }
}

class Numero extends DataClass implements Insertable<Numero> {
  final int id;
  final int numero;
  const Numero({required this.id, required this.numero});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['numero'] = Variable<int>(numero);
    return map;
  }

  NumerosCompanion toCompanion(bool nullToAbsent) {
    return NumerosCompanion(id: Value(id), numero: Value(numero));
  }

  factory Numero.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Numero(
      id: serializer.fromJson<int>(json['id']),
      numero: serializer.fromJson<int>(json['numero']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'numero': serializer.toJson<int>(numero),
    };
  }

  Numero copyWith({int? id, int? numero}) =>
      Numero(id: id ?? this.id, numero: numero ?? this.numero);
  Numero copyWithCompanion(NumerosCompanion data) {
    return Numero(
      id: data.id.present ? data.id.value : this.id,
      numero: data.numero.present ? data.numero.value : this.numero,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Numero(')
          ..write('id: $id, ')
          ..write('numero: $numero')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, numero);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Numero && other.id == this.id && other.numero == this.numero);
}

class NumerosCompanion extends UpdateCompanion<Numero> {
  final Value<int> id;
  final Value<int> numero;
  const NumerosCompanion({
    this.id = const Value.absent(),
    this.numero = const Value.absent(),
  });
  NumerosCompanion.insert({this.id = const Value.absent(), required int numero})
    : numero = Value(numero);
  static Insertable<Numero> custom({
    Expression<int>? id,
    Expression<int>? numero,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (numero != null) 'numero': numero,
    });
  }

  NumerosCompanion copyWith({Value<int>? id, Value<int>? numero}) {
    return NumerosCompanion(id: id ?? this.id, numero: numero ?? this.numero);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (numero.present) {
      map['numero'] = Variable<int>(numero.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NumerosCompanion(')
          ..write('id: $id, ')
          ..write('numero: $numero')
          ..write(')'))
        .toString();
  }
}

class $FonemasTable extends Fonemas with TableInfo<$FonemasTable, Fonema> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FonemasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fonemaMeta = const VerificationMeta('fonema');
  @override
  late final GeneratedColumn<String> fonema = GeneratedColumn<String>(
    'fonema',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 45),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, fonema];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fonemas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Fonema> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fonema')) {
      context.handle(
        _fonemaMeta,
        fonema.isAcceptableOrUnknown(data['fonema']!, _fonemaMeta),
      );
    } else if (isInserting) {
      context.missing(_fonemaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Fonema map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Fonema(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fonema: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fonema'],
      )!,
    );
  }

  @override
  $FonemasTable createAlias(String alias) {
    return $FonemasTable(attachedDatabase, alias);
  }
}

class Fonema extends DataClass implements Insertable<Fonema> {
  final int id;
  final String fonema;
  const Fonema({required this.id, required this.fonema});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fonema'] = Variable<String>(fonema);
    return map;
  }

  FonemasCompanion toCompanion(bool nullToAbsent) {
    return FonemasCompanion(id: Value(id), fonema: Value(fonema));
  }

  factory Fonema.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fonema(
      id: serializer.fromJson<int>(json['id']),
      fonema: serializer.fromJson<String>(json['fonema']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fonema': serializer.toJson<String>(fonema),
    };
  }

  Fonema copyWith({int? id, String? fonema}) =>
      Fonema(id: id ?? this.id, fonema: fonema ?? this.fonema);
  Fonema copyWithCompanion(FonemasCompanion data) {
    return Fonema(
      id: data.id.present ? data.id.value : this.id,
      fonema: data.fonema.present ? data.fonema.value : this.fonema,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Fonema(')
          ..write('id: $id, ')
          ..write('fonema: $fonema')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fonema);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fonema && other.id == this.id && other.fonema == this.fonema);
}

class FonemasCompanion extends UpdateCompanion<Fonema> {
  final Value<int> id;
  final Value<String> fonema;
  const FonemasCompanion({
    this.id = const Value.absent(),
    this.fonema = const Value.absent(),
  });
  FonemasCompanion.insert({
    this.id = const Value.absent(),
    required String fonema,
  }) : fonema = Value(fonema);
  static Insertable<Fonema> custom({
    Expression<int>? id,
    Expression<String>? fonema,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fonema != null) 'fonema': fonema,
    });
  }

  FonemasCompanion copyWith({Value<int>? id, Value<String>? fonema}) {
    return FonemasCompanion(id: id ?? this.id, fonema: fonema ?? this.fonema);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fonema.present) {
      map['fonema'] = Variable<String>(fonema.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FonemasCompanion(')
          ..write('id: $id, ')
          ..write('fonema: $fonema')
          ..write(')'))
        .toString();
  }
}

class $TipoDePalabraTable extends TipoDePalabra
    with TableInfo<$TipoDePalabraTable, TipoDePalabraData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TipoDePalabraTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 15),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, tipo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tipo_de_palabra';
  @override
  VerificationContext validateIntegrity(
    Insertable<TipoDePalabraData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TipoDePalabraData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TipoDePalabraData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
    );
  }

  @override
  $TipoDePalabraTable createAlias(String alias) {
    return $TipoDePalabraTable(attachedDatabase, alias);
  }
}

class TipoDePalabraData extends DataClass
    implements Insertable<TipoDePalabraData> {
  final int id;
  final String tipo;
  const TipoDePalabraData({required this.id, required this.tipo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tipo'] = Variable<String>(tipo);
    return map;
  }

  TipoDePalabraCompanion toCompanion(bool nullToAbsent) {
    return TipoDePalabraCompanion(id: Value(id), tipo: Value(tipo));
  }

  factory TipoDePalabraData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TipoDePalabraData(
      id: serializer.fromJson<int>(json['id']),
      tipo: serializer.fromJson<String>(json['tipo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipo': serializer.toJson<String>(tipo),
    };
  }

  TipoDePalabraData copyWith({int? id, String? tipo}) =>
      TipoDePalabraData(id: id ?? this.id, tipo: tipo ?? this.tipo);
  TipoDePalabraData copyWithCompanion(TipoDePalabraCompanion data) {
    return TipoDePalabraData(
      id: data.id.present ? data.id.value : this.id,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TipoDePalabraData(')
          ..write('id: $id, ')
          ..write('tipo: $tipo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tipo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TipoDePalabraData &&
          other.id == this.id &&
          other.tipo == this.tipo);
}

class TipoDePalabraCompanion extends UpdateCompanion<TipoDePalabraData> {
  final Value<int> id;
  final Value<String> tipo;
  const TipoDePalabraCompanion({
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
  });
  TipoDePalabraCompanion.insert({
    this.id = const Value.absent(),
    required String tipo,
  }) : tipo = Value(tipo);
  static Insertable<TipoDePalabraData> custom({
    Expression<int>? id,
    Expression<String>? tipo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipo != null) 'tipo': tipo,
    });
  }

  TipoDePalabraCompanion copyWith({Value<int>? id, Value<String>? tipo}) {
    return TipoDePalabraCompanion(id: id ?? this.id, tipo: tipo ?? this.tipo);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TipoDePalabraCompanion(')
          ..write('id: $id, ')
          ..write('tipo: $tipo')
          ..write(')'))
        .toString();
  }
}

class $PalabrasTable extends Palabras with TableInfo<$PalabrasTable, Palabra> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PalabrasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _palabraMeta = const VerificationMeta(
    'palabra',
  );
  @override
  late final GeneratedColumn<String> palabra = GeneratedColumn<String>(
    'palabra',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 24),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoDePalabraIdMeta = const VerificationMeta(
    'tipoDePalabraId',
  );
  @override
  late final GeneratedColumn<int> tipoDePalabraId = GeneratedColumn<int>(
    'tipo_de_palabra_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tipo_de_palabra (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, palabra, tipoDePalabraId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'palabras';
  @override
  VerificationContext validateIntegrity(
    Insertable<Palabra> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('palabra')) {
      context.handle(
        _palabraMeta,
        palabra.isAcceptableOrUnknown(data['palabra']!, _palabraMeta),
      );
    } else if (isInserting) {
      context.missing(_palabraMeta);
    }
    if (data.containsKey('tipo_de_palabra_id')) {
      context.handle(
        _tipoDePalabraIdMeta,
        tipoDePalabraId.isAcceptableOrUnknown(
          data['tipo_de_palabra_id']!,
          _tipoDePalabraIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tipoDePalabraIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Palabra map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Palabra(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      palabra: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}palabra'],
      )!,
      tipoDePalabraId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tipo_de_palabra_id'],
      )!,
    );
  }

  @override
  $PalabrasTable createAlias(String alias) {
    return $PalabrasTable(attachedDatabase, alias);
  }
}

class Palabra extends DataClass implements Insertable<Palabra> {
  final int id;
  final String palabra;
  final int tipoDePalabraId;
  const Palabra({
    required this.id,
    required this.palabra,
    required this.tipoDePalabraId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['palabra'] = Variable<String>(palabra);
    map['tipo_de_palabra_id'] = Variable<int>(tipoDePalabraId);
    return map;
  }

  PalabrasCompanion toCompanion(bool nullToAbsent) {
    return PalabrasCompanion(
      id: Value(id),
      palabra: Value(palabra),
      tipoDePalabraId: Value(tipoDePalabraId),
    );
  }

  factory Palabra.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Palabra(
      id: serializer.fromJson<int>(json['id']),
      palabra: serializer.fromJson<String>(json['palabra']),
      tipoDePalabraId: serializer.fromJson<int>(json['tipoDePalabraId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'palabra': serializer.toJson<String>(palabra),
      'tipoDePalabraId': serializer.toJson<int>(tipoDePalabraId),
    };
  }

  Palabra copyWith({int? id, String? palabra, int? tipoDePalabraId}) => Palabra(
    id: id ?? this.id,
    palabra: palabra ?? this.palabra,
    tipoDePalabraId: tipoDePalabraId ?? this.tipoDePalabraId,
  );
  Palabra copyWithCompanion(PalabrasCompanion data) {
    return Palabra(
      id: data.id.present ? data.id.value : this.id,
      palabra: data.palabra.present ? data.palabra.value : this.palabra,
      tipoDePalabraId: data.tipoDePalabraId.present
          ? data.tipoDePalabraId.value
          : this.tipoDePalabraId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Palabra(')
          ..write('id: $id, ')
          ..write('palabra: $palabra, ')
          ..write('tipoDePalabraId: $tipoDePalabraId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, palabra, tipoDePalabraId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Palabra &&
          other.id == this.id &&
          other.palabra == this.palabra &&
          other.tipoDePalabraId == this.tipoDePalabraId);
}

class PalabrasCompanion extends UpdateCompanion<Palabra> {
  final Value<int> id;
  final Value<String> palabra;
  final Value<int> tipoDePalabraId;
  const PalabrasCompanion({
    this.id = const Value.absent(),
    this.palabra = const Value.absent(),
    this.tipoDePalabraId = const Value.absent(),
  });
  PalabrasCompanion.insert({
    this.id = const Value.absent(),
    required String palabra,
    required int tipoDePalabraId,
  }) : palabra = Value(palabra),
       tipoDePalabraId = Value(tipoDePalabraId);
  static Insertable<Palabra> custom({
    Expression<int>? id,
    Expression<String>? palabra,
    Expression<int>? tipoDePalabraId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (palabra != null) 'palabra': palabra,
      if (tipoDePalabraId != null) 'tipo_de_palabra_id': tipoDePalabraId,
    });
  }

  PalabrasCompanion copyWith({
    Value<int>? id,
    Value<String>? palabra,
    Value<int>? tipoDePalabraId,
  }) {
    return PalabrasCompanion(
      id: id ?? this.id,
      palabra: palabra ?? this.palabra,
      tipoDePalabraId: tipoDePalabraId ?? this.tipoDePalabraId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (palabra.present) {
      map['palabra'] = Variable<String>(palabra.value);
    }
    if (tipoDePalabraId.present) {
      map['tipo_de_palabra_id'] = Variable<int>(tipoDePalabraId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PalabrasCompanion(')
          ..write('id: $id, ')
          ..write('palabra: $palabra, ')
          ..write('tipoDePalabraId: $tipoDePalabraId')
          ..write(')'))
        .toString();
  }
}

class $ModulosTable extends Modulos with TableInfo<$ModulosTable, Modulo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModulosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 45),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'modulos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Modulo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Modulo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Modulo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
    );
  }

  @override
  $ModulosTable createAlias(String alias) {
    return $ModulosTable(attachedDatabase, alias);
  }
}

class Modulo extends DataClass implements Insertable<Modulo> {
  final int id;
  final String nombre;
  const Modulo({required this.id, required this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    return map;
  }

  ModulosCompanion toCompanion(bool nullToAbsent) {
    return ModulosCompanion(id: Value(id), nombre: Value(nombre));
  }

  factory Modulo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Modulo(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  Modulo copyWith({int? id, String? nombre}) =>
      Modulo(id: id ?? this.id, nombre: nombre ?? this.nombre);
  Modulo copyWithCompanion(ModulosCompanion data) {
    return Modulo(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Modulo(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Modulo && other.id == this.id && other.nombre == this.nombre);
}

class ModulosCompanion extends UpdateCompanion<Modulo> {
  final Value<int> id;
  final Value<String> nombre;
  const ModulosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  ModulosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
  }) : nombre = Value(nombre);
  static Insertable<Modulo> custom({
    Expression<int>? id,
    Expression<String>? nombre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
    });
  }

  ModulosCompanion copyWith({Value<int>? id, Value<String>? nombre}) {
    return ModulosCompanion(id: id ?? this.id, nombre: nombre ?? this.nombre);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModulosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }
}

class $ActividadesTable extends Actividades
    with TableInfo<$ActividadesTable, Actividade> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActividadesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 45),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'actividades';
  @override
  VerificationContext validateIntegrity(
    Insertable<Actividade> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Actividade map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Actividade(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      ),
    );
  }

  @override
  $ActividadesTable createAlias(String alias) {
    return $ActividadesTable(attachedDatabase, alias);
  }
}

class Actividade extends DataClass implements Insertable<Actividade> {
  final int id;
  final String? nombre;
  const Actividade({required this.id, this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || nombre != null) {
      map['nombre'] = Variable<String>(nombre);
    }
    return map;
  }

  ActividadesCompanion toCompanion(bool nullToAbsent) {
    return ActividadesCompanion(
      id: Value(id),
      nombre: nombre == null && nullToAbsent
          ? const Value.absent()
          : Value(nombre),
    );
  }

  factory Actividade.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Actividade(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String?>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String?>(nombre),
    };
  }

  Actividade copyWith({
    int? id,
    Value<String?> nombre = const Value.absent(),
  }) => Actividade(
    id: id ?? this.id,
    nombre: nombre.present ? nombre.value : this.nombre,
  );
  Actividade copyWithCompanion(ActividadesCompanion data) {
    return Actividade(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Actividade(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Actividade &&
          other.id == this.id &&
          other.nombre == this.nombre);
}

class ActividadesCompanion extends UpdateCompanion<Actividade> {
  final Value<int> id;
  final Value<String?> nombre;
  const ActividadesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  ActividadesCompanion.insert({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  static Insertable<Actividade> custom({
    Expression<int>? id,
    Expression<String>? nombre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
    });
  }

  ActividadesCompanion copyWith({Value<int>? id, Value<String?>? nombre}) {
    return ActividadesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActividadesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }
}

class $MedallasTable extends Medallas with TableInfo<$MedallasTable, Medalla> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedallasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 45),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagenMeta = const VerificationMeta('imagen');
  @override
  late final GeneratedColumn<String> imagen = GeneratedColumn<String>(
    'imagen',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 45),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetPathMeta = const VerificationMeta(
    'assetPath',
  );
  @override
  late final GeneratedColumn<String> assetPath = GeneratedColumn<String>(
    'asset_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre, imagen, assetPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medallas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Medalla> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('imagen')) {
      context.handle(
        _imagenMeta,
        imagen.isAcceptableOrUnknown(data['imagen']!, _imagenMeta),
      );
    } else if (isInserting) {
      context.missing(_imagenMeta);
    }
    if (data.containsKey('asset_path')) {
      context.handle(
        _assetPathMeta,
        assetPath.isAcceptableOrUnknown(data['asset_path']!, _assetPathMeta),
      );
    } else if (isInserting) {
      context.missing(_assetPathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Medalla map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Medalla(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      imagen: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}imagen'],
      )!,
      assetPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_path'],
      )!,
    );
  }

  @override
  $MedallasTable createAlias(String alias) {
    return $MedallasTable(attachedDatabase, alias);
  }
}

class Medalla extends DataClass implements Insertable<Medalla> {
  final int id;
  final String nombre;
  final String imagen;
  final String assetPath;
  const Medalla({
    required this.id,
    required this.nombre,
    required this.imagen,
    required this.assetPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['imagen'] = Variable<String>(imagen);
    map['asset_path'] = Variable<String>(assetPath);
    return map;
  }

  MedallasCompanion toCompanion(bool nullToAbsent) {
    return MedallasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      imagen: Value(imagen),
      assetPath: Value(assetPath),
    );
  }

  factory Medalla.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Medalla(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      imagen: serializer.fromJson<String>(json['imagen']),
      assetPath: serializer.fromJson<String>(json['assetPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'imagen': serializer.toJson<String>(imagen),
      'assetPath': serializer.toJson<String>(assetPath),
    };
  }

  Medalla copyWith({
    int? id,
    String? nombre,
    String? imagen,
    String? assetPath,
  }) => Medalla(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    imagen: imagen ?? this.imagen,
    assetPath: assetPath ?? this.assetPath,
  );
  Medalla copyWithCompanion(MedallasCompanion data) {
    return Medalla(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      imagen: data.imagen.present ? data.imagen.value : this.imagen,
      assetPath: data.assetPath.present ? data.assetPath.value : this.assetPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Medalla(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('imagen: $imagen, ')
          ..write('assetPath: $assetPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, imagen, assetPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Medalla &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.imagen == this.imagen &&
          other.assetPath == this.assetPath);
}

class MedallasCompanion extends UpdateCompanion<Medalla> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> imagen;
  final Value<String> assetPath;
  const MedallasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.imagen = const Value.absent(),
    this.assetPath = const Value.absent(),
  });
  MedallasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String imagen,
    required String assetPath,
  }) : nombre = Value(nombre),
       imagen = Value(imagen),
       assetPath = Value(assetPath);
  static Insertable<Medalla> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? imagen,
    Expression<String>? assetPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (imagen != null) 'imagen': imagen,
      if (assetPath != null) 'asset_path': assetPath,
    });
  }

  MedallasCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? imagen,
    Value<String>? assetPath,
  }) {
    return MedallasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      imagen: imagen ?? this.imagen,
      assetPath: assetPath ?? this.assetPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (imagen.present) {
      map['imagen'] = Variable<String>(imagen.value);
    }
    if (assetPath.present) {
      map['asset_path'] = Variable<String>(assetPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedallasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('imagen: $imagen, ')
          ..write('assetPath: $assetPath')
          ..write(')'))
        .toString();
  }
}

class $UsuariosHasNumerosTable extends UsuariosHasNumeros
    with TableInfo<$UsuariosHasNumerosTable, UsuariosHasNumero> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosHasNumerosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _numeroIdMeta = const VerificationMeta(
    'numeroId',
  );
  @override
  late final GeneratedColumn<int> numeroId = GeneratedColumn<int>(
    'numero_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES numeros (id)',
    ),
  );
  static const VerificationMeta _aciertosMeta = const VerificationMeta(
    'aciertos',
  );
  @override
  late final GeneratedColumn<int> aciertos = GeneratedColumn<int>(
    'aciertos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [usuarioId, numeroId, aciertos, total];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios_has_numeros';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsuariosHasNumero> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('numero_id')) {
      context.handle(
        _numeroIdMeta,
        numeroId.isAcceptableOrUnknown(data['numero_id']!, _numeroIdMeta),
      );
    } else if (isInserting) {
      context.missing(_numeroIdMeta);
    }
    if (data.containsKey('aciertos')) {
      context.handle(
        _aciertosMeta,
        aciertos.isAcceptableOrUnknown(data['aciertos']!, _aciertosMeta),
      );
    } else if (isInserting) {
      context.missing(_aciertosMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {usuarioId, numeroId};
  @override
  UsuariosHasNumero map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsuariosHasNumero(
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      numeroId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero_id'],
      )!,
      aciertos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}aciertos'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
    );
  }

  @override
  $UsuariosHasNumerosTable createAlias(String alias) {
    return $UsuariosHasNumerosTable(attachedDatabase, alias);
  }
}

class UsuariosHasNumero extends DataClass
    implements Insertable<UsuariosHasNumero> {
  final String usuarioId;
  final int numeroId;
  final int aciertos;
  final int total;
  const UsuariosHasNumero({
    required this.usuarioId,
    required this.numeroId,
    required this.aciertos,
    required this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['usuario_id'] = Variable<String>(usuarioId);
    map['numero_id'] = Variable<int>(numeroId);
    map['aciertos'] = Variable<int>(aciertos);
    map['total'] = Variable<int>(total);
    return map;
  }

  UsuariosHasNumerosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosHasNumerosCompanion(
      usuarioId: Value(usuarioId),
      numeroId: Value(numeroId),
      aciertos: Value(aciertos),
      total: Value(total),
    );
  }

  factory UsuariosHasNumero.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsuariosHasNumero(
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      numeroId: serializer.fromJson<int>(json['numeroId']),
      aciertos: serializer.fromJson<int>(json['aciertos']),
      total: serializer.fromJson<int>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'usuarioId': serializer.toJson<String>(usuarioId),
      'numeroId': serializer.toJson<int>(numeroId),
      'aciertos': serializer.toJson<int>(aciertos),
      'total': serializer.toJson<int>(total),
    };
  }

  UsuariosHasNumero copyWith({
    String? usuarioId,
    int? numeroId,
    int? aciertos,
    int? total,
  }) => UsuariosHasNumero(
    usuarioId: usuarioId ?? this.usuarioId,
    numeroId: numeroId ?? this.numeroId,
    aciertos: aciertos ?? this.aciertos,
    total: total ?? this.total,
  );
  UsuariosHasNumero copyWithCompanion(UsuariosHasNumerosCompanion data) {
    return UsuariosHasNumero(
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      numeroId: data.numeroId.present ? data.numeroId.value : this.numeroId,
      aciertos: data.aciertos.present ? data.aciertos.value : this.aciertos,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosHasNumero(')
          ..write('usuarioId: $usuarioId, ')
          ..write('numeroId: $numeroId, ')
          ..write('aciertos: $aciertos, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(usuarioId, numeroId, aciertos, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuariosHasNumero &&
          other.usuarioId == this.usuarioId &&
          other.numeroId == this.numeroId &&
          other.aciertos == this.aciertos &&
          other.total == this.total);
}

class UsuariosHasNumerosCompanion extends UpdateCompanion<UsuariosHasNumero> {
  final Value<String> usuarioId;
  final Value<int> numeroId;
  final Value<int> aciertos;
  final Value<int> total;
  final Value<int> rowid;
  const UsuariosHasNumerosCompanion({
    this.usuarioId = const Value.absent(),
    this.numeroId = const Value.absent(),
    this.aciertos = const Value.absent(),
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsuariosHasNumerosCompanion.insert({
    required String usuarioId,
    required int numeroId,
    required int aciertos,
    required int total,
    this.rowid = const Value.absent(),
  }) : usuarioId = Value(usuarioId),
       numeroId = Value(numeroId),
       aciertos = Value(aciertos),
       total = Value(total);
  static Insertable<UsuariosHasNumero> custom({
    Expression<String>? usuarioId,
    Expression<int>? numeroId,
    Expression<int>? aciertos,
    Expression<int>? total,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (numeroId != null) 'numero_id': numeroId,
      if (aciertos != null) 'aciertos': aciertos,
      if (total != null) 'total': total,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsuariosHasNumerosCompanion copyWith({
    Value<String>? usuarioId,
    Value<int>? numeroId,
    Value<int>? aciertos,
    Value<int>? total,
    Value<int>? rowid,
  }) {
    return UsuariosHasNumerosCompanion(
      usuarioId: usuarioId ?? this.usuarioId,
      numeroId: numeroId ?? this.numeroId,
      aciertos: aciertos ?? this.aciertos,
      total: total ?? this.total,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (numeroId.present) {
      map['numero_id'] = Variable<int>(numeroId.value);
    }
    if (aciertos.present) {
      map['aciertos'] = Variable<int>(aciertos.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosHasNumerosCompanion(')
          ..write('usuarioId: $usuarioId, ')
          ..write('numeroId: $numeroId, ')
          ..write('aciertos: $aciertos, ')
          ..write('total: $total, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsuariosHasFonemasTable extends UsuariosHasFonemas
    with TableInfo<$UsuariosHasFonemasTable, UsuariosHasFonema> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosHasFonemasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _fonemaIdMeta = const VerificationMeta(
    'fonemaId',
  );
  @override
  late final GeneratedColumn<int> fonemaId = GeneratedColumn<int>(
    'fonema_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fonemas (id)',
    ),
  );
  static const VerificationMeta _aciertosMeta = const VerificationMeta(
    'aciertos',
  );
  @override
  late final GeneratedColumn<int> aciertos = GeneratedColumn<int>(
    'aciertos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [usuarioId, fonemaId, aciertos, total];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios_has_fonemas';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsuariosHasFonema> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('fonema_id')) {
      context.handle(
        _fonemaIdMeta,
        fonemaId.isAcceptableOrUnknown(data['fonema_id']!, _fonemaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fonemaIdMeta);
    }
    if (data.containsKey('aciertos')) {
      context.handle(
        _aciertosMeta,
        aciertos.isAcceptableOrUnknown(data['aciertos']!, _aciertosMeta),
      );
    } else if (isInserting) {
      context.missing(_aciertosMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {usuarioId, fonemaId};
  @override
  UsuariosHasFonema map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsuariosHasFonema(
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      fonemaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fonema_id'],
      )!,
      aciertos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}aciertos'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
    );
  }

  @override
  $UsuariosHasFonemasTable createAlias(String alias) {
    return $UsuariosHasFonemasTable(attachedDatabase, alias);
  }
}

class UsuariosHasFonema extends DataClass
    implements Insertable<UsuariosHasFonema> {
  final String usuarioId;
  final int fonemaId;
  final int aciertos;
  final int total;
  const UsuariosHasFonema({
    required this.usuarioId,
    required this.fonemaId,
    required this.aciertos,
    required this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['usuario_id'] = Variable<String>(usuarioId);
    map['fonema_id'] = Variable<int>(fonemaId);
    map['aciertos'] = Variable<int>(aciertos);
    map['total'] = Variable<int>(total);
    return map;
  }

  UsuariosHasFonemasCompanion toCompanion(bool nullToAbsent) {
    return UsuariosHasFonemasCompanion(
      usuarioId: Value(usuarioId),
      fonemaId: Value(fonemaId),
      aciertos: Value(aciertos),
      total: Value(total),
    );
  }

  factory UsuariosHasFonema.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsuariosHasFonema(
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      fonemaId: serializer.fromJson<int>(json['fonemaId']),
      aciertos: serializer.fromJson<int>(json['aciertos']),
      total: serializer.fromJson<int>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'usuarioId': serializer.toJson<String>(usuarioId),
      'fonemaId': serializer.toJson<int>(fonemaId),
      'aciertos': serializer.toJson<int>(aciertos),
      'total': serializer.toJson<int>(total),
    };
  }

  UsuariosHasFonema copyWith({
    String? usuarioId,
    int? fonemaId,
    int? aciertos,
    int? total,
  }) => UsuariosHasFonema(
    usuarioId: usuarioId ?? this.usuarioId,
    fonemaId: fonemaId ?? this.fonemaId,
    aciertos: aciertos ?? this.aciertos,
    total: total ?? this.total,
  );
  UsuariosHasFonema copyWithCompanion(UsuariosHasFonemasCompanion data) {
    return UsuariosHasFonema(
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      fonemaId: data.fonemaId.present ? data.fonemaId.value : this.fonemaId,
      aciertos: data.aciertos.present ? data.aciertos.value : this.aciertos,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosHasFonema(')
          ..write('usuarioId: $usuarioId, ')
          ..write('fonemaId: $fonemaId, ')
          ..write('aciertos: $aciertos, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(usuarioId, fonemaId, aciertos, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuariosHasFonema &&
          other.usuarioId == this.usuarioId &&
          other.fonemaId == this.fonemaId &&
          other.aciertos == this.aciertos &&
          other.total == this.total);
}

class UsuariosHasFonemasCompanion extends UpdateCompanion<UsuariosHasFonema> {
  final Value<String> usuarioId;
  final Value<int> fonemaId;
  final Value<int> aciertos;
  final Value<int> total;
  final Value<int> rowid;
  const UsuariosHasFonemasCompanion({
    this.usuarioId = const Value.absent(),
    this.fonemaId = const Value.absent(),
    this.aciertos = const Value.absent(),
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsuariosHasFonemasCompanion.insert({
    required String usuarioId,
    required int fonemaId,
    required int aciertos,
    required int total,
    this.rowid = const Value.absent(),
  }) : usuarioId = Value(usuarioId),
       fonemaId = Value(fonemaId),
       aciertos = Value(aciertos),
       total = Value(total);
  static Insertable<UsuariosHasFonema> custom({
    Expression<String>? usuarioId,
    Expression<int>? fonemaId,
    Expression<int>? aciertos,
    Expression<int>? total,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (fonemaId != null) 'fonema_id': fonemaId,
      if (aciertos != null) 'aciertos': aciertos,
      if (total != null) 'total': total,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsuariosHasFonemasCompanion copyWith({
    Value<String>? usuarioId,
    Value<int>? fonemaId,
    Value<int>? aciertos,
    Value<int>? total,
    Value<int>? rowid,
  }) {
    return UsuariosHasFonemasCompanion(
      usuarioId: usuarioId ?? this.usuarioId,
      fonemaId: fonemaId ?? this.fonemaId,
      aciertos: aciertos ?? this.aciertos,
      total: total ?? this.total,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (fonemaId.present) {
      map['fonema_id'] = Variable<int>(fonemaId.value);
    }
    if (aciertos.present) {
      map['aciertos'] = Variable<int>(aciertos.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosHasFonemasCompanion(')
          ..write('usuarioId: $usuarioId, ')
          ..write('fonemaId: $fonemaId, ')
          ..write('aciertos: $aciertos, ')
          ..write('total: $total, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsuariosHasPalabrasTable extends UsuariosHasPalabras
    with TableInfo<$UsuariosHasPalabrasTable, UsuariosHasPalabra> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosHasPalabrasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _palabraIdMeta = const VerificationMeta(
    'palabraId',
  );
  @override
  late final GeneratedColumn<int> palabraId = GeneratedColumn<int>(
    'palabra_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES palabras (id)',
    ),
  );
  static const VerificationMeta _aciertosMeta = const VerificationMeta(
    'aciertos',
  );
  @override
  late final GeneratedColumn<int> aciertos = GeneratedColumn<int>(
    'aciertos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [usuarioId, palabraId, aciertos, total];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios_has_palabras';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsuariosHasPalabra> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('palabra_id')) {
      context.handle(
        _palabraIdMeta,
        palabraId.isAcceptableOrUnknown(data['palabra_id']!, _palabraIdMeta),
      );
    } else if (isInserting) {
      context.missing(_palabraIdMeta);
    }
    if (data.containsKey('aciertos')) {
      context.handle(
        _aciertosMeta,
        aciertos.isAcceptableOrUnknown(data['aciertos']!, _aciertosMeta),
      );
    } else if (isInserting) {
      context.missing(_aciertosMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {usuarioId, palabraId};
  @override
  UsuariosHasPalabra map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsuariosHasPalabra(
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      palabraId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}palabra_id'],
      )!,
      aciertos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}aciertos'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
    );
  }

  @override
  $UsuariosHasPalabrasTable createAlias(String alias) {
    return $UsuariosHasPalabrasTable(attachedDatabase, alias);
  }
}

class UsuariosHasPalabra extends DataClass
    implements Insertable<UsuariosHasPalabra> {
  final String usuarioId;
  final int palabraId;
  final int aciertos;
  final int total;
  const UsuariosHasPalabra({
    required this.usuarioId,
    required this.palabraId,
    required this.aciertos,
    required this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['usuario_id'] = Variable<String>(usuarioId);
    map['palabra_id'] = Variable<int>(palabraId);
    map['aciertos'] = Variable<int>(aciertos);
    map['total'] = Variable<int>(total);
    return map;
  }

  UsuariosHasPalabrasCompanion toCompanion(bool nullToAbsent) {
    return UsuariosHasPalabrasCompanion(
      usuarioId: Value(usuarioId),
      palabraId: Value(palabraId),
      aciertos: Value(aciertos),
      total: Value(total),
    );
  }

  factory UsuariosHasPalabra.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsuariosHasPalabra(
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      palabraId: serializer.fromJson<int>(json['palabraId']),
      aciertos: serializer.fromJson<int>(json['aciertos']),
      total: serializer.fromJson<int>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'usuarioId': serializer.toJson<String>(usuarioId),
      'palabraId': serializer.toJson<int>(palabraId),
      'aciertos': serializer.toJson<int>(aciertos),
      'total': serializer.toJson<int>(total),
    };
  }

  UsuariosHasPalabra copyWith({
    String? usuarioId,
    int? palabraId,
    int? aciertos,
    int? total,
  }) => UsuariosHasPalabra(
    usuarioId: usuarioId ?? this.usuarioId,
    palabraId: palabraId ?? this.palabraId,
    aciertos: aciertos ?? this.aciertos,
    total: total ?? this.total,
  );
  UsuariosHasPalabra copyWithCompanion(UsuariosHasPalabrasCompanion data) {
    return UsuariosHasPalabra(
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      palabraId: data.palabraId.present ? data.palabraId.value : this.palabraId,
      aciertos: data.aciertos.present ? data.aciertos.value : this.aciertos,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosHasPalabra(')
          ..write('usuarioId: $usuarioId, ')
          ..write('palabraId: $palabraId, ')
          ..write('aciertos: $aciertos, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(usuarioId, palabraId, aciertos, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuariosHasPalabra &&
          other.usuarioId == this.usuarioId &&
          other.palabraId == this.palabraId &&
          other.aciertos == this.aciertos &&
          other.total == this.total);
}

class UsuariosHasPalabrasCompanion extends UpdateCompanion<UsuariosHasPalabra> {
  final Value<String> usuarioId;
  final Value<int> palabraId;
  final Value<int> aciertos;
  final Value<int> total;
  final Value<int> rowid;
  const UsuariosHasPalabrasCompanion({
    this.usuarioId = const Value.absent(),
    this.palabraId = const Value.absent(),
    this.aciertos = const Value.absent(),
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsuariosHasPalabrasCompanion.insert({
    required String usuarioId,
    required int palabraId,
    required int aciertos,
    required int total,
    this.rowid = const Value.absent(),
  }) : usuarioId = Value(usuarioId),
       palabraId = Value(palabraId),
       aciertos = Value(aciertos),
       total = Value(total);
  static Insertable<UsuariosHasPalabra> custom({
    Expression<String>? usuarioId,
    Expression<int>? palabraId,
    Expression<int>? aciertos,
    Expression<int>? total,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (palabraId != null) 'palabra_id': palabraId,
      if (aciertos != null) 'aciertos': aciertos,
      if (total != null) 'total': total,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsuariosHasPalabrasCompanion copyWith({
    Value<String>? usuarioId,
    Value<int>? palabraId,
    Value<int>? aciertos,
    Value<int>? total,
    Value<int>? rowid,
  }) {
    return UsuariosHasPalabrasCompanion(
      usuarioId: usuarioId ?? this.usuarioId,
      palabraId: palabraId ?? this.palabraId,
      aciertos: aciertos ?? this.aciertos,
      total: total ?? this.total,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (palabraId.present) {
      map['palabra_id'] = Variable<int>(palabraId.value);
    }
    if (aciertos.present) {
      map['aciertos'] = Variable<int>(aciertos.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosHasPalabrasCompanion(')
          ..write('usuarioId: $usuarioId, ')
          ..write('palabraId: $palabraId, ')
          ..write('aciertos: $aciertos, ')
          ..write('total: $total, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActividadesHasModulosTable extends ActividadesHasModulos
    with TableInfo<$ActividadesHasModulosTable, ActividadesHasModulo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActividadesHasModulosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _actividadIdMeta = const VerificationMeta(
    'actividadId',
  );
  @override
  late final GeneratedColumn<int> actividadId = GeneratedColumn<int>(
    'actividad_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES actividades (id)',
    ),
  );
  static const VerificationMeta _moduloIdMeta = const VerificationMeta(
    'moduloId',
  );
  @override
  late final GeneratedColumn<int> moduloId = GeneratedColumn<int>(
    'modulo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES modulos (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [actividadId, moduloId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'actividades_has_modulos';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActividadesHasModulo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('actividad_id')) {
      context.handle(
        _actividadIdMeta,
        actividadId.isAcceptableOrUnknown(
          data['actividad_id']!,
          _actividadIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actividadIdMeta);
    }
    if (data.containsKey('modulo_id')) {
      context.handle(
        _moduloIdMeta,
        moduloId.isAcceptableOrUnknown(data['modulo_id']!, _moduloIdMeta),
      );
    } else if (isInserting) {
      context.missing(_moduloIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {actividadId, moduloId};
  @override
  ActividadesHasModulo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActividadesHasModulo(
      actividadId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actividad_id'],
      )!,
      moduloId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}modulo_id'],
      )!,
    );
  }

  @override
  $ActividadesHasModulosTable createAlias(String alias) {
    return $ActividadesHasModulosTable(attachedDatabase, alias);
  }
}

class ActividadesHasModulo extends DataClass
    implements Insertable<ActividadesHasModulo> {
  final int actividadId;
  final int moduloId;
  const ActividadesHasModulo({
    required this.actividadId,
    required this.moduloId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['actividad_id'] = Variable<int>(actividadId);
    map['modulo_id'] = Variable<int>(moduloId);
    return map;
  }

  ActividadesHasModulosCompanion toCompanion(bool nullToAbsent) {
    return ActividadesHasModulosCompanion(
      actividadId: Value(actividadId),
      moduloId: Value(moduloId),
    );
  }

  factory ActividadesHasModulo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActividadesHasModulo(
      actividadId: serializer.fromJson<int>(json['actividadId']),
      moduloId: serializer.fromJson<int>(json['moduloId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'actividadId': serializer.toJson<int>(actividadId),
      'moduloId': serializer.toJson<int>(moduloId),
    };
  }

  ActividadesHasModulo copyWith({int? actividadId, int? moduloId}) =>
      ActividadesHasModulo(
        actividadId: actividadId ?? this.actividadId,
        moduloId: moduloId ?? this.moduloId,
      );
  ActividadesHasModulo copyWithCompanion(ActividadesHasModulosCompanion data) {
    return ActividadesHasModulo(
      actividadId: data.actividadId.present
          ? data.actividadId.value
          : this.actividadId,
      moduloId: data.moduloId.present ? data.moduloId.value : this.moduloId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActividadesHasModulo(')
          ..write('actividadId: $actividadId, ')
          ..write('moduloId: $moduloId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(actividadId, moduloId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActividadesHasModulo &&
          other.actividadId == this.actividadId &&
          other.moduloId == this.moduloId);
}

class ActividadesHasModulosCompanion
    extends UpdateCompanion<ActividadesHasModulo> {
  final Value<int> actividadId;
  final Value<int> moduloId;
  final Value<int> rowid;
  const ActividadesHasModulosCompanion({
    this.actividadId = const Value.absent(),
    this.moduloId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActividadesHasModulosCompanion.insert({
    required int actividadId,
    required int moduloId,
    this.rowid = const Value.absent(),
  }) : actividadId = Value(actividadId),
       moduloId = Value(moduloId);
  static Insertable<ActividadesHasModulo> custom({
    Expression<int>? actividadId,
    Expression<int>? moduloId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (actividadId != null) 'actividad_id': actividadId,
      if (moduloId != null) 'modulo_id': moduloId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActividadesHasModulosCompanion copyWith({
    Value<int>? actividadId,
    Value<int>? moduloId,
    Value<int>? rowid,
  }) {
    return ActividadesHasModulosCompanion(
      actividadId: actividadId ?? this.actividadId,
      moduloId: moduloId ?? this.moduloId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (actividadId.present) {
      map['actividad_id'] = Variable<int>(actividadId.value);
    }
    if (moduloId.present) {
      map['modulo_id'] = Variable<int>(moduloId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActividadesHasModulosCompanion(')
          ..write('actividadId: $actividadId, ')
          ..write('moduloId: $moduloId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsuariosHasActividadesTable extends UsuariosHasActividades
    with TableInfo<$UsuariosHasActividadesTable, ProgresoActividad> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosHasActividadesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _actividadIdMeta = const VerificationMeta(
    'actividadId',
  );
  @override
  late final GeneratedColumn<int> actividadId = GeneratedColumn<int>(
    'actividad_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES actividades (id)',
    ),
  );
  static const VerificationMeta _aciertosMeta = const VerificationMeta(
    'aciertos',
  );
  @override
  late final GeneratedColumn<int> aciertos = GeneratedColumn<int>(
    'aciertos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    usuarioId,
    actividadId,
    aciertos,
    total,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios_has_actividades';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgresoActividad> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('actividad_id')) {
      context.handle(
        _actividadIdMeta,
        actividadId.isAcceptableOrUnknown(
          data['actividad_id']!,
          _actividadIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actividadIdMeta);
    }
    if (data.containsKey('aciertos')) {
      context.handle(
        _aciertosMeta,
        aciertos.isAcceptableOrUnknown(data['aciertos']!, _aciertosMeta),
      );
    } else if (isInserting) {
      context.missing(_aciertosMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {usuarioId, actividadId};
  @override
  ProgresoActividad map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgresoActividad(
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      actividadId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actividad_id'],
      )!,
      aciertos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}aciertos'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      ),
    );
  }

  @override
  $UsuariosHasActividadesTable createAlias(String alias) {
    return $UsuariosHasActividadesTable(attachedDatabase, alias);
  }
}

class ProgresoActividad extends DataClass
    implements Insertable<ProgresoActividad> {
  final String usuarioId;
  final int actividadId;
  final int aciertos;
  final int? total;
  const ProgresoActividad({
    required this.usuarioId,
    required this.actividadId,
    required this.aciertos,
    this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['usuario_id'] = Variable<String>(usuarioId);
    map['actividad_id'] = Variable<int>(actividadId);
    map['aciertos'] = Variable<int>(aciertos);
    if (!nullToAbsent || total != null) {
      map['total'] = Variable<int>(total);
    }
    return map;
  }

  UsuariosHasActividadesCompanion toCompanion(bool nullToAbsent) {
    return UsuariosHasActividadesCompanion(
      usuarioId: Value(usuarioId),
      actividadId: Value(actividadId),
      aciertos: Value(aciertos),
      total: total == null && nullToAbsent
          ? const Value.absent()
          : Value(total),
    );
  }

  factory ProgresoActividad.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgresoActividad(
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      actividadId: serializer.fromJson<int>(json['actividadId']),
      aciertos: serializer.fromJson<int>(json['aciertos']),
      total: serializer.fromJson<int?>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'usuarioId': serializer.toJson<String>(usuarioId),
      'actividadId': serializer.toJson<int>(actividadId),
      'aciertos': serializer.toJson<int>(aciertos),
      'total': serializer.toJson<int?>(total),
    };
  }

  ProgresoActividad copyWith({
    String? usuarioId,
    int? actividadId,
    int? aciertos,
    Value<int?> total = const Value.absent(),
  }) => ProgresoActividad(
    usuarioId: usuarioId ?? this.usuarioId,
    actividadId: actividadId ?? this.actividadId,
    aciertos: aciertos ?? this.aciertos,
    total: total.present ? total.value : this.total,
  );
  ProgresoActividad copyWithCompanion(UsuariosHasActividadesCompanion data) {
    return ProgresoActividad(
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      actividadId: data.actividadId.present
          ? data.actividadId.value
          : this.actividadId,
      aciertos: data.aciertos.present ? data.aciertos.value : this.aciertos,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgresoActividad(')
          ..write('usuarioId: $usuarioId, ')
          ..write('actividadId: $actividadId, ')
          ..write('aciertos: $aciertos, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(usuarioId, actividadId, aciertos, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgresoActividad &&
          other.usuarioId == this.usuarioId &&
          other.actividadId == this.actividadId &&
          other.aciertos == this.aciertos &&
          other.total == this.total);
}

class UsuariosHasActividadesCompanion
    extends UpdateCompanion<ProgresoActividad> {
  final Value<String> usuarioId;
  final Value<int> actividadId;
  final Value<int> aciertos;
  final Value<int?> total;
  final Value<int> rowid;
  const UsuariosHasActividadesCompanion({
    this.usuarioId = const Value.absent(),
    this.actividadId = const Value.absent(),
    this.aciertos = const Value.absent(),
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsuariosHasActividadesCompanion.insert({
    required String usuarioId,
    required int actividadId,
    required int aciertos,
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : usuarioId = Value(usuarioId),
       actividadId = Value(actividadId),
       aciertos = Value(aciertos);
  static Insertable<ProgresoActividad> custom({
    Expression<String>? usuarioId,
    Expression<int>? actividadId,
    Expression<int>? aciertos,
    Expression<int>? total,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (actividadId != null) 'actividad_id': actividadId,
      if (aciertos != null) 'aciertos': aciertos,
      if (total != null) 'total': total,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsuariosHasActividadesCompanion copyWith({
    Value<String>? usuarioId,
    Value<int>? actividadId,
    Value<int>? aciertos,
    Value<int?>? total,
    Value<int>? rowid,
  }) {
    return UsuariosHasActividadesCompanion(
      usuarioId: usuarioId ?? this.usuarioId,
      actividadId: actividadId ?? this.actividadId,
      aciertos: aciertos ?? this.aciertos,
      total: total ?? this.total,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (actividadId.present) {
      map['actividad_id'] = Variable<int>(actividadId.value);
    }
    if (aciertos.present) {
      map['aciertos'] = Variable<int>(aciertos.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosHasActividadesCompanion(')
          ..write('usuarioId: $usuarioId, ')
          ..write('actividadId: $actividadId, ')
          ..write('aciertos: $aciertos, ')
          ..write('total: $total, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ModulosHasUsuariosTable extends ModulosHasUsuarios
    with TableInfo<$ModulosHasUsuariosTable, ModulosHasUsuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModulosHasUsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _moduloIdMeta = const VerificationMeta(
    'moduloId',
  );
  @override
  late final GeneratedColumn<int> moduloId = GeneratedColumn<int>(
    'modulo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES modulos (id)',
    ),
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _progresoMeta = const VerificationMeta(
    'progreso',
  );
  @override
  late final GeneratedColumn<double> progreso = GeneratedColumn<double>(
    'progreso',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [moduloId, usuarioId, progreso];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'modulos_has_usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<ModulosHasUsuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('modulo_id')) {
      context.handle(
        _moduloIdMeta,
        moduloId.isAcceptableOrUnknown(data['modulo_id']!, _moduloIdMeta),
      );
    } else if (isInserting) {
      context.missing(_moduloIdMeta);
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('progreso')) {
      context.handle(
        _progresoMeta,
        progreso.isAcceptableOrUnknown(data['progreso']!, _progresoMeta),
      );
    } else if (isInserting) {
      context.missing(_progresoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {moduloId, usuarioId};
  @override
  ModulosHasUsuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ModulosHasUsuario(
      moduloId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}modulo_id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      progreso: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progreso'],
      )!,
    );
  }

  @override
  $ModulosHasUsuariosTable createAlias(String alias) {
    return $ModulosHasUsuariosTable(attachedDatabase, alias);
  }
}

class ModulosHasUsuario extends DataClass
    implements Insertable<ModulosHasUsuario> {
  final int moduloId;
  final String usuarioId;
  final double progreso;
  const ModulosHasUsuario({
    required this.moduloId,
    required this.usuarioId,
    required this.progreso,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['modulo_id'] = Variable<int>(moduloId);
    map['usuario_id'] = Variable<String>(usuarioId);
    map['progreso'] = Variable<double>(progreso);
    return map;
  }

  ModulosHasUsuariosCompanion toCompanion(bool nullToAbsent) {
    return ModulosHasUsuariosCompanion(
      moduloId: Value(moduloId),
      usuarioId: Value(usuarioId),
      progreso: Value(progreso),
    );
  }

  factory ModulosHasUsuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModulosHasUsuario(
      moduloId: serializer.fromJson<int>(json['moduloId']),
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      progreso: serializer.fromJson<double>(json['progreso']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'moduloId': serializer.toJson<int>(moduloId),
      'usuarioId': serializer.toJson<String>(usuarioId),
      'progreso': serializer.toJson<double>(progreso),
    };
  }

  ModulosHasUsuario copyWith({
    int? moduloId,
    String? usuarioId,
    double? progreso,
  }) => ModulosHasUsuario(
    moduloId: moduloId ?? this.moduloId,
    usuarioId: usuarioId ?? this.usuarioId,
    progreso: progreso ?? this.progreso,
  );
  ModulosHasUsuario copyWithCompanion(ModulosHasUsuariosCompanion data) {
    return ModulosHasUsuario(
      moduloId: data.moduloId.present ? data.moduloId.value : this.moduloId,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      progreso: data.progreso.present ? data.progreso.value : this.progreso,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ModulosHasUsuario(')
          ..write('moduloId: $moduloId, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('progreso: $progreso')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(moduloId, usuarioId, progreso);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModulosHasUsuario &&
          other.moduloId == this.moduloId &&
          other.usuarioId == this.usuarioId &&
          other.progreso == this.progreso);
}

class ModulosHasUsuariosCompanion extends UpdateCompanion<ModulosHasUsuario> {
  final Value<int> moduloId;
  final Value<String> usuarioId;
  final Value<double> progreso;
  final Value<int> rowid;
  const ModulosHasUsuariosCompanion({
    this.moduloId = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.progreso = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ModulosHasUsuariosCompanion.insert({
    required int moduloId,
    required String usuarioId,
    required double progreso,
    this.rowid = const Value.absent(),
  }) : moduloId = Value(moduloId),
       usuarioId = Value(usuarioId),
       progreso = Value(progreso);
  static Insertable<ModulosHasUsuario> custom({
    Expression<int>? moduloId,
    Expression<String>? usuarioId,
    Expression<double>? progreso,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (moduloId != null) 'modulo_id': moduloId,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (progreso != null) 'progreso': progreso,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ModulosHasUsuariosCompanion copyWith({
    Value<int>? moduloId,
    Value<String>? usuarioId,
    Value<double>? progreso,
    Value<int>? rowid,
  }) {
    return ModulosHasUsuariosCompanion(
      moduloId: moduloId ?? this.moduloId,
      usuarioId: usuarioId ?? this.usuarioId,
      progreso: progreso ?? this.progreso,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (moduloId.present) {
      map['modulo_id'] = Variable<int>(moduloId.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (progreso.present) {
      map['progreso'] = Variable<double>(progreso.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModulosHasUsuariosCompanion(')
          ..write('moduloId: $moduloId, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('progreso: $progreso, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsuariosHasMedallasTable extends UsuariosHasMedallas
    with TableInfo<$UsuariosHasMedallasTable, UsuariosHasMedalla> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosHasMedallasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _medallaIdMeta = const VerificationMeta(
    'medallaId',
  );
  @override
  late final GeneratedColumn<int> medallaId = GeneratedColumn<int>(
    'medalla_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES medallas (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [usuarioId, medallaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios_has_medallas';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsuariosHasMedalla> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('medalla_id')) {
      context.handle(
        _medallaIdMeta,
        medallaId.isAcceptableOrUnknown(data['medalla_id']!, _medallaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_medallaIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {usuarioId, medallaId};
  @override
  UsuariosHasMedalla map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsuariosHasMedalla(
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      medallaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}medalla_id'],
      )!,
    );
  }

  @override
  $UsuariosHasMedallasTable createAlias(String alias) {
    return $UsuariosHasMedallasTable(attachedDatabase, alias);
  }
}

class UsuariosHasMedalla extends DataClass
    implements Insertable<UsuariosHasMedalla> {
  final String usuarioId;
  final int medallaId;
  const UsuariosHasMedalla({required this.usuarioId, required this.medallaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['usuario_id'] = Variable<String>(usuarioId);
    map['medalla_id'] = Variable<int>(medallaId);
    return map;
  }

  UsuariosHasMedallasCompanion toCompanion(bool nullToAbsent) {
    return UsuariosHasMedallasCompanion(
      usuarioId: Value(usuarioId),
      medallaId: Value(medallaId),
    );
  }

  factory UsuariosHasMedalla.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsuariosHasMedalla(
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      medallaId: serializer.fromJson<int>(json['medallaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'usuarioId': serializer.toJson<String>(usuarioId),
      'medallaId': serializer.toJson<int>(medallaId),
    };
  }

  UsuariosHasMedalla copyWith({String? usuarioId, int? medallaId}) =>
      UsuariosHasMedalla(
        usuarioId: usuarioId ?? this.usuarioId,
        medallaId: medallaId ?? this.medallaId,
      );
  UsuariosHasMedalla copyWithCompanion(UsuariosHasMedallasCompanion data) {
    return UsuariosHasMedalla(
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      medallaId: data.medallaId.present ? data.medallaId.value : this.medallaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosHasMedalla(')
          ..write('usuarioId: $usuarioId, ')
          ..write('medallaId: $medallaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(usuarioId, medallaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuariosHasMedalla &&
          other.usuarioId == this.usuarioId &&
          other.medallaId == this.medallaId);
}

class UsuariosHasMedallasCompanion extends UpdateCompanion<UsuariosHasMedalla> {
  final Value<String> usuarioId;
  final Value<int> medallaId;
  final Value<int> rowid;
  const UsuariosHasMedallasCompanion({
    this.usuarioId = const Value.absent(),
    this.medallaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsuariosHasMedallasCompanion.insert({
    required String usuarioId,
    required int medallaId,
    this.rowid = const Value.absent(),
  }) : usuarioId = Value(usuarioId),
       medallaId = Value(medallaId);
  static Insertable<UsuariosHasMedalla> custom({
    Expression<String>? usuarioId,
    Expression<int>? medallaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (medallaId != null) 'medalla_id': medallaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsuariosHasMedallasCompanion copyWith({
    Value<String>? usuarioId,
    Value<int>? medallaId,
    Value<int>? rowid,
  }) {
    return UsuariosHasMedallasCompanion(
      usuarioId: usuarioId ?? this.usuarioId,
      medallaId: medallaId ?? this.medallaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (medallaId.present) {
      map['medalla_id'] = Variable<int>(medallaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosHasMedallasCompanion(')
          ..write('usuarioId: $usuarioId, ')
          ..write('medallaId: $medallaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TutorTable tutor = $TutorTable(this);
  late final $KvStoreTable kvStore = $KvStoreTable(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $ConfiguracionesTable configuraciones = $ConfiguracionesTable(
    this,
  );
  late final $NumerosTable numeros = $NumerosTable(this);
  late final $FonemasTable fonemas = $FonemasTable(this);
  late final $TipoDePalabraTable tipoDePalabra = $TipoDePalabraTable(this);
  late final $PalabrasTable palabras = $PalabrasTable(this);
  late final $ModulosTable modulos = $ModulosTable(this);
  late final $ActividadesTable actividades = $ActividadesTable(this);
  late final $MedallasTable medallas = $MedallasTable(this);
  late final $UsuariosHasNumerosTable usuariosHasNumeros =
      $UsuariosHasNumerosTable(this);
  late final $UsuariosHasFonemasTable usuariosHasFonemas =
      $UsuariosHasFonemasTable(this);
  late final $UsuariosHasPalabrasTable usuariosHasPalabras =
      $UsuariosHasPalabrasTable(this);
  late final $ActividadesHasModulosTable actividadesHasModulos =
      $ActividadesHasModulosTable(this);
  late final $UsuariosHasActividadesTable usuariosHasActividades =
      $UsuariosHasActividadesTable(this);
  late final $ModulosHasUsuariosTable modulosHasUsuarios =
      $ModulosHasUsuariosTable(this);
  late final $UsuariosHasMedallasTable usuariosHasMedallas =
      $UsuariosHasMedallasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tutor,
    kvStore,
    usuarios,
    configuraciones,
    numeros,
    fonemas,
    tipoDePalabra,
    palabras,
    modulos,
    actividades,
    medallas,
    usuariosHasNumeros,
    usuariosHasFonemas,
    usuariosHasPalabras,
    actividadesHasModulos,
    usuariosHasActividades,
    modulosHasUsuarios,
    usuariosHasMedallas,
  ];
}

typedef $$TutorTableCreateCompanionBuilder =
    TutorCompanion Function({
      required String id,
      required String usuario,
      required String pinSeguridad,
      Value<DateTime> fechaCreacion,
      Value<int> rowid,
    });
typedef $$TutorTableUpdateCompanionBuilder =
    TutorCompanion Function({
      Value<String> id,
      Value<String> usuario,
      Value<String> pinSeguridad,
      Value<DateTime> fechaCreacion,
      Value<int> rowid,
    });

final class $$TutorTableReferences
    extends BaseReferences<_$AppDatabase, $TutorTable, TutorData> {
  $$TutorTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UsuariosTable, List<Usuario>> _usuariosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.usuarios,
    aliasName: $_aliasNameGenerator(db.tutor.id, db.usuarios.tutorId),
  );

  $$UsuariosTableProcessedTableManager get usuariosRefs {
    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.tutorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_usuariosRefsTable($_db));
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

  ColumnFilters<String> get pinSeguridad => $composableBuilder(
    column: $table.pinSeguridad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> usuariosRefs(
    Expression<bool> Function($$UsuariosTableFilterComposer f) f,
  ) {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.tutorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
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

  ColumnOrderings<String> get pinSeguridad => $composableBuilder(
    column: $table.pinSeguridad,
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

  GeneratedColumn<String> get pinSeguridad => $composableBuilder(
    column: $table.pinSeguridad,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => column,
  );

  Expression<T> usuariosRefs<T extends Object>(
    Expression<T> Function($$UsuariosTableAnnotationComposer a) f,
  ) {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.tutorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
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
          PrefetchHooks Function({bool usuariosRefs, bool configuracionesRefs})
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
                Value<String> usuario = const Value.absent(),
                Value<String> pinSeguridad = const Value.absent(),
                Value<DateTime> fechaCreacion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TutorCompanion(
                id: id,
                usuario: usuario,
                pinSeguridad: pinSeguridad,
                fechaCreacion: fechaCreacion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String usuario,
                required String pinSeguridad,
                Value<DateTime> fechaCreacion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TutorCompanion.insert(
                id: id,
                usuario: usuario,
                pinSeguridad: pinSeguridad,
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
              ({usuariosRefs = false, configuracionesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (usuariosRefs) db.usuarios,
                    if (configuracionesRefs) db.configuraciones,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (usuariosRefs)
                        await $_getPrefetchedData<
                          TutorData,
                          $TutorTable,
                          Usuario
                        >(
                          currentTable: table,
                          referencedTable: $$TutorTableReferences
                              ._usuariosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TutorTableReferences(
                                db,
                                table,
                                p0,
                              ).usuariosRefs,
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
      PrefetchHooks Function({bool usuariosRefs, bool configuracionesRefs})
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
typedef $$UsuariosTableCreateCompanionBuilder =
    UsuariosCompanion Function({
      required String id,
      required String tutorId,
      required String nombre,
      required String icono,
      Value<bool> activo,
      Value<int> rowid,
    });
typedef $$UsuariosTableUpdateCompanionBuilder =
    UsuariosCompanion Function({
      Value<String> id,
      Value<String> tutorId,
      Value<String> nombre,
      Value<String> icono,
      Value<bool> activo,
      Value<int> rowid,
    });

final class $$UsuariosTableReferences
    extends BaseReferences<_$AppDatabase, $UsuariosTable, Usuario> {
  $$UsuariosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TutorTable _tutorIdTable(_$AppDatabase db) => db.tutor.createAlias(
    $_aliasNameGenerator(db.usuarios.tutorId, db.tutor.id),
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

  static MultiTypedResultKey<$UsuariosHasNumerosTable, List<UsuariosHasNumero>>
  _usuariosHasNumerosRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.usuariosHasNumeros,
        aliasName: $_aliasNameGenerator(
          db.usuarios.id,
          db.usuariosHasNumeros.usuarioId,
        ),
      );

  $$UsuariosHasNumerosTableProcessedTableManager get usuariosHasNumerosRefs {
    final manager = $$UsuariosHasNumerosTableTableManager(
      $_db,
      $_db.usuariosHasNumeros,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _usuariosHasNumerosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UsuariosHasFonemasTable, List<UsuariosHasFonema>>
  _usuariosHasFonemasRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.usuariosHasFonemas,
        aliasName: $_aliasNameGenerator(
          db.usuarios.id,
          db.usuariosHasFonemas.usuarioId,
        ),
      );

  $$UsuariosHasFonemasTableProcessedTableManager get usuariosHasFonemasRefs {
    final manager = $$UsuariosHasFonemasTableTableManager(
      $_db,
      $_db.usuariosHasFonemas,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _usuariosHasFonemasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $UsuariosHasPalabrasTable,
    List<UsuariosHasPalabra>
  >
  _usuariosHasPalabrasRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.usuariosHasPalabras,
        aliasName: $_aliasNameGenerator(
          db.usuarios.id,
          db.usuariosHasPalabras.usuarioId,
        ),
      );

  $$UsuariosHasPalabrasTableProcessedTableManager get usuariosHasPalabrasRefs {
    final manager = $$UsuariosHasPalabrasTableTableManager(
      $_db,
      $_db.usuariosHasPalabras,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _usuariosHasPalabrasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $UsuariosHasActividadesTable,
    List<ProgresoActividad>
  >
  _usuariosHasActividadesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.usuariosHasActividades,
        aliasName: $_aliasNameGenerator(
          db.usuarios.id,
          db.usuariosHasActividades.usuarioId,
        ),
      );

  $$UsuariosHasActividadesTableProcessedTableManager
  get usuariosHasActividadesRefs {
    final manager = $$UsuariosHasActividadesTableTableManager(
      $_db,
      $_db.usuariosHasActividades,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _usuariosHasActividadesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ModulosHasUsuariosTable, List<ModulosHasUsuario>>
  _modulosHasUsuariosRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.modulosHasUsuarios,
        aliasName: $_aliasNameGenerator(
          db.usuarios.id,
          db.modulosHasUsuarios.usuarioId,
        ),
      );

  $$ModulosHasUsuariosTableProcessedTableManager get modulosHasUsuariosRefs {
    final manager = $$ModulosHasUsuariosTableTableManager(
      $_db,
      $_db.modulosHasUsuarios,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _modulosHasUsuariosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $UsuariosHasMedallasTable,
    List<UsuariosHasMedalla>
  >
  _usuariosHasMedallasRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.usuariosHasMedallas,
        aliasName: $_aliasNameGenerator(
          db.usuarios.id,
          db.usuariosHasMedallas.usuarioId,
        ),
      );

  $$UsuariosHasMedallasTableProcessedTableManager get usuariosHasMedallasRefs {
    final manager = $$UsuariosHasMedallasTableTableManager(
      $_db,
      $_db.usuariosHasMedallas,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _usuariosHasMedallasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
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

  ColumnFilters<String> get icono => $composableBuilder(
    column: $table.icono,
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

  Expression<bool> usuariosHasNumerosRefs(
    Expression<bool> Function($$UsuariosHasNumerosTableFilterComposer f) f,
  ) {
    final $$UsuariosHasNumerosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usuariosHasNumeros,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosHasNumerosTableFilterComposer(
            $db: $db,
            $table: $db.usuariosHasNumeros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> usuariosHasFonemasRefs(
    Expression<bool> Function($$UsuariosHasFonemasTableFilterComposer f) f,
  ) {
    final $$UsuariosHasFonemasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usuariosHasFonemas,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosHasFonemasTableFilterComposer(
            $db: $db,
            $table: $db.usuariosHasFonemas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> usuariosHasPalabrasRefs(
    Expression<bool> Function($$UsuariosHasPalabrasTableFilterComposer f) f,
  ) {
    final $$UsuariosHasPalabrasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usuariosHasPalabras,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosHasPalabrasTableFilterComposer(
            $db: $db,
            $table: $db.usuariosHasPalabras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> usuariosHasActividadesRefs(
    Expression<bool> Function($$UsuariosHasActividadesTableFilterComposer f) f,
  ) {
    final $$UsuariosHasActividadesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.usuariosHasActividades,
          getReferencedColumn: (t) => t.usuarioId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UsuariosHasActividadesTableFilterComposer(
                $db: $db,
                $table: $db.usuariosHasActividades,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> modulosHasUsuariosRefs(
    Expression<bool> Function($$ModulosHasUsuariosTableFilterComposer f) f,
  ) {
    final $$ModulosHasUsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.modulosHasUsuarios,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ModulosHasUsuariosTableFilterComposer(
            $db: $db,
            $table: $db.modulosHasUsuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> usuariosHasMedallasRefs(
    Expression<bool> Function($$UsuariosHasMedallasTableFilterComposer f) f,
  ) {
    final $$UsuariosHasMedallasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usuariosHasMedallas,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosHasMedallasTableFilterComposer(
            $db: $db,
            $table: $db.usuariosHasMedallas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
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

  ColumnOrderings<String> get icono => $composableBuilder(
    column: $table.icono,
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

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
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

  GeneratedColumn<String> get icono =>
      $composableBuilder(column: $table.icono, builder: (column) => column);

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

  Expression<T> usuariosHasNumerosRefs<T extends Object>(
    Expression<T> Function($$UsuariosHasNumerosTableAnnotationComposer a) f,
  ) {
    final $$UsuariosHasNumerosTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.usuariosHasNumeros,
          getReferencedColumn: (t) => t.usuarioId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UsuariosHasNumerosTableAnnotationComposer(
                $db: $db,
                $table: $db.usuariosHasNumeros,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> usuariosHasFonemasRefs<T extends Object>(
    Expression<T> Function($$UsuariosHasFonemasTableAnnotationComposer a) f,
  ) {
    final $$UsuariosHasFonemasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.usuariosHasFonemas,
          getReferencedColumn: (t) => t.usuarioId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UsuariosHasFonemasTableAnnotationComposer(
                $db: $db,
                $table: $db.usuariosHasFonemas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> usuariosHasPalabrasRefs<T extends Object>(
    Expression<T> Function($$UsuariosHasPalabrasTableAnnotationComposer a) f,
  ) {
    final $$UsuariosHasPalabrasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.usuariosHasPalabras,
          getReferencedColumn: (t) => t.usuarioId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UsuariosHasPalabrasTableAnnotationComposer(
                $db: $db,
                $table: $db.usuariosHasPalabras,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> usuariosHasActividadesRefs<T extends Object>(
    Expression<T> Function($$UsuariosHasActividadesTableAnnotationComposer a) f,
  ) {
    final $$UsuariosHasActividadesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.usuariosHasActividades,
          getReferencedColumn: (t) => t.usuarioId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UsuariosHasActividadesTableAnnotationComposer(
                $db: $db,
                $table: $db.usuariosHasActividades,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> modulosHasUsuariosRefs<T extends Object>(
    Expression<T> Function($$ModulosHasUsuariosTableAnnotationComposer a) f,
  ) {
    final $$ModulosHasUsuariosTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.modulosHasUsuarios,
          getReferencedColumn: (t) => t.usuarioId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ModulosHasUsuariosTableAnnotationComposer(
                $db: $db,
                $table: $db.modulosHasUsuarios,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> usuariosHasMedallasRefs<T extends Object>(
    Expression<T> Function($$UsuariosHasMedallasTableAnnotationComposer a) f,
  ) {
    final $$UsuariosHasMedallasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.usuariosHasMedallas,
          getReferencedColumn: (t) => t.usuarioId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UsuariosHasMedallasTableAnnotationComposer(
                $db: $db,
                $table: $db.usuariosHasMedallas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosTable,
          Usuario,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (Usuario, $$UsuariosTableReferences),
          Usuario,
          PrefetchHooks Function({
            bool tutorId,
            bool usuariosHasNumerosRefs,
            bool usuariosHasFonemasRefs,
            bool usuariosHasPalabrasRefs,
            bool usuariosHasActividadesRefs,
            bool modulosHasUsuariosRefs,
            bool usuariosHasMedallasRefs,
          })
        > {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tutorId = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> icono = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosCompanion(
                id: id,
                tutorId: tutorId,
                nombre: nombre,
                icono: icono,
                activo: activo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tutorId,
                required String nombre,
                required String icono,
                Value<bool> activo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosCompanion.insert(
                id: id,
                tutorId: tutorId,
                nombre: nombre,
                icono: icono,
                activo: activo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tutorId = false,
                usuariosHasNumerosRefs = false,
                usuariosHasFonemasRefs = false,
                usuariosHasPalabrasRefs = false,
                usuariosHasActividadesRefs = false,
                modulosHasUsuariosRefs = false,
                usuariosHasMedallasRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (usuariosHasNumerosRefs) db.usuariosHasNumeros,
                    if (usuariosHasFonemasRefs) db.usuariosHasFonemas,
                    if (usuariosHasPalabrasRefs) db.usuariosHasPalabras,
                    if (usuariosHasActividadesRefs) db.usuariosHasActividades,
                    if (modulosHasUsuariosRefs) db.modulosHasUsuarios,
                    if (usuariosHasMedallasRefs) db.usuariosHasMedallas,
                  ],
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
                                    referencedTable: $$UsuariosTableReferences
                                        ._tutorIdTable(db),
                                    referencedColumn: $$UsuariosTableReferences
                                        ._tutorIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (usuariosHasNumerosRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          UsuariosHasNumero
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._usuariosHasNumerosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).usuariosHasNumerosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.usuarioId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (usuariosHasFonemasRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          UsuariosHasFonema
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._usuariosHasFonemasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).usuariosHasFonemasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.usuarioId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (usuariosHasPalabrasRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          UsuariosHasPalabra
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._usuariosHasPalabrasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).usuariosHasPalabrasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.usuarioId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (usuariosHasActividadesRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          ProgresoActividad
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._usuariosHasActividadesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).usuariosHasActividadesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.usuarioId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (modulosHasUsuariosRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          ModulosHasUsuario
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._modulosHasUsuariosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).modulosHasUsuariosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.usuarioId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (usuariosHasMedallasRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          UsuariosHasMedalla
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._usuariosHasMedallasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).usuariosHasMedallasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.usuarioId == item.id,
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

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosTable,
      Usuario,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (Usuario, $$UsuariosTableReferences),
      Usuario,
      PrefetchHooks Function({
        bool tutorId,
        bool usuariosHasNumerosRefs,
        bool usuariosHasFonemasRefs,
        bool usuariosHasPalabrasRefs,
        bool usuariosHasActividadesRefs,
        bool modulosHasUsuariosRefs,
        bool usuariosHasMedallasRefs,
      })
    >;
typedef $$ConfiguracionesTableCreateCompanionBuilder =
    ConfiguracionesCompanion Function({
      required String tutorId,
      Value<bool> ttsHabilitado,
      Value<double> ttsVelocidad,
      Value<bool> musicaFondo,
      Value<int> rowid,
    });
typedef $$ConfiguracionesTableUpdateCompanionBuilder =
    ConfiguracionesCompanion Function({
      Value<String> tutorId,
      Value<bool> ttsHabilitado,
      Value<double> ttsVelocidad,
      Value<bool> musicaFondo,
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

  ColumnFilters<double> get ttsVelocidad => $composableBuilder(
    column: $table.ttsVelocidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get musicaFondo => $composableBuilder(
    column: $table.musicaFondo,
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

  ColumnOrderings<double> get ttsVelocidad => $composableBuilder(
    column: $table.ttsVelocidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get musicaFondo => $composableBuilder(
    column: $table.musicaFondo,
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

  GeneratedColumn<double> get ttsVelocidad => $composableBuilder(
    column: $table.ttsVelocidad,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get musicaFondo => $composableBuilder(
    column: $table.musicaFondo,
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
                Value<double> ttsVelocidad = const Value.absent(),
                Value<bool> musicaFondo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConfiguracionesCompanion(
                tutorId: tutorId,
                ttsHabilitado: ttsHabilitado,
                ttsVelocidad: ttsVelocidad,
                musicaFondo: musicaFondo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String tutorId,
                Value<bool> ttsHabilitado = const Value.absent(),
                Value<double> ttsVelocidad = const Value.absent(),
                Value<bool> musicaFondo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConfiguracionesCompanion.insert(
                tutorId: tutorId,
                ttsHabilitado: ttsHabilitado,
                ttsVelocidad: ttsVelocidad,
                musicaFondo: musicaFondo,
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
typedef $$NumerosTableCreateCompanionBuilder =
    NumerosCompanion Function({Value<int> id, required int numero});
typedef $$NumerosTableUpdateCompanionBuilder =
    NumerosCompanion Function({Value<int> id, Value<int> numero});

final class $$NumerosTableReferences
    extends BaseReferences<_$AppDatabase, $NumerosTable, Numero> {
  $$NumerosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UsuariosHasNumerosTable, List<UsuariosHasNumero>>
  _usuariosHasNumerosRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.usuariosHasNumeros,
        aliasName: $_aliasNameGenerator(
          db.numeros.id,
          db.usuariosHasNumeros.numeroId,
        ),
      );

  $$UsuariosHasNumerosTableProcessedTableManager get usuariosHasNumerosRefs {
    final manager = $$UsuariosHasNumerosTableTableManager(
      $_db,
      $_db.usuariosHasNumeros,
    ).filter((f) => f.numeroId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _usuariosHasNumerosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NumerosTableFilterComposer
    extends Composer<_$AppDatabase, $NumerosTable> {
  $$NumerosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> usuariosHasNumerosRefs(
    Expression<bool> Function($$UsuariosHasNumerosTableFilterComposer f) f,
  ) {
    final $$UsuariosHasNumerosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usuariosHasNumeros,
      getReferencedColumn: (t) => t.numeroId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosHasNumerosTableFilterComposer(
            $db: $db,
            $table: $db.usuariosHasNumeros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NumerosTableOrderingComposer
    extends Composer<_$AppDatabase, $NumerosTable> {
  $$NumerosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NumerosTableAnnotationComposer
    extends Composer<_$AppDatabase, $NumerosTable> {
  $$NumerosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  Expression<T> usuariosHasNumerosRefs<T extends Object>(
    Expression<T> Function($$UsuariosHasNumerosTableAnnotationComposer a) f,
  ) {
    final $$UsuariosHasNumerosTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.usuariosHasNumeros,
          getReferencedColumn: (t) => t.numeroId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UsuariosHasNumerosTableAnnotationComposer(
                $db: $db,
                $table: $db.usuariosHasNumeros,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$NumerosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NumerosTable,
          Numero,
          $$NumerosTableFilterComposer,
          $$NumerosTableOrderingComposer,
          $$NumerosTableAnnotationComposer,
          $$NumerosTableCreateCompanionBuilder,
          $$NumerosTableUpdateCompanionBuilder,
          (Numero, $$NumerosTableReferences),
          Numero,
          PrefetchHooks Function({bool usuariosHasNumerosRefs})
        > {
  $$NumerosTableTableManager(_$AppDatabase db, $NumerosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NumerosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NumerosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NumerosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> numero = const Value.absent(),
              }) => NumerosCompanion(id: id, numero: numero),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required int numero}) =>
                  NumerosCompanion.insert(id: id, numero: numero),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NumerosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usuariosHasNumerosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (usuariosHasNumerosRefs) db.usuariosHasNumeros,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (usuariosHasNumerosRefs)
                    await $_getPrefetchedData<
                      Numero,
                      $NumerosTable,
                      UsuariosHasNumero
                    >(
                      currentTable: table,
                      referencedTable: $$NumerosTableReferences
                          ._usuariosHasNumerosRefsTable(db),
                      managerFromTypedResult: (p0) => $$NumerosTableReferences(
                        db,
                        table,
                        p0,
                      ).usuariosHasNumerosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.numeroId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$NumerosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NumerosTable,
      Numero,
      $$NumerosTableFilterComposer,
      $$NumerosTableOrderingComposer,
      $$NumerosTableAnnotationComposer,
      $$NumerosTableCreateCompanionBuilder,
      $$NumerosTableUpdateCompanionBuilder,
      (Numero, $$NumerosTableReferences),
      Numero,
      PrefetchHooks Function({bool usuariosHasNumerosRefs})
    >;
typedef $$FonemasTableCreateCompanionBuilder =
    FonemasCompanion Function({Value<int> id, required String fonema});
typedef $$FonemasTableUpdateCompanionBuilder =
    FonemasCompanion Function({Value<int> id, Value<String> fonema});

final class $$FonemasTableReferences
    extends BaseReferences<_$AppDatabase, $FonemasTable, Fonema> {
  $$FonemasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UsuariosHasFonemasTable, List<UsuariosHasFonema>>
  _usuariosHasFonemasRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.usuariosHasFonemas,
        aliasName: $_aliasNameGenerator(
          db.fonemas.id,
          db.usuariosHasFonemas.fonemaId,
        ),
      );

  $$UsuariosHasFonemasTableProcessedTableManager get usuariosHasFonemasRefs {
    final manager = $$UsuariosHasFonemasTableTableManager(
      $_db,
      $_db.usuariosHasFonemas,
    ).filter((f) => f.fonemaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _usuariosHasFonemasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FonemasTableFilterComposer
    extends Composer<_$AppDatabase, $FonemasTable> {
  $$FonemasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fonema => $composableBuilder(
    column: $table.fonema,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> usuariosHasFonemasRefs(
    Expression<bool> Function($$UsuariosHasFonemasTableFilterComposer f) f,
  ) {
    final $$UsuariosHasFonemasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usuariosHasFonemas,
      getReferencedColumn: (t) => t.fonemaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosHasFonemasTableFilterComposer(
            $db: $db,
            $table: $db.usuariosHasFonemas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FonemasTableOrderingComposer
    extends Composer<_$AppDatabase, $FonemasTable> {
  $$FonemasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fonema => $composableBuilder(
    column: $table.fonema,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FonemasTableAnnotationComposer
    extends Composer<_$AppDatabase, $FonemasTable> {
  $$FonemasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fonema =>
      $composableBuilder(column: $table.fonema, builder: (column) => column);

  Expression<T> usuariosHasFonemasRefs<T extends Object>(
    Expression<T> Function($$UsuariosHasFonemasTableAnnotationComposer a) f,
  ) {
    final $$UsuariosHasFonemasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.usuariosHasFonemas,
          getReferencedColumn: (t) => t.fonemaId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UsuariosHasFonemasTableAnnotationComposer(
                $db: $db,
                $table: $db.usuariosHasFonemas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FonemasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FonemasTable,
          Fonema,
          $$FonemasTableFilterComposer,
          $$FonemasTableOrderingComposer,
          $$FonemasTableAnnotationComposer,
          $$FonemasTableCreateCompanionBuilder,
          $$FonemasTableUpdateCompanionBuilder,
          (Fonema, $$FonemasTableReferences),
          Fonema,
          PrefetchHooks Function({bool usuariosHasFonemasRefs})
        > {
  $$FonemasTableTableManager(_$AppDatabase db, $FonemasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FonemasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FonemasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FonemasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fonema = const Value.absent(),
              }) => FonemasCompanion(id: id, fonema: fonema),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String fonema,
              }) => FonemasCompanion.insert(id: id, fonema: fonema),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FonemasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usuariosHasFonemasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (usuariosHasFonemasRefs) db.usuariosHasFonemas,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (usuariosHasFonemasRefs)
                    await $_getPrefetchedData<
                      Fonema,
                      $FonemasTable,
                      UsuariosHasFonema
                    >(
                      currentTable: table,
                      referencedTable: $$FonemasTableReferences
                          ._usuariosHasFonemasRefsTable(db),
                      managerFromTypedResult: (p0) => $$FonemasTableReferences(
                        db,
                        table,
                        p0,
                      ).usuariosHasFonemasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.fonemaId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FonemasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FonemasTable,
      Fonema,
      $$FonemasTableFilterComposer,
      $$FonemasTableOrderingComposer,
      $$FonemasTableAnnotationComposer,
      $$FonemasTableCreateCompanionBuilder,
      $$FonemasTableUpdateCompanionBuilder,
      (Fonema, $$FonemasTableReferences),
      Fonema,
      PrefetchHooks Function({bool usuariosHasFonemasRefs})
    >;
typedef $$TipoDePalabraTableCreateCompanionBuilder =
    TipoDePalabraCompanion Function({Value<int> id, required String tipo});
typedef $$TipoDePalabraTableUpdateCompanionBuilder =
    TipoDePalabraCompanion Function({Value<int> id, Value<String> tipo});

final class $$TipoDePalabraTableReferences
    extends
        BaseReferences<_$AppDatabase, $TipoDePalabraTable, TipoDePalabraData> {
  $$TipoDePalabraTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PalabrasTable, List<Palabra>> _palabrasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.palabras,
    aliasName: $_aliasNameGenerator(
      db.tipoDePalabra.id,
      db.palabras.tipoDePalabraId,
    ),
  );

  $$PalabrasTableProcessedTableManager get palabrasRefs {
    final manager = $$PalabrasTableTableManager(
      $_db,
      $_db.palabras,
    ).filter((f) => f.tipoDePalabraId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_palabrasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TipoDePalabraTableFilterComposer
    extends Composer<_$AppDatabase, $TipoDePalabraTable> {
  $$TipoDePalabraTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> palabrasRefs(
    Expression<bool> Function($$PalabrasTableFilterComposer f) f,
  ) {
    final $$PalabrasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.palabras,
      getReferencedColumn: (t) => t.tipoDePalabraId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PalabrasTableFilterComposer(
            $db: $db,
            $table: $db.palabras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TipoDePalabraTableOrderingComposer
    extends Composer<_$AppDatabase, $TipoDePalabraTable> {
  $$TipoDePalabraTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TipoDePalabraTableAnnotationComposer
    extends Composer<_$AppDatabase, $TipoDePalabraTable> {
  $$TipoDePalabraTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  Expression<T> palabrasRefs<T extends Object>(
    Expression<T> Function($$PalabrasTableAnnotationComposer a) f,
  ) {
    final $$PalabrasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.palabras,
      getReferencedColumn: (t) => t.tipoDePalabraId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PalabrasTableAnnotationComposer(
            $db: $db,
            $table: $db.palabras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TipoDePalabraTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TipoDePalabraTable,
          TipoDePalabraData,
          $$TipoDePalabraTableFilterComposer,
          $$TipoDePalabraTableOrderingComposer,
          $$TipoDePalabraTableAnnotationComposer,
          $$TipoDePalabraTableCreateCompanionBuilder,
          $$TipoDePalabraTableUpdateCompanionBuilder,
          (TipoDePalabraData, $$TipoDePalabraTableReferences),
          TipoDePalabraData,
          PrefetchHooks Function({bool palabrasRefs})
        > {
  $$TipoDePalabraTableTableManager(_$AppDatabase db, $TipoDePalabraTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TipoDePalabraTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TipoDePalabraTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TipoDePalabraTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tipo = const Value.absent(),
              }) => TipoDePalabraCompanion(id: id, tipo: tipo),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String tipo}) =>
                  TipoDePalabraCompanion.insert(id: id, tipo: tipo),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TipoDePalabraTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({palabrasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (palabrasRefs) db.palabras],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (palabrasRefs)
                    await $_getPrefetchedData<
                      TipoDePalabraData,
                      $TipoDePalabraTable,
                      Palabra
                    >(
                      currentTable: table,
                      referencedTable: $$TipoDePalabraTableReferences
                          ._palabrasRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TipoDePalabraTableReferences(
                            db,
                            table,
                            p0,
                          ).palabrasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.tipoDePalabraId == item.id,
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

typedef $$TipoDePalabraTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TipoDePalabraTable,
      TipoDePalabraData,
      $$TipoDePalabraTableFilterComposer,
      $$TipoDePalabraTableOrderingComposer,
      $$TipoDePalabraTableAnnotationComposer,
      $$TipoDePalabraTableCreateCompanionBuilder,
      $$TipoDePalabraTableUpdateCompanionBuilder,
      (TipoDePalabraData, $$TipoDePalabraTableReferences),
      TipoDePalabraData,
      PrefetchHooks Function({bool palabrasRefs})
    >;
typedef $$PalabrasTableCreateCompanionBuilder =
    PalabrasCompanion Function({
      Value<int> id,
      required String palabra,
      required int tipoDePalabraId,
    });
typedef $$PalabrasTableUpdateCompanionBuilder =
    PalabrasCompanion Function({
      Value<int> id,
      Value<String> palabra,
      Value<int> tipoDePalabraId,
    });

final class $$PalabrasTableReferences
    extends BaseReferences<_$AppDatabase, $PalabrasTable, Palabra> {
  $$PalabrasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TipoDePalabraTable _tipoDePalabraIdTable(_$AppDatabase db) =>
      db.tipoDePalabra.createAlias(
        $_aliasNameGenerator(db.palabras.tipoDePalabraId, db.tipoDePalabra.id),
      );

  $$TipoDePalabraTableProcessedTableManager get tipoDePalabraId {
    final $_column = $_itemColumn<int>('tipo_de_palabra_id')!;

    final manager = $$TipoDePalabraTableTableManager(
      $_db,
      $_db.tipoDePalabra,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tipoDePalabraIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $UsuariosHasPalabrasTable,
    List<UsuariosHasPalabra>
  >
  _usuariosHasPalabrasRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.usuariosHasPalabras,
        aliasName: $_aliasNameGenerator(
          db.palabras.id,
          db.usuariosHasPalabras.palabraId,
        ),
      );

  $$UsuariosHasPalabrasTableProcessedTableManager get usuariosHasPalabrasRefs {
    final manager = $$UsuariosHasPalabrasTableTableManager(
      $_db,
      $_db.usuariosHasPalabras,
    ).filter((f) => f.palabraId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _usuariosHasPalabrasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PalabrasTableFilterComposer
    extends Composer<_$AppDatabase, $PalabrasTable> {
  $$PalabrasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get palabra => $composableBuilder(
    column: $table.palabra,
    builder: (column) => ColumnFilters(column),
  );

  $$TipoDePalabraTableFilterComposer get tipoDePalabraId {
    final $$TipoDePalabraTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tipoDePalabraId,
      referencedTable: $db.tipoDePalabra,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TipoDePalabraTableFilterComposer(
            $db: $db,
            $table: $db.tipoDePalabra,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> usuariosHasPalabrasRefs(
    Expression<bool> Function($$UsuariosHasPalabrasTableFilterComposer f) f,
  ) {
    final $$UsuariosHasPalabrasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usuariosHasPalabras,
      getReferencedColumn: (t) => t.palabraId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosHasPalabrasTableFilterComposer(
            $db: $db,
            $table: $db.usuariosHasPalabras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PalabrasTableOrderingComposer
    extends Composer<_$AppDatabase, $PalabrasTable> {
  $$PalabrasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get palabra => $composableBuilder(
    column: $table.palabra,
    builder: (column) => ColumnOrderings(column),
  );

  $$TipoDePalabraTableOrderingComposer get tipoDePalabraId {
    final $$TipoDePalabraTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tipoDePalabraId,
      referencedTable: $db.tipoDePalabra,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TipoDePalabraTableOrderingComposer(
            $db: $db,
            $table: $db.tipoDePalabra,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PalabrasTableAnnotationComposer
    extends Composer<_$AppDatabase, $PalabrasTable> {
  $$PalabrasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get palabra =>
      $composableBuilder(column: $table.palabra, builder: (column) => column);

  $$TipoDePalabraTableAnnotationComposer get tipoDePalabraId {
    final $$TipoDePalabraTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tipoDePalabraId,
      referencedTable: $db.tipoDePalabra,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TipoDePalabraTableAnnotationComposer(
            $db: $db,
            $table: $db.tipoDePalabra,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> usuariosHasPalabrasRefs<T extends Object>(
    Expression<T> Function($$UsuariosHasPalabrasTableAnnotationComposer a) f,
  ) {
    final $$UsuariosHasPalabrasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.usuariosHasPalabras,
          getReferencedColumn: (t) => t.palabraId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UsuariosHasPalabrasTableAnnotationComposer(
                $db: $db,
                $table: $db.usuariosHasPalabras,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PalabrasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PalabrasTable,
          Palabra,
          $$PalabrasTableFilterComposer,
          $$PalabrasTableOrderingComposer,
          $$PalabrasTableAnnotationComposer,
          $$PalabrasTableCreateCompanionBuilder,
          $$PalabrasTableUpdateCompanionBuilder,
          (Palabra, $$PalabrasTableReferences),
          Palabra,
          PrefetchHooks Function({
            bool tipoDePalabraId,
            bool usuariosHasPalabrasRefs,
          })
        > {
  $$PalabrasTableTableManager(_$AppDatabase db, $PalabrasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PalabrasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PalabrasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PalabrasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> palabra = const Value.absent(),
                Value<int> tipoDePalabraId = const Value.absent(),
              }) => PalabrasCompanion(
                id: id,
                palabra: palabra,
                tipoDePalabraId: tipoDePalabraId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String palabra,
                required int tipoDePalabraId,
              }) => PalabrasCompanion.insert(
                id: id,
                palabra: palabra,
                tipoDePalabraId: tipoDePalabraId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PalabrasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({tipoDePalabraId = false, usuariosHasPalabrasRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (usuariosHasPalabrasRefs) db.usuariosHasPalabras,
                  ],
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
                        if (tipoDePalabraId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.tipoDePalabraId,
                                    referencedTable: $$PalabrasTableReferences
                                        ._tipoDePalabraIdTable(db),
                                    referencedColumn: $$PalabrasTableReferences
                                        ._tipoDePalabraIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (usuariosHasPalabrasRefs)
                        await $_getPrefetchedData<
                          Palabra,
                          $PalabrasTable,
                          UsuariosHasPalabra
                        >(
                          currentTable: table,
                          referencedTable: $$PalabrasTableReferences
                              ._usuariosHasPalabrasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PalabrasTableReferences(
                                db,
                                table,
                                p0,
                              ).usuariosHasPalabrasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.palabraId == item.id,
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

typedef $$PalabrasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PalabrasTable,
      Palabra,
      $$PalabrasTableFilterComposer,
      $$PalabrasTableOrderingComposer,
      $$PalabrasTableAnnotationComposer,
      $$PalabrasTableCreateCompanionBuilder,
      $$PalabrasTableUpdateCompanionBuilder,
      (Palabra, $$PalabrasTableReferences),
      Palabra,
      PrefetchHooks Function({
        bool tipoDePalabraId,
        bool usuariosHasPalabrasRefs,
      })
    >;
typedef $$ModulosTableCreateCompanionBuilder =
    ModulosCompanion Function({Value<int> id, required String nombre});
typedef $$ModulosTableUpdateCompanionBuilder =
    ModulosCompanion Function({Value<int> id, Value<String> nombre});

final class $$ModulosTableReferences
    extends BaseReferences<_$AppDatabase, $ModulosTable, Modulo> {
  $$ModulosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ActividadesHasModulosTable,
    List<ActividadesHasModulo>
  >
  _actividadesHasModulosRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.actividadesHasModulos,
        aliasName: $_aliasNameGenerator(
          db.modulos.id,
          db.actividadesHasModulos.moduloId,
        ),
      );

  $$ActividadesHasModulosTableProcessedTableManager
  get actividadesHasModulosRefs {
    final manager = $$ActividadesHasModulosTableTableManager(
      $_db,
      $_db.actividadesHasModulos,
    ).filter((f) => f.moduloId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _actividadesHasModulosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ModulosHasUsuariosTable, List<ModulosHasUsuario>>
  _modulosHasUsuariosRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.modulosHasUsuarios,
        aliasName: $_aliasNameGenerator(
          db.modulos.id,
          db.modulosHasUsuarios.moduloId,
        ),
      );

  $$ModulosHasUsuariosTableProcessedTableManager get modulosHasUsuariosRefs {
    final manager = $$ModulosHasUsuariosTableTableManager(
      $_db,
      $_db.modulosHasUsuarios,
    ).filter((f) => f.moduloId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _modulosHasUsuariosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ModulosTableFilterComposer
    extends Composer<_$AppDatabase, $ModulosTable> {
  $$ModulosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> actividadesHasModulosRefs(
    Expression<bool> Function($$ActividadesHasModulosTableFilterComposer f) f,
  ) {
    final $$ActividadesHasModulosTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.actividadesHasModulos,
          getReferencedColumn: (t) => t.moduloId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ActividadesHasModulosTableFilterComposer(
                $db: $db,
                $table: $db.actividadesHasModulos,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> modulosHasUsuariosRefs(
    Expression<bool> Function($$ModulosHasUsuariosTableFilterComposer f) f,
  ) {
    final $$ModulosHasUsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.modulosHasUsuarios,
      getReferencedColumn: (t) => t.moduloId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ModulosHasUsuariosTableFilterComposer(
            $db: $db,
            $table: $db.modulosHasUsuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ModulosTableOrderingComposer
    extends Composer<_$AppDatabase, $ModulosTable> {
  $$ModulosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ModulosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ModulosTable> {
  $$ModulosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  Expression<T> actividadesHasModulosRefs<T extends Object>(
    Expression<T> Function($$ActividadesHasModulosTableAnnotationComposer a) f,
  ) {
    final $$ActividadesHasModulosTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.actividadesHasModulos,
          getReferencedColumn: (t) => t.moduloId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ActividadesHasModulosTableAnnotationComposer(
                $db: $db,
                $table: $db.actividadesHasModulos,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> modulosHasUsuariosRefs<T extends Object>(
    Expression<T> Function($$ModulosHasUsuariosTableAnnotationComposer a) f,
  ) {
    final $$ModulosHasUsuariosTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.modulosHasUsuarios,
          getReferencedColumn: (t) => t.moduloId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ModulosHasUsuariosTableAnnotationComposer(
                $db: $db,
                $table: $db.modulosHasUsuarios,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ModulosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ModulosTable,
          Modulo,
          $$ModulosTableFilterComposer,
          $$ModulosTableOrderingComposer,
          $$ModulosTableAnnotationComposer,
          $$ModulosTableCreateCompanionBuilder,
          $$ModulosTableUpdateCompanionBuilder,
          (Modulo, $$ModulosTableReferences),
          Modulo,
          PrefetchHooks Function({
            bool actividadesHasModulosRefs,
            bool modulosHasUsuariosRefs,
          })
        > {
  $$ModulosTableTableManager(_$AppDatabase db, $ModulosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ModulosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ModulosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ModulosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
              }) => ModulosCompanion(id: id, nombre: nombre),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
              }) => ModulosCompanion.insert(id: id, nombre: nombre),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ModulosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                actividadesHasModulosRefs = false,
                modulosHasUsuariosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (actividadesHasModulosRefs) db.actividadesHasModulos,
                    if (modulosHasUsuariosRefs) db.modulosHasUsuarios,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (actividadesHasModulosRefs)
                        await $_getPrefetchedData<
                          Modulo,
                          $ModulosTable,
                          ActividadesHasModulo
                        >(
                          currentTable: table,
                          referencedTable: $$ModulosTableReferences
                              ._actividadesHasModulosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ModulosTableReferences(
                                db,
                                table,
                                p0,
                              ).actividadesHasModulosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.moduloId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (modulosHasUsuariosRefs)
                        await $_getPrefetchedData<
                          Modulo,
                          $ModulosTable,
                          ModulosHasUsuario
                        >(
                          currentTable: table,
                          referencedTable: $$ModulosTableReferences
                              ._modulosHasUsuariosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ModulosTableReferences(
                                db,
                                table,
                                p0,
                              ).modulosHasUsuariosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.moduloId == item.id,
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

typedef $$ModulosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ModulosTable,
      Modulo,
      $$ModulosTableFilterComposer,
      $$ModulosTableOrderingComposer,
      $$ModulosTableAnnotationComposer,
      $$ModulosTableCreateCompanionBuilder,
      $$ModulosTableUpdateCompanionBuilder,
      (Modulo, $$ModulosTableReferences),
      Modulo,
      PrefetchHooks Function({
        bool actividadesHasModulosRefs,
        bool modulosHasUsuariosRefs,
      })
    >;
typedef $$ActividadesTableCreateCompanionBuilder =
    ActividadesCompanion Function({Value<int> id, Value<String?> nombre});
typedef $$ActividadesTableUpdateCompanionBuilder =
    ActividadesCompanion Function({Value<int> id, Value<String?> nombre});

final class $$ActividadesTableReferences
    extends BaseReferences<_$AppDatabase, $ActividadesTable, Actividade> {
  $$ActividadesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ActividadesHasModulosTable,
    List<ActividadesHasModulo>
  >
  _actividadesHasModulosRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.actividadesHasModulos,
        aliasName: $_aliasNameGenerator(
          db.actividades.id,
          db.actividadesHasModulos.actividadId,
        ),
      );

  $$ActividadesHasModulosTableProcessedTableManager
  get actividadesHasModulosRefs {
    final manager = $$ActividadesHasModulosTableTableManager(
      $_db,
      $_db.actividadesHasModulos,
    ).filter((f) => f.actividadId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _actividadesHasModulosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $UsuariosHasActividadesTable,
    List<ProgresoActividad>
  >
  _usuariosHasActividadesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.usuariosHasActividades,
        aliasName: $_aliasNameGenerator(
          db.actividades.id,
          db.usuariosHasActividades.actividadId,
        ),
      );

  $$UsuariosHasActividadesTableProcessedTableManager
  get usuariosHasActividadesRefs {
    final manager = $$UsuariosHasActividadesTableTableManager(
      $_db,
      $_db.usuariosHasActividades,
    ).filter((f) => f.actividadId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _usuariosHasActividadesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ActividadesTableFilterComposer
    extends Composer<_$AppDatabase, $ActividadesTable> {
  $$ActividadesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> actividadesHasModulosRefs(
    Expression<bool> Function($$ActividadesHasModulosTableFilterComposer f) f,
  ) {
    final $$ActividadesHasModulosTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.actividadesHasModulos,
          getReferencedColumn: (t) => t.actividadId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ActividadesHasModulosTableFilterComposer(
                $db: $db,
                $table: $db.actividadesHasModulos,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> usuariosHasActividadesRefs(
    Expression<bool> Function($$UsuariosHasActividadesTableFilterComposer f) f,
  ) {
    final $$UsuariosHasActividadesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.usuariosHasActividades,
          getReferencedColumn: (t) => t.actividadId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UsuariosHasActividadesTableFilterComposer(
                $db: $db,
                $table: $db.usuariosHasActividades,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ActividadesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActividadesTable> {
  $$ActividadesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActividadesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActividadesTable> {
  $$ActividadesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  Expression<T> actividadesHasModulosRefs<T extends Object>(
    Expression<T> Function($$ActividadesHasModulosTableAnnotationComposer a) f,
  ) {
    final $$ActividadesHasModulosTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.actividadesHasModulos,
          getReferencedColumn: (t) => t.actividadId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ActividadesHasModulosTableAnnotationComposer(
                $db: $db,
                $table: $db.actividadesHasModulos,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> usuariosHasActividadesRefs<T extends Object>(
    Expression<T> Function($$UsuariosHasActividadesTableAnnotationComposer a) f,
  ) {
    final $$UsuariosHasActividadesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.usuariosHasActividades,
          getReferencedColumn: (t) => t.actividadId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UsuariosHasActividadesTableAnnotationComposer(
                $db: $db,
                $table: $db.usuariosHasActividades,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ActividadesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActividadesTable,
          Actividade,
          $$ActividadesTableFilterComposer,
          $$ActividadesTableOrderingComposer,
          $$ActividadesTableAnnotationComposer,
          $$ActividadesTableCreateCompanionBuilder,
          $$ActividadesTableUpdateCompanionBuilder,
          (Actividade, $$ActividadesTableReferences),
          Actividade,
          PrefetchHooks Function({
            bool actividadesHasModulosRefs,
            bool usuariosHasActividadesRefs,
          })
        > {
  $$ActividadesTableTableManager(_$AppDatabase db, $ActividadesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActividadesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActividadesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActividadesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> nombre = const Value.absent(),
              }) => ActividadesCompanion(id: id, nombre: nombre),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> nombre = const Value.absent(),
              }) => ActividadesCompanion.insert(id: id, nombre: nombre),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ActividadesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                actividadesHasModulosRefs = false,
                usuariosHasActividadesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (actividadesHasModulosRefs) db.actividadesHasModulos,
                    if (usuariosHasActividadesRefs) db.usuariosHasActividades,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (actividadesHasModulosRefs)
                        await $_getPrefetchedData<
                          Actividade,
                          $ActividadesTable,
                          ActividadesHasModulo
                        >(
                          currentTable: table,
                          referencedTable: $$ActividadesTableReferences
                              ._actividadesHasModulosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ActividadesTableReferences(
                                db,
                                table,
                                p0,
                              ).actividadesHasModulosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.actividadId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (usuariosHasActividadesRefs)
                        await $_getPrefetchedData<
                          Actividade,
                          $ActividadesTable,
                          ProgresoActividad
                        >(
                          currentTable: table,
                          referencedTable: $$ActividadesTableReferences
                              ._usuariosHasActividadesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ActividadesTableReferences(
                                db,
                                table,
                                p0,
                              ).usuariosHasActividadesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.actividadId == item.id,
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

typedef $$ActividadesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActividadesTable,
      Actividade,
      $$ActividadesTableFilterComposer,
      $$ActividadesTableOrderingComposer,
      $$ActividadesTableAnnotationComposer,
      $$ActividadesTableCreateCompanionBuilder,
      $$ActividadesTableUpdateCompanionBuilder,
      (Actividade, $$ActividadesTableReferences),
      Actividade,
      PrefetchHooks Function({
        bool actividadesHasModulosRefs,
        bool usuariosHasActividadesRefs,
      })
    >;
typedef $$MedallasTableCreateCompanionBuilder =
    MedallasCompanion Function({
      Value<int> id,
      required String nombre,
      required String imagen,
      required String assetPath,
    });
typedef $$MedallasTableUpdateCompanionBuilder =
    MedallasCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> imagen,
      Value<String> assetPath,
    });

final class $$MedallasTableReferences
    extends BaseReferences<_$AppDatabase, $MedallasTable, Medalla> {
  $$MedallasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $UsuariosHasMedallasTable,
    List<UsuariosHasMedalla>
  >
  _usuariosHasMedallasRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.usuariosHasMedallas,
        aliasName: $_aliasNameGenerator(
          db.medallas.id,
          db.usuariosHasMedallas.medallaId,
        ),
      );

  $$UsuariosHasMedallasTableProcessedTableManager get usuariosHasMedallasRefs {
    final manager = $$UsuariosHasMedallasTableTableManager(
      $_db,
      $_db.usuariosHasMedallas,
    ).filter((f) => f.medallaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _usuariosHasMedallasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MedallasTableFilterComposer
    extends Composer<_$AppDatabase, $MedallasTable> {
  $$MedallasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagen => $composableBuilder(
    column: $table.imagen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetPath => $composableBuilder(
    column: $table.assetPath,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> usuariosHasMedallasRefs(
    Expression<bool> Function($$UsuariosHasMedallasTableFilterComposer f) f,
  ) {
    final $$UsuariosHasMedallasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usuariosHasMedallas,
      getReferencedColumn: (t) => t.medallaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosHasMedallasTableFilterComposer(
            $db: $db,
            $table: $db.usuariosHasMedallas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MedallasTableOrderingComposer
    extends Composer<_$AppDatabase, $MedallasTable> {
  $$MedallasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagen => $composableBuilder(
    column: $table.imagen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetPath => $composableBuilder(
    column: $table.assetPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MedallasTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedallasTable> {
  $$MedallasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get imagen =>
      $composableBuilder(column: $table.imagen, builder: (column) => column);

  GeneratedColumn<String> get assetPath =>
      $composableBuilder(column: $table.assetPath, builder: (column) => column);

  Expression<T> usuariosHasMedallasRefs<T extends Object>(
    Expression<T> Function($$UsuariosHasMedallasTableAnnotationComposer a) f,
  ) {
    final $$UsuariosHasMedallasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.usuariosHasMedallas,
          getReferencedColumn: (t) => t.medallaId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UsuariosHasMedallasTableAnnotationComposer(
                $db: $db,
                $table: $db.usuariosHasMedallas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MedallasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MedallasTable,
          Medalla,
          $$MedallasTableFilterComposer,
          $$MedallasTableOrderingComposer,
          $$MedallasTableAnnotationComposer,
          $$MedallasTableCreateCompanionBuilder,
          $$MedallasTableUpdateCompanionBuilder,
          (Medalla, $$MedallasTableReferences),
          Medalla,
          PrefetchHooks Function({bool usuariosHasMedallasRefs})
        > {
  $$MedallasTableTableManager(_$AppDatabase db, $MedallasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedallasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedallasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedallasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> imagen = const Value.absent(),
                Value<String> assetPath = const Value.absent(),
              }) => MedallasCompanion(
                id: id,
                nombre: nombre,
                imagen: imagen,
                assetPath: assetPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String imagen,
                required String assetPath,
              }) => MedallasCompanion.insert(
                id: id,
                nombre: nombre,
                imagen: imagen,
                assetPath: assetPath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MedallasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usuariosHasMedallasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (usuariosHasMedallasRefs) db.usuariosHasMedallas,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (usuariosHasMedallasRefs)
                    await $_getPrefetchedData<
                      Medalla,
                      $MedallasTable,
                      UsuariosHasMedalla
                    >(
                      currentTable: table,
                      referencedTable: $$MedallasTableReferences
                          ._usuariosHasMedallasRefsTable(db),
                      managerFromTypedResult: (p0) => $$MedallasTableReferences(
                        db,
                        table,
                        p0,
                      ).usuariosHasMedallasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.medallaId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MedallasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MedallasTable,
      Medalla,
      $$MedallasTableFilterComposer,
      $$MedallasTableOrderingComposer,
      $$MedallasTableAnnotationComposer,
      $$MedallasTableCreateCompanionBuilder,
      $$MedallasTableUpdateCompanionBuilder,
      (Medalla, $$MedallasTableReferences),
      Medalla,
      PrefetchHooks Function({bool usuariosHasMedallasRefs})
    >;
typedef $$UsuariosHasNumerosTableCreateCompanionBuilder =
    UsuariosHasNumerosCompanion Function({
      required String usuarioId,
      required int numeroId,
      required int aciertos,
      required int total,
      Value<int> rowid,
    });
typedef $$UsuariosHasNumerosTableUpdateCompanionBuilder =
    UsuariosHasNumerosCompanion Function({
      Value<String> usuarioId,
      Value<int> numeroId,
      Value<int> aciertos,
      Value<int> total,
      Value<int> rowid,
    });

final class $$UsuariosHasNumerosTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UsuariosHasNumerosTable,
          UsuariosHasNumero
        > {
  $$UsuariosHasNumerosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias(
        $_aliasNameGenerator(db.usuariosHasNumeros.usuarioId, db.usuarios.id),
      );

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<String>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $NumerosTable _numeroIdTable(_$AppDatabase db) =>
      db.numeros.createAlias(
        $_aliasNameGenerator(db.usuariosHasNumeros.numeroId, db.numeros.id),
      );

  $$NumerosTableProcessedTableManager get numeroId {
    final $_column = $_itemColumn<int>('numero_id')!;

    final manager = $$NumerosTableTableManager(
      $_db,
      $_db.numeros,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_numeroIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UsuariosHasNumerosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosHasNumerosTable> {
  $$UsuariosHasNumerosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get aciertos => $composableBuilder(
    column: $table.aciertos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NumerosTableFilterComposer get numeroId {
    final $$NumerosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.numeroId,
      referencedTable: $db.numeros,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NumerosTableFilterComposer(
            $db: $db,
            $table: $db.numeros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasNumerosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosHasNumerosTable> {
  $$UsuariosHasNumerosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get aciertos => $composableBuilder(
    column: $table.aciertos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NumerosTableOrderingComposer get numeroId {
    final $$NumerosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.numeroId,
      referencedTable: $db.numeros,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NumerosTableOrderingComposer(
            $db: $db,
            $table: $db.numeros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasNumerosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosHasNumerosTable> {
  $$UsuariosHasNumerosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get aciertos =>
      $composableBuilder(column: $table.aciertos, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NumerosTableAnnotationComposer get numeroId {
    final $$NumerosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.numeroId,
      referencedTable: $db.numeros,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NumerosTableAnnotationComposer(
            $db: $db,
            $table: $db.numeros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasNumerosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosHasNumerosTable,
          UsuariosHasNumero,
          $$UsuariosHasNumerosTableFilterComposer,
          $$UsuariosHasNumerosTableOrderingComposer,
          $$UsuariosHasNumerosTableAnnotationComposer,
          $$UsuariosHasNumerosTableCreateCompanionBuilder,
          $$UsuariosHasNumerosTableUpdateCompanionBuilder,
          (UsuariosHasNumero, $$UsuariosHasNumerosTableReferences),
          UsuariosHasNumero,
          PrefetchHooks Function({bool usuarioId, bool numeroId})
        > {
  $$UsuariosHasNumerosTableTableManager(
    _$AppDatabase db,
    $UsuariosHasNumerosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosHasNumerosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosHasNumerosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosHasNumerosTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> usuarioId = const Value.absent(),
                Value<int> numeroId = const Value.absent(),
                Value<int> aciertos = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosHasNumerosCompanion(
                usuarioId: usuarioId,
                numeroId: numeroId,
                aciertos: aciertos,
                total: total,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String usuarioId,
                required int numeroId,
                required int aciertos,
                required int total,
                Value<int> rowid = const Value.absent(),
              }) => UsuariosHasNumerosCompanion.insert(
                usuarioId: usuarioId,
                numeroId: numeroId,
                aciertos: aciertos,
                total: total,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosHasNumerosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usuarioId = false, numeroId = false}) {
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
                    if (usuarioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.usuarioId,
                                referencedTable:
                                    $$UsuariosHasNumerosTableReferences
                                        ._usuarioIdTable(db),
                                referencedColumn:
                                    $$UsuariosHasNumerosTableReferences
                                        ._usuarioIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (numeroId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.numeroId,
                                referencedTable:
                                    $$UsuariosHasNumerosTableReferences
                                        ._numeroIdTable(db),
                                referencedColumn:
                                    $$UsuariosHasNumerosTableReferences
                                        ._numeroIdTable(db)
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

typedef $$UsuariosHasNumerosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosHasNumerosTable,
      UsuariosHasNumero,
      $$UsuariosHasNumerosTableFilterComposer,
      $$UsuariosHasNumerosTableOrderingComposer,
      $$UsuariosHasNumerosTableAnnotationComposer,
      $$UsuariosHasNumerosTableCreateCompanionBuilder,
      $$UsuariosHasNumerosTableUpdateCompanionBuilder,
      (UsuariosHasNumero, $$UsuariosHasNumerosTableReferences),
      UsuariosHasNumero,
      PrefetchHooks Function({bool usuarioId, bool numeroId})
    >;
typedef $$UsuariosHasFonemasTableCreateCompanionBuilder =
    UsuariosHasFonemasCompanion Function({
      required String usuarioId,
      required int fonemaId,
      required int aciertos,
      required int total,
      Value<int> rowid,
    });
typedef $$UsuariosHasFonemasTableUpdateCompanionBuilder =
    UsuariosHasFonemasCompanion Function({
      Value<String> usuarioId,
      Value<int> fonemaId,
      Value<int> aciertos,
      Value<int> total,
      Value<int> rowid,
    });

final class $$UsuariosHasFonemasTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UsuariosHasFonemasTable,
          UsuariosHasFonema
        > {
  $$UsuariosHasFonemasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias(
        $_aliasNameGenerator(db.usuariosHasFonemas.usuarioId, db.usuarios.id),
      );

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<String>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FonemasTable _fonemaIdTable(_$AppDatabase db) =>
      db.fonemas.createAlias(
        $_aliasNameGenerator(db.usuariosHasFonemas.fonemaId, db.fonemas.id),
      );

  $$FonemasTableProcessedTableManager get fonemaId {
    final $_column = $_itemColumn<int>('fonema_id')!;

    final manager = $$FonemasTableTableManager(
      $_db,
      $_db.fonemas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fonemaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UsuariosHasFonemasTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosHasFonemasTable> {
  $$UsuariosHasFonemasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get aciertos => $composableBuilder(
    column: $table.aciertos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FonemasTableFilterComposer get fonemaId {
    final $$FonemasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fonemaId,
      referencedTable: $db.fonemas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FonemasTableFilterComposer(
            $db: $db,
            $table: $db.fonemas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasFonemasTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosHasFonemasTable> {
  $$UsuariosHasFonemasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get aciertos => $composableBuilder(
    column: $table.aciertos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FonemasTableOrderingComposer get fonemaId {
    final $$FonemasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fonemaId,
      referencedTable: $db.fonemas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FonemasTableOrderingComposer(
            $db: $db,
            $table: $db.fonemas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasFonemasTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosHasFonemasTable> {
  $$UsuariosHasFonemasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get aciertos =>
      $composableBuilder(column: $table.aciertos, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FonemasTableAnnotationComposer get fonemaId {
    final $$FonemasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fonemaId,
      referencedTable: $db.fonemas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FonemasTableAnnotationComposer(
            $db: $db,
            $table: $db.fonemas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasFonemasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosHasFonemasTable,
          UsuariosHasFonema,
          $$UsuariosHasFonemasTableFilterComposer,
          $$UsuariosHasFonemasTableOrderingComposer,
          $$UsuariosHasFonemasTableAnnotationComposer,
          $$UsuariosHasFonemasTableCreateCompanionBuilder,
          $$UsuariosHasFonemasTableUpdateCompanionBuilder,
          (UsuariosHasFonema, $$UsuariosHasFonemasTableReferences),
          UsuariosHasFonema,
          PrefetchHooks Function({bool usuarioId, bool fonemaId})
        > {
  $$UsuariosHasFonemasTableTableManager(
    _$AppDatabase db,
    $UsuariosHasFonemasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosHasFonemasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosHasFonemasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosHasFonemasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> usuarioId = const Value.absent(),
                Value<int> fonemaId = const Value.absent(),
                Value<int> aciertos = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosHasFonemasCompanion(
                usuarioId: usuarioId,
                fonemaId: fonemaId,
                aciertos: aciertos,
                total: total,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String usuarioId,
                required int fonemaId,
                required int aciertos,
                required int total,
                Value<int> rowid = const Value.absent(),
              }) => UsuariosHasFonemasCompanion.insert(
                usuarioId: usuarioId,
                fonemaId: fonemaId,
                aciertos: aciertos,
                total: total,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosHasFonemasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usuarioId = false, fonemaId = false}) {
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
                    if (usuarioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.usuarioId,
                                referencedTable:
                                    $$UsuariosHasFonemasTableReferences
                                        ._usuarioIdTable(db),
                                referencedColumn:
                                    $$UsuariosHasFonemasTableReferences
                                        ._usuarioIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (fonemaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fonemaId,
                                referencedTable:
                                    $$UsuariosHasFonemasTableReferences
                                        ._fonemaIdTable(db),
                                referencedColumn:
                                    $$UsuariosHasFonemasTableReferences
                                        ._fonemaIdTable(db)
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

typedef $$UsuariosHasFonemasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosHasFonemasTable,
      UsuariosHasFonema,
      $$UsuariosHasFonemasTableFilterComposer,
      $$UsuariosHasFonemasTableOrderingComposer,
      $$UsuariosHasFonemasTableAnnotationComposer,
      $$UsuariosHasFonemasTableCreateCompanionBuilder,
      $$UsuariosHasFonemasTableUpdateCompanionBuilder,
      (UsuariosHasFonema, $$UsuariosHasFonemasTableReferences),
      UsuariosHasFonema,
      PrefetchHooks Function({bool usuarioId, bool fonemaId})
    >;
typedef $$UsuariosHasPalabrasTableCreateCompanionBuilder =
    UsuariosHasPalabrasCompanion Function({
      required String usuarioId,
      required int palabraId,
      required int aciertos,
      required int total,
      Value<int> rowid,
    });
typedef $$UsuariosHasPalabrasTableUpdateCompanionBuilder =
    UsuariosHasPalabrasCompanion Function({
      Value<String> usuarioId,
      Value<int> palabraId,
      Value<int> aciertos,
      Value<int> total,
      Value<int> rowid,
    });

final class $$UsuariosHasPalabrasTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UsuariosHasPalabrasTable,
          UsuariosHasPalabra
        > {
  $$UsuariosHasPalabrasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias(
        $_aliasNameGenerator(db.usuariosHasPalabras.usuarioId, db.usuarios.id),
      );

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<String>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PalabrasTable _palabraIdTable(_$AppDatabase db) =>
      db.palabras.createAlias(
        $_aliasNameGenerator(db.usuariosHasPalabras.palabraId, db.palabras.id),
      );

  $$PalabrasTableProcessedTableManager get palabraId {
    final $_column = $_itemColumn<int>('palabra_id')!;

    final manager = $$PalabrasTableTableManager(
      $_db,
      $_db.palabras,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_palabraIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UsuariosHasPalabrasTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosHasPalabrasTable> {
  $$UsuariosHasPalabrasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get aciertos => $composableBuilder(
    column: $table.aciertos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PalabrasTableFilterComposer get palabraId {
    final $$PalabrasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.palabraId,
      referencedTable: $db.palabras,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PalabrasTableFilterComposer(
            $db: $db,
            $table: $db.palabras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasPalabrasTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosHasPalabrasTable> {
  $$UsuariosHasPalabrasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get aciertos => $composableBuilder(
    column: $table.aciertos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PalabrasTableOrderingComposer get palabraId {
    final $$PalabrasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.palabraId,
      referencedTable: $db.palabras,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PalabrasTableOrderingComposer(
            $db: $db,
            $table: $db.palabras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasPalabrasTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosHasPalabrasTable> {
  $$UsuariosHasPalabrasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get aciertos =>
      $composableBuilder(column: $table.aciertos, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PalabrasTableAnnotationComposer get palabraId {
    final $$PalabrasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.palabraId,
      referencedTable: $db.palabras,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PalabrasTableAnnotationComposer(
            $db: $db,
            $table: $db.palabras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasPalabrasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosHasPalabrasTable,
          UsuariosHasPalabra,
          $$UsuariosHasPalabrasTableFilterComposer,
          $$UsuariosHasPalabrasTableOrderingComposer,
          $$UsuariosHasPalabrasTableAnnotationComposer,
          $$UsuariosHasPalabrasTableCreateCompanionBuilder,
          $$UsuariosHasPalabrasTableUpdateCompanionBuilder,
          (UsuariosHasPalabra, $$UsuariosHasPalabrasTableReferences),
          UsuariosHasPalabra,
          PrefetchHooks Function({bool usuarioId, bool palabraId})
        > {
  $$UsuariosHasPalabrasTableTableManager(
    _$AppDatabase db,
    $UsuariosHasPalabrasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosHasPalabrasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosHasPalabrasTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UsuariosHasPalabrasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> usuarioId = const Value.absent(),
                Value<int> palabraId = const Value.absent(),
                Value<int> aciertos = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosHasPalabrasCompanion(
                usuarioId: usuarioId,
                palabraId: palabraId,
                aciertos: aciertos,
                total: total,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String usuarioId,
                required int palabraId,
                required int aciertos,
                required int total,
                Value<int> rowid = const Value.absent(),
              }) => UsuariosHasPalabrasCompanion.insert(
                usuarioId: usuarioId,
                palabraId: palabraId,
                aciertos: aciertos,
                total: total,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosHasPalabrasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usuarioId = false, palabraId = false}) {
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
                    if (usuarioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.usuarioId,
                                referencedTable:
                                    $$UsuariosHasPalabrasTableReferences
                                        ._usuarioIdTable(db),
                                referencedColumn:
                                    $$UsuariosHasPalabrasTableReferences
                                        ._usuarioIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (palabraId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.palabraId,
                                referencedTable:
                                    $$UsuariosHasPalabrasTableReferences
                                        ._palabraIdTable(db),
                                referencedColumn:
                                    $$UsuariosHasPalabrasTableReferences
                                        ._palabraIdTable(db)
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

typedef $$UsuariosHasPalabrasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosHasPalabrasTable,
      UsuariosHasPalabra,
      $$UsuariosHasPalabrasTableFilterComposer,
      $$UsuariosHasPalabrasTableOrderingComposer,
      $$UsuariosHasPalabrasTableAnnotationComposer,
      $$UsuariosHasPalabrasTableCreateCompanionBuilder,
      $$UsuariosHasPalabrasTableUpdateCompanionBuilder,
      (UsuariosHasPalabra, $$UsuariosHasPalabrasTableReferences),
      UsuariosHasPalabra,
      PrefetchHooks Function({bool usuarioId, bool palabraId})
    >;
typedef $$ActividadesHasModulosTableCreateCompanionBuilder =
    ActividadesHasModulosCompanion Function({
      required int actividadId,
      required int moduloId,
      Value<int> rowid,
    });
typedef $$ActividadesHasModulosTableUpdateCompanionBuilder =
    ActividadesHasModulosCompanion Function({
      Value<int> actividadId,
      Value<int> moduloId,
      Value<int> rowid,
    });

final class $$ActividadesHasModulosTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ActividadesHasModulosTable,
          ActividadesHasModulo
        > {
  $$ActividadesHasModulosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ActividadesTable _actividadIdTable(_$AppDatabase db) =>
      db.actividades.createAlias(
        $_aliasNameGenerator(
          db.actividadesHasModulos.actividadId,
          db.actividades.id,
        ),
      );

  $$ActividadesTableProcessedTableManager get actividadId {
    final $_column = $_itemColumn<int>('actividad_id')!;

    final manager = $$ActividadesTableTableManager(
      $_db,
      $_db.actividades,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_actividadIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ModulosTable _moduloIdTable(_$AppDatabase db) =>
      db.modulos.createAlias(
        $_aliasNameGenerator(db.actividadesHasModulos.moduloId, db.modulos.id),
      );

  $$ModulosTableProcessedTableManager get moduloId {
    final $_column = $_itemColumn<int>('modulo_id')!;

    final manager = $$ModulosTableTableManager(
      $_db,
      $_db.modulos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_moduloIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ActividadesHasModulosTableFilterComposer
    extends Composer<_$AppDatabase, $ActividadesHasModulosTable> {
  $$ActividadesHasModulosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ActividadesTableFilterComposer get actividadId {
    final $$ActividadesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.actividadId,
      referencedTable: $db.actividades,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActividadesTableFilterComposer(
            $db: $db,
            $table: $db.actividades,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ModulosTableFilterComposer get moduloId {
    final $$ModulosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moduloId,
      referencedTable: $db.modulos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ModulosTableFilterComposer(
            $db: $db,
            $table: $db.modulos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActividadesHasModulosTableOrderingComposer
    extends Composer<_$AppDatabase, $ActividadesHasModulosTable> {
  $$ActividadesHasModulosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ActividadesTableOrderingComposer get actividadId {
    final $$ActividadesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.actividadId,
      referencedTable: $db.actividades,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActividadesTableOrderingComposer(
            $db: $db,
            $table: $db.actividades,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ModulosTableOrderingComposer get moduloId {
    final $$ModulosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moduloId,
      referencedTable: $db.modulos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ModulosTableOrderingComposer(
            $db: $db,
            $table: $db.modulos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActividadesHasModulosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActividadesHasModulosTable> {
  $$ActividadesHasModulosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ActividadesTableAnnotationComposer get actividadId {
    final $$ActividadesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.actividadId,
      referencedTable: $db.actividades,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActividadesTableAnnotationComposer(
            $db: $db,
            $table: $db.actividades,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ModulosTableAnnotationComposer get moduloId {
    final $$ModulosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moduloId,
      referencedTable: $db.modulos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ModulosTableAnnotationComposer(
            $db: $db,
            $table: $db.modulos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActividadesHasModulosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActividadesHasModulosTable,
          ActividadesHasModulo,
          $$ActividadesHasModulosTableFilterComposer,
          $$ActividadesHasModulosTableOrderingComposer,
          $$ActividadesHasModulosTableAnnotationComposer,
          $$ActividadesHasModulosTableCreateCompanionBuilder,
          $$ActividadesHasModulosTableUpdateCompanionBuilder,
          (ActividadesHasModulo, $$ActividadesHasModulosTableReferences),
          ActividadesHasModulo,
          PrefetchHooks Function({bool actividadId, bool moduloId})
        > {
  $$ActividadesHasModulosTableTableManager(
    _$AppDatabase db,
    $ActividadesHasModulosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActividadesHasModulosTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ActividadesHasModulosTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ActividadesHasModulosTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> actividadId = const Value.absent(),
                Value<int> moduloId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActividadesHasModulosCompanion(
                actividadId: actividadId,
                moduloId: moduloId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int actividadId,
                required int moduloId,
                Value<int> rowid = const Value.absent(),
              }) => ActividadesHasModulosCompanion.insert(
                actividadId: actividadId,
                moduloId: moduloId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ActividadesHasModulosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({actividadId = false, moduloId = false}) {
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
                    if (actividadId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.actividadId,
                                referencedTable:
                                    $$ActividadesHasModulosTableReferences
                                        ._actividadIdTable(db),
                                referencedColumn:
                                    $$ActividadesHasModulosTableReferences
                                        ._actividadIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (moduloId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.moduloId,
                                referencedTable:
                                    $$ActividadesHasModulosTableReferences
                                        ._moduloIdTable(db),
                                referencedColumn:
                                    $$ActividadesHasModulosTableReferences
                                        ._moduloIdTable(db)
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

typedef $$ActividadesHasModulosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActividadesHasModulosTable,
      ActividadesHasModulo,
      $$ActividadesHasModulosTableFilterComposer,
      $$ActividadesHasModulosTableOrderingComposer,
      $$ActividadesHasModulosTableAnnotationComposer,
      $$ActividadesHasModulosTableCreateCompanionBuilder,
      $$ActividadesHasModulosTableUpdateCompanionBuilder,
      (ActividadesHasModulo, $$ActividadesHasModulosTableReferences),
      ActividadesHasModulo,
      PrefetchHooks Function({bool actividadId, bool moduloId})
    >;
typedef $$UsuariosHasActividadesTableCreateCompanionBuilder =
    UsuariosHasActividadesCompanion Function({
      required String usuarioId,
      required int actividadId,
      required int aciertos,
      Value<int?> total,
      Value<int> rowid,
    });
typedef $$UsuariosHasActividadesTableUpdateCompanionBuilder =
    UsuariosHasActividadesCompanion Function({
      Value<String> usuarioId,
      Value<int> actividadId,
      Value<int> aciertos,
      Value<int?> total,
      Value<int> rowid,
    });

final class $$UsuariosHasActividadesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UsuariosHasActividadesTable,
          ProgresoActividad
        > {
  $$UsuariosHasActividadesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias(
        $_aliasNameGenerator(
          db.usuariosHasActividades.usuarioId,
          db.usuarios.id,
        ),
      );

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<String>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ActividadesTable _actividadIdTable(_$AppDatabase db) =>
      db.actividades.createAlias(
        $_aliasNameGenerator(
          db.usuariosHasActividades.actividadId,
          db.actividades.id,
        ),
      );

  $$ActividadesTableProcessedTableManager get actividadId {
    final $_column = $_itemColumn<int>('actividad_id')!;

    final manager = $$ActividadesTableTableManager(
      $_db,
      $_db.actividades,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_actividadIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UsuariosHasActividadesTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosHasActividadesTable> {
  $$UsuariosHasActividadesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get aciertos => $composableBuilder(
    column: $table.aciertos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ActividadesTableFilterComposer get actividadId {
    final $$ActividadesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.actividadId,
      referencedTable: $db.actividades,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActividadesTableFilterComposer(
            $db: $db,
            $table: $db.actividades,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasActividadesTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosHasActividadesTable> {
  $$UsuariosHasActividadesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get aciertos => $composableBuilder(
    column: $table.aciertos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ActividadesTableOrderingComposer get actividadId {
    final $$ActividadesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.actividadId,
      referencedTable: $db.actividades,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActividadesTableOrderingComposer(
            $db: $db,
            $table: $db.actividades,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasActividadesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosHasActividadesTable> {
  $$UsuariosHasActividadesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get aciertos =>
      $composableBuilder(column: $table.aciertos, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ActividadesTableAnnotationComposer get actividadId {
    final $$ActividadesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.actividadId,
      referencedTable: $db.actividades,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActividadesTableAnnotationComposer(
            $db: $db,
            $table: $db.actividades,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasActividadesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosHasActividadesTable,
          ProgresoActividad,
          $$UsuariosHasActividadesTableFilterComposer,
          $$UsuariosHasActividadesTableOrderingComposer,
          $$UsuariosHasActividadesTableAnnotationComposer,
          $$UsuariosHasActividadesTableCreateCompanionBuilder,
          $$UsuariosHasActividadesTableUpdateCompanionBuilder,
          (ProgresoActividad, $$UsuariosHasActividadesTableReferences),
          ProgresoActividad,
          PrefetchHooks Function({bool usuarioId, bool actividadId})
        > {
  $$UsuariosHasActividadesTableTableManager(
    _$AppDatabase db,
    $UsuariosHasActividadesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosHasActividadesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$UsuariosHasActividadesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UsuariosHasActividadesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> usuarioId = const Value.absent(),
                Value<int> actividadId = const Value.absent(),
                Value<int> aciertos = const Value.absent(),
                Value<int?> total = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosHasActividadesCompanion(
                usuarioId: usuarioId,
                actividadId: actividadId,
                aciertos: aciertos,
                total: total,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String usuarioId,
                required int actividadId,
                required int aciertos,
                Value<int?> total = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosHasActividadesCompanion.insert(
                usuarioId: usuarioId,
                actividadId: actividadId,
                aciertos: aciertos,
                total: total,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosHasActividadesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usuarioId = false, actividadId = false}) {
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
                    if (usuarioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.usuarioId,
                                referencedTable:
                                    $$UsuariosHasActividadesTableReferences
                                        ._usuarioIdTable(db),
                                referencedColumn:
                                    $$UsuariosHasActividadesTableReferences
                                        ._usuarioIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (actividadId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.actividadId,
                                referencedTable:
                                    $$UsuariosHasActividadesTableReferences
                                        ._actividadIdTable(db),
                                referencedColumn:
                                    $$UsuariosHasActividadesTableReferences
                                        ._actividadIdTable(db)
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

typedef $$UsuariosHasActividadesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosHasActividadesTable,
      ProgresoActividad,
      $$UsuariosHasActividadesTableFilterComposer,
      $$UsuariosHasActividadesTableOrderingComposer,
      $$UsuariosHasActividadesTableAnnotationComposer,
      $$UsuariosHasActividadesTableCreateCompanionBuilder,
      $$UsuariosHasActividadesTableUpdateCompanionBuilder,
      (ProgresoActividad, $$UsuariosHasActividadesTableReferences),
      ProgresoActividad,
      PrefetchHooks Function({bool usuarioId, bool actividadId})
    >;
typedef $$ModulosHasUsuariosTableCreateCompanionBuilder =
    ModulosHasUsuariosCompanion Function({
      required int moduloId,
      required String usuarioId,
      required double progreso,
      Value<int> rowid,
    });
typedef $$ModulosHasUsuariosTableUpdateCompanionBuilder =
    ModulosHasUsuariosCompanion Function({
      Value<int> moduloId,
      Value<String> usuarioId,
      Value<double> progreso,
      Value<int> rowid,
    });

final class $$ModulosHasUsuariosTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ModulosHasUsuariosTable,
          ModulosHasUsuario
        > {
  $$ModulosHasUsuariosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ModulosTable _moduloIdTable(_$AppDatabase db) =>
      db.modulos.createAlias(
        $_aliasNameGenerator(db.modulosHasUsuarios.moduloId, db.modulos.id),
      );

  $$ModulosTableProcessedTableManager get moduloId {
    final $_column = $_itemColumn<int>('modulo_id')!;

    final manager = $$ModulosTableTableManager(
      $_db,
      $_db.modulos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_moduloIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias(
        $_aliasNameGenerator(db.modulosHasUsuarios.usuarioId, db.usuarios.id),
      );

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<String>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ModulosHasUsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $ModulosHasUsuariosTable> {
  $$ModulosHasUsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get progreso => $composableBuilder(
    column: $table.progreso,
    builder: (column) => ColumnFilters(column),
  );

  $$ModulosTableFilterComposer get moduloId {
    final $$ModulosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moduloId,
      referencedTable: $db.modulos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ModulosTableFilterComposer(
            $db: $db,
            $table: $db.modulos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ModulosHasUsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $ModulosHasUsuariosTable> {
  $$ModulosHasUsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get progreso => $composableBuilder(
    column: $table.progreso,
    builder: (column) => ColumnOrderings(column),
  );

  $$ModulosTableOrderingComposer get moduloId {
    final $$ModulosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moduloId,
      referencedTable: $db.modulos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ModulosTableOrderingComposer(
            $db: $db,
            $table: $db.modulos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ModulosHasUsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ModulosHasUsuariosTable> {
  $$ModulosHasUsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get progreso =>
      $composableBuilder(column: $table.progreso, builder: (column) => column);

  $$ModulosTableAnnotationComposer get moduloId {
    final $$ModulosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moduloId,
      referencedTable: $db.modulos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ModulosTableAnnotationComposer(
            $db: $db,
            $table: $db.modulos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ModulosHasUsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ModulosHasUsuariosTable,
          ModulosHasUsuario,
          $$ModulosHasUsuariosTableFilterComposer,
          $$ModulosHasUsuariosTableOrderingComposer,
          $$ModulosHasUsuariosTableAnnotationComposer,
          $$ModulosHasUsuariosTableCreateCompanionBuilder,
          $$ModulosHasUsuariosTableUpdateCompanionBuilder,
          (ModulosHasUsuario, $$ModulosHasUsuariosTableReferences),
          ModulosHasUsuario,
          PrefetchHooks Function({bool moduloId, bool usuarioId})
        > {
  $$ModulosHasUsuariosTableTableManager(
    _$AppDatabase db,
    $ModulosHasUsuariosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ModulosHasUsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ModulosHasUsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ModulosHasUsuariosTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> moduloId = const Value.absent(),
                Value<String> usuarioId = const Value.absent(),
                Value<double> progreso = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ModulosHasUsuariosCompanion(
                moduloId: moduloId,
                usuarioId: usuarioId,
                progreso: progreso,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int moduloId,
                required String usuarioId,
                required double progreso,
                Value<int> rowid = const Value.absent(),
              }) => ModulosHasUsuariosCompanion.insert(
                moduloId: moduloId,
                usuarioId: usuarioId,
                progreso: progreso,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ModulosHasUsuariosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({moduloId = false, usuarioId = false}) {
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
                    if (moduloId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.moduloId,
                                referencedTable:
                                    $$ModulosHasUsuariosTableReferences
                                        ._moduloIdTable(db),
                                referencedColumn:
                                    $$ModulosHasUsuariosTableReferences
                                        ._moduloIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (usuarioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.usuarioId,
                                referencedTable:
                                    $$ModulosHasUsuariosTableReferences
                                        ._usuarioIdTable(db),
                                referencedColumn:
                                    $$ModulosHasUsuariosTableReferences
                                        ._usuarioIdTable(db)
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

typedef $$ModulosHasUsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ModulosHasUsuariosTable,
      ModulosHasUsuario,
      $$ModulosHasUsuariosTableFilterComposer,
      $$ModulosHasUsuariosTableOrderingComposer,
      $$ModulosHasUsuariosTableAnnotationComposer,
      $$ModulosHasUsuariosTableCreateCompanionBuilder,
      $$ModulosHasUsuariosTableUpdateCompanionBuilder,
      (ModulosHasUsuario, $$ModulosHasUsuariosTableReferences),
      ModulosHasUsuario,
      PrefetchHooks Function({bool moduloId, bool usuarioId})
    >;
typedef $$UsuariosHasMedallasTableCreateCompanionBuilder =
    UsuariosHasMedallasCompanion Function({
      required String usuarioId,
      required int medallaId,
      Value<int> rowid,
    });
typedef $$UsuariosHasMedallasTableUpdateCompanionBuilder =
    UsuariosHasMedallasCompanion Function({
      Value<String> usuarioId,
      Value<int> medallaId,
      Value<int> rowid,
    });

final class $$UsuariosHasMedallasTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UsuariosHasMedallasTable,
          UsuariosHasMedalla
        > {
  $$UsuariosHasMedallasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias(
        $_aliasNameGenerator(db.usuariosHasMedallas.usuarioId, db.usuarios.id),
      );

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<String>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MedallasTable _medallaIdTable(_$AppDatabase db) =>
      db.medallas.createAlias(
        $_aliasNameGenerator(db.usuariosHasMedallas.medallaId, db.medallas.id),
      );

  $$MedallasTableProcessedTableManager get medallaId {
    final $_column = $_itemColumn<int>('medalla_id')!;

    final manager = $$MedallasTableTableManager(
      $_db,
      $_db.medallas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_medallaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UsuariosHasMedallasTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosHasMedallasTable> {
  $$UsuariosHasMedallasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedallasTableFilterComposer get medallaId {
    final $$MedallasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medallaId,
      referencedTable: $db.medallas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedallasTableFilterComposer(
            $db: $db,
            $table: $db.medallas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasMedallasTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosHasMedallasTable> {
  $$UsuariosHasMedallasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedallasTableOrderingComposer get medallaId {
    final $$MedallasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medallaId,
      referencedTable: $db.medallas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedallasTableOrderingComposer(
            $db: $db,
            $table: $db.medallas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasMedallasTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosHasMedallasTable> {
  $$UsuariosHasMedallasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedallasTableAnnotationComposer get medallaId {
    final $$MedallasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medallaId,
      referencedTable: $db.medallas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedallasTableAnnotationComposer(
            $db: $db,
            $table: $db.medallas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosHasMedallasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosHasMedallasTable,
          UsuariosHasMedalla,
          $$UsuariosHasMedallasTableFilterComposer,
          $$UsuariosHasMedallasTableOrderingComposer,
          $$UsuariosHasMedallasTableAnnotationComposer,
          $$UsuariosHasMedallasTableCreateCompanionBuilder,
          $$UsuariosHasMedallasTableUpdateCompanionBuilder,
          (UsuariosHasMedalla, $$UsuariosHasMedallasTableReferences),
          UsuariosHasMedalla,
          PrefetchHooks Function({bool usuarioId, bool medallaId})
        > {
  $$UsuariosHasMedallasTableTableManager(
    _$AppDatabase db,
    $UsuariosHasMedallasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosHasMedallasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosHasMedallasTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UsuariosHasMedallasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> usuarioId = const Value.absent(),
                Value<int> medallaId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosHasMedallasCompanion(
                usuarioId: usuarioId,
                medallaId: medallaId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String usuarioId,
                required int medallaId,
                Value<int> rowid = const Value.absent(),
              }) => UsuariosHasMedallasCompanion.insert(
                usuarioId: usuarioId,
                medallaId: medallaId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosHasMedallasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usuarioId = false, medallaId = false}) {
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
                    if (usuarioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.usuarioId,
                                referencedTable:
                                    $$UsuariosHasMedallasTableReferences
                                        ._usuarioIdTable(db),
                                referencedColumn:
                                    $$UsuariosHasMedallasTableReferences
                                        ._usuarioIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (medallaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.medallaId,
                                referencedTable:
                                    $$UsuariosHasMedallasTableReferences
                                        ._medallaIdTable(db),
                                referencedColumn:
                                    $$UsuariosHasMedallasTableReferences
                                        ._medallaIdTable(db)
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

typedef $$UsuariosHasMedallasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosHasMedallasTable,
      UsuariosHasMedalla,
      $$UsuariosHasMedallasTableFilterComposer,
      $$UsuariosHasMedallasTableOrderingComposer,
      $$UsuariosHasMedallasTableAnnotationComposer,
      $$UsuariosHasMedallasTableCreateCompanionBuilder,
      $$UsuariosHasMedallasTableUpdateCompanionBuilder,
      (UsuariosHasMedalla, $$UsuariosHasMedallasTableReferences),
      UsuariosHasMedalla,
      PrefetchHooks Function({bool usuarioId, bool medallaId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TutorTableTableManager get tutor =>
      $$TutorTableTableManager(_db, _db.tutor);
  $$KvStoreTableTableManager get kvStore =>
      $$KvStoreTableTableManager(_db, _db.kvStore);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$ConfiguracionesTableTableManager get configuraciones =>
      $$ConfiguracionesTableTableManager(_db, _db.configuraciones);
  $$NumerosTableTableManager get numeros =>
      $$NumerosTableTableManager(_db, _db.numeros);
  $$FonemasTableTableManager get fonemas =>
      $$FonemasTableTableManager(_db, _db.fonemas);
  $$TipoDePalabraTableTableManager get tipoDePalabra =>
      $$TipoDePalabraTableTableManager(_db, _db.tipoDePalabra);
  $$PalabrasTableTableManager get palabras =>
      $$PalabrasTableTableManager(_db, _db.palabras);
  $$ModulosTableTableManager get modulos =>
      $$ModulosTableTableManager(_db, _db.modulos);
  $$ActividadesTableTableManager get actividades =>
      $$ActividadesTableTableManager(_db, _db.actividades);
  $$MedallasTableTableManager get medallas =>
      $$MedallasTableTableManager(_db, _db.medallas);
  $$UsuariosHasNumerosTableTableManager get usuariosHasNumeros =>
      $$UsuariosHasNumerosTableTableManager(_db, _db.usuariosHasNumeros);
  $$UsuariosHasFonemasTableTableManager get usuariosHasFonemas =>
      $$UsuariosHasFonemasTableTableManager(_db, _db.usuariosHasFonemas);
  $$UsuariosHasPalabrasTableTableManager get usuariosHasPalabras =>
      $$UsuariosHasPalabrasTableTableManager(_db, _db.usuariosHasPalabras);
  $$ActividadesHasModulosTableTableManager get actividadesHasModulos =>
      $$ActividadesHasModulosTableTableManager(_db, _db.actividadesHasModulos);
  $$UsuariosHasActividadesTableTableManager get usuariosHasActividades =>
      $$UsuariosHasActividadesTableTableManager(
        _db,
        _db.usuariosHasActividades,
      );
  $$ModulosHasUsuariosTableTableManager get modulosHasUsuarios =>
      $$ModulosHasUsuariosTableTableManager(_db, _db.modulosHasUsuarios);
  $$UsuariosHasMedallasTableTableManager get usuariosHasMedallas =>
      $$UsuariosHasMedallasTableTableManager(_db, _db.usuariosHasMedallas);
}
