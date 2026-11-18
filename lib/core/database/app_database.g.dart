// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SchoolSettingsTable extends SchoolSettings
    with TableInfo<$SchoolSettingsTable, SchoolSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchoolSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _schoolNameMeta = const VerificationMeta(
    'schoolName',
  );
  @override
  late final GeneratedColumn<String> schoolName = GeneratedColumn<String>(
    'school_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _logoPathMeta = const VerificationMeta(
    'logoPath',
  );
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
    'logo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, schoolName, address, logoPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'school_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SchoolSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('school_name')) {
      context.handle(
        _schoolNameMeta,
        schoolName.isAcceptableOrUnknown(data['school_name']!, _schoolNameMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('logo_path')) {
      context.handle(
        _logoPathMeta,
        logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SchoolSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SchoolSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      schoolName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      logoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_path'],
      ),
    );
  }

  @override
  $SchoolSettingsTable createAlias(String alias) {
    return $SchoolSettingsTable(attachedDatabase, alias);
  }
}

class SchoolSetting extends DataClass implements Insertable<SchoolSetting> {
  final int id;
  final String schoolName;
  final String address;
  final String? logoPath;
  const SchoolSetting({
    required this.id,
    required this.schoolName,
    required this.address,
    this.logoPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['school_name'] = Variable<String>(schoolName);
    map['address'] = Variable<String>(address);
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    return map;
  }

  SchoolSettingsCompanion toCompanion(bool nullToAbsent) {
    return SchoolSettingsCompanion(
      id: Value(id),
      schoolName: Value(schoolName),
      address: Value(address),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
    );
  }

  factory SchoolSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SchoolSetting(
      id: serializer.fromJson<int>(json['id']),
      schoolName: serializer.fromJson<String>(json['schoolName']),
      address: serializer.fromJson<String>(json['address']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'schoolName': serializer.toJson<String>(schoolName),
      'address': serializer.toJson<String>(address),
      'logoPath': serializer.toJson<String?>(logoPath),
    };
  }

  SchoolSetting copyWith({
    int? id,
    String? schoolName,
    String? address,
    Value<String?> logoPath = const Value.absent(),
  }) => SchoolSetting(
    id: id ?? this.id,
    schoolName: schoolName ?? this.schoolName,
    address: address ?? this.address,
    logoPath: logoPath.present ? logoPath.value : this.logoPath,
  );
  SchoolSetting copyWithCompanion(SchoolSettingsCompanion data) {
    return SchoolSetting(
      id: data.id.present ? data.id.value : this.id,
      schoolName: data.schoolName.present
          ? data.schoolName.value
          : this.schoolName,
      address: data.address.present ? data.address.value : this.address,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SchoolSetting(')
          ..write('id: $id, ')
          ..write('schoolName: $schoolName, ')
          ..write('address: $address, ')
          ..write('logoPath: $logoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, schoolName, address, logoPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SchoolSetting &&
          other.id == this.id &&
          other.schoolName == this.schoolName &&
          other.address == this.address &&
          other.logoPath == this.logoPath);
}

class SchoolSettingsCompanion extends UpdateCompanion<SchoolSetting> {
  final Value<int> id;
  final Value<String> schoolName;
  final Value<String> address;
  final Value<String?> logoPath;
  const SchoolSettingsCompanion({
    this.id = const Value.absent(),
    this.schoolName = const Value.absent(),
    this.address = const Value.absent(),
    this.logoPath = const Value.absent(),
  });
  SchoolSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.schoolName = const Value.absent(),
    this.address = const Value.absent(),
    this.logoPath = const Value.absent(),
  });
  static Insertable<SchoolSetting> custom({
    Expression<int>? id,
    Expression<String>? schoolName,
    Expression<String>? address,
    Expression<String>? logoPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (schoolName != null) 'school_name': schoolName,
      if (address != null) 'address': address,
      if (logoPath != null) 'logo_path': logoPath,
    });
  }

  SchoolSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? schoolName,
    Value<String>? address,
    Value<String?>? logoPath,
  }) {
    return SchoolSettingsCompanion(
      id: id ?? this.id,
      schoolName: schoolName ?? this.schoolName,
      address: address ?? this.address,
      logoPath: logoPath ?? this.logoPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (schoolName.present) {
      map['school_name'] = Variable<String>(schoolName.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchoolSettingsCompanion(')
          ..write('id: $id, ')
          ..write('schoolName: $schoolName, ')
          ..write('address: $address, ')
          ..write('logoPath: $logoPath')
          ..write(')'))
        .toString();
  }
}

class $AcademicYearsTable extends AcademicYears
    with TableInfo<$AcademicYearsTable, AcademicYear> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AcademicYearsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'academic_years';
  @override
  VerificationContext validateIntegrity(
    Insertable<AcademicYear> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AcademicYear map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AcademicYear(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AcademicYearsTable createAlias(String alias) {
    return $AcademicYearsTable(attachedDatabase, alias);
  }
}

class AcademicYear extends DataClass implements Insertable<AcademicYear> {
  final int id;
  final String name;
  final bool isActive;
  final String createdAt;
  const AcademicYear({
    required this.id,
    required this.name,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  AcademicYearsCompanion toCompanion(bool nullToAbsent) {
    return AcademicYearsCompanion(
      id: Value(id),
      name: Value(name),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory AcademicYear.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AcademicYear(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  AcademicYear copyWith({
    int? id,
    String? name,
    bool? isActive,
    String? createdAt,
  }) => AcademicYear(
    id: id ?? this.id,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  AcademicYear copyWithCompanion(AcademicYearsCompanion data) {
    return AcademicYear(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AcademicYear(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AcademicYear &&
          other.id == this.id &&
          other.name == this.name &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class AcademicYearsCompanion extends UpdateCompanion<AcademicYear> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<String> createdAt;
  const AcademicYearsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AcademicYearsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.isActive = const Value.absent(),
    required String createdAt,
  }) : name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<AcademicYear> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AcademicYearsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<bool>? isActive,
    Value<String>? createdAt,
  }) {
    return AcademicYearsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AcademicYearsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SemestersTable extends Semesters
    with TableInfo<$SemestersTable, Semester> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SemestersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _academicYearIdMeta = const VerificationMeta(
    'academicYearId',
  );
  @override
  late final GeneratedColumn<int> academicYearId = GeneratedColumn<int>(
    'academic_year_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES academic_years (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    academicYearId,
    name,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'semesters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Semester> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('academic_year_id')) {
      context.handle(
        _academicYearIdMeta,
        academicYearId.isAcceptableOrUnknown(
          data['academic_year_id']!,
          _academicYearIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_academicYearIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {academicYearId, name},
  ];
  @override
  Semester map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Semester(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      academicYearId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}academic_year_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SemestersTable createAlias(String alias) {
    return $SemestersTable(attachedDatabase, alias);
  }
}

class Semester extends DataClass implements Insertable<Semester> {
  final int id;
  final int academicYearId;
  final String name;
  final bool isActive;
  final String createdAt;
  const Semester({
    required this.id,
    required this.academicYearId,
    required this.name,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['academic_year_id'] = Variable<int>(academicYearId);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  SemestersCompanion toCompanion(bool nullToAbsent) {
    return SemestersCompanion(
      id: Value(id),
      academicYearId: Value(academicYearId),
      name: Value(name),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Semester.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Semester(
      id: serializer.fromJson<int>(json['id']),
      academicYearId: serializer.fromJson<int>(json['academicYearId']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'academicYearId': serializer.toJson<int>(academicYearId),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Semester copyWith({
    int? id,
    int? academicYearId,
    String? name,
    bool? isActive,
    String? createdAt,
  }) => Semester(
    id: id ?? this.id,
    academicYearId: academicYearId ?? this.academicYearId,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  Semester copyWithCompanion(SemestersCompanion data) {
    return Semester(
      id: data.id.present ? data.id.value : this.id,
      academicYearId: data.academicYearId.present
          ? data.academicYearId.value
          : this.academicYearId,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Semester(')
          ..write('id: $id, ')
          ..write('academicYearId: $academicYearId, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, academicYearId, name, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Semester &&
          other.id == this.id &&
          other.academicYearId == this.academicYearId &&
          other.name == this.name &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class SemestersCompanion extends UpdateCompanion<Semester> {
  final Value<int> id;
  final Value<int> academicYearId;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<String> createdAt;
  const SemestersCompanion({
    this.id = const Value.absent(),
    this.academicYearId = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SemestersCompanion.insert({
    this.id = const Value.absent(),
    required int academicYearId,
    required String name,
    this.isActive = const Value.absent(),
    required String createdAt,
  }) : academicYearId = Value(academicYearId),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Semester> custom({
    Expression<int>? id,
    Expression<int>? academicYearId,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (academicYearId != null) 'academic_year_id': academicYearId,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SemestersCompanion copyWith({
    Value<int>? id,
    Value<int>? academicYearId,
    Value<String>? name,
    Value<bool>? isActive,
    Value<String>? createdAt,
  }) {
    return SemestersCompanion(
      id: id ?? this.id,
      academicYearId: academicYearId ?? this.academicYearId,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (academicYearId.present) {
      map['academic_year_id'] = Variable<int>(academicYearId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SemestersCompanion(')
          ..write('id: $id, ')
          ..write('academicYearId: $academicYearId, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $GradingPeriodsTable extends GradingPeriods
    with TableInfo<$GradingPeriodsTable, GradingPeriod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GradingPeriodsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grading_periods';
  @override
  VerificationContext validateIntegrity(
    Insertable<GradingPeriod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GradingPeriod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GradingPeriod(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $GradingPeriodsTable createAlias(String alias) {
    return $GradingPeriodsTable(attachedDatabase, alias);
  }
}

class GradingPeriod extends DataClass implements Insertable<GradingPeriod> {
  final int id;
  final String name;
  final int sortOrder;
  const GradingPeriod({
    required this.id,
    required this.name,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  GradingPeriodsCompanion toCompanion(bool nullToAbsent) {
    return GradingPeriodsCompanion(
      id: Value(id),
      name: Value(name),
      sortOrder: Value(sortOrder),
    );
  }

  factory GradingPeriod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GradingPeriod(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  GradingPeriod copyWith({int? id, String? name, int? sortOrder}) =>
      GradingPeriod(
        id: id ?? this.id,
        name: name ?? this.name,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  GradingPeriod copyWithCompanion(GradingPeriodsCompanion data) {
    return GradingPeriod(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GradingPeriod(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GradingPeriod &&
          other.id == this.id &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder);
}

class GradingPeriodsCompanion extends UpdateCompanion<GradingPeriod> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> sortOrder;
  const GradingPeriodsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  GradingPeriodsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int sortOrder,
  }) : name = Value(name),
       sortOrder = Value(sortOrder);
  static Insertable<GradingPeriod> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  GradingPeriodsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? sortOrder,
  }) {
    return GradingPeriodsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GradingPeriodsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $InstructorsTable extends Instructors
    with TableInfo<$InstructorsTable, Instructor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstructorsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _employeeNumberMeta = const VerificationMeta(
    'employeeNumber',
  );
  @override
  late final GeneratedColumn<String> employeeNumber = GeneratedColumn<String>(
    'employee_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _middleNameMeta = const VerificationMeta(
    'middleName',
  );
  @override
  late final GeneratedColumn<String> middleName = GeneratedColumn<String>(
    'middle_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _suffixMeta = const VerificationMeta('suffix');
  @override
  late final GeneratedColumn<String> suffix = GeneratedColumn<String>(
    'suffix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactNumberMeta = const VerificationMeta(
    'contactNumber',
  );
  @override
  late final GeneratedColumn<String> contactNumber = GeneratedColumn<String>(
    'contact_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    employeeNumber,
    firstName,
    middleName,
    lastName,
    suffix,
    email,
    contactNumber,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'instructors';
  @override
  VerificationContext validateIntegrity(
    Insertable<Instructor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('employee_number')) {
      context.handle(
        _employeeNumberMeta,
        employeeNumber.isAcceptableOrUnknown(
          data['employee_number']!,
          _employeeNumberMeta,
        ),
      );
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('middle_name')) {
      context.handle(
        _middleNameMeta,
        middleName.isAcceptableOrUnknown(data['middle_name']!, _middleNameMeta),
      );
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('suffix')) {
      context.handle(
        _suffixMeta,
        suffix.isAcceptableOrUnknown(data['suffix']!, _suffixMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('contact_number')) {
      context.handle(
        _contactNumberMeta,
        contactNumber.isAcceptableOrUnknown(
          data['contact_number']!,
          _contactNumberMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Instructor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Instructor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      employeeNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}employee_number'],
      ),
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      middleName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}middle_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      suffix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}suffix'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      contactNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_number'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $InstructorsTable createAlias(String alias) {
    return $InstructorsTable(attachedDatabase, alias);
  }
}

class Instructor extends DataClass implements Insertable<Instructor> {
  final int id;
  final String? employeeNumber;
  final String firstName;
  final String middleName;
  final String lastName;
  final String suffix;
  final String? email;
  final String? contactNumber;
  final bool isActive;
  const Instructor({
    required this.id,
    this.employeeNumber,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.suffix,
    this.email,
    this.contactNumber,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || employeeNumber != null) {
      map['employee_number'] = Variable<String>(employeeNumber);
    }
    map['first_name'] = Variable<String>(firstName);
    map['middle_name'] = Variable<String>(middleName);
    map['last_name'] = Variable<String>(lastName);
    map['suffix'] = Variable<String>(suffix);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || contactNumber != null) {
      map['contact_number'] = Variable<String>(contactNumber);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  InstructorsCompanion toCompanion(bool nullToAbsent) {
    return InstructorsCompanion(
      id: Value(id),
      employeeNumber: employeeNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeNumber),
      firstName: Value(firstName),
      middleName: Value(middleName),
      lastName: Value(lastName),
      suffix: Value(suffix),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      contactNumber: contactNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(contactNumber),
      isActive: Value(isActive),
    );
  }

  factory Instructor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Instructor(
      id: serializer.fromJson<int>(json['id']),
      employeeNumber: serializer.fromJson<String?>(json['employeeNumber']),
      firstName: serializer.fromJson<String>(json['firstName']),
      middleName: serializer.fromJson<String>(json['middleName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      suffix: serializer.fromJson<String>(json['suffix']),
      email: serializer.fromJson<String?>(json['email']),
      contactNumber: serializer.fromJson<String?>(json['contactNumber']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employeeNumber': serializer.toJson<String?>(employeeNumber),
      'firstName': serializer.toJson<String>(firstName),
      'middleName': serializer.toJson<String>(middleName),
      'lastName': serializer.toJson<String>(lastName),
      'suffix': serializer.toJson<String>(suffix),
      'email': serializer.toJson<String?>(email),
      'contactNumber': serializer.toJson<String?>(contactNumber),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Instructor copyWith({
    int? id,
    Value<String?> employeeNumber = const Value.absent(),
    String? firstName,
    String? middleName,
    String? lastName,
    String? suffix,
    Value<String?> email = const Value.absent(),
    Value<String?> contactNumber = const Value.absent(),
    bool? isActive,
  }) => Instructor(
    id: id ?? this.id,
    employeeNumber: employeeNumber.present
        ? employeeNumber.value
        : this.employeeNumber,
    firstName: firstName ?? this.firstName,
    middleName: middleName ?? this.middleName,
    lastName: lastName ?? this.lastName,
    suffix: suffix ?? this.suffix,
    email: email.present ? email.value : this.email,
    contactNumber: contactNumber.present
        ? contactNumber.value
        : this.contactNumber,
    isActive: isActive ?? this.isActive,
  );
  Instructor copyWithCompanion(InstructorsCompanion data) {
    return Instructor(
      id: data.id.present ? data.id.value : this.id,
      employeeNumber: data.employeeNumber.present
          ? data.employeeNumber.value
          : this.employeeNumber,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      middleName: data.middleName.present
          ? data.middleName.value
          : this.middleName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      suffix: data.suffix.present ? data.suffix.value : this.suffix,
      email: data.email.present ? data.email.value : this.email,
      contactNumber: data.contactNumber.present
          ? data.contactNumber.value
          : this.contactNumber,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Instructor(')
          ..write('id: $id, ')
          ..write('employeeNumber: $employeeNumber, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('suffix: $suffix, ')
          ..write('email: $email, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    employeeNumber,
    firstName,
    middleName,
    lastName,
    suffix,
    email,
    contactNumber,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Instructor &&
          other.id == this.id &&
          other.employeeNumber == this.employeeNumber &&
          other.firstName == this.firstName &&
          other.middleName == this.middleName &&
          other.lastName == this.lastName &&
          other.suffix == this.suffix &&
          other.email == this.email &&
          other.contactNumber == this.contactNumber &&
          other.isActive == this.isActive);
}

class InstructorsCompanion extends UpdateCompanion<Instructor> {
  final Value<int> id;
  final Value<String?> employeeNumber;
  final Value<String> firstName;
  final Value<String> middleName;
  final Value<String> lastName;
  final Value<String> suffix;
  final Value<String?> email;
  final Value<String?> contactNumber;
  final Value<bool> isActive;
  const InstructorsCompanion({
    this.id = const Value.absent(),
    this.employeeNumber = const Value.absent(),
    this.firstName = const Value.absent(),
    this.middleName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.suffix = const Value.absent(),
    this.email = const Value.absent(),
    this.contactNumber = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  InstructorsCompanion.insert({
    this.id = const Value.absent(),
    this.employeeNumber = const Value.absent(),
    required String firstName,
    this.middleName = const Value.absent(),
    required String lastName,
    this.suffix = const Value.absent(),
    this.email = const Value.absent(),
    this.contactNumber = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : firstName = Value(firstName),
       lastName = Value(lastName);
  static Insertable<Instructor> custom({
    Expression<int>? id,
    Expression<String>? employeeNumber,
    Expression<String>? firstName,
    Expression<String>? middleName,
    Expression<String>? lastName,
    Expression<String>? suffix,
    Expression<String>? email,
    Expression<String>? contactNumber,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employeeNumber != null) 'employee_number': employeeNumber,
      if (firstName != null) 'first_name': firstName,
      if (middleName != null) 'middle_name': middleName,
      if (lastName != null) 'last_name': lastName,
      if (suffix != null) 'suffix': suffix,
      if (email != null) 'email': email,
      if (contactNumber != null) 'contact_number': contactNumber,
      if (isActive != null) 'is_active': isActive,
    });
  }

  InstructorsCompanion copyWith({
    Value<int>? id,
    Value<String?>? employeeNumber,
    Value<String>? firstName,
    Value<String>? middleName,
    Value<String>? lastName,
    Value<String>? suffix,
    Value<String?>? email,
    Value<String?>? contactNumber,
    Value<bool>? isActive,
  }) {
    return InstructorsCompanion(
      id: id ?? this.id,
      employeeNumber: employeeNumber ?? this.employeeNumber,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      suffix: suffix ?? this.suffix,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (employeeNumber.present) {
      map['employee_number'] = Variable<String>(employeeNumber.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (middleName.present) {
      map['middle_name'] = Variable<String>(middleName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (suffix.present) {
      map['suffix'] = Variable<String>(suffix.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (contactNumber.present) {
      map['contact_number'] = Variable<String>(contactNumber.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstructorsCompanion(')
          ..write('id: $id, ')
          ..write('employeeNumber: $employeeNumber, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('suffix: $suffix, ')
          ..write('email: $email, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $SectionsTable extends Sections with TableInfo<$SectionsTable, Section> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SectionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _courseMeta = const VerificationMeta('course');
  @override
  late final GeneratedColumn<String> course = GeneratedColumn<String>(
    'course',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _yearLevelMeta = const VerificationMeta(
    'yearLevel',
  );
  @override
  late final GeneratedColumn<int> yearLevel = GeneratedColumn<int>(
    'year_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, course, yearLevel];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sections';
  @override
  VerificationContext validateIntegrity(
    Insertable<Section> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('course')) {
      context.handle(
        _courseMeta,
        course.isAcceptableOrUnknown(data['course']!, _courseMeta),
      );
    }
    if (data.containsKey('year_level')) {
      context.handle(
        _yearLevelMeta,
        yearLevel.isAcceptableOrUnknown(data['year_level']!, _yearLevelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Section map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Section(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      course: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course'],
      )!,
      yearLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year_level'],
      ),
    );
  }

  @override
  $SectionsTable createAlias(String alias) {
    return $SectionsTable(attachedDatabase, alias);
  }
}

class Section extends DataClass implements Insertable<Section> {
  final int id;
  final String name;
  final String course;
  final int? yearLevel;
  const Section({
    required this.id,
    required this.name,
    required this.course,
    this.yearLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['course'] = Variable<String>(course);
    if (!nullToAbsent || yearLevel != null) {
      map['year_level'] = Variable<int>(yearLevel);
    }
    return map;
  }

  SectionsCompanion toCompanion(bool nullToAbsent) {
    return SectionsCompanion(
      id: Value(id),
      name: Value(name),
      course: Value(course),
      yearLevel: yearLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(yearLevel),
    );
  }

  factory Section.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Section(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      course: serializer.fromJson<String>(json['course']),
      yearLevel: serializer.fromJson<int?>(json['yearLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'course': serializer.toJson<String>(course),
      'yearLevel': serializer.toJson<int?>(yearLevel),
    };
  }

  Section copyWith({
    int? id,
    String? name,
    String? course,
    Value<int?> yearLevel = const Value.absent(),
  }) => Section(
    id: id ?? this.id,
    name: name ?? this.name,
    course: course ?? this.course,
    yearLevel: yearLevel.present ? yearLevel.value : this.yearLevel,
  );
  Section copyWithCompanion(SectionsCompanion data) {
    return Section(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      course: data.course.present ? data.course.value : this.course,
      yearLevel: data.yearLevel.present ? data.yearLevel.value : this.yearLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Section(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('course: $course, ')
          ..write('yearLevel: $yearLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, course, yearLevel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Section &&
          other.id == this.id &&
          other.name == this.name &&
          other.course == this.course &&
          other.yearLevel == this.yearLevel);
}

class SectionsCompanion extends UpdateCompanion<Section> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> course;
  final Value<int?> yearLevel;
  const SectionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.course = const Value.absent(),
    this.yearLevel = const Value.absent(),
  });
  SectionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.course = const Value.absent(),
    this.yearLevel = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Section> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? course,
    Expression<int>? yearLevel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (course != null) 'course': course,
      if (yearLevel != null) 'year_level': yearLevel,
    });
  }

  SectionsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? course,
    Value<int?>? yearLevel,
  }) {
    return SectionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      course: course ?? this.course,
      yearLevel: yearLevel ?? this.yearLevel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (course.present) {
      map['course'] = Variable<String>(course.value);
    }
    if (yearLevel.present) {
      map['year_level'] = Variable<int>(yearLevel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('course: $course, ')
          ..write('yearLevel: $yearLevel')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _academicYearIdMeta = const VerificationMeta(
    'academicYearId',
  );
  @override
  late final GeneratedColumn<int> academicYearId = GeneratedColumn<int>(
    'academic_year_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES academic_years (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _semesterIdMeta = const VerificationMeta(
    'semesterId',
  );
  @override
  late final GeneratedColumn<int> semesterId = GeneratedColumn<int>(
    'semester_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES semesters (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sectionIdMeta = const VerificationMeta(
    'sectionId',
  );
  @override
  late final GeneratedColumn<int> sectionId = GeneratedColumn<int>(
    'section_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sections (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _instructorIdMeta = const VerificationMeta(
    'instructorId',
  );
  @override
  late final GeneratedColumn<int> instructorId = GeneratedColumn<int>(
    'instructor_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES instructors (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _unitsMeta = const VerificationMeta('units');
  @override
  late final GeneratedColumn<double> units = GeneratedColumn<double>(
    'units',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(3.0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Active'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    description,
    academicYearId,
    semesterId,
    sectionId,
    instructorId,
    units,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subject> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('academic_year_id')) {
      context.handle(
        _academicYearIdMeta,
        academicYearId.isAcceptableOrUnknown(
          data['academic_year_id']!,
          _academicYearIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_academicYearIdMeta);
    }
    if (data.containsKey('semester_id')) {
      context.handle(
        _semesterIdMeta,
        semesterId.isAcceptableOrUnknown(data['semester_id']!, _semesterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_semesterIdMeta);
    }
    if (data.containsKey('section_id')) {
      context.handle(
        _sectionIdMeta,
        sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta),
      );
    }
    if (data.containsKey('instructor_id')) {
      context.handle(
        _instructorIdMeta,
        instructorId.isAcceptableOrUnknown(
          data['instructor_id']!,
          _instructorIdMeta,
        ),
      );
    }
    if (data.containsKey('units')) {
      context.handle(
        _unitsMeta,
        units.isAcceptableOrUnknown(data['units']!, _unitsMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {code, academicYearId, semesterId, sectionId},
  ];
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      academicYearId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}academic_year_id'],
      )!,
      semesterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}semester_id'],
      )!,
      sectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}section_id'],
      ),
      instructorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}instructor_id'],
      ),
      units: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}units'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  final int id;
  final String code;
  final String name;
  final String description;
  final int academicYearId;
  final int semesterId;
  final int? sectionId;
  final int? instructorId;
  final double units;
  final String status;
  final String createdAt;
  final String updatedAt;
  const Subject({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.academicYearId,
    required this.semesterId,
    this.sectionId,
    this.instructorId,
    required this.units,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['academic_year_id'] = Variable<int>(academicYearId);
    map['semester_id'] = Variable<int>(semesterId);
    if (!nullToAbsent || sectionId != null) {
      map['section_id'] = Variable<int>(sectionId);
    }
    if (!nullToAbsent || instructorId != null) {
      map['instructor_id'] = Variable<int>(instructorId);
    }
    map['units'] = Variable<double>(units);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      description: Value(description),
      academicYearId: Value(academicYearId),
      semesterId: Value(semesterId),
      sectionId: sectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sectionId),
      instructorId: instructorId == null && nullToAbsent
          ? const Value.absent()
          : Value(instructorId),
      units: Value(units),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Subject.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      academicYearId: serializer.fromJson<int>(json['academicYearId']),
      semesterId: serializer.fromJson<int>(json['semesterId']),
      sectionId: serializer.fromJson<int?>(json['sectionId']),
      instructorId: serializer.fromJson<int?>(json['instructorId']),
      units: serializer.fromJson<double>(json['units']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'academicYearId': serializer.toJson<int>(academicYearId),
      'semesterId': serializer.toJson<int>(semesterId),
      'sectionId': serializer.toJson<int?>(sectionId),
      'instructorId': serializer.toJson<int?>(instructorId),
      'units': serializer.toJson<double>(units),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  Subject copyWith({
    int? id,
    String? code,
    String? name,
    String? description,
    int? academicYearId,
    int? semesterId,
    Value<int?> sectionId = const Value.absent(),
    Value<int?> instructorId = const Value.absent(),
    double? units,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) => Subject(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    description: description ?? this.description,
    academicYearId: academicYearId ?? this.academicYearId,
    semesterId: semesterId ?? this.semesterId,
    sectionId: sectionId.present ? sectionId.value : this.sectionId,
    instructorId: instructorId.present ? instructorId.value : this.instructorId,
    units: units ?? this.units,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Subject copyWithCompanion(SubjectsCompanion data) {
    return Subject(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      academicYearId: data.academicYearId.present
          ? data.academicYearId.value
          : this.academicYearId,
      semesterId: data.semesterId.present
          ? data.semesterId.value
          : this.semesterId,
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      instructorId: data.instructorId.present
          ? data.instructorId.value
          : this.instructorId,
      units: data.units.present ? data.units.value : this.units,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('academicYearId: $academicYearId, ')
          ..write('semesterId: $semesterId, ')
          ..write('sectionId: $sectionId, ')
          ..write('instructorId: $instructorId, ')
          ..write('units: $units, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    description,
    academicYearId,
    semesterId,
    sectionId,
    instructorId,
    units,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.description == this.description &&
          other.academicYearId == this.academicYearId &&
          other.semesterId == this.semesterId &&
          other.sectionId == this.sectionId &&
          other.instructorId == this.instructorId &&
          other.units == this.units &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<String> description;
  final Value<int> academicYearId;
  final Value<int> semesterId;
  final Value<int?> sectionId;
  final Value<int?> instructorId;
  final Value<double> units;
  final Value<String> status;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.academicYearId = const Value.absent(),
    this.semesterId = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.instructorId = const Value.absent(),
    this.units = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SubjectsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.description = const Value.absent(),
    required int academicYearId,
    required int semesterId,
    this.sectionId = const Value.absent(),
    this.instructorId = const Value.absent(),
    this.units = const Value.absent(),
    this.status = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  }) : code = Value(code),
       name = Value(name),
       academicYearId = Value(academicYearId),
       semesterId = Value(semesterId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Subject> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? academicYearId,
    Expression<int>? semesterId,
    Expression<int>? sectionId,
    Expression<int>? instructorId,
    Expression<double>? units,
    Expression<String>? status,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (academicYearId != null) 'academic_year_id': academicYearId,
      if (semesterId != null) 'semester_id': semesterId,
      if (sectionId != null) 'section_id': sectionId,
      if (instructorId != null) 'instructor_id': instructorId,
      if (units != null) 'units': units,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SubjectsCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
    Value<String>? description,
    Value<int>? academicYearId,
    Value<int>? semesterId,
    Value<int?>? sectionId,
    Value<int?>? instructorId,
    Value<double>? units,
    Value<String>? status,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return SubjectsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      academicYearId: academicYearId ?? this.academicYearId,
      semesterId: semesterId ?? this.semesterId,
      sectionId: sectionId ?? this.sectionId,
      instructorId: instructorId ?? this.instructorId,
      units: units ?? this.units,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (academicYearId.present) {
      map['academic_year_id'] = Variable<int>(academicYearId.value);
    }
    if (semesterId.present) {
      map['semester_id'] = Variable<int>(semesterId.value);
    }
    if (sectionId.present) {
      map['section_id'] = Variable<int>(sectionId.value);
    }
    if (instructorId.present) {
      map['instructor_id'] = Variable<int>(instructorId.value);
    }
    if (units.present) {
      map['units'] = Variable<double>(units.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('academicYearId: $academicYearId, ')
          ..write('semesterId: $semesterId, ')
          ..write('sectionId: $sectionId, ')
          ..write('instructorId: $instructorId, ')
          ..write('units: $units, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _studentNumberMeta = const VerificationMeta(
    'studentNumber',
  );
  @override
  late final GeneratedColumn<String> studentNumber = GeneratedColumn<String>(
    'student_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _middleNameMeta = const VerificationMeta(
    'middleName',
  );
  @override
  late final GeneratedColumn<String> middleName = GeneratedColumn<String>(
    'middle_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _suffixMeta = const VerificationMeta('suffix');
  @override
  late final GeneratedColumn<String> suffix = GeneratedColumn<String>(
    'suffix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactNumberMeta = const VerificationMeta(
    'contactNumber',
  );
  @override
  late final GeneratedColumn<String> contactNumber = GeneratedColumn<String>(
    'contact_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _courseMeta = const VerificationMeta('course');
  @override
  late final GeneratedColumn<String> course = GeneratedColumn<String>(
    'course',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _yearLevelMeta = const VerificationMeta(
    'yearLevel',
  );
  @override
  late final GeneratedColumn<int> yearLevel = GeneratedColumn<int>(
    'year_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sectionIdMeta = const VerificationMeta(
    'sectionId',
  );
  @override
  late final GeneratedColumn<int> sectionId = GeneratedColumn<int>(
    'section_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sections (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Active'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentNumber,
    firstName,
    middleName,
    lastName,
    suffix,
    gender,
    email,
    contactNumber,
    course,
    yearLevel,
    sectionId,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(
    Insertable<Student> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_number')) {
      context.handle(
        _studentNumberMeta,
        studentNumber.isAcceptableOrUnknown(
          data['student_number']!,
          _studentNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studentNumberMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('middle_name')) {
      context.handle(
        _middleNameMeta,
        middleName.isAcceptableOrUnknown(data['middle_name']!, _middleNameMeta),
      );
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('suffix')) {
      context.handle(
        _suffixMeta,
        suffix.isAcceptableOrUnknown(data['suffix']!, _suffixMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('contact_number')) {
      context.handle(
        _contactNumberMeta,
        contactNumber.isAcceptableOrUnknown(
          data['contact_number']!,
          _contactNumberMeta,
        ),
      );
    }
    if (data.containsKey('course')) {
      context.handle(
        _courseMeta,
        course.isAcceptableOrUnknown(data['course']!, _courseMeta),
      );
    }
    if (data.containsKey('year_level')) {
      context.handle(
        _yearLevelMeta,
        yearLevel.isAcceptableOrUnknown(data['year_level']!, _yearLevelMeta),
      );
    }
    if (data.containsKey('section_id')) {
      context.handle(
        _sectionIdMeta,
        sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_number'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      middleName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}middle_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      suffix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}suffix'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      contactNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_number'],
      ),
      course: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course'],
      )!,
      yearLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year_level'],
      ),
      sectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}section_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  final int id;
  final String studentNumber;
  final String firstName;
  final String middleName;
  final String lastName;
  final String suffix;
  final String? gender;
  final String? email;
  final String? contactNumber;
  final String course;
  final int? yearLevel;
  final int? sectionId;
  final String status;
  final String createdAt;
  final String updatedAt;
  const Student({
    required this.id,
    required this.studentNumber,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.suffix,
    this.gender,
    this.email,
    this.contactNumber,
    required this.course,
    this.yearLevel,
    this.sectionId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_number'] = Variable<String>(studentNumber);
    map['first_name'] = Variable<String>(firstName);
    map['middle_name'] = Variable<String>(middleName);
    map['last_name'] = Variable<String>(lastName);
    map['suffix'] = Variable<String>(suffix);
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || contactNumber != null) {
      map['contact_number'] = Variable<String>(contactNumber);
    }
    map['course'] = Variable<String>(course);
    if (!nullToAbsent || yearLevel != null) {
      map['year_level'] = Variable<int>(yearLevel);
    }
    if (!nullToAbsent || sectionId != null) {
      map['section_id'] = Variable<int>(sectionId);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      studentNumber: Value(studentNumber),
      firstName: Value(firstName),
      middleName: Value(middleName),
      lastName: Value(lastName),
      suffix: Value(suffix),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      contactNumber: contactNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(contactNumber),
      course: Value(course),
      yearLevel: yearLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(yearLevel),
      sectionId: sectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sectionId),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Student.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<int>(json['id']),
      studentNumber: serializer.fromJson<String>(json['studentNumber']),
      firstName: serializer.fromJson<String>(json['firstName']),
      middleName: serializer.fromJson<String>(json['middleName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      suffix: serializer.fromJson<String>(json['suffix']),
      gender: serializer.fromJson<String?>(json['gender']),
      email: serializer.fromJson<String?>(json['email']),
      contactNumber: serializer.fromJson<String?>(json['contactNumber']),
      course: serializer.fromJson<String>(json['course']),
      yearLevel: serializer.fromJson<int?>(json['yearLevel']),
      sectionId: serializer.fromJson<int?>(json['sectionId']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentNumber': serializer.toJson<String>(studentNumber),
      'firstName': serializer.toJson<String>(firstName),
      'middleName': serializer.toJson<String>(middleName),
      'lastName': serializer.toJson<String>(lastName),
      'suffix': serializer.toJson<String>(suffix),
      'gender': serializer.toJson<String?>(gender),
      'email': serializer.toJson<String?>(email),
      'contactNumber': serializer.toJson<String?>(contactNumber),
      'course': serializer.toJson<String>(course),
      'yearLevel': serializer.toJson<int?>(yearLevel),
      'sectionId': serializer.toJson<int?>(sectionId),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  Student copyWith({
    int? id,
    String? studentNumber,
    String? firstName,
    String? middleName,
    String? lastName,
    String? suffix,
    Value<String?> gender = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> contactNumber = const Value.absent(),
    String? course,
    Value<int?> yearLevel = const Value.absent(),
    Value<int?> sectionId = const Value.absent(),
    String? status,
    String? createdAt,
    String? updatedAt,
  }) => Student(
    id: id ?? this.id,
    studentNumber: studentNumber ?? this.studentNumber,
    firstName: firstName ?? this.firstName,
    middleName: middleName ?? this.middleName,
    lastName: lastName ?? this.lastName,
    suffix: suffix ?? this.suffix,
    gender: gender.present ? gender.value : this.gender,
    email: email.present ? email.value : this.email,
    contactNumber: contactNumber.present
        ? contactNumber.value
        : this.contactNumber,
    course: course ?? this.course,
    yearLevel: yearLevel.present ? yearLevel.value : this.yearLevel,
    sectionId: sectionId.present ? sectionId.value : this.sectionId,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Student copyWithCompanion(StudentsCompanion data) {
    return Student(
      id: data.id.present ? data.id.value : this.id,
      studentNumber: data.studentNumber.present
          ? data.studentNumber.value
          : this.studentNumber,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      middleName: data.middleName.present
          ? data.middleName.value
          : this.middleName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      suffix: data.suffix.present ? data.suffix.value : this.suffix,
      gender: data.gender.present ? data.gender.value : this.gender,
      email: data.email.present ? data.email.value : this.email,
      contactNumber: data.contactNumber.present
          ? data.contactNumber.value
          : this.contactNumber,
      course: data.course.present ? data.course.value : this.course,
      yearLevel: data.yearLevel.present ? data.yearLevel.value : this.yearLevel,
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('studentNumber: $studentNumber, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('suffix: $suffix, ')
          ..write('gender: $gender, ')
          ..write('email: $email, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('course: $course, ')
          ..write('yearLevel: $yearLevel, ')
          ..write('sectionId: $sectionId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentNumber,
    firstName,
    middleName,
    lastName,
    suffix,
    gender,
    email,
    contactNumber,
    course,
    yearLevel,
    sectionId,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == this.id &&
          other.studentNumber == this.studentNumber &&
          other.firstName == this.firstName &&
          other.middleName == this.middleName &&
          other.lastName == this.lastName &&
          other.suffix == this.suffix &&
          other.gender == this.gender &&
          other.email == this.email &&
          other.contactNumber == this.contactNumber &&
          other.course == this.course &&
          other.yearLevel == this.yearLevel &&
          other.sectionId == this.sectionId &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> studentNumber;
  final Value<String> firstName;
  final Value<String> middleName;
  final Value<String> lastName;
  final Value<String> suffix;
  final Value<String?> gender;
  final Value<String?> email;
  final Value<String?> contactNumber;
  final Value<String> course;
  final Value<int?> yearLevel;
  final Value<int?> sectionId;
  final Value<String> status;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.studentNumber = const Value.absent(),
    this.firstName = const Value.absent(),
    this.middleName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.suffix = const Value.absent(),
    this.gender = const Value.absent(),
    this.email = const Value.absent(),
    this.contactNumber = const Value.absent(),
    this.course = const Value.absent(),
    this.yearLevel = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String studentNumber,
    required String firstName,
    this.middleName = const Value.absent(),
    required String lastName,
    this.suffix = const Value.absent(),
    this.gender = const Value.absent(),
    this.email = const Value.absent(),
    this.contactNumber = const Value.absent(),
    this.course = const Value.absent(),
    this.yearLevel = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.status = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  }) : studentNumber = Value(studentNumber),
       firstName = Value(firstName),
       lastName = Value(lastName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? studentNumber,
    Expression<String>? firstName,
    Expression<String>? middleName,
    Expression<String>? lastName,
    Expression<String>? suffix,
    Expression<String>? gender,
    Expression<String>? email,
    Expression<String>? contactNumber,
    Expression<String>? course,
    Expression<int>? yearLevel,
    Expression<int>? sectionId,
    Expression<String>? status,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentNumber != null) 'student_number': studentNumber,
      if (firstName != null) 'first_name': firstName,
      if (middleName != null) 'middle_name': middleName,
      if (lastName != null) 'last_name': lastName,
      if (suffix != null) 'suffix': suffix,
      if (gender != null) 'gender': gender,
      if (email != null) 'email': email,
      if (contactNumber != null) 'contact_number': contactNumber,
      if (course != null) 'course': course,
      if (yearLevel != null) 'year_level': yearLevel,
      if (sectionId != null) 'section_id': sectionId,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudentsCompanion copyWith({
    Value<int>? id,
    Value<String>? studentNumber,
    Value<String>? firstName,
    Value<String>? middleName,
    Value<String>? lastName,
    Value<String>? suffix,
    Value<String?>? gender,
    Value<String?>? email,
    Value<String?>? contactNumber,
    Value<String>? course,
    Value<int?>? yearLevel,
    Value<int?>? sectionId,
    Value<String>? status,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return StudentsCompanion(
      id: id ?? this.id,
      studentNumber: studentNumber ?? this.studentNumber,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      suffix: suffix ?? this.suffix,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      course: course ?? this.course,
      yearLevel: yearLevel ?? this.yearLevel,
      sectionId: sectionId ?? this.sectionId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentNumber.present) {
      map['student_number'] = Variable<String>(studentNumber.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (middleName.present) {
      map['middle_name'] = Variable<String>(middleName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (suffix.present) {
      map['suffix'] = Variable<String>(suffix.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (contactNumber.present) {
      map['contact_number'] = Variable<String>(contactNumber.value);
    }
    if (course.present) {
      map['course'] = Variable<String>(course.value);
    }
    if (yearLevel.present) {
      map['year_level'] = Variable<int>(yearLevel.value);
    }
    if (sectionId.present) {
      map['section_id'] = Variable<int>(sectionId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('studentNumber: $studentNumber, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('suffix: $suffix, ')
          ..write('gender: $gender, ')
          ..write('email: $email, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('course: $course, ')
          ..write('yearLevel: $yearLevel, ')
          ..write('sectionId: $sectionId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SubjectEnrollmentsTable extends SubjectEnrollments
    with TableInfo<$SubjectEnrollmentsTable, SubjectEnrollment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectEnrollmentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _enrolledAtMeta = const VerificationMeta(
    'enrolledAt',
  );
  @override
  late final GeneratedColumn<String> enrolledAt = GeneratedColumn<String>(
    'enrolled_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Enrolled'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    studentId,
    enrolledAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subject_enrollments';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubjectEnrollment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('enrolled_at')) {
      context.handle(
        _enrolledAtMeta,
        enrolledAt.isAcceptableOrUnknown(data['enrolled_at']!, _enrolledAtMeta),
      );
    } else if (isInserting) {
      context.missing(_enrolledAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {subjectId, studentId},
  ];
  @override
  SubjectEnrollment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubjectEnrollment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      enrolledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}enrolled_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $SubjectEnrollmentsTable createAlias(String alias) {
    return $SubjectEnrollmentsTable(attachedDatabase, alias);
  }
}

class SubjectEnrollment extends DataClass
    implements Insertable<SubjectEnrollment> {
  final int id;
  final int subjectId;
  final int studentId;
  final String enrolledAt;
  final String status;
  const SubjectEnrollment({
    required this.id,
    required this.subjectId,
    required this.studentId,
    required this.enrolledAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject_id'] = Variable<int>(subjectId);
    map['student_id'] = Variable<int>(studentId);
    map['enrolled_at'] = Variable<String>(enrolledAt);
    map['status'] = Variable<String>(status);
    return map;
  }

  SubjectEnrollmentsCompanion toCompanion(bool nullToAbsent) {
    return SubjectEnrollmentsCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      studentId: Value(studentId),
      enrolledAt: Value(enrolledAt),
      status: Value(status),
    );
  }

  factory SubjectEnrollment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubjectEnrollment(
      id: serializer.fromJson<int>(json['id']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      enrolledAt: serializer.fromJson<String>(json['enrolledAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectId': serializer.toJson<int>(subjectId),
      'studentId': serializer.toJson<int>(studentId),
      'enrolledAt': serializer.toJson<String>(enrolledAt),
      'status': serializer.toJson<String>(status),
    };
  }

  SubjectEnrollment copyWith({
    int? id,
    int? subjectId,
    int? studentId,
    String? enrolledAt,
    String? status,
  }) => SubjectEnrollment(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    studentId: studentId ?? this.studentId,
    enrolledAt: enrolledAt ?? this.enrolledAt,
    status: status ?? this.status,
  );
  SubjectEnrollment copyWithCompanion(SubjectEnrollmentsCompanion data) {
    return SubjectEnrollment(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      enrolledAt: data.enrolledAt.present
          ? data.enrolledAt.value
          : this.enrolledAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubjectEnrollment(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('studentId: $studentId, ')
          ..write('enrolledAt: $enrolledAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, subjectId, studentId, enrolledAt, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubjectEnrollment &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.studentId == this.studentId &&
          other.enrolledAt == this.enrolledAt &&
          other.status == this.status);
}

class SubjectEnrollmentsCompanion extends UpdateCompanion<SubjectEnrollment> {
  final Value<int> id;
  final Value<int> subjectId;
  final Value<int> studentId;
  final Value<String> enrolledAt;
  final Value<String> status;
  const SubjectEnrollmentsCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.enrolledAt = const Value.absent(),
    this.status = const Value.absent(),
  });
  SubjectEnrollmentsCompanion.insert({
    this.id = const Value.absent(),
    required int subjectId,
    required int studentId,
    required String enrolledAt,
    this.status = const Value.absent(),
  }) : subjectId = Value(subjectId),
       studentId = Value(studentId),
       enrolledAt = Value(enrolledAt);
  static Insertable<SubjectEnrollment> custom({
    Expression<int>? id,
    Expression<int>? subjectId,
    Expression<int>? studentId,
    Expression<String>? enrolledAt,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (studentId != null) 'student_id': studentId,
      if (enrolledAt != null) 'enrolled_at': enrolledAt,
      if (status != null) 'status': status,
    });
  }

  SubjectEnrollmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? subjectId,
    Value<int>? studentId,
    Value<String>? enrolledAt,
    Value<String>? status,
  }) {
    return SubjectEnrollmentsCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      studentId: studentId ?? this.studentId,
      enrolledAt: enrolledAt ?? this.enrolledAt,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (enrolledAt.present) {
      map['enrolled_at'] = Variable<String>(enrolledAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectEnrollmentsCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('studentId: $studentId, ')
          ..write('enrolledAt: $enrolledAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $AssessmentsTable extends Assessments
    with TableInfo<$AssessmentsTable, Assessment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssessmentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gradingPeriodIdMeta = const VerificationMeta(
    'gradingPeriodId',
  );
  @override
  late final GeneratedColumn<int> gradingPeriodId = GeneratedColumn<int>(
    'grading_period_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES grading_periods (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalPossibleScoreMeta =
      const VerificationMeta('totalPossibleScore');
  @override
  late final GeneratedColumn<double> totalPossibleScore =
      GeneratedColumn<double>(
        'total_possible_score',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    gradingPeriodId,
    name,
    type,
    date,
    totalPossibleScore,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assessments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Assessment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('grading_period_id')) {
      context.handle(
        _gradingPeriodIdMeta,
        gradingPeriodId.isAcceptableOrUnknown(
          data['grading_period_id']!,
          _gradingPeriodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gradingPeriodIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('total_possible_score')) {
      context.handle(
        _totalPossibleScoreMeta,
        totalPossibleScore.isAcceptableOrUnknown(
          data['total_possible_score']!,
          _totalPossibleScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalPossibleScoreMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Assessment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Assessment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      gradingPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grading_period_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      ),
      totalPossibleScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_possible_score'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AssessmentsTable createAlias(String alias) {
    return $AssessmentsTable(attachedDatabase, alias);
  }
}

class Assessment extends DataClass implements Insertable<Assessment> {
  final int id;
  final int subjectId;
  final int gradingPeriodId;
  final String name;
  final String type;
  final String? date;
  final double totalPossibleScore;
  final int sortOrder;
  final String createdAt;
  const Assessment({
    required this.id,
    required this.subjectId,
    required this.gradingPeriodId,
    required this.name,
    required this.type,
    this.date,
    required this.totalPossibleScore,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject_id'] = Variable<int>(subjectId);
    map['grading_period_id'] = Variable<int>(gradingPeriodId);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    map['total_possible_score'] = Variable<double>(totalPossibleScore);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  AssessmentsCompanion toCompanion(bool nullToAbsent) {
    return AssessmentsCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      gradingPeriodId: Value(gradingPeriodId),
      name: Value(name),
      type: Value(type),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      totalPossibleScore: Value(totalPossibleScore),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory Assessment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Assessment(
      id: serializer.fromJson<int>(json['id']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      gradingPeriodId: serializer.fromJson<int>(json['gradingPeriodId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<String?>(json['date']),
      totalPossibleScore: serializer.fromJson<double>(
        json['totalPossibleScore'],
      ),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectId': serializer.toJson<int>(subjectId),
      'gradingPeriodId': serializer.toJson<int>(gradingPeriodId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<String?>(date),
      'totalPossibleScore': serializer.toJson<double>(totalPossibleScore),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Assessment copyWith({
    int? id,
    int? subjectId,
    int? gradingPeriodId,
    String? name,
    String? type,
    Value<String?> date = const Value.absent(),
    double? totalPossibleScore,
    int? sortOrder,
    String? createdAt,
  }) => Assessment(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    gradingPeriodId: gradingPeriodId ?? this.gradingPeriodId,
    name: name ?? this.name,
    type: type ?? this.type,
    date: date.present ? date.value : this.date,
    totalPossibleScore: totalPossibleScore ?? this.totalPossibleScore,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  Assessment copyWithCompanion(AssessmentsCompanion data) {
    return Assessment(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      gradingPeriodId: data.gradingPeriodId.present
          ? data.gradingPeriodId.value
          : this.gradingPeriodId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      totalPossibleScore: data.totalPossibleScore.present
          ? data.totalPossibleScore.value
          : this.totalPossibleScore,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Assessment(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('gradingPeriodId: $gradingPeriodId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('totalPossibleScore: $totalPossibleScore, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subjectId,
    gradingPeriodId,
    name,
    type,
    date,
    totalPossibleScore,
    sortOrder,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Assessment &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.gradingPeriodId == this.gradingPeriodId &&
          other.name == this.name &&
          other.type == this.type &&
          other.date == this.date &&
          other.totalPossibleScore == this.totalPossibleScore &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class AssessmentsCompanion extends UpdateCompanion<Assessment> {
  final Value<int> id;
  final Value<int> subjectId;
  final Value<int> gradingPeriodId;
  final Value<String> name;
  final Value<String> type;
  final Value<String?> date;
  final Value<double> totalPossibleScore;
  final Value<int> sortOrder;
  final Value<String> createdAt;
  const AssessmentsCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.gradingPeriodId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.totalPossibleScore = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AssessmentsCompanion.insert({
    this.id = const Value.absent(),
    required int subjectId,
    required int gradingPeriodId,
    required String name,
    required String type,
    this.date = const Value.absent(),
    required double totalPossibleScore,
    this.sortOrder = const Value.absent(),
    required String createdAt,
  }) : subjectId = Value(subjectId),
       gradingPeriodId = Value(gradingPeriodId),
       name = Value(name),
       type = Value(type),
       totalPossibleScore = Value(totalPossibleScore),
       createdAt = Value(createdAt);
  static Insertable<Assessment> custom({
    Expression<int>? id,
    Expression<int>? subjectId,
    Expression<int>? gradingPeriodId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? date,
    Expression<double>? totalPossibleScore,
    Expression<int>? sortOrder,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (gradingPeriodId != null) 'grading_period_id': gradingPeriodId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (totalPossibleScore != null)
        'total_possible_score': totalPossibleScore,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AssessmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? subjectId,
    Value<int>? gradingPeriodId,
    Value<String>? name,
    Value<String>? type,
    Value<String?>? date,
    Value<double>? totalPossibleScore,
    Value<int>? sortOrder,
    Value<String>? createdAt,
  }) {
    return AssessmentsCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      gradingPeriodId: gradingPeriodId ?? this.gradingPeriodId,
      name: name ?? this.name,
      type: type ?? this.type,
      date: date ?? this.date,
      totalPossibleScore: totalPossibleScore ?? this.totalPossibleScore,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (gradingPeriodId.present) {
      map['grading_period_id'] = Variable<int>(gradingPeriodId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (totalPossibleScore.present) {
      map['total_possible_score'] = Variable<double>(totalPossibleScore.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssessmentsCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('gradingPeriodId: $gradingPeriodId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('totalPossibleScore: $totalPossibleScore, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StudentAssessmentScoresTable extends StudentAssessmentScores
    with TableInfo<$StudentAssessmentScoresTable, StudentAssessmentScore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentAssessmentScoresTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _assessmentIdMeta = const VerificationMeta(
    'assessmentId',
  );
  @override
  late final GeneratedColumn<int> assessmentId = GeneratedColumn<int>(
    'assessment_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES assessments (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    assessmentId,
    studentId,
    score,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_assessment_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentAssessmentScore> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('assessment_id')) {
      context.handle(
        _assessmentIdMeta,
        assessmentId.isAcceptableOrUnknown(
          data['assessment_id']!,
          _assessmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_assessmentIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {assessmentId, studentId},
  ];
  @override
  StudentAssessmentScore map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentAssessmentScore(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      assessmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}assessment_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $StudentAssessmentScoresTable createAlias(String alias) {
    return $StudentAssessmentScoresTable(attachedDatabase, alias);
  }
}

class StudentAssessmentScore extends DataClass
    implements Insertable<StudentAssessmentScore> {
  final int id;
  final int assessmentId;
  final int studentId;
  final double? score;
  final String? updatedAt;
  const StudentAssessmentScore({
    required this.id,
    required this.assessmentId,
    required this.studentId,
    this.score,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['assessment_id'] = Variable<int>(assessmentId);
    map['student_id'] = Variable<int>(studentId);
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<double>(score);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  StudentAssessmentScoresCompanion toCompanion(bool nullToAbsent) {
    return StudentAssessmentScoresCompanion(
      id: Value(id),
      assessmentId: Value(assessmentId),
      studentId: Value(studentId),
      score: score == null && nullToAbsent
          ? const Value.absent()
          : Value(score),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory StudentAssessmentScore.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentAssessmentScore(
      id: serializer.fromJson<int>(json['id']),
      assessmentId: serializer.fromJson<int>(json['assessmentId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      score: serializer.fromJson<double?>(json['score']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'assessmentId': serializer.toJson<int>(assessmentId),
      'studentId': serializer.toJson<int>(studentId),
      'score': serializer.toJson<double?>(score),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  StudentAssessmentScore copyWith({
    int? id,
    int? assessmentId,
    int? studentId,
    Value<double?> score = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
  }) => StudentAssessmentScore(
    id: id ?? this.id,
    assessmentId: assessmentId ?? this.assessmentId,
    studentId: studentId ?? this.studentId,
    score: score.present ? score.value : this.score,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  StudentAssessmentScore copyWithCompanion(
    StudentAssessmentScoresCompanion data,
  ) {
    return StudentAssessmentScore(
      id: data.id.present ? data.id.value : this.id,
      assessmentId: data.assessmentId.present
          ? data.assessmentId.value
          : this.assessmentId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      score: data.score.present ? data.score.value : this.score,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentAssessmentScore(')
          ..write('id: $id, ')
          ..write('assessmentId: $assessmentId, ')
          ..write('studentId: $studentId, ')
          ..write('score: $score, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, assessmentId, studentId, score, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentAssessmentScore &&
          other.id == this.id &&
          other.assessmentId == this.assessmentId &&
          other.studentId == this.studentId &&
          other.score == this.score &&
          other.updatedAt == this.updatedAt);
}

class StudentAssessmentScoresCompanion
    extends UpdateCompanion<StudentAssessmentScore> {
  final Value<int> id;
  final Value<int> assessmentId;
  final Value<int> studentId;
  final Value<double?> score;
  final Value<String?> updatedAt;
  const StudentAssessmentScoresCompanion({
    this.id = const Value.absent(),
    this.assessmentId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.score = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudentAssessmentScoresCompanion.insert({
    this.id = const Value.absent(),
    required int assessmentId,
    required int studentId,
    this.score = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : assessmentId = Value(assessmentId),
       studentId = Value(studentId);
  static Insertable<StudentAssessmentScore> custom({
    Expression<int>? id,
    Expression<int>? assessmentId,
    Expression<int>? studentId,
    Expression<double>? score,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assessmentId != null) 'assessment_id': assessmentId,
      if (studentId != null) 'student_id': studentId,
      if (score != null) 'score': score,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudentAssessmentScoresCompanion copyWith({
    Value<int>? id,
    Value<int>? assessmentId,
    Value<int>? studentId,
    Value<double?>? score,
    Value<String?>? updatedAt,
  }) {
    return StudentAssessmentScoresCompanion(
      id: id ?? this.id,
      assessmentId: assessmentId ?? this.assessmentId,
      studentId: studentId ?? this.studentId,
      score: score ?? this.score,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (assessmentId.present) {
      map['assessment_id'] = Variable<int>(assessmentId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentAssessmentScoresCompanion(')
          ..write('id: $id, ')
          ..write('assessmentId: $assessmentId, ')
          ..write('studentId: $studentId, ')
          ..write('score: $score, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AttendanceSessionsTable extends AttendanceSessions
    with TableInfo<$AttendanceSessionsTable, AttendanceSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceSessionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gradingPeriodIdMeta = const VerificationMeta(
    'gradingPeriodId',
  );
  @override
  late final GeneratedColumn<int> gradingPeriodId = GeneratedColumn<int>(
    'grading_period_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES grading_periods (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sessionDateMeta = const VerificationMeta(
    'sessionDate',
  );
  @override
  late final GeneratedColumn<String> sessionDate = GeneratedColumn<String>(
    'session_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Attendance'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    gradingPeriodId,
    sessionDate,
    name,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('grading_period_id')) {
      context.handle(
        _gradingPeriodIdMeta,
        gradingPeriodId.isAcceptableOrUnknown(
          data['grading_period_id']!,
          _gradingPeriodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gradingPeriodIdMeta);
    }
    if (data.containsKey('session_date')) {
      context.handle(
        _sessionDateMeta,
        sessionDate.isAcceptableOrUnknown(
          data['session_date']!,
          _sessionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionDateMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendanceSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      gradingPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grading_period_id'],
      )!,
      sessionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_date'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $AttendanceSessionsTable createAlias(String alias) {
    return $AttendanceSessionsTable(attachedDatabase, alias);
  }
}

class AttendanceSession extends DataClass
    implements Insertable<AttendanceSession> {
  final int id;
  final int subjectId;
  final int gradingPeriodId;
  final String sessionDate;
  final String name;
  final int sortOrder;
  const AttendanceSession({
    required this.id,
    required this.subjectId,
    required this.gradingPeriodId,
    required this.sessionDate,
    required this.name,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject_id'] = Variable<int>(subjectId);
    map['grading_period_id'] = Variable<int>(gradingPeriodId);
    map['session_date'] = Variable<String>(sessionDate);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  AttendanceSessionsCompanion toCompanion(bool nullToAbsent) {
    return AttendanceSessionsCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      gradingPeriodId: Value(gradingPeriodId),
      sessionDate: Value(sessionDate),
      name: Value(name),
      sortOrder: Value(sortOrder),
    );
  }

  factory AttendanceSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceSession(
      id: serializer.fromJson<int>(json['id']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      gradingPeriodId: serializer.fromJson<int>(json['gradingPeriodId']),
      sessionDate: serializer.fromJson<String>(json['sessionDate']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectId': serializer.toJson<int>(subjectId),
      'gradingPeriodId': serializer.toJson<int>(gradingPeriodId),
      'sessionDate': serializer.toJson<String>(sessionDate),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  AttendanceSession copyWith({
    int? id,
    int? subjectId,
    int? gradingPeriodId,
    String? sessionDate,
    String? name,
    int? sortOrder,
  }) => AttendanceSession(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    gradingPeriodId: gradingPeriodId ?? this.gradingPeriodId,
    sessionDate: sessionDate ?? this.sessionDate,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  AttendanceSession copyWithCompanion(AttendanceSessionsCompanion data) {
    return AttendanceSession(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      gradingPeriodId: data.gradingPeriodId.present
          ? data.gradingPeriodId.value
          : this.gradingPeriodId,
      sessionDate: data.sessionDate.present
          ? data.sessionDate.value
          : this.sessionDate,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceSession(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('gradingPeriodId: $gradingPeriodId, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, subjectId, gradingPeriodId, sessionDate, name, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceSession &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.gradingPeriodId == this.gradingPeriodId &&
          other.sessionDate == this.sessionDate &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder);
}

class AttendanceSessionsCompanion extends UpdateCompanion<AttendanceSession> {
  final Value<int> id;
  final Value<int> subjectId;
  final Value<int> gradingPeriodId;
  final Value<String> sessionDate;
  final Value<String> name;
  final Value<int> sortOrder;
  const AttendanceSessionsCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.gradingPeriodId = const Value.absent(),
    this.sessionDate = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  AttendanceSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int subjectId,
    required int gradingPeriodId,
    required String sessionDate,
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : subjectId = Value(subjectId),
       gradingPeriodId = Value(gradingPeriodId),
       sessionDate = Value(sessionDate);
  static Insertable<AttendanceSession> custom({
    Expression<int>? id,
    Expression<int>? subjectId,
    Expression<int>? gradingPeriodId,
    Expression<String>? sessionDate,
    Expression<String>? name,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (gradingPeriodId != null) 'grading_period_id': gradingPeriodId,
      if (sessionDate != null) 'session_date': sessionDate,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  AttendanceSessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? subjectId,
    Value<int>? gradingPeriodId,
    Value<String>? sessionDate,
    Value<String>? name,
    Value<int>? sortOrder,
  }) {
    return AttendanceSessionsCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      gradingPeriodId: gradingPeriodId ?? this.gradingPeriodId,
      sessionDate: sessionDate ?? this.sessionDate,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (gradingPeriodId.present) {
      map['grading_period_id'] = Variable<int>(gradingPeriodId.value);
    }
    if (sessionDate.present) {
      map['session_date'] = Variable<String>(sessionDate.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceSessionsCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('gradingPeriodId: $gradingPeriodId, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $StudentAttendanceTable extends StudentAttendance
    with TableInfo<$StudentAttendanceTable, StudentAttendanceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentAttendanceTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _attendanceSessionIdMeta =
      const VerificationMeta('attendanceSessionId');
  @override
  late final GeneratedColumn<int> attendanceSessionId = GeneratedColumn<int>(
    'attendance_session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES attendance_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    attendanceSessionId,
    studentId,
    code,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_attendance';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentAttendanceData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('attendance_session_id')) {
      context.handle(
        _attendanceSessionIdMeta,
        attendanceSessionId.isAcceptableOrUnknown(
          data['attendance_session_id']!,
          _attendanceSessionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attendanceSessionIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {attendanceSessionId, studentId},
  ];
  @override
  StudentAttendanceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentAttendanceData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      attendanceSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attendance_session_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $StudentAttendanceTable createAlias(String alias) {
    return $StudentAttendanceTable(attachedDatabase, alias);
  }
}

class StudentAttendanceData extends DataClass
    implements Insertable<StudentAttendanceData> {
  final int id;
  final int attendanceSessionId;
  final int studentId;
  final String code;
  final String? updatedAt;
  const StudentAttendanceData({
    required this.id,
    required this.attendanceSessionId,
    required this.studentId,
    required this.code,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['attendance_session_id'] = Variable<int>(attendanceSessionId);
    map['student_id'] = Variable<int>(studentId);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  StudentAttendanceCompanion toCompanion(bool nullToAbsent) {
    return StudentAttendanceCompanion(
      id: Value(id),
      attendanceSessionId: Value(attendanceSessionId),
      studentId: Value(studentId),
      code: Value(code),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory StudentAttendanceData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentAttendanceData(
      id: serializer.fromJson<int>(json['id']),
      attendanceSessionId: serializer.fromJson<int>(
        json['attendanceSessionId'],
      ),
      studentId: serializer.fromJson<int>(json['studentId']),
      code: serializer.fromJson<String>(json['code']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'attendanceSessionId': serializer.toJson<int>(attendanceSessionId),
      'studentId': serializer.toJson<int>(studentId),
      'code': serializer.toJson<String>(code),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  StudentAttendanceData copyWith({
    int? id,
    int? attendanceSessionId,
    int? studentId,
    String? code,
    Value<String?> updatedAt = const Value.absent(),
  }) => StudentAttendanceData(
    id: id ?? this.id,
    attendanceSessionId: attendanceSessionId ?? this.attendanceSessionId,
    studentId: studentId ?? this.studentId,
    code: code ?? this.code,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  StudentAttendanceData copyWithCompanion(StudentAttendanceCompanion data) {
    return StudentAttendanceData(
      id: data.id.present ? data.id.value : this.id,
      attendanceSessionId: data.attendanceSessionId.present
          ? data.attendanceSessionId.value
          : this.attendanceSessionId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      code: data.code.present ? data.code.value : this.code,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentAttendanceData(')
          ..write('id: $id, ')
          ..write('attendanceSessionId: $attendanceSessionId, ')
          ..write('studentId: $studentId, ')
          ..write('code: $code, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, attendanceSessionId, studentId, code, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentAttendanceData &&
          other.id == this.id &&
          other.attendanceSessionId == this.attendanceSessionId &&
          other.studentId == this.studentId &&
          other.code == this.code &&
          other.updatedAt == this.updatedAt);
}

class StudentAttendanceCompanion
    extends UpdateCompanion<StudentAttendanceData> {
  final Value<int> id;
  final Value<int> attendanceSessionId;
  final Value<int> studentId;
  final Value<String> code;
  final Value<String?> updatedAt;
  const StudentAttendanceCompanion({
    this.id = const Value.absent(),
    this.attendanceSessionId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.code = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudentAttendanceCompanion.insert({
    this.id = const Value.absent(),
    required int attendanceSessionId,
    required int studentId,
    required String code,
    this.updatedAt = const Value.absent(),
  }) : attendanceSessionId = Value(attendanceSessionId),
       studentId = Value(studentId),
       code = Value(code);
  static Insertable<StudentAttendanceData> custom({
    Expression<int>? id,
    Expression<int>? attendanceSessionId,
    Expression<int>? studentId,
    Expression<String>? code,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (attendanceSessionId != null)
        'attendance_session_id': attendanceSessionId,
      if (studentId != null) 'student_id': studentId,
      if (code != null) 'code': code,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudentAttendanceCompanion copyWith({
    Value<int>? id,
    Value<int>? attendanceSessionId,
    Value<int>? studentId,
    Value<String>? code,
    Value<String?>? updatedAt,
  }) {
    return StudentAttendanceCompanion(
      id: id ?? this.id,
      attendanceSessionId: attendanceSessionId ?? this.attendanceSessionId,
      studentId: studentId ?? this.studentId,
      code: code ?? this.code,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (attendanceSessionId.present) {
      map['attendance_session_id'] = Variable<int>(attendanceSessionId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentAttendanceCompanion(')
          ..write('id: $id, ')
          ..write('attendanceSessionId: $attendanceSessionId, ')
          ..write('studentId: $studentId, ')
          ..write('code: $code, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $IndependentLearningRecordsTable extends IndependentLearningRecords
    with
        TableInfo<$IndependentLearningRecordsTable, IndependentLearningRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IndependentLearningRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gradingPeriodIdMeta = const VerificationMeta(
    'gradingPeriodId',
  );
  @override
  late final GeneratedColumn<int> gradingPeriodId = GeneratedColumn<int>(
    'grading_period_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES grading_periods (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _activityNameMeta = const VerificationMeta(
    'activityName',
  );
  @override
  late final GeneratedColumn<String> activityName = GeneratedColumn<String>(
    'activity_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _activityDateMeta = const VerificationMeta(
    'activityDate',
  );
  @override
  late final GeneratedColumn<String> activityDate = GeneratedColumn<String>(
    'activity_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalPossibleScoreMeta =
      const VerificationMeta('totalPossibleScore');
  @override
  late final GeneratedColumn<double> totalPossibleScore =
      GeneratedColumn<double>(
        'total_possible_score',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    gradingPeriodId,
    activityName,
    description,
    activityDate,
    totalPossibleScore,
    remarks,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'independent_learning_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<IndependentLearningRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('grading_period_id')) {
      context.handle(
        _gradingPeriodIdMeta,
        gradingPeriodId.isAcceptableOrUnknown(
          data['grading_period_id']!,
          _gradingPeriodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gradingPeriodIdMeta);
    }
    if (data.containsKey('activity_name')) {
      context.handle(
        _activityNameMeta,
        activityName.isAcceptableOrUnknown(
          data['activity_name']!,
          _activityNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('activity_date')) {
      context.handle(
        _activityDateMeta,
        activityDate.isAcceptableOrUnknown(
          data['activity_date']!,
          _activityDateMeta,
        ),
      );
    }
    if (data.containsKey('total_possible_score')) {
      context.handle(
        _totalPossibleScoreMeta,
        totalPossibleScore.isAcceptableOrUnknown(
          data['total_possible_score']!,
          _totalPossibleScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalPossibleScoreMeta);
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IndependentLearningRecord map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IndependentLearningRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      gradingPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grading_period_id'],
      )!,
      activityName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      activityDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_date'],
      ),
      totalPossibleScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_possible_score'],
      )!,
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $IndependentLearningRecordsTable createAlias(String alias) {
    return $IndependentLearningRecordsTable(attachedDatabase, alias);
  }
}

class IndependentLearningRecord extends DataClass
    implements Insertable<IndependentLearningRecord> {
  final int id;
  final int subjectId;
  final int gradingPeriodId;
  final String activityName;
  final String description;
  final String? activityDate;
  final double totalPossibleScore;
  final String remarks;
  final String createdAt;
  const IndependentLearningRecord({
    required this.id,
    required this.subjectId,
    required this.gradingPeriodId,
    required this.activityName,
    required this.description,
    this.activityDate,
    required this.totalPossibleScore,
    required this.remarks,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject_id'] = Variable<int>(subjectId);
    map['grading_period_id'] = Variable<int>(gradingPeriodId);
    map['activity_name'] = Variable<String>(activityName);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || activityDate != null) {
      map['activity_date'] = Variable<String>(activityDate);
    }
    map['total_possible_score'] = Variable<double>(totalPossibleScore);
    map['remarks'] = Variable<String>(remarks);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  IndependentLearningRecordsCompanion toCompanion(bool nullToAbsent) {
    return IndependentLearningRecordsCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      gradingPeriodId: Value(gradingPeriodId),
      activityName: Value(activityName),
      description: Value(description),
      activityDate: activityDate == null && nullToAbsent
          ? const Value.absent()
          : Value(activityDate),
      totalPossibleScore: Value(totalPossibleScore),
      remarks: Value(remarks),
      createdAt: Value(createdAt),
    );
  }

  factory IndependentLearningRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IndependentLearningRecord(
      id: serializer.fromJson<int>(json['id']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      gradingPeriodId: serializer.fromJson<int>(json['gradingPeriodId']),
      activityName: serializer.fromJson<String>(json['activityName']),
      description: serializer.fromJson<String>(json['description']),
      activityDate: serializer.fromJson<String?>(json['activityDate']),
      totalPossibleScore: serializer.fromJson<double>(
        json['totalPossibleScore'],
      ),
      remarks: serializer.fromJson<String>(json['remarks']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectId': serializer.toJson<int>(subjectId),
      'gradingPeriodId': serializer.toJson<int>(gradingPeriodId),
      'activityName': serializer.toJson<String>(activityName),
      'description': serializer.toJson<String>(description),
      'activityDate': serializer.toJson<String?>(activityDate),
      'totalPossibleScore': serializer.toJson<double>(totalPossibleScore),
      'remarks': serializer.toJson<String>(remarks),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  IndependentLearningRecord copyWith({
    int? id,
    int? subjectId,
    int? gradingPeriodId,
    String? activityName,
    String? description,
    Value<String?> activityDate = const Value.absent(),
    double? totalPossibleScore,
    String? remarks,
    String? createdAt,
  }) => IndependentLearningRecord(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    gradingPeriodId: gradingPeriodId ?? this.gradingPeriodId,
    activityName: activityName ?? this.activityName,
    description: description ?? this.description,
    activityDate: activityDate.present ? activityDate.value : this.activityDate,
    totalPossibleScore: totalPossibleScore ?? this.totalPossibleScore,
    remarks: remarks ?? this.remarks,
    createdAt: createdAt ?? this.createdAt,
  );
  IndependentLearningRecord copyWithCompanion(
    IndependentLearningRecordsCompanion data,
  ) {
    return IndependentLearningRecord(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      gradingPeriodId: data.gradingPeriodId.present
          ? data.gradingPeriodId.value
          : this.gradingPeriodId,
      activityName: data.activityName.present
          ? data.activityName.value
          : this.activityName,
      description: data.description.present
          ? data.description.value
          : this.description,
      activityDate: data.activityDate.present
          ? data.activityDate.value
          : this.activityDate,
      totalPossibleScore: data.totalPossibleScore.present
          ? data.totalPossibleScore.value
          : this.totalPossibleScore,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IndependentLearningRecord(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('gradingPeriodId: $gradingPeriodId, ')
          ..write('activityName: $activityName, ')
          ..write('description: $description, ')
          ..write('activityDate: $activityDate, ')
          ..write('totalPossibleScore: $totalPossibleScore, ')
          ..write('remarks: $remarks, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subjectId,
    gradingPeriodId,
    activityName,
    description,
    activityDate,
    totalPossibleScore,
    remarks,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IndependentLearningRecord &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.gradingPeriodId == this.gradingPeriodId &&
          other.activityName == this.activityName &&
          other.description == this.description &&
          other.activityDate == this.activityDate &&
          other.totalPossibleScore == this.totalPossibleScore &&
          other.remarks == this.remarks &&
          other.createdAt == this.createdAt);
}

class IndependentLearningRecordsCompanion
    extends UpdateCompanion<IndependentLearningRecord> {
  final Value<int> id;
  final Value<int> subjectId;
  final Value<int> gradingPeriodId;
  final Value<String> activityName;
  final Value<String> description;
  final Value<String?> activityDate;
  final Value<double> totalPossibleScore;
  final Value<String> remarks;
  final Value<String> createdAt;
  const IndependentLearningRecordsCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.gradingPeriodId = const Value.absent(),
    this.activityName = const Value.absent(),
    this.description = const Value.absent(),
    this.activityDate = const Value.absent(),
    this.totalPossibleScore = const Value.absent(),
    this.remarks = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  IndependentLearningRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int subjectId,
    required int gradingPeriodId,
    required String activityName,
    this.description = const Value.absent(),
    this.activityDate = const Value.absent(),
    required double totalPossibleScore,
    this.remarks = const Value.absent(),
    required String createdAt,
  }) : subjectId = Value(subjectId),
       gradingPeriodId = Value(gradingPeriodId),
       activityName = Value(activityName),
       totalPossibleScore = Value(totalPossibleScore),
       createdAt = Value(createdAt);
  static Insertable<IndependentLearningRecord> custom({
    Expression<int>? id,
    Expression<int>? subjectId,
    Expression<int>? gradingPeriodId,
    Expression<String>? activityName,
    Expression<String>? description,
    Expression<String>? activityDate,
    Expression<double>? totalPossibleScore,
    Expression<String>? remarks,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (gradingPeriodId != null) 'grading_period_id': gradingPeriodId,
      if (activityName != null) 'activity_name': activityName,
      if (description != null) 'description': description,
      if (activityDate != null) 'activity_date': activityDate,
      if (totalPossibleScore != null)
        'total_possible_score': totalPossibleScore,
      if (remarks != null) 'remarks': remarks,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  IndependentLearningRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? subjectId,
    Value<int>? gradingPeriodId,
    Value<String>? activityName,
    Value<String>? description,
    Value<String?>? activityDate,
    Value<double>? totalPossibleScore,
    Value<String>? remarks,
    Value<String>? createdAt,
  }) {
    return IndependentLearningRecordsCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      gradingPeriodId: gradingPeriodId ?? this.gradingPeriodId,
      activityName: activityName ?? this.activityName,
      description: description ?? this.description,
      activityDate: activityDate ?? this.activityDate,
      totalPossibleScore: totalPossibleScore ?? this.totalPossibleScore,
      remarks: remarks ?? this.remarks,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (gradingPeriodId.present) {
      map['grading_period_id'] = Variable<int>(gradingPeriodId.value);
    }
    if (activityName.present) {
      map['activity_name'] = Variable<String>(activityName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (activityDate.present) {
      map['activity_date'] = Variable<String>(activityDate.value);
    }
    if (totalPossibleScore.present) {
      map['total_possible_score'] = Variable<double>(totalPossibleScore.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IndependentLearningRecordsCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('gradingPeriodId: $gradingPeriodId, ')
          ..write('activityName: $activityName, ')
          ..write('description: $description, ')
          ..write('activityDate: $activityDate, ')
          ..write('totalPossibleScore: $totalPossibleScore, ')
          ..write('remarks: $remarks, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StudentIndependentLearningScoresTable
    extends StudentIndependentLearningScores
    with
        TableInfo<
          $StudentIndependentLearningScoresTable,
          StudentIndependentLearningScore
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentIndependentLearningScoresTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<int> recordId = GeneratedColumn<int>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES independent_learning_records (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recordId,
    studentId,
    score,
    remarks,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_independent_learning_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentIndependentLearningScore> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {recordId, studentId},
  ];
  @override
  StudentIndependentLearningScore map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentIndependentLearningScore(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}record_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      ),
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $StudentIndependentLearningScoresTable createAlias(String alias) {
    return $StudentIndependentLearningScoresTable(attachedDatabase, alias);
  }
}

class StudentIndependentLearningScore extends DataClass
    implements Insertable<StudentIndependentLearningScore> {
  final int id;
  final int recordId;
  final int studentId;
  final double? score;
  final String remarks;
  final String? updatedAt;
  const StudentIndependentLearningScore({
    required this.id,
    required this.recordId,
    required this.studentId,
    this.score,
    required this.remarks,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['record_id'] = Variable<int>(recordId);
    map['student_id'] = Variable<int>(studentId);
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<double>(score);
    }
    map['remarks'] = Variable<String>(remarks);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  StudentIndependentLearningScoresCompanion toCompanion(bool nullToAbsent) {
    return StudentIndependentLearningScoresCompanion(
      id: Value(id),
      recordId: Value(recordId),
      studentId: Value(studentId),
      score: score == null && nullToAbsent
          ? const Value.absent()
          : Value(score),
      remarks: Value(remarks),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory StudentIndependentLearningScore.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentIndependentLearningScore(
      id: serializer.fromJson<int>(json['id']),
      recordId: serializer.fromJson<int>(json['recordId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      score: serializer.fromJson<double?>(json['score']),
      remarks: serializer.fromJson<String>(json['remarks']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recordId': serializer.toJson<int>(recordId),
      'studentId': serializer.toJson<int>(studentId),
      'score': serializer.toJson<double?>(score),
      'remarks': serializer.toJson<String>(remarks),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  StudentIndependentLearningScore copyWith({
    int? id,
    int? recordId,
    int? studentId,
    Value<double?> score = const Value.absent(),
    String? remarks,
    Value<String?> updatedAt = const Value.absent(),
  }) => StudentIndependentLearningScore(
    id: id ?? this.id,
    recordId: recordId ?? this.recordId,
    studentId: studentId ?? this.studentId,
    score: score.present ? score.value : this.score,
    remarks: remarks ?? this.remarks,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  StudentIndependentLearningScore copyWithCompanion(
    StudentIndependentLearningScoresCompanion data,
  ) {
    return StudentIndependentLearningScore(
      id: data.id.present ? data.id.value : this.id,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      score: data.score.present ? data.score.value : this.score,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentIndependentLearningScore(')
          ..write('id: $id, ')
          ..write('recordId: $recordId, ')
          ..write('studentId: $studentId, ')
          ..write('score: $score, ')
          ..write('remarks: $remarks, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, recordId, studentId, score, remarks, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentIndependentLearningScore &&
          other.id == this.id &&
          other.recordId == this.recordId &&
          other.studentId == this.studentId &&
          other.score == this.score &&
          other.remarks == this.remarks &&
          other.updatedAt == this.updatedAt);
}

class StudentIndependentLearningScoresCompanion
    extends UpdateCompanion<StudentIndependentLearningScore> {
  final Value<int> id;
  final Value<int> recordId;
  final Value<int> studentId;
  final Value<double?> score;
  final Value<String> remarks;
  final Value<String?> updatedAt;
  const StudentIndependentLearningScoresCompanion({
    this.id = const Value.absent(),
    this.recordId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.score = const Value.absent(),
    this.remarks = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudentIndependentLearningScoresCompanion.insert({
    this.id = const Value.absent(),
    required int recordId,
    required int studentId,
    this.score = const Value.absent(),
    this.remarks = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : recordId = Value(recordId),
       studentId = Value(studentId);
  static Insertable<StudentIndependentLearningScore> custom({
    Expression<int>? id,
    Expression<int>? recordId,
    Expression<int>? studentId,
    Expression<double>? score,
    Expression<String>? remarks,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordId != null) 'record_id': recordId,
      if (studentId != null) 'student_id': studentId,
      if (score != null) 'score': score,
      if (remarks != null) 'remarks': remarks,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudentIndependentLearningScoresCompanion copyWith({
    Value<int>? id,
    Value<int>? recordId,
    Value<int>? studentId,
    Value<double?>? score,
    Value<String>? remarks,
    Value<String?>? updatedAt,
  }) {
    return StudentIndependentLearningScoresCompanion(
      id: id ?? this.id,
      recordId: recordId ?? this.recordId,
      studentId: studentId ?? this.studentId,
      score: score ?? this.score,
      remarks: remarks ?? this.remarks,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<int>(recordId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentIndependentLearningScoresCompanion(')
          ..write('id: $id, ')
          ..write('recordId: $recordId, ')
          ..write('studentId: $studentId, ')
          ..write('score: $score, ')
          ..write('remarks: $remarks, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $GradingConfigurationsTable extends GradingConfigurations
    with TableInfo<$GradingConfigurationsTable, GradingConfiguration> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GradingConfigurationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quizWeightMeta = const VerificationMeta(
    'quizWeight',
  );
  @override
  late final GeneratedColumn<double> quizWeight = GeneratedColumn<double>(
    'quiz_weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(20.0),
  );
  static const VerificationMeta _attendanceWeightMeta = const VerificationMeta(
    'attendanceWeight',
  );
  @override
  late final GeneratedColumn<double> attendanceWeight = GeneratedColumn<double>(
    'attendance_weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(10.0),
  );
  static const VerificationMeta _workWeightMeta = const VerificationMeta(
    'workWeight',
  );
  @override
  late final GeneratedColumn<double> workWeight = GeneratedColumn<double>(
    'work_weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(20.0),
  );
  static const VerificationMeta _majorExamWeightMeta = const VerificationMeta(
    'majorExamWeight',
  );
  @override
  late final GeneratedColumn<double> majorExamWeight = GeneratedColumn<double>(
    'major_exam_weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(40.0),
  );
  static const VerificationMeta _independentLearningWeightMeta =
      const VerificationMeta('independentLearningWeight');
  @override
  late final GeneratedColumn<double> independentLearningWeight =
      GeneratedColumn<double>(
        'independent_learning_weight',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(10.0),
      );
  static const VerificationMeta _decimalPlacesMeta = const VerificationMeta(
    'decimalPlaces',
  );
  @override
  late final GeneratedColumn<int> decimalPlaces = GeneratedColumn<int>(
    'decimal_places',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    name,
    quizWeight,
    attendanceWeight,
    workWeight,
    majorExamWeight,
    independentLearningWeight,
    decimalPlaces,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grading_configurations';
  @override
  VerificationContext validateIntegrity(
    Insertable<GradingConfiguration> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('quiz_weight')) {
      context.handle(
        _quizWeightMeta,
        quizWeight.isAcceptableOrUnknown(data['quiz_weight']!, _quizWeightMeta),
      );
    }
    if (data.containsKey('attendance_weight')) {
      context.handle(
        _attendanceWeightMeta,
        attendanceWeight.isAcceptableOrUnknown(
          data['attendance_weight']!,
          _attendanceWeightMeta,
        ),
      );
    }
    if (data.containsKey('work_weight')) {
      context.handle(
        _workWeightMeta,
        workWeight.isAcceptableOrUnknown(data['work_weight']!, _workWeightMeta),
      );
    }
    if (data.containsKey('major_exam_weight')) {
      context.handle(
        _majorExamWeightMeta,
        majorExamWeight.isAcceptableOrUnknown(
          data['major_exam_weight']!,
          _majorExamWeightMeta,
        ),
      );
    }
    if (data.containsKey('independent_learning_weight')) {
      context.handle(
        _independentLearningWeightMeta,
        independentLearningWeight.isAcceptableOrUnknown(
          data['independent_learning_weight']!,
          _independentLearningWeightMeta,
        ),
      );
    }
    if (data.containsKey('decimal_places')) {
      context.handle(
        _decimalPlacesMeta,
        decimalPlaces.isAcceptableOrUnknown(
          data['decimal_places']!,
          _decimalPlacesMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GradingConfiguration map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GradingConfiguration(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      quizWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quiz_weight'],
      )!,
      attendanceWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}attendance_weight'],
      )!,
      workWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}work_weight'],
      )!,
      majorExamWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}major_exam_weight'],
      )!,
      independentLearningWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}independent_learning_weight'],
      )!,
      decimalPlaces: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}decimal_places'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $GradingConfigurationsTable createAlias(String alias) {
    return $GradingConfigurationsTable(attachedDatabase, alias);
  }
}

class GradingConfiguration extends DataClass
    implements Insertable<GradingConfiguration> {
  final int id;
  final int? subjectId;
  final String name;
  final double quizWeight;
  final double attendanceWeight;
  final double workWeight;
  final double majorExamWeight;
  final double independentLearningWeight;
  final int decimalPlaces;
  final bool isActive;
  const GradingConfiguration({
    required this.id,
    this.subjectId,
    required this.name,
    required this.quizWeight,
    required this.attendanceWeight,
    required this.workWeight,
    required this.majorExamWeight,
    required this.independentLearningWeight,
    required this.decimalPlaces,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<int>(subjectId);
    }
    map['name'] = Variable<String>(name);
    map['quiz_weight'] = Variable<double>(quizWeight);
    map['attendance_weight'] = Variable<double>(attendanceWeight);
    map['work_weight'] = Variable<double>(workWeight);
    map['major_exam_weight'] = Variable<double>(majorExamWeight);
    map['independent_learning_weight'] = Variable<double>(
      independentLearningWeight,
    );
    map['decimal_places'] = Variable<int>(decimalPlaces);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  GradingConfigurationsCompanion toCompanion(bool nullToAbsent) {
    return GradingConfigurationsCompanion(
      id: Value(id),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
      name: Value(name),
      quizWeight: Value(quizWeight),
      attendanceWeight: Value(attendanceWeight),
      workWeight: Value(workWeight),
      majorExamWeight: Value(majorExamWeight),
      independentLearningWeight: Value(independentLearningWeight),
      decimalPlaces: Value(decimalPlaces),
      isActive: Value(isActive),
    );
  }

  factory GradingConfiguration.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GradingConfiguration(
      id: serializer.fromJson<int>(json['id']),
      subjectId: serializer.fromJson<int?>(json['subjectId']),
      name: serializer.fromJson<String>(json['name']),
      quizWeight: serializer.fromJson<double>(json['quizWeight']),
      attendanceWeight: serializer.fromJson<double>(json['attendanceWeight']),
      workWeight: serializer.fromJson<double>(json['workWeight']),
      majorExamWeight: serializer.fromJson<double>(json['majorExamWeight']),
      independentLearningWeight: serializer.fromJson<double>(
        json['independentLearningWeight'],
      ),
      decimalPlaces: serializer.fromJson<int>(json['decimalPlaces']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectId': serializer.toJson<int?>(subjectId),
      'name': serializer.toJson<String>(name),
      'quizWeight': serializer.toJson<double>(quizWeight),
      'attendanceWeight': serializer.toJson<double>(attendanceWeight),
      'workWeight': serializer.toJson<double>(workWeight),
      'majorExamWeight': serializer.toJson<double>(majorExamWeight),
      'independentLearningWeight': serializer.toJson<double>(
        independentLearningWeight,
      ),
      'decimalPlaces': serializer.toJson<int>(decimalPlaces),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  GradingConfiguration copyWith({
    int? id,
    Value<int?> subjectId = const Value.absent(),
    String? name,
    double? quizWeight,
    double? attendanceWeight,
    double? workWeight,
    double? majorExamWeight,
    double? independentLearningWeight,
    int? decimalPlaces,
    bool? isActive,
  }) => GradingConfiguration(
    id: id ?? this.id,
    subjectId: subjectId.present ? subjectId.value : this.subjectId,
    name: name ?? this.name,
    quizWeight: quizWeight ?? this.quizWeight,
    attendanceWeight: attendanceWeight ?? this.attendanceWeight,
    workWeight: workWeight ?? this.workWeight,
    majorExamWeight: majorExamWeight ?? this.majorExamWeight,
    independentLearningWeight:
        independentLearningWeight ?? this.independentLearningWeight,
    decimalPlaces: decimalPlaces ?? this.decimalPlaces,
    isActive: isActive ?? this.isActive,
  );
  GradingConfiguration copyWithCompanion(GradingConfigurationsCompanion data) {
    return GradingConfiguration(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      name: data.name.present ? data.name.value : this.name,
      quizWeight: data.quizWeight.present
          ? data.quizWeight.value
          : this.quizWeight,
      attendanceWeight: data.attendanceWeight.present
          ? data.attendanceWeight.value
          : this.attendanceWeight,
      workWeight: data.workWeight.present
          ? data.workWeight.value
          : this.workWeight,
      majorExamWeight: data.majorExamWeight.present
          ? data.majorExamWeight.value
          : this.majorExamWeight,
      independentLearningWeight: data.independentLearningWeight.present
          ? data.independentLearningWeight.value
          : this.independentLearningWeight,
      decimalPlaces: data.decimalPlaces.present
          ? data.decimalPlaces.value
          : this.decimalPlaces,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GradingConfiguration(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('name: $name, ')
          ..write('quizWeight: $quizWeight, ')
          ..write('attendanceWeight: $attendanceWeight, ')
          ..write('workWeight: $workWeight, ')
          ..write('majorExamWeight: $majorExamWeight, ')
          ..write('independentLearningWeight: $independentLearningWeight, ')
          ..write('decimalPlaces: $decimalPlaces, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subjectId,
    name,
    quizWeight,
    attendanceWeight,
    workWeight,
    majorExamWeight,
    independentLearningWeight,
    decimalPlaces,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GradingConfiguration &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.name == this.name &&
          other.quizWeight == this.quizWeight &&
          other.attendanceWeight == this.attendanceWeight &&
          other.workWeight == this.workWeight &&
          other.majorExamWeight == this.majorExamWeight &&
          other.independentLearningWeight == this.independentLearningWeight &&
          other.decimalPlaces == this.decimalPlaces &&
          other.isActive == this.isActive);
}

class GradingConfigurationsCompanion
    extends UpdateCompanion<GradingConfiguration> {
  final Value<int> id;
  final Value<int?> subjectId;
  final Value<String> name;
  final Value<double> quizWeight;
  final Value<double> attendanceWeight;
  final Value<double> workWeight;
  final Value<double> majorExamWeight;
  final Value<double> independentLearningWeight;
  final Value<int> decimalPlaces;
  final Value<bool> isActive;
  const GradingConfigurationsCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.name = const Value.absent(),
    this.quizWeight = const Value.absent(),
    this.attendanceWeight = const Value.absent(),
    this.workWeight = const Value.absent(),
    this.majorExamWeight = const Value.absent(),
    this.independentLearningWeight = const Value.absent(),
    this.decimalPlaces = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  GradingConfigurationsCompanion.insert({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    required String name,
    this.quizWeight = const Value.absent(),
    this.attendanceWeight = const Value.absent(),
    this.workWeight = const Value.absent(),
    this.majorExamWeight = const Value.absent(),
    this.independentLearningWeight = const Value.absent(),
    this.decimalPlaces = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : name = Value(name);
  static Insertable<GradingConfiguration> custom({
    Expression<int>? id,
    Expression<int>? subjectId,
    Expression<String>? name,
    Expression<double>? quizWeight,
    Expression<double>? attendanceWeight,
    Expression<double>? workWeight,
    Expression<double>? majorExamWeight,
    Expression<double>? independentLearningWeight,
    Expression<int>? decimalPlaces,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (name != null) 'name': name,
      if (quizWeight != null) 'quiz_weight': quizWeight,
      if (attendanceWeight != null) 'attendance_weight': attendanceWeight,
      if (workWeight != null) 'work_weight': workWeight,
      if (majorExamWeight != null) 'major_exam_weight': majorExamWeight,
      if (independentLearningWeight != null)
        'independent_learning_weight': independentLearningWeight,
      if (decimalPlaces != null) 'decimal_places': decimalPlaces,
      if (isActive != null) 'is_active': isActive,
    });
  }

  GradingConfigurationsCompanion copyWith({
    Value<int>? id,
    Value<int?>? subjectId,
    Value<String>? name,
    Value<double>? quizWeight,
    Value<double>? attendanceWeight,
    Value<double>? workWeight,
    Value<double>? majorExamWeight,
    Value<double>? independentLearningWeight,
    Value<int>? decimalPlaces,
    Value<bool>? isActive,
  }) {
    return GradingConfigurationsCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      name: name ?? this.name,
      quizWeight: quizWeight ?? this.quizWeight,
      attendanceWeight: attendanceWeight ?? this.attendanceWeight,
      workWeight: workWeight ?? this.workWeight,
      majorExamWeight: majorExamWeight ?? this.majorExamWeight,
      independentLearningWeight:
          independentLearningWeight ?? this.independentLearningWeight,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (quizWeight.present) {
      map['quiz_weight'] = Variable<double>(quizWeight.value);
    }
    if (attendanceWeight.present) {
      map['attendance_weight'] = Variable<double>(attendanceWeight.value);
    }
    if (workWeight.present) {
      map['work_weight'] = Variable<double>(workWeight.value);
    }
    if (majorExamWeight.present) {
      map['major_exam_weight'] = Variable<double>(majorExamWeight.value);
    }
    if (independentLearningWeight.present) {
      map['independent_learning_weight'] = Variable<double>(
        independentLearningWeight.value,
      );
    }
    if (decimalPlaces.present) {
      map['decimal_places'] = Variable<int>(decimalPlaces.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GradingConfigurationsCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('name: $name, ')
          ..write('quizWeight: $quizWeight, ')
          ..write('attendanceWeight: $attendanceWeight, ')
          ..write('workWeight: $workWeight, ')
          ..write('majorExamWeight: $majorExamWeight, ')
          ..write('independentLearningWeight: $independentLearningWeight, ')
          ..write('decimalPlaces: $decimalPlaces, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $TermGradesTable extends TermGrades
    with TableInfo<$TermGradesTable, TermGrade> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermGradesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gradingPeriodIdMeta = const VerificationMeta(
    'gradingPeriodId',
  );
  @override
  late final GeneratedColumn<int> gradingPeriodId = GeneratedColumn<int>(
    'grading_period_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES grading_periods (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<double> grade = GeneratedColumn<double>(
    'grade',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _calculatedAtMeta = const VerificationMeta(
    'calculatedAt',
  );
  @override
  late final GeneratedColumn<String> calculatedAt = GeneratedColumn<String>(
    'calculated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    studentId,
    gradingPeriodId,
    grade,
    remarks,
    calculatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_grades';
  @override
  VerificationContext validateIntegrity(
    Insertable<TermGrade> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('grading_period_id')) {
      context.handle(
        _gradingPeriodIdMeta,
        gradingPeriodId.isAcceptableOrUnknown(
          data['grading_period_id']!,
          _gradingPeriodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gradingPeriodIdMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    if (data.containsKey('calculated_at')) {
      context.handle(
        _calculatedAtMeta,
        calculatedAt.isAcceptableOrUnknown(
          data['calculated_at']!,
          _calculatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {subjectId, studentId, gradingPeriodId},
  ];
  @override
  TermGrade map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermGrade(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      gradingPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grading_period_id'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grade'],
      ),
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      )!,
      calculatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calculated_at'],
      ),
    );
  }

  @override
  $TermGradesTable createAlias(String alias) {
    return $TermGradesTable(attachedDatabase, alias);
  }
}

class TermGrade extends DataClass implements Insertable<TermGrade> {
  final int id;
  final int subjectId;
  final int studentId;
  final int gradingPeriodId;
  final double? grade;
  final String remarks;
  final String? calculatedAt;
  const TermGrade({
    required this.id,
    required this.subjectId,
    required this.studentId,
    required this.gradingPeriodId,
    this.grade,
    required this.remarks,
    this.calculatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject_id'] = Variable<int>(subjectId);
    map['student_id'] = Variable<int>(studentId);
    map['grading_period_id'] = Variable<int>(gradingPeriodId);
    if (!nullToAbsent || grade != null) {
      map['grade'] = Variable<double>(grade);
    }
    map['remarks'] = Variable<String>(remarks);
    if (!nullToAbsent || calculatedAt != null) {
      map['calculated_at'] = Variable<String>(calculatedAt);
    }
    return map;
  }

  TermGradesCompanion toCompanion(bool nullToAbsent) {
    return TermGradesCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      studentId: Value(studentId),
      gradingPeriodId: Value(gradingPeriodId),
      grade: grade == null && nullToAbsent
          ? const Value.absent()
          : Value(grade),
      remarks: Value(remarks),
      calculatedAt: calculatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(calculatedAt),
    );
  }

  factory TermGrade.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermGrade(
      id: serializer.fromJson<int>(json['id']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      gradingPeriodId: serializer.fromJson<int>(json['gradingPeriodId']),
      grade: serializer.fromJson<double?>(json['grade']),
      remarks: serializer.fromJson<String>(json['remarks']),
      calculatedAt: serializer.fromJson<String?>(json['calculatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectId': serializer.toJson<int>(subjectId),
      'studentId': serializer.toJson<int>(studentId),
      'gradingPeriodId': serializer.toJson<int>(gradingPeriodId),
      'grade': serializer.toJson<double?>(grade),
      'remarks': serializer.toJson<String>(remarks),
      'calculatedAt': serializer.toJson<String?>(calculatedAt),
    };
  }

  TermGrade copyWith({
    int? id,
    int? subjectId,
    int? studentId,
    int? gradingPeriodId,
    Value<double?> grade = const Value.absent(),
    String? remarks,
    Value<String?> calculatedAt = const Value.absent(),
  }) => TermGrade(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    studentId: studentId ?? this.studentId,
    gradingPeriodId: gradingPeriodId ?? this.gradingPeriodId,
    grade: grade.present ? grade.value : this.grade,
    remarks: remarks ?? this.remarks,
    calculatedAt: calculatedAt.present ? calculatedAt.value : this.calculatedAt,
  );
  TermGrade copyWithCompanion(TermGradesCompanion data) {
    return TermGrade(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      gradingPeriodId: data.gradingPeriodId.present
          ? data.gradingPeriodId.value
          : this.gradingPeriodId,
      grade: data.grade.present ? data.grade.value : this.grade,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      calculatedAt: data.calculatedAt.present
          ? data.calculatedAt.value
          : this.calculatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermGrade(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('studentId: $studentId, ')
          ..write('gradingPeriodId: $gradingPeriodId, ')
          ..write('grade: $grade, ')
          ..write('remarks: $remarks, ')
          ..write('calculatedAt: $calculatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subjectId,
    studentId,
    gradingPeriodId,
    grade,
    remarks,
    calculatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermGrade &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.studentId == this.studentId &&
          other.gradingPeriodId == this.gradingPeriodId &&
          other.grade == this.grade &&
          other.remarks == this.remarks &&
          other.calculatedAt == this.calculatedAt);
}

class TermGradesCompanion extends UpdateCompanion<TermGrade> {
  final Value<int> id;
  final Value<int> subjectId;
  final Value<int> studentId;
  final Value<int> gradingPeriodId;
  final Value<double?> grade;
  final Value<String> remarks;
  final Value<String?> calculatedAt;
  const TermGradesCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.gradingPeriodId = const Value.absent(),
    this.grade = const Value.absent(),
    this.remarks = const Value.absent(),
    this.calculatedAt = const Value.absent(),
  });
  TermGradesCompanion.insert({
    this.id = const Value.absent(),
    required int subjectId,
    required int studentId,
    required int gradingPeriodId,
    this.grade = const Value.absent(),
    this.remarks = const Value.absent(),
    this.calculatedAt = const Value.absent(),
  }) : subjectId = Value(subjectId),
       studentId = Value(studentId),
       gradingPeriodId = Value(gradingPeriodId);
  static Insertable<TermGrade> custom({
    Expression<int>? id,
    Expression<int>? subjectId,
    Expression<int>? studentId,
    Expression<int>? gradingPeriodId,
    Expression<double>? grade,
    Expression<String>? remarks,
    Expression<String>? calculatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (studentId != null) 'student_id': studentId,
      if (gradingPeriodId != null) 'grading_period_id': gradingPeriodId,
      if (grade != null) 'grade': grade,
      if (remarks != null) 'remarks': remarks,
      if (calculatedAt != null) 'calculated_at': calculatedAt,
    });
  }

  TermGradesCompanion copyWith({
    Value<int>? id,
    Value<int>? subjectId,
    Value<int>? studentId,
    Value<int>? gradingPeriodId,
    Value<double?>? grade,
    Value<String>? remarks,
    Value<String?>? calculatedAt,
  }) {
    return TermGradesCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      studentId: studentId ?? this.studentId,
      gradingPeriodId: gradingPeriodId ?? this.gradingPeriodId,
      grade: grade ?? this.grade,
      remarks: remarks ?? this.remarks,
      calculatedAt: calculatedAt ?? this.calculatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (gradingPeriodId.present) {
      map['grading_period_id'] = Variable<int>(gradingPeriodId.value);
    }
    if (grade.present) {
      map['grade'] = Variable<double>(grade.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (calculatedAt.present) {
      map['calculated_at'] = Variable<String>(calculatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermGradesCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('studentId: $studentId, ')
          ..write('gradingPeriodId: $gradingPeriodId, ')
          ..write('grade: $grade, ')
          ..write('remarks: $remarks, ')
          ..write('calculatedAt: $calculatedAt')
          ..write(')'))
        .toString();
  }
}

class $GradeRankingsTable extends GradeRankings
    with TableInfo<$GradeRankingsTable, GradeRanking> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GradeRankingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gradingPeriodIdMeta = const VerificationMeta(
    'gradingPeriodId',
  );
  @override
  late final GeneratedColumn<int> gradingPeriodId = GeneratedColumn<int>(
    'grading_period_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES grading_periods (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<int> rank = GeneratedColumn<int>(
    'rank',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<double> grade = GeneratedColumn<double>(
    'grade',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calculatedAtMeta = const VerificationMeta(
    'calculatedAt',
  );
  @override
  late final GeneratedColumn<String> calculatedAt = GeneratedColumn<String>(
    'calculated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    gradingPeriodId,
    studentId,
    rank,
    grade,
    calculatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grade_rankings';
  @override
  VerificationContext validateIntegrity(
    Insertable<GradeRanking> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('grading_period_id')) {
      context.handle(
        _gradingPeriodIdMeta,
        gradingPeriodId.isAcceptableOrUnknown(
          data['grading_period_id']!,
          _gradingPeriodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gradingPeriodIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('rank')) {
      context.handle(
        _rankMeta,
        rank.isAcceptableOrUnknown(data['rank']!, _rankMeta),
      );
    } else if (isInserting) {
      context.missing(_rankMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('calculated_at')) {
      context.handle(
        _calculatedAtMeta,
        calculatedAt.isAcceptableOrUnknown(
          data['calculated_at']!,
          _calculatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_calculatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {subjectId, gradingPeriodId, studentId},
  ];
  @override
  GradeRanking map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GradeRanking(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      gradingPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grading_period_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      rank: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rank'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grade'],
      )!,
      calculatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calculated_at'],
      )!,
    );
  }

  @override
  $GradeRankingsTable createAlias(String alias) {
    return $GradeRankingsTable(attachedDatabase, alias);
  }
}

class GradeRanking extends DataClass implements Insertable<GradeRanking> {
  final int id;
  final int subjectId;
  final int gradingPeriodId;
  final int studentId;
  final int rank;
  final double grade;
  final String calculatedAt;
  const GradeRanking({
    required this.id,
    required this.subjectId,
    required this.gradingPeriodId,
    required this.studentId,
    required this.rank,
    required this.grade,
    required this.calculatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject_id'] = Variable<int>(subjectId);
    map['grading_period_id'] = Variable<int>(gradingPeriodId);
    map['student_id'] = Variable<int>(studentId);
    map['rank'] = Variable<int>(rank);
    map['grade'] = Variable<double>(grade);
    map['calculated_at'] = Variable<String>(calculatedAt);
    return map;
  }

  GradeRankingsCompanion toCompanion(bool nullToAbsent) {
    return GradeRankingsCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      gradingPeriodId: Value(gradingPeriodId),
      studentId: Value(studentId),
      rank: Value(rank),
      grade: Value(grade),
      calculatedAt: Value(calculatedAt),
    );
  }

  factory GradeRanking.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GradeRanking(
      id: serializer.fromJson<int>(json['id']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      gradingPeriodId: serializer.fromJson<int>(json['gradingPeriodId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      rank: serializer.fromJson<int>(json['rank']),
      grade: serializer.fromJson<double>(json['grade']),
      calculatedAt: serializer.fromJson<String>(json['calculatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectId': serializer.toJson<int>(subjectId),
      'gradingPeriodId': serializer.toJson<int>(gradingPeriodId),
      'studentId': serializer.toJson<int>(studentId),
      'rank': serializer.toJson<int>(rank),
      'grade': serializer.toJson<double>(grade),
      'calculatedAt': serializer.toJson<String>(calculatedAt),
    };
  }

  GradeRanking copyWith({
    int? id,
    int? subjectId,
    int? gradingPeriodId,
    int? studentId,
    int? rank,
    double? grade,
    String? calculatedAt,
  }) => GradeRanking(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    gradingPeriodId: gradingPeriodId ?? this.gradingPeriodId,
    studentId: studentId ?? this.studentId,
    rank: rank ?? this.rank,
    grade: grade ?? this.grade,
    calculatedAt: calculatedAt ?? this.calculatedAt,
  );
  GradeRanking copyWithCompanion(GradeRankingsCompanion data) {
    return GradeRanking(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      gradingPeriodId: data.gradingPeriodId.present
          ? data.gradingPeriodId.value
          : this.gradingPeriodId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      rank: data.rank.present ? data.rank.value : this.rank,
      grade: data.grade.present ? data.grade.value : this.grade,
      calculatedAt: data.calculatedAt.present
          ? data.calculatedAt.value
          : this.calculatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GradeRanking(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('gradingPeriodId: $gradingPeriodId, ')
          ..write('studentId: $studentId, ')
          ..write('rank: $rank, ')
          ..write('grade: $grade, ')
          ..write('calculatedAt: $calculatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subjectId,
    gradingPeriodId,
    studentId,
    rank,
    grade,
    calculatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GradeRanking &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.gradingPeriodId == this.gradingPeriodId &&
          other.studentId == this.studentId &&
          other.rank == this.rank &&
          other.grade == this.grade &&
          other.calculatedAt == this.calculatedAt);
}

class GradeRankingsCompanion extends UpdateCompanion<GradeRanking> {
  final Value<int> id;
  final Value<int> subjectId;
  final Value<int> gradingPeriodId;
  final Value<int> studentId;
  final Value<int> rank;
  final Value<double> grade;
  final Value<String> calculatedAt;
  const GradeRankingsCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.gradingPeriodId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.rank = const Value.absent(),
    this.grade = const Value.absent(),
    this.calculatedAt = const Value.absent(),
  });
  GradeRankingsCompanion.insert({
    this.id = const Value.absent(),
    required int subjectId,
    required int gradingPeriodId,
    required int studentId,
    required int rank,
    required double grade,
    required String calculatedAt,
  }) : subjectId = Value(subjectId),
       gradingPeriodId = Value(gradingPeriodId),
       studentId = Value(studentId),
       rank = Value(rank),
       grade = Value(grade),
       calculatedAt = Value(calculatedAt);
  static Insertable<GradeRanking> custom({
    Expression<int>? id,
    Expression<int>? subjectId,
    Expression<int>? gradingPeriodId,
    Expression<int>? studentId,
    Expression<int>? rank,
    Expression<double>? grade,
    Expression<String>? calculatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (gradingPeriodId != null) 'grading_period_id': gradingPeriodId,
      if (studentId != null) 'student_id': studentId,
      if (rank != null) 'rank': rank,
      if (grade != null) 'grade': grade,
      if (calculatedAt != null) 'calculated_at': calculatedAt,
    });
  }

  GradeRankingsCompanion copyWith({
    Value<int>? id,
    Value<int>? subjectId,
    Value<int>? gradingPeriodId,
    Value<int>? studentId,
    Value<int>? rank,
    Value<double>? grade,
    Value<String>? calculatedAt,
  }) {
    return GradeRankingsCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      gradingPeriodId: gradingPeriodId ?? this.gradingPeriodId,
      studentId: studentId ?? this.studentId,
      rank: rank ?? this.rank,
      grade: grade ?? this.grade,
      calculatedAt: calculatedAt ?? this.calculatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (gradingPeriodId.present) {
      map['grading_period_id'] = Variable<int>(gradingPeriodId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (rank.present) {
      map['rank'] = Variable<int>(rank.value);
    }
    if (grade.present) {
      map['grade'] = Variable<double>(grade.value);
    }
    if (calculatedAt.present) {
      map['calculated_at'] = Variable<String>(calculatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GradeRankingsCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('gradingPeriodId: $gradingPeriodId, ')
          ..write('studentId: $studentId, ')
          ..write('rank: $rank, ')
          ..write('grade: $grade, ')
          ..write('calculatedAt: $calculatedAt')
          ..write(')'))
        .toString();
  }
}

class $ApplicationSettingsTable extends ApplicationSettings
    with TableInfo<$ApplicationSettingsTable, ApplicationSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApplicationSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'application_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ApplicationSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ApplicationSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApplicationSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ApplicationSettingsTable createAlias(String alias) {
    return $ApplicationSettingsTable(attachedDatabase, alias);
  }
}

class ApplicationSetting extends DataClass
    implements Insertable<ApplicationSetting> {
  final int id;
  final String key;
  final String value;
  final String updatedAt;
  const ApplicationSetting({
    required this.id,
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  ApplicationSettingsCompanion toCompanion(bool nullToAbsent) {
    return ApplicationSettingsCompanion(
      id: Value(id),
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory ApplicationSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApplicationSetting(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  ApplicationSetting copyWith({
    int? id,
    String? key,
    String? value,
    String? updatedAt,
  }) => ApplicationSetting(
    id: id ?? this.id,
    key: key ?? this.key,
    value: value ?? this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ApplicationSetting copyWithCompanion(ApplicationSettingsCompanion data) {
    return ApplicationSetting(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationSetting(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApplicationSetting &&
          other.id == this.id &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class ApplicationSettingsCompanion extends UpdateCompanion<ApplicationSetting> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> value;
  final Value<String> updatedAt;
  const ApplicationSettingsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ApplicationSettingsCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String value,
    required String updatedAt,
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<ApplicationSetting> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? value,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ApplicationSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<String>? value,
    Value<String>? updatedAt,
  }) {
    return ApplicationSettingsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationSettingsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ActivityLogsTable extends ActivityLogs
    with TableInfo<$ActivityLogsTable, ActivityLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _activityMeta = const VerificationMeta(
    'activity',
  );
  @override
  late final GeneratedColumn<String> activity = GeneratedColumn<String>(
    'activity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
    'entity_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    activity,
    details,
    entityType,
    entityId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('activity')) {
      context.handle(
        _activityMeta,
        activity.isAcceptableOrUnknown(data['activity']!, _activityMeta),
      );
    } else if (isInserting) {
      context.missing(_activityMeta);
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      activity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      ),
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entity_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ActivityLogsTable createAlias(String alias) {
    return $ActivityLogsTable(attachedDatabase, alias);
  }
}

class ActivityLog extends DataClass implements Insertable<ActivityLog> {
  final int id;
  final String activity;
  final String details;
  final String? entityType;
  final int? entityId;
  final String createdAt;
  const ActivityLog({
    required this.id,
    required this.activity,
    required this.details,
    this.entityType,
    this.entityId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['activity'] = Variable<String>(activity);
    map['details'] = Variable<String>(details);
    if (!nullToAbsent || entityType != null) {
      map['entity_type'] = Variable<String>(entityType);
    }
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<int>(entityId);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  ActivityLogsCompanion toCompanion(bool nullToAbsent) {
    return ActivityLogsCompanion(
      id: Value(id),
      activity: Value(activity),
      details: Value(details),
      entityType: entityType == null && nullToAbsent
          ? const Value.absent()
          : Value(entityType),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      createdAt: Value(createdAt),
    );
  }

  factory ActivityLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityLog(
      id: serializer.fromJson<int>(json['id']),
      activity: serializer.fromJson<String>(json['activity']),
      details: serializer.fromJson<String>(json['details']),
      entityType: serializer.fromJson<String?>(json['entityType']),
      entityId: serializer.fromJson<int?>(json['entityId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'activity': serializer.toJson<String>(activity),
      'details': serializer.toJson<String>(details),
      'entityType': serializer.toJson<String?>(entityType),
      'entityId': serializer.toJson<int?>(entityId),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  ActivityLog copyWith({
    int? id,
    String? activity,
    String? details,
    Value<String?> entityType = const Value.absent(),
    Value<int?> entityId = const Value.absent(),
    String? createdAt,
  }) => ActivityLog(
    id: id ?? this.id,
    activity: activity ?? this.activity,
    details: details ?? this.details,
    entityType: entityType.present ? entityType.value : this.entityType,
    entityId: entityId.present ? entityId.value : this.entityId,
    createdAt: createdAt ?? this.createdAt,
  );
  ActivityLog copyWithCompanion(ActivityLogsCompanion data) {
    return ActivityLog(
      id: data.id.present ? data.id.value : this.id,
      activity: data.activity.present ? data.activity.value : this.activity,
      details: data.details.present ? data.details.value : this.details,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityLog(')
          ..write('id: $id, ')
          ..write('activity: $activity, ')
          ..write('details: $details, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, activity, details, entityType, entityId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityLog &&
          other.id == this.id &&
          other.activity == this.activity &&
          other.details == this.details &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.createdAt == this.createdAt);
}

class ActivityLogsCompanion extends UpdateCompanion<ActivityLog> {
  final Value<int> id;
  final Value<String> activity;
  final Value<String> details;
  final Value<String?> entityType;
  final Value<int?> entityId;
  final Value<String> createdAt;
  const ActivityLogsCompanion({
    this.id = const Value.absent(),
    this.activity = const Value.absent(),
    this.details = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ActivityLogsCompanion.insert({
    this.id = const Value.absent(),
    required String activity,
    this.details = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    required String createdAt,
  }) : activity = Value(activity),
       createdAt = Value(createdAt);
  static Insertable<ActivityLog> custom({
    Expression<int>? id,
    Expression<String>? activity,
    Expression<String>? details,
    Expression<String>? entityType,
    Expression<int>? entityId,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (activity != null) 'activity': activity,
      if (details != null) 'details': details,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ActivityLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? activity,
    Value<String>? details,
    Value<String?>? entityType,
    Value<int?>? entityId,
    Value<String>? createdAt,
  }) {
    return ActivityLogsCompanion(
      id: id ?? this.id,
      activity: activity ?? this.activity,
      details: details ?? this.details,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (activity.present) {
      map['activity'] = Variable<String>(activity.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityLogsCompanion(')
          ..write('id: $id, ')
          ..write('activity: $activity, ')
          ..write('details: $details, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SchoolSettingsTable schoolSettings = $SchoolSettingsTable(this);
  late final $AcademicYearsTable academicYears = $AcademicYearsTable(this);
  late final $SemestersTable semesters = $SemestersTable(this);
  late final $GradingPeriodsTable gradingPeriods = $GradingPeriodsTable(this);
  late final $InstructorsTable instructors = $InstructorsTable(this);
  late final $SectionsTable sections = $SectionsTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $SubjectEnrollmentsTable subjectEnrollments =
      $SubjectEnrollmentsTable(this);
  late final $AssessmentsTable assessments = $AssessmentsTable(this);
  late final $StudentAssessmentScoresTable studentAssessmentScores =
      $StudentAssessmentScoresTable(this);
  late final $AttendanceSessionsTable attendanceSessions =
      $AttendanceSessionsTable(this);
  late final $StudentAttendanceTable studentAttendance =
      $StudentAttendanceTable(this);
  late final $IndependentLearningRecordsTable independentLearningRecords =
      $IndependentLearningRecordsTable(this);
  late final $StudentIndependentLearningScoresTable
  studentIndependentLearningScores = $StudentIndependentLearningScoresTable(
    this,
  );
  late final $GradingConfigurationsTable gradingConfigurations =
      $GradingConfigurationsTable(this);
  late final $TermGradesTable termGrades = $TermGradesTable(this);
  late final $GradeRankingsTable gradeRankings = $GradeRankingsTable(this);
  late final $ApplicationSettingsTable applicationSettings =
      $ApplicationSettingsTable(this);
  late final $ActivityLogsTable activityLogs = $ActivityLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    schoolSettings,
    academicYears,
    semesters,
    gradingPeriods,
    instructors,
    sections,
    subjects,
    students,
    subjectEnrollments,
    assessments,
    studentAssessmentScores,
    attendanceSessions,
    studentAttendance,
    independentLearningRecords,
    studentIndependentLearningScores,
    gradingConfigurations,
    termGrades,
    gradeRankings,
    applicationSettings,
    activityLogs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'academic_years',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('semesters', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'academic_years',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('subjects', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'semesters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('subjects', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('subjects', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'instructors',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('subjects', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('students', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('subject_enrollments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'students',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('subject_enrollments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('assessments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'grading_periods',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('assessments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'assessments',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('student_assessment_scores', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'students',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('student_assessment_scores', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('attendance_sessions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'grading_periods',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('attendance_sessions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'attendance_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('student_attendance', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'students',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('student_attendance', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('independent_learning_records', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'grading_periods',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('independent_learning_records', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'independent_learning_records',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate(
          'student_independent_learning_scores',
          kind: UpdateKind.delete,
        ),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'students',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate(
          'student_independent_learning_scores',
          kind: UpdateKind.delete,
        ),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('grading_configurations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('term_grades', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'students',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('term_grades', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'grading_periods',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('term_grades', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('grade_rankings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'grading_periods',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('grade_rankings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'students',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('grade_rankings', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SchoolSettingsTableCreateCompanionBuilder =
    SchoolSettingsCompanion Function({
      Value<int> id,
      Value<String> schoolName,
      Value<String> address,
      Value<String?> logoPath,
    });
typedef $$SchoolSettingsTableUpdateCompanionBuilder =
    SchoolSettingsCompanion Function({
      Value<int> id,
      Value<String> schoolName,
      Value<String> address,
      Value<String?> logoPath,
    });

class $$SchoolSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SchoolSettingsTable> {
  $$SchoolSettingsTableFilterComposer({
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

  ColumnFilters<String> get schoolName => $composableBuilder(
    column: $table.schoolName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SchoolSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SchoolSettingsTable> {
  $$SchoolSettingsTableOrderingComposer({
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

  ColumnOrderings<String> get schoolName => $composableBuilder(
    column: $table.schoolName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SchoolSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SchoolSettingsTable> {
  $$SchoolSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schoolName => $composableBuilder(
    column: $table.schoolName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);
}

class $$SchoolSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SchoolSettingsTable,
          SchoolSetting,
          $$SchoolSettingsTableFilterComposer,
          $$SchoolSettingsTableOrderingComposer,
          $$SchoolSettingsTableAnnotationComposer,
          $$SchoolSettingsTableCreateCompanionBuilder,
          $$SchoolSettingsTableUpdateCompanionBuilder,
          (
            SchoolSetting,
            BaseReferences<_$AppDatabase, $SchoolSettingsTable, SchoolSetting>,
          ),
          SchoolSetting,
          PrefetchHooks Function()
        > {
  $$SchoolSettingsTableTableManager(
    _$AppDatabase db,
    $SchoolSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SchoolSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SchoolSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SchoolSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> schoolName = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
              }) => SchoolSettingsCompanion(
                id: id,
                schoolName: schoolName,
                address: address,
                logoPath: logoPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> schoolName = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
              }) => SchoolSettingsCompanion.insert(
                id: id,
                schoolName: schoolName,
                address: address,
                logoPath: logoPath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SchoolSettingsTable, SchoolSetting>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SchoolSettingsTable,
                    SchoolSetting
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SchoolSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SchoolSettingsTable,
      SchoolSetting,
      $$SchoolSettingsTableFilterComposer,
      $$SchoolSettingsTableOrderingComposer,
      $$SchoolSettingsTableAnnotationComposer,
      $$SchoolSettingsTableCreateCompanionBuilder,
      $$SchoolSettingsTableUpdateCompanionBuilder,
      (
        SchoolSetting,
        BaseReferences<_$AppDatabase, $SchoolSettingsTable, SchoolSetting>,
      ),
      SchoolSetting,
      PrefetchHooks Function()
    >;
typedef $$AcademicYearsTableCreateCompanionBuilder =
    AcademicYearsCompanion Function({
      Value<int> id,
      required String name,
      Value<bool> isActive,
      required String createdAt,
    });
typedef $$AcademicYearsTableUpdateCompanionBuilder =
    AcademicYearsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<bool> isActive,
      Value<String> createdAt,
    });

final class $$AcademicYearsTableReferences
    extends BaseReferences<_$AppDatabase, $AcademicYearsTable, AcademicYear> {
  $$AcademicYearsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SemestersTable, List<Semester>>
  _semestersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.semesters,
    aliasName: 'academic_years__id__semesters__academic_year_id',
  );

  $$SemestersTableProcessedTableManager get semestersRefs {
    final manager = $$SemestersTableTableManager(
      $_db,
      $_db.semesters,
    ).filter((f) => f.academicYearId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_semestersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SubjectsTable, List<Subject>> _subjectsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.subjects,
    aliasName: 'academic_years__id__subjects__academic_year_id',
  );

  $$SubjectsTableProcessedTableManager get subjectsRefs {
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.academicYearId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_subjectsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AcademicYearsTableFilterComposer
    extends Composer<_$AppDatabase, $AcademicYearsTable> {
  $$AcademicYearsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> semestersRefs(
    Expression<bool> Function($$SemestersTableFilterComposer f) f,
  ) {
    final $$SemestersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.semesters,
      getReferencedColumn: (t) => t.academicYearId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemestersTableFilterComposer(
            $db: $db,
            $table: $db.semesters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> subjectsRefs(
    Expression<bool> Function($$SubjectsTableFilterComposer f) f,
  ) {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.academicYearId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AcademicYearsTableOrderingComposer
    extends Composer<_$AppDatabase, $AcademicYearsTable> {
  $$AcademicYearsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AcademicYearsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AcademicYearsTable> {
  $$AcademicYearsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> semestersRefs<T extends Object>(
    Expression<T> Function($$SemestersTableAnnotationComposer a) f,
  ) {
    final $$SemestersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.semesters,
      getReferencedColumn: (t) => t.academicYearId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemestersTableAnnotationComposer(
            $db: $db,
            $table: $db.semesters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> subjectsRefs<T extends Object>(
    Expression<T> Function($$SubjectsTableAnnotationComposer a) f,
  ) {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.academicYearId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AcademicYearsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AcademicYearsTable,
          AcademicYear,
          $$AcademicYearsTableFilterComposer,
          $$AcademicYearsTableOrderingComposer,
          $$AcademicYearsTableAnnotationComposer,
          $$AcademicYearsTableCreateCompanionBuilder,
          $$AcademicYearsTableUpdateCompanionBuilder,
          (AcademicYear, $$AcademicYearsTableReferences),
          AcademicYear,
          PrefetchHooks Function({bool semestersRefs, bool subjectsRefs})
        > {
  $$AcademicYearsTableTableManager(_$AppDatabase db, $AcademicYearsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AcademicYearsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AcademicYearsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AcademicYearsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
              }) => AcademicYearsCompanion(
                id: id,
                name: name,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<bool> isActive = const Value.absent(),
                required String createdAt,
              }) => AcademicYearsCompanion.insert(
                id: id,
                name: name,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AcademicYearsTable, AcademicYear>(table),
                  $$AcademicYearsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({semestersRefs = false, subjectsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (semestersRefs) db.semesters,
                    if (subjectsRefs) db.subjects,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (semestersRefs)
                        await $_getPrefetchedDataByColumns<
                          AcademicYear,
                          $AcademicYearsTable,
                          Semester,
                          $SemestersTable
                        >(
                          currentTable: table,
                          referencedTable: $$AcademicYearsTableReferences
                              ._semestersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AcademicYearsTableReferences(
                                db,
                                table,
                                p0,
                              ).semestersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'academic_year_id',
                          typedResults: items,
                        ),
                      if (subjectsRefs)
                        await $_getPrefetchedDataByColumns<
                          AcademicYear,
                          $AcademicYearsTable,
                          Subject,
                          $SubjectsTable
                        >(
                          currentTable: table,
                          referencedTable: $$AcademicYearsTableReferences
                              ._subjectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AcademicYearsTableReferences(
                                db,
                                table,
                                p0,
                              ).subjectsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'academic_year_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AcademicYearsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AcademicYearsTable,
      AcademicYear,
      $$AcademicYearsTableFilterComposer,
      $$AcademicYearsTableOrderingComposer,
      $$AcademicYearsTableAnnotationComposer,
      $$AcademicYearsTableCreateCompanionBuilder,
      $$AcademicYearsTableUpdateCompanionBuilder,
      (AcademicYear, $$AcademicYearsTableReferences),
      AcademicYear,
      PrefetchHooks Function({bool semestersRefs, bool subjectsRefs})
    >;
typedef $$SemestersTableCreateCompanionBuilder = SemestersCompanion Function({
  Value<int> id,
  required int academicYearId,
  required String name,
  Value<bool> isActive,
  required String createdAt,
});
typedef $$SemestersTableUpdateCompanionBuilder = SemestersCompanion Function({
  Value<int> id,
  Value<int> academicYearId,
  Value<String> name,
  Value<bool> isActive,
  Value<String> createdAt,
});

final class $$SemestersTableReferences
    extends BaseReferences<_$AppDatabase, $SemestersTable, Semester> {
  $$SemestersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AcademicYearsTable _academicYearIdTable(_$AppDatabase db) => db
      .academicYears
      .createAlias('semesters__academic_year_id__academic_years__id');

  $$AcademicYearsTableProcessedTableManager get academicYearId {
    final $_column = $_itemColumn<int>('academic_year_id')!;

    final manager = $$AcademicYearsTableTableManager(
      $_db,
      $_db.academicYears,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_academicYearIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SubjectsTable, List<Subject>> _subjectsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.subjects,
    aliasName: 'semesters__id__subjects__semester_id',
  );

  $$SubjectsTableProcessedTableManager get subjectsRefs {
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.semesterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_subjectsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SemestersTableFilterComposer
    extends Composer<_$AppDatabase, $SemestersTable> {
  $$SemestersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AcademicYearsTableFilterComposer get academicYearId {
    final $$AcademicYearsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicYearId,
      referencedTable: $db.academicYears,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicYearsTableFilterComposer(
            $db: $db,
            $table: $db.academicYears,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> subjectsRefs(
    Expression<bool> Function($$SubjectsTableFilterComposer f) f,
  ) {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.semesterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SemestersTableOrderingComposer
    extends Composer<_$AppDatabase, $SemestersTable> {
  $$SemestersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AcademicYearsTableOrderingComposer get academicYearId {
    final $$AcademicYearsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicYearId,
      referencedTable: $db.academicYears,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicYearsTableOrderingComposer(
            $db: $db,
            $table: $db.academicYears,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SemestersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SemestersTable> {
  $$SemestersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AcademicYearsTableAnnotationComposer get academicYearId {
    final $$AcademicYearsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicYearId,
      referencedTable: $db.academicYears,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicYearsTableAnnotationComposer(
            $db: $db,
            $table: $db.academicYears,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> subjectsRefs<T extends Object>(
    Expression<T> Function($$SubjectsTableAnnotationComposer a) f,
  ) {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.semesterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SemestersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SemestersTable,
          Semester,
          $$SemestersTableFilterComposer,
          $$SemestersTableOrderingComposer,
          $$SemestersTableAnnotationComposer,
          $$SemestersTableCreateCompanionBuilder,
          $$SemestersTableUpdateCompanionBuilder,
          (Semester, $$SemestersTableReferences),
          Semester,
          PrefetchHooks Function({bool academicYearId, bool subjectsRefs})
        > {
  $$SemestersTableTableManager(_$AppDatabase db, $SemestersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SemestersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SemestersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SemestersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> academicYearId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
              }) => SemestersCompanion(
                id: id,
                academicYearId: academicYearId,
                name: name,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int academicYearId,
                required String name,
                Value<bool> isActive = const Value.absent(),
                required String createdAt,
              }) => SemestersCompanion.insert(
                id: id,
                academicYearId: academicYearId,
                name: name,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SemestersTable, Semester>(table),
                  $$SemestersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({academicYearId = false, subjectsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (subjectsRefs) db.subjects],
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
                        if (academicYearId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.academicYearId,
                            referencedTable: $$SemestersTableReferences
                                ._academicYearIdTable(db),
                            referencedColumn: $$SemestersTableReferences
                                ._academicYearIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (subjectsRefs)
                        await $_getPrefetchedDataByColumns<
                          Semester,
                          $SemestersTable,
                          Subject,
                          $SubjectsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SemestersTableReferences
                              ._subjectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SemestersTableReferences(
                                db,
                                table,
                                p0,
                              ).subjectsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'semester_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SemestersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SemestersTable,
      Semester,
      $$SemestersTableFilterComposer,
      $$SemestersTableOrderingComposer,
      $$SemestersTableAnnotationComposer,
      $$SemestersTableCreateCompanionBuilder,
      $$SemestersTableUpdateCompanionBuilder,
      (Semester, $$SemestersTableReferences),
      Semester,
      PrefetchHooks Function({bool academicYearId, bool subjectsRefs})
    >;
typedef $$GradingPeriodsTableCreateCompanionBuilder =
    GradingPeriodsCompanion Function({
      Value<int> id,
      required String name,
      required int sortOrder,
    });
typedef $$GradingPeriodsTableUpdateCompanionBuilder =
    GradingPeriodsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> sortOrder,
    });

final class $$GradingPeriodsTableReferences
    extends BaseReferences<_$AppDatabase, $GradingPeriodsTable, GradingPeriod> {
  $$GradingPeriodsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$AssessmentsTable, List<Assessment>>
  _assessmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.assessments,
    aliasName: 'grading_periods__id__assessments__grading_period_id',
  );

  $$AssessmentsTableProcessedTableManager get assessmentsRefs {
    final manager = $$AssessmentsTableTableManager(
      $_db,
      $_db.assessments,
    ).filter((f) => f.gradingPeriodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_assessmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AttendanceSessionsTable, List<AttendanceSession>>
  _attendanceSessionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.attendanceSessions,
        aliasName:
            'grading_periods__id__attendance_sessions__grading_period_id',
      );

  $$AttendanceSessionsTableProcessedTableManager get attendanceSessionsRefs {
    final manager = $$AttendanceSessionsTableTableManager(
      $_db,
      $_db.attendanceSessions,
    ).filter((f) => f.gradingPeriodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _attendanceSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $IndependentLearningRecordsTable,
    List<IndependentLearningRecord>
  >
  _independentLearningRecordsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.independentLearningRecords,
    aliasName:
        'grading_periods__id__independent_learning_records__grading_period_id',
  );

  $$IndependentLearningRecordsTableProcessedTableManager
  get independentLearningRecordsRefs {
    final manager = $$IndependentLearningRecordsTableTableManager(
      $_db,
      $_db.independentLearningRecords,
    ).filter((f) => f.gradingPeriodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _independentLearningRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TermGradesTable, List<TermGrade>>
  _termGradesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.termGrades,
    aliasName: 'grading_periods__id__term_grades__grading_period_id',
  );

  $$TermGradesTableProcessedTableManager get termGradesRefs {
    final manager = $$TermGradesTableTableManager(
      $_db,
      $_db.termGrades,
    ).filter((f) => f.gradingPeriodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_termGradesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GradeRankingsTable, List<GradeRanking>>
  _gradeRankingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gradeRankings,
    aliasName: 'grading_periods__id__grade_rankings__grading_period_id',
  );

  $$GradeRankingsTableProcessedTableManager get gradeRankingsRefs {
    final manager = $$GradeRankingsTableTableManager(
      $_db,
      $_db.gradeRankings,
    ).filter((f) => f.gradingPeriodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_gradeRankingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GradingPeriodsTableFilterComposer
    extends Composer<_$AppDatabase, $GradingPeriodsTable> {
  $$GradingPeriodsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> assessmentsRefs(
    Expression<bool> Function($$AssessmentsTableFilterComposer f) f,
  ) {
    final $$AssessmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.gradingPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableFilterComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> attendanceSessionsRefs(
    Expression<bool> Function($$AttendanceSessionsTableFilterComposer f) f,
  ) {
    final $$AttendanceSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendanceSessions,
      getReferencedColumn: (t) => t.gradingPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceSessionsTableFilterComposer(
            $db: $db,
            $table: $db.attendanceSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> independentLearningRecordsRefs(
    Expression<bool> Function($$IndependentLearningRecordsTableFilterComposer f)
    f,
  ) {
    final $$IndependentLearningRecordsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.independentLearningRecords,
          getReferencedColumn: (t) => t.gradingPeriodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$IndependentLearningRecordsTableFilterComposer(
                $db: $db,
                $table: $db.independentLearningRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> termGradesRefs(
    Expression<bool> Function($$TermGradesTableFilterComposer f) f,
  ) {
    final $$TermGradesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.termGrades,
      getReferencedColumn: (t) => t.gradingPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TermGradesTableFilterComposer(
            $db: $db,
            $table: $db.termGrades,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gradeRankingsRefs(
    Expression<bool> Function($$GradeRankingsTableFilterComposer f) f,
  ) {
    final $$GradeRankingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gradeRankings,
      getReferencedColumn: (t) => t.gradingPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradeRankingsTableFilterComposer(
            $db: $db,
            $table: $db.gradeRankings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GradingPeriodsTableOrderingComposer
    extends Composer<_$AppDatabase, $GradingPeriodsTable> {
  $$GradingPeriodsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GradingPeriodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GradingPeriodsTable> {
  $$GradingPeriodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> assessmentsRefs<T extends Object>(
    Expression<T> Function($$AssessmentsTableAnnotationComposer a) f,
  ) {
    final $$AssessmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.gradingPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> attendanceSessionsRefs<T extends Object>(
    Expression<T> Function($$AttendanceSessionsTableAnnotationComposer a) f,
  ) {
    final $$AttendanceSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.attendanceSessions,
          getReferencedColumn: (t) => t.gradingPeriodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AttendanceSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.attendanceSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> independentLearningRecordsRefs<T extends Object>(
    Expression<T> Function(
      $$IndependentLearningRecordsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$IndependentLearningRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.independentLearningRecords,
          getReferencedColumn: (t) => t.gradingPeriodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$IndependentLearningRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.independentLearningRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> termGradesRefs<T extends Object>(
    Expression<T> Function($$TermGradesTableAnnotationComposer a) f,
  ) {
    final $$TermGradesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.termGrades,
      getReferencedColumn: (t) => t.gradingPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TermGradesTableAnnotationComposer(
            $db: $db,
            $table: $db.termGrades,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> gradeRankingsRefs<T extends Object>(
    Expression<T> Function($$GradeRankingsTableAnnotationComposer a) f,
  ) {
    final $$GradeRankingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gradeRankings,
      getReferencedColumn: (t) => t.gradingPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradeRankingsTableAnnotationComposer(
            $db: $db,
            $table: $db.gradeRankings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GradingPeriodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GradingPeriodsTable,
          GradingPeriod,
          $$GradingPeriodsTableFilterComposer,
          $$GradingPeriodsTableOrderingComposer,
          $$GradingPeriodsTableAnnotationComposer,
          $$GradingPeriodsTableCreateCompanionBuilder,
          $$GradingPeriodsTableUpdateCompanionBuilder,
          (GradingPeriod, $$GradingPeriodsTableReferences),
          GradingPeriod,
          PrefetchHooks Function({
            bool assessmentsRefs,
            bool attendanceSessionsRefs,
            bool independentLearningRecordsRefs,
            bool termGradesRefs,
            bool gradeRankingsRefs,
          })
        > {
  $$GradingPeriodsTableTableManager(
    _$AppDatabase db,
    $GradingPeriodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GradingPeriodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GradingPeriodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GradingPeriodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => GradingPeriodsCompanion(
                id: id,
                name: name,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int sortOrder,
              }) => GradingPeriodsCompanion.insert(
                id: id,
                name: name,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GradingPeriodsTable, GradingPeriod>(table),
                  $$GradingPeriodsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                assessmentsRefs = false,
                attendanceSessionsRefs = false,
                independentLearningRecordsRefs = false,
                termGradesRefs = false,
                gradeRankingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (assessmentsRefs) db.assessments,
                    if (attendanceSessionsRefs) db.attendanceSessions,
                    if (independentLearningRecordsRefs)
                      db.independentLearningRecords,
                    if (termGradesRefs) db.termGrades,
                    if (gradeRankingsRefs) db.gradeRankings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (assessmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          GradingPeriod,
                          $GradingPeriodsTable,
                          Assessment,
                          $AssessmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$GradingPeriodsTableReferences
                              ._assessmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GradingPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).assessmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'grading_period_id',
                          typedResults: items,
                        ),
                      if (attendanceSessionsRefs)
                        await $_getPrefetchedDataByColumns<
                          GradingPeriod,
                          $GradingPeriodsTable,
                          AttendanceSession,
                          $AttendanceSessionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$GradingPeriodsTableReferences
                              ._attendanceSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GradingPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).attendanceSessionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'grading_period_id',
                          typedResults: items,
                        ),
                      if (independentLearningRecordsRefs)
                        await $_getPrefetchedDataByColumns<
                          GradingPeriod,
                          $GradingPeriodsTable,
                          IndependentLearningRecord,
                          $IndependentLearningRecordsTable
                        >(
                          currentTable: table,
                          referencedTable: $$GradingPeriodsTableReferences
                              ._independentLearningRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GradingPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).independentLearningRecordsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'grading_period_id',
                          typedResults: items,
                        ),
                      if (termGradesRefs)
                        await $_getPrefetchedDataByColumns<
                          GradingPeriod,
                          $GradingPeriodsTable,
                          TermGrade,
                          $TermGradesTable
                        >(
                          currentTable: table,
                          referencedTable: $$GradingPeriodsTableReferences
                              ._termGradesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GradingPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).termGradesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'grading_period_id',
                          typedResults: items,
                        ),
                      if (gradeRankingsRefs)
                        await $_getPrefetchedDataByColumns<
                          GradingPeriod,
                          $GradingPeriodsTable,
                          GradeRanking,
                          $GradeRankingsTable
                        >(
                          currentTable: table,
                          referencedTable: $$GradingPeriodsTableReferences
                              ._gradeRankingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GradingPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).gradeRankingsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'grading_period_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GradingPeriodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GradingPeriodsTable,
      GradingPeriod,
      $$GradingPeriodsTableFilterComposer,
      $$GradingPeriodsTableOrderingComposer,
      $$GradingPeriodsTableAnnotationComposer,
      $$GradingPeriodsTableCreateCompanionBuilder,
      $$GradingPeriodsTableUpdateCompanionBuilder,
      (GradingPeriod, $$GradingPeriodsTableReferences),
      GradingPeriod,
      PrefetchHooks Function({
        bool assessmentsRefs,
        bool attendanceSessionsRefs,
        bool independentLearningRecordsRefs,
        bool termGradesRefs,
        bool gradeRankingsRefs,
      })
    >;
typedef $$InstructorsTableCreateCompanionBuilder =
    InstructorsCompanion Function({
      Value<int> id,
      Value<String?> employeeNumber,
      required String firstName,
      Value<String> middleName,
      required String lastName,
      Value<String> suffix,
      Value<String?> email,
      Value<String?> contactNumber,
      Value<bool> isActive,
    });
typedef $$InstructorsTableUpdateCompanionBuilder =
    InstructorsCompanion Function({
      Value<int> id,
      Value<String?> employeeNumber,
      Value<String> firstName,
      Value<String> middleName,
      Value<String> lastName,
      Value<String> suffix,
      Value<String?> email,
      Value<String?> contactNumber,
      Value<bool> isActive,
    });

final class $$InstructorsTableReferences
    extends BaseReferences<_$AppDatabase, $InstructorsTable, Instructor> {
  $$InstructorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SubjectsTable, List<Subject>> _subjectsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.subjects,
    aliasName: 'instructors__id__subjects__instructor_id',
  );

  $$SubjectsTableProcessedTableManager get subjectsRefs {
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.instructorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_subjectsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InstructorsTableFilterComposer
    extends Composer<_$AppDatabase, $InstructorsTable> {
  $$InstructorsTableFilterComposer({
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

  ColumnFilters<String> get employeeNumber => $composableBuilder(
    column: $table.employeeNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get suffix => $composableBuilder(
    column: $table.suffix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> subjectsRefs(
    Expression<bool> Function($$SubjectsTableFilterComposer f) f,
  ) {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.instructorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstructorsTableOrderingComposer
    extends Composer<_$AppDatabase, $InstructorsTable> {
  $$InstructorsTableOrderingComposer({
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

  ColumnOrderings<String> get employeeNumber => $composableBuilder(
    column: $table.employeeNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get suffix => $composableBuilder(
    column: $table.suffix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InstructorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InstructorsTable> {
  $$InstructorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get employeeNumber => $composableBuilder(
    column: $table.employeeNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get suffix =>
      $composableBuilder(column: $table.suffix, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> subjectsRefs<T extends Object>(
    Expression<T> Function($$SubjectsTableAnnotationComposer a) f,
  ) {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.instructorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstructorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InstructorsTable,
          Instructor,
          $$InstructorsTableFilterComposer,
          $$InstructorsTableOrderingComposer,
          $$InstructorsTableAnnotationComposer,
          $$InstructorsTableCreateCompanionBuilder,
          $$InstructorsTableUpdateCompanionBuilder,
          (Instructor, $$InstructorsTableReferences),
          Instructor,
          PrefetchHooks Function({bool subjectsRefs})
        > {
  $$InstructorsTableTableManager(_$AppDatabase db, $InstructorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstructorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstructorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InstructorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> employeeNumber = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> middleName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> suffix = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> contactNumber = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => InstructorsCompanion(
                id: id,
                employeeNumber: employeeNumber,
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                suffix: suffix,
                email: email,
                contactNumber: contactNumber,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> employeeNumber = const Value.absent(),
                required String firstName,
                Value<String> middleName = const Value.absent(),
                required String lastName,
                Value<String> suffix = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> contactNumber = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => InstructorsCompanion.insert(
                id: id,
                employeeNumber: employeeNumber,
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                suffix: suffix,
                email: email,
                contactNumber: contactNumber,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InstructorsTable, Instructor>(table),
                  $$InstructorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({subjectsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (subjectsRefs) db.subjects],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (subjectsRefs)
                    await $_getPrefetchedDataByColumns<
                      Instructor,
                      $InstructorsTable,
                      Subject,
                      $SubjectsTable
                    >(
                      currentTable: table,
                      referencedTable: $$InstructorsTableReferences
                          ._subjectsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$InstructorsTableReferences(
                            db,
                            table,
                            p0,
                          ).subjectsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'instructor_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$InstructorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InstructorsTable,
      Instructor,
      $$InstructorsTableFilterComposer,
      $$InstructorsTableOrderingComposer,
      $$InstructorsTableAnnotationComposer,
      $$InstructorsTableCreateCompanionBuilder,
      $$InstructorsTableUpdateCompanionBuilder,
      (Instructor, $$InstructorsTableReferences),
      Instructor,
      PrefetchHooks Function({bool subjectsRefs})
    >;
typedef $$SectionsTableCreateCompanionBuilder = SectionsCompanion Function({
  Value<int> id,
  required String name,
  Value<String> course,
  Value<int?> yearLevel,
});
typedef $$SectionsTableUpdateCompanionBuilder = SectionsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> course,
  Value<int?> yearLevel,
});

final class $$SectionsTableReferences
    extends BaseReferences<_$AppDatabase, $SectionsTable, Section> {
  $$SectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SubjectsTable, List<Subject>> _subjectsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.subjects,
    aliasName: 'sections__id__subjects__section_id',
  );

  $$SubjectsTableProcessedTableManager get subjectsRefs {
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.sectionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_subjectsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudentsTable, List<Student>> _studentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.students,
    aliasName: 'sections__id__students__section_id',
  );

  $$StudentsTableProcessedTableManager get studentsRefs {
    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.sectionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SectionsTableFilterComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get course => $composableBuilder(
    column: $table.course,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get yearLevel => $composableBuilder(
    column: $table.yearLevel,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> subjectsRefs(
    Expression<bool> Function($$SubjectsTableFilterComposer f) f,
  ) {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studentsRefs(
    Expression<bool> Function($$StudentsTableFilterComposer f) f,
  ) {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get course => $composableBuilder(
    column: $table.course,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get yearLevel => $composableBuilder(
    column: $table.yearLevel,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get course =>
      $composableBuilder(column: $table.course, builder: (column) => column);

  GeneratedColumn<int> get yearLevel =>
      $composableBuilder(column: $table.yearLevel, builder: (column) => column);

  Expression<T> subjectsRefs<T extends Object>(
    Expression<T> Function($$SubjectsTableAnnotationComposer a) f,
  ) {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studentsRefs<T extends Object>(
    Expression<T> Function($$StudentsTableAnnotationComposer a) f,
  ) {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SectionsTable,
          Section,
          $$SectionsTableFilterComposer,
          $$SectionsTableOrderingComposer,
          $$SectionsTableAnnotationComposer,
          $$SectionsTableCreateCompanionBuilder,
          $$SectionsTableUpdateCompanionBuilder,
          (Section, $$SectionsTableReferences),
          Section,
          PrefetchHooks Function({bool subjectsRefs, bool studentsRefs})
        > {
  $$SectionsTableTableManager(_$AppDatabase db, $SectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> course = const Value.absent(),
                Value<int?> yearLevel = const Value.absent(),
              }) => SectionsCompanion(
                id: id,
                name: name,
                course: course,
                yearLevel: yearLevel,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> course = const Value.absent(),
                Value<int?> yearLevel = const Value.absent(),
              }) => SectionsCompanion.insert(
                id: id,
                name: name,
                course: course,
                yearLevel: yearLevel,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SectionsTable, Section>(table),
                  $$SectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({subjectsRefs = false, studentsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (subjectsRefs) db.subjects,
                    if (studentsRefs) db.students,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (subjectsRefs)
                        await $_getPrefetchedDataByColumns<
                          Section,
                          $SectionsTable,
                          Subject,
                          $SubjectsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SectionsTableReferences
                              ._subjectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).subjectsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'section_id',
                          typedResults: items,
                        ),
                      if (studentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Section,
                          $SectionsTable,
                          Student,
                          $StudentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SectionsTableReferences
                              ._studentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).studentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'section_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SectionsTable,
      Section,
      $$SectionsTableFilterComposer,
      $$SectionsTableOrderingComposer,
      $$SectionsTableAnnotationComposer,
      $$SectionsTableCreateCompanionBuilder,
      $$SectionsTableUpdateCompanionBuilder,
      (Section, $$SectionsTableReferences),
      Section,
      PrefetchHooks Function({bool subjectsRefs, bool studentsRefs})
    >;
typedef $$SubjectsTableCreateCompanionBuilder = SubjectsCompanion Function({
  Value<int> id,
  required String code,
  required String name,
  Value<String> description,
  required int academicYearId,
  required int semesterId,
  Value<int?> sectionId,
  Value<int?> instructorId,
  Value<double> units,
  Value<String> status,
  required String createdAt,
  required String updatedAt,
});
typedef $$SubjectsTableUpdateCompanionBuilder = SubjectsCompanion Function({
  Value<int> id,
  Value<String> code,
  Value<String> name,
  Value<String> description,
  Value<int> academicYearId,
  Value<int> semesterId,
  Value<int?> sectionId,
  Value<int?> instructorId,
  Value<double> units,
  Value<String> status,
  Value<String> createdAt,
  Value<String> updatedAt,
});

final class $$SubjectsTableReferences
    extends BaseReferences<_$AppDatabase, $SubjectsTable, Subject> {
  $$SubjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AcademicYearsTable _academicYearIdTable(_$AppDatabase db) => db
      .academicYears
      .createAlias('subjects__academic_year_id__academic_years__id');

  $$AcademicYearsTableProcessedTableManager get academicYearId {
    final $_column = $_itemColumn<int>('academic_year_id')!;

    final manager = $$AcademicYearsTableTableManager(
      $_db,
      $_db.academicYears,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_academicYearIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SemestersTable _semesterIdTable(_$AppDatabase db) =>
      db.semesters.createAlias('subjects__semester_id__semesters__id');

  $$SemestersTableProcessedTableManager get semesterId {
    final $_column = $_itemColumn<int>('semester_id')!;

    final manager = $$SemestersTableTableManager(
      $_db,
      $_db.semesters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_semesterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SectionsTable _sectionIdTable(_$AppDatabase db) =>
      db.sections.createAlias('subjects__section_id__sections__id');

  $$SectionsTableProcessedTableManager? get sectionId {
    final $_column = $_itemColumn<int>('section_id');
    if ($_column == null) return null;
    final manager = $$SectionsTableTableManager(
      $_db,
      $_db.sections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InstructorsTable _instructorIdTable(_$AppDatabase db) =>
      db.instructors.createAlias('subjects__instructor_id__instructors__id');

  $$InstructorsTableProcessedTableManager? get instructorId {
    final $_column = $_itemColumn<int>('instructor_id');
    if ($_column == null) return null;
    final manager = $$InstructorsTableTableManager(
      $_db,
      $_db.instructors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_instructorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SubjectEnrollmentsTable, List<SubjectEnrollment>>
  _subjectEnrollmentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.subjectEnrollments,
        aliasName: 'subjects__id__subject_enrollments__subject_id',
      );

  $$SubjectEnrollmentsTableProcessedTableManager get subjectEnrollmentsRefs {
    final manager = $$SubjectEnrollmentsTableTableManager(
      $_db,
      $_db.subjectEnrollments,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _subjectEnrollmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AssessmentsTable, List<Assessment>>
  _assessmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.assessments,
    aliasName: 'subjects__id__assessments__subject_id',
  );

  $$AssessmentsTableProcessedTableManager get assessmentsRefs {
    final manager = $$AssessmentsTableTableManager(
      $_db,
      $_db.assessments,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_assessmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AttendanceSessionsTable, List<AttendanceSession>>
  _attendanceSessionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.attendanceSessions,
        aliasName: 'subjects__id__attendance_sessions__subject_id',
      );

  $$AttendanceSessionsTableProcessedTableManager get attendanceSessionsRefs {
    final manager = $$AttendanceSessionsTableTableManager(
      $_db,
      $_db.attendanceSessions,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _attendanceSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $IndependentLearningRecordsTable,
    List<IndependentLearningRecord>
  >
  _independentLearningRecordsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.independentLearningRecords,
        aliasName: 'subjects__id__independent_learning_records__subject_id',
      );

  $$IndependentLearningRecordsTableProcessedTableManager
  get independentLearningRecordsRefs {
    final manager = $$IndependentLearningRecordsTableTableManager(
      $_db,
      $_db.independentLearningRecords,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _independentLearningRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $GradingConfigurationsTable,
    List<GradingConfiguration>
  >
  _gradingConfigurationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.gradingConfigurations,
        aliasName: 'subjects__id__grading_configurations__subject_id',
      );

  $$GradingConfigurationsTableProcessedTableManager
  get gradingConfigurationsRefs {
    final manager = $$GradingConfigurationsTableTableManager(
      $_db,
      $_db.gradingConfigurations,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _gradingConfigurationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TermGradesTable, List<TermGrade>>
  _termGradesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.termGrades,
    aliasName: 'subjects__id__term_grades__subject_id',
  );

  $$TermGradesTableProcessedTableManager get termGradesRefs {
    final manager = $$TermGradesTableTableManager(
      $_db,
      $_db.termGrades,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_termGradesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GradeRankingsTable, List<GradeRanking>>
  _gradeRankingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gradeRankings,
    aliasName: 'subjects__id__grade_rankings__subject_id',
  );

  $$GradeRankingsTableProcessedTableManager get gradeRankingsRefs {
    final manager = $$GradeRankingsTableTableManager(
      $_db,
      $_db.gradeRankings,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_gradeRankingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get units => $composableBuilder(
    column: $table.units,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AcademicYearsTableFilterComposer get academicYearId {
    final $$AcademicYearsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicYearId,
      referencedTable: $db.academicYears,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicYearsTableFilterComposer(
            $db: $db,
            $table: $db.academicYears,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SemestersTableFilterComposer get semesterId {
    final $$SemestersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.semesterId,
      referencedTable: $db.semesters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemestersTableFilterComposer(
            $db: $db,
            $table: $db.semesters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SectionsTableFilterComposer get sectionId {
    final $$SectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableFilterComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstructorsTableFilterComposer get instructorId {
    final $$InstructorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.instructorId,
      referencedTable: $db.instructors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstructorsTableFilterComposer(
            $db: $db,
            $table: $db.instructors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> subjectEnrollmentsRefs(
    Expression<bool> Function($$SubjectEnrollmentsTableFilterComposer f) f,
  ) {
    final $$SubjectEnrollmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjectEnrollments,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectEnrollmentsTableFilterComposer(
            $db: $db,
            $table: $db.subjectEnrollments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> assessmentsRefs(
    Expression<bool> Function($$AssessmentsTableFilterComposer f) f,
  ) {
    final $$AssessmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableFilterComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> attendanceSessionsRefs(
    Expression<bool> Function($$AttendanceSessionsTableFilterComposer f) f,
  ) {
    final $$AttendanceSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendanceSessions,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceSessionsTableFilterComposer(
            $db: $db,
            $table: $db.attendanceSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> independentLearningRecordsRefs(
    Expression<bool> Function($$IndependentLearningRecordsTableFilterComposer f)
    f,
  ) {
    final $$IndependentLearningRecordsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.independentLearningRecords,
          getReferencedColumn: (t) => t.subjectId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$IndependentLearningRecordsTableFilterComposer(
                $db: $db,
                $table: $db.independentLearningRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> gradingConfigurationsRefs(
    Expression<bool> Function($$GradingConfigurationsTableFilterComposer f) f,
  ) {
    final $$GradingConfigurationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.gradingConfigurations,
          getReferencedColumn: (t) => t.subjectId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GradingConfigurationsTableFilterComposer(
                $db: $db,
                $table: $db.gradingConfigurations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> termGradesRefs(
    Expression<bool> Function($$TermGradesTableFilterComposer f) f,
  ) {
    final $$TermGradesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.termGrades,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TermGradesTableFilterComposer(
            $db: $db,
            $table: $db.termGrades,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gradeRankingsRefs(
    Expression<bool> Function($$GradeRankingsTableFilterComposer f) f,
  ) {
    final $$GradeRankingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gradeRankings,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradeRankingsTableFilterComposer(
            $db: $db,
            $table: $db.gradeRankings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get units => $composableBuilder(
    column: $table.units,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AcademicYearsTableOrderingComposer get academicYearId {
    final $$AcademicYearsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicYearId,
      referencedTable: $db.academicYears,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicYearsTableOrderingComposer(
            $db: $db,
            $table: $db.academicYears,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SemestersTableOrderingComposer get semesterId {
    final $$SemestersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.semesterId,
      referencedTable: $db.semesters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemestersTableOrderingComposer(
            $db: $db,
            $table: $db.semesters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SectionsTableOrderingComposer get sectionId {
    final $$SectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableOrderingComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstructorsTableOrderingComposer get instructorId {
    final $$InstructorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.instructorId,
      referencedTable: $db.instructors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstructorsTableOrderingComposer(
            $db: $db,
            $table: $db.instructors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get units =>
      $composableBuilder(column: $table.units, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AcademicYearsTableAnnotationComposer get academicYearId {
    final $$AcademicYearsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicYearId,
      referencedTable: $db.academicYears,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicYearsTableAnnotationComposer(
            $db: $db,
            $table: $db.academicYears,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SemestersTableAnnotationComposer get semesterId {
    final $$SemestersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.semesterId,
      referencedTable: $db.semesters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemestersTableAnnotationComposer(
            $db: $db,
            $table: $db.semesters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SectionsTableAnnotationComposer get sectionId {
    final $$SectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstructorsTableAnnotationComposer get instructorId {
    final $$InstructorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.instructorId,
      referencedTable: $db.instructors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstructorsTableAnnotationComposer(
            $db: $db,
            $table: $db.instructors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> subjectEnrollmentsRefs<T extends Object>(
    Expression<T> Function($$SubjectEnrollmentsTableAnnotationComposer a) f,
  ) {
    final $$SubjectEnrollmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.subjectEnrollments,
          getReferencedColumn: (t) => t.subjectId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SubjectEnrollmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.subjectEnrollments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> assessmentsRefs<T extends Object>(
    Expression<T> Function($$AssessmentsTableAnnotationComposer a) f,
  ) {
    final $$AssessmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> attendanceSessionsRefs<T extends Object>(
    Expression<T> Function($$AttendanceSessionsTableAnnotationComposer a) f,
  ) {
    final $$AttendanceSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.attendanceSessions,
          getReferencedColumn: (t) => t.subjectId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AttendanceSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.attendanceSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> independentLearningRecordsRefs<T extends Object>(
    Expression<T> Function(
      $$IndependentLearningRecordsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$IndependentLearningRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.independentLearningRecords,
          getReferencedColumn: (t) => t.subjectId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$IndependentLearningRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.independentLearningRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> gradingConfigurationsRefs<T extends Object>(
    Expression<T> Function($$GradingConfigurationsTableAnnotationComposer a) f,
  ) {
    final $$GradingConfigurationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.gradingConfigurations,
          getReferencedColumn: (t) => t.subjectId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GradingConfigurationsTableAnnotationComposer(
                $db: $db,
                $table: $db.gradingConfigurations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> termGradesRefs<T extends Object>(
    Expression<T> Function($$TermGradesTableAnnotationComposer a) f,
  ) {
    final $$TermGradesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.termGrades,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TermGradesTableAnnotationComposer(
            $db: $db,
            $table: $db.termGrades,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> gradeRankingsRefs<T extends Object>(
    Expression<T> Function($$GradeRankingsTableAnnotationComposer a) f,
  ) {
    final $$GradeRankingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gradeRankings,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradeRankingsTableAnnotationComposer(
            $db: $db,
            $table: $db.gradeRankings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubjectsTable,
          Subject,
          $$SubjectsTableFilterComposer,
          $$SubjectsTableOrderingComposer,
          $$SubjectsTableAnnotationComposer,
          $$SubjectsTableCreateCompanionBuilder,
          $$SubjectsTableUpdateCompanionBuilder,
          (Subject, $$SubjectsTableReferences),
          Subject,
          PrefetchHooks Function({
            bool academicYearId,
            bool semesterId,
            bool sectionId,
            bool instructorId,
            bool subjectEnrollmentsRefs,
            bool assessmentsRefs,
            bool attendanceSessionsRefs,
            bool independentLearningRecordsRefs,
            bool gradingConfigurationsRefs,
            bool termGradesRefs,
            bool gradeRankingsRefs,
          })
        > {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> academicYearId = const Value.absent(),
                Value<int> semesterId = const Value.absent(),
                Value<int?> sectionId = const Value.absent(),
                Value<int?> instructorId = const Value.absent(),
                Value<double> units = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => SubjectsCompanion(
                id: id,
                code: code,
                name: name,
                description: description,
                academicYearId: academicYearId,
                semesterId: semesterId,
                sectionId: sectionId,
                instructorId: instructorId,
                units: units,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
                Value<String> description = const Value.absent(),
                required int academicYearId,
                required int semesterId,
                Value<int?> sectionId = const Value.absent(),
                Value<int?> instructorId = const Value.absent(),
                Value<double> units = const Value.absent(),
                Value<String> status = const Value.absent(),
                required String createdAt,
                required String updatedAt,
              }) => SubjectsCompanion.insert(
                id: id,
                code: code,
                name: name,
                description: description,
                academicYearId: academicYearId,
                semesterId: semesterId,
                sectionId: sectionId,
                instructorId: instructorId,
                units: units,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SubjectsTable, Subject>(table),
                  $$SubjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                academicYearId = false,
                semesterId = false,
                sectionId = false,
                instructorId = false,
                subjectEnrollmentsRefs = false,
                assessmentsRefs = false,
                attendanceSessionsRefs = false,
                independentLearningRecordsRefs = false,
                gradingConfigurationsRefs = false,
                termGradesRefs = false,
                gradeRankingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (subjectEnrollmentsRefs) db.subjectEnrollments,
                    if (assessmentsRefs) db.assessments,
                    if (attendanceSessionsRefs) db.attendanceSessions,
                    if (independentLearningRecordsRefs)
                      db.independentLearningRecords,
                    if (gradingConfigurationsRefs) db.gradingConfigurations,
                    if (termGradesRefs) db.termGrades,
                    if (gradeRankingsRefs) db.gradeRankings,
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
                        if (academicYearId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.academicYearId,
                            referencedTable: $$SubjectsTableReferences
                                ._academicYearIdTable(db),
                            referencedColumn: $$SubjectsTableReferences
                                ._academicYearIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (semesterId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.semesterId,
                            referencedTable: $$SubjectsTableReferences
                                ._semesterIdTable(db),
                            referencedColumn: $$SubjectsTableReferences
                                ._semesterIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (sectionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.sectionId,
                            referencedTable: $$SubjectsTableReferences
                                ._sectionIdTable(db),
                            referencedColumn: $$SubjectsTableReferences
                                ._sectionIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (instructorId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.instructorId,
                            referencedTable: $$SubjectsTableReferences
                                ._instructorIdTable(db),
                            referencedColumn: $$SubjectsTableReferences
                                ._instructorIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (subjectEnrollmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Subject,
                          $SubjectsTable,
                          SubjectEnrollment,
                          $SubjectEnrollmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._subjectEnrollmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).subjectEnrollmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'subject_id',
                          typedResults: items,
                        ),
                      if (assessmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Subject,
                          $SubjectsTable,
                          Assessment,
                          $AssessmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._assessmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).assessmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'subject_id',
                          typedResults: items,
                        ),
                      if (attendanceSessionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Subject,
                          $SubjectsTable,
                          AttendanceSession,
                          $AttendanceSessionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._attendanceSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).attendanceSessionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'subject_id',
                          typedResults: items,
                        ),
                      if (independentLearningRecordsRefs)
                        await $_getPrefetchedDataByColumns<
                          Subject,
                          $SubjectsTable,
                          IndependentLearningRecord,
                          $IndependentLearningRecordsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._independentLearningRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).independentLearningRecordsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'subject_id',
                          typedResults: items,
                        ),
                      if (gradingConfigurationsRefs)
                        await $_getPrefetchedDataByColumns<
                          Subject,
                          $SubjectsTable,
                          GradingConfiguration,
                          $GradingConfigurationsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._gradingConfigurationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).gradingConfigurationsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'subject_id',
                          typedResults: items,
                        ),
                      if (termGradesRefs)
                        await $_getPrefetchedDataByColumns<
                          Subject,
                          $SubjectsTable,
                          TermGrade,
                          $TermGradesTable
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._termGradesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).termGradesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'subject_id',
                          typedResults: items,
                        ),
                      if (gradeRankingsRefs)
                        await $_getPrefetchedDataByColumns<
                          Subject,
                          $SubjectsTable,
                          GradeRanking,
                          $GradeRankingsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._gradeRankingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).gradeRankingsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'subject_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubjectsTable,
      Subject,
      $$SubjectsTableFilterComposer,
      $$SubjectsTableOrderingComposer,
      $$SubjectsTableAnnotationComposer,
      $$SubjectsTableCreateCompanionBuilder,
      $$SubjectsTableUpdateCompanionBuilder,
      (Subject, $$SubjectsTableReferences),
      Subject,
      PrefetchHooks Function({
        bool academicYearId,
        bool semesterId,
        bool sectionId,
        bool instructorId,
        bool subjectEnrollmentsRefs,
        bool assessmentsRefs,
        bool attendanceSessionsRefs,
        bool independentLearningRecordsRefs,
        bool gradingConfigurationsRefs,
        bool termGradesRefs,
        bool gradeRankingsRefs,
      })
    >;
typedef $$StudentsTableCreateCompanionBuilder = StudentsCompanion Function({
  Value<int> id,
  required String studentNumber,
  required String firstName,
  Value<String> middleName,
  required String lastName,
  Value<String> suffix,
  Value<String?> gender,
  Value<String?> email,
  Value<String?> contactNumber,
  Value<String> course,
  Value<int?> yearLevel,
  Value<int?> sectionId,
  Value<String> status,
  required String createdAt,
  required String updatedAt,
});
typedef $$StudentsTableUpdateCompanionBuilder = StudentsCompanion Function({
  Value<int> id,
  Value<String> studentNumber,
  Value<String> firstName,
  Value<String> middleName,
  Value<String> lastName,
  Value<String> suffix,
  Value<String?> gender,
  Value<String?> email,
  Value<String?> contactNumber,
  Value<String> course,
  Value<int?> yearLevel,
  Value<int?> sectionId,
  Value<String> status,
  Value<String> createdAt,
  Value<String> updatedAt,
});

final class $$StudentsTableReferences
    extends BaseReferences<_$AppDatabase, $StudentsTable, Student> {
  $$StudentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SectionsTable _sectionIdTable(_$AppDatabase db) =>
      db.sections.createAlias('students__section_id__sections__id');

  $$SectionsTableProcessedTableManager? get sectionId {
    final $_column = $_itemColumn<int>('section_id');
    if ($_column == null) return null;
    final manager = $$SectionsTableTableManager(
      $_db,
      $_db.sections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SubjectEnrollmentsTable, List<SubjectEnrollment>>
  _subjectEnrollmentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.subjectEnrollments,
        aliasName: 'students__id__subject_enrollments__student_id',
      );

  $$SubjectEnrollmentsTableProcessedTableManager get subjectEnrollmentsRefs {
    final manager = $$SubjectEnrollmentsTableTableManager(
      $_db,
      $_db.subjectEnrollments,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _subjectEnrollmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $StudentAssessmentScoresTable,
    List<StudentAssessmentScore>
  >
  _studentAssessmentScoresRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.studentAssessmentScores,
        aliasName: 'students__id__student_assessment_scores__student_id',
      );

  $$StudentAssessmentScoresTableProcessedTableManager
  get studentAssessmentScoresRefs {
    final manager = $$StudentAssessmentScoresTableTableManager(
      $_db,
      $_db.studentAssessmentScores,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _studentAssessmentScoresRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $StudentAttendanceTable,
    List<StudentAttendanceData>
  >
  _studentAttendanceRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.studentAttendance,
        aliasName: 'students__id__student_attendance__student_id',
      );

  $$StudentAttendanceTableProcessedTableManager get studentAttendanceRefs {
    final manager = $$StudentAttendanceTableTableManager(
      $_db,
      $_db.studentAttendance,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _studentAttendanceRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $StudentIndependentLearningScoresTable,
    List<StudentIndependentLearningScore>
  >
  _studentIndependentLearningScoresRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.studentIndependentLearningScores,
        aliasName:
            'students__id__student_independent_learning_scores__student_id',
      );

  $$StudentIndependentLearningScoresTableProcessedTableManager
  get studentIndependentLearningScoresRefs {
    final manager = $$StudentIndependentLearningScoresTableTableManager(
      $_db,
      $_db.studentIndependentLearningScores,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _studentIndependentLearningScoresRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TermGradesTable, List<TermGrade>>
  _termGradesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.termGrades,
    aliasName: 'students__id__term_grades__student_id',
  );

  $$TermGradesTableProcessedTableManager get termGradesRefs {
    final manager = $$TermGradesTableTableManager(
      $_db,
      $_db.termGrades,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_termGradesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GradeRankingsTable, List<GradeRanking>>
  _gradeRankingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gradeRankings,
    aliasName: 'students__id__grade_rankings__student_id',
  );

  $$GradeRankingsTableProcessedTableManager get gradeRankingsRefs {
    final manager = $$GradeRankingsTableTableManager(
      $_db,
      $_db.gradeRankings,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_gradeRankingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudentsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
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

  ColumnFilters<String> get studentNumber => $composableBuilder(
    column: $table.studentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get suffix => $composableBuilder(
    column: $table.suffix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get course => $composableBuilder(
    column: $table.course,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get yearLevel => $composableBuilder(
    column: $table.yearLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SectionsTableFilterComposer get sectionId {
    final $$SectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableFilterComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> subjectEnrollmentsRefs(
    Expression<bool> Function($$SubjectEnrollmentsTableFilterComposer f) f,
  ) {
    final $$SubjectEnrollmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjectEnrollments,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectEnrollmentsTableFilterComposer(
            $db: $db,
            $table: $db.subjectEnrollments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studentAssessmentScoresRefs(
    Expression<bool> Function($$StudentAssessmentScoresTableFilterComposer f) f,
  ) {
    final $$StudentAssessmentScoresTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.studentAssessmentScores,
          getReferencedColumn: (t) => t.studentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StudentAssessmentScoresTableFilterComposer(
                $db: $db,
                $table: $db.studentAssessmentScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> studentAttendanceRefs(
    Expression<bool> Function($$StudentAttendanceTableFilterComposer f) f,
  ) {
    final $$StudentAttendanceTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studentAttendance,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentAttendanceTableFilterComposer(
            $db: $db,
            $table: $db.studentAttendance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studentIndependentLearningScoresRefs(
    Expression<bool> Function(
      $$StudentIndependentLearningScoresTableFilterComposer f,
    )
    f,
  ) {
    final $$StudentIndependentLearningScoresTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.studentIndependentLearningScores,
          getReferencedColumn: (t) => t.studentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StudentIndependentLearningScoresTableFilterComposer(
                $db: $db,
                $table: $db.studentIndependentLearningScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> termGradesRefs(
    Expression<bool> Function($$TermGradesTableFilterComposer f) f,
  ) {
    final $$TermGradesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.termGrades,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TermGradesTableFilterComposer(
            $db: $db,
            $table: $db.termGrades,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gradeRankingsRefs(
    Expression<bool> Function($$GradeRankingsTableFilterComposer f) f,
  ) {
    final $$GradeRankingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gradeRankings,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradeRankingsTableFilterComposer(
            $db: $db,
            $table: $db.gradeRankings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
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

  ColumnOrderings<String> get studentNumber => $composableBuilder(
    column: $table.studentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get suffix => $composableBuilder(
    column: $table.suffix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get course => $composableBuilder(
    column: $table.course,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get yearLevel => $composableBuilder(
    column: $table.yearLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SectionsTableOrderingComposer get sectionId {
    final $$SectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableOrderingComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get studentNumber => $composableBuilder(
    column: $table.studentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get suffix =>
      $composableBuilder(column: $table.suffix, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get course =>
      $composableBuilder(column: $table.course, builder: (column) => column);

  GeneratedColumn<int> get yearLevel =>
      $composableBuilder(column: $table.yearLevel, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SectionsTableAnnotationComposer get sectionId {
    final $$SectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> subjectEnrollmentsRefs<T extends Object>(
    Expression<T> Function($$SubjectEnrollmentsTableAnnotationComposer a) f,
  ) {
    final $$SubjectEnrollmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.subjectEnrollments,
          getReferencedColumn: (t) => t.studentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SubjectEnrollmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.subjectEnrollments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> studentAssessmentScoresRefs<T extends Object>(
    Expression<T> Function($$StudentAssessmentScoresTableAnnotationComposer a)
    f,
  ) {
    final $$StudentAssessmentScoresTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.studentAssessmentScores,
          getReferencedColumn: (t) => t.studentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StudentAssessmentScoresTableAnnotationComposer(
                $db: $db,
                $table: $db.studentAssessmentScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> studentAttendanceRefs<T extends Object>(
    Expression<T> Function($$StudentAttendanceTableAnnotationComposer a) f,
  ) {
    final $$StudentAttendanceTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.studentAttendance,
          getReferencedColumn: (t) => t.studentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StudentAttendanceTableAnnotationComposer(
                $db: $db,
                $table: $db.studentAttendance,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> studentIndependentLearningScoresRefs<T extends Object>(
    Expression<T> Function(
      $$StudentIndependentLearningScoresTableAnnotationComposer a,
    )
    f,
  ) {
    final $$StudentIndependentLearningScoresTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.studentIndependentLearningScores,
          getReferencedColumn: (t) => t.studentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StudentIndependentLearningScoresTableAnnotationComposer(
                $db: $db,
                $table: $db.studentIndependentLearningScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> termGradesRefs<T extends Object>(
    Expression<T> Function($$TermGradesTableAnnotationComposer a) f,
  ) {
    final $$TermGradesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.termGrades,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TermGradesTableAnnotationComposer(
            $db: $db,
            $table: $db.termGrades,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> gradeRankingsRefs<T extends Object>(
    Expression<T> Function($$GradeRankingsTableAnnotationComposer a) f,
  ) {
    final $$GradeRankingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gradeRankings,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradeRankingsTableAnnotationComposer(
            $db: $db,
            $table: $db.gradeRankings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentsTable,
          Student,
          $$StudentsTableFilterComposer,
          $$StudentsTableOrderingComposer,
          $$StudentsTableAnnotationComposer,
          $$StudentsTableCreateCompanionBuilder,
          $$StudentsTableUpdateCompanionBuilder,
          (Student, $$StudentsTableReferences),
          Student,
          PrefetchHooks Function({
            bool sectionId,
            bool subjectEnrollmentsRefs,
            bool studentAssessmentScoresRefs,
            bool studentAttendanceRefs,
            bool studentIndependentLearningScoresRefs,
            bool termGradesRefs,
            bool gradeRankingsRefs,
          })
        > {
  $$StudentsTableTableManager(_$AppDatabase db, $StudentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> studentNumber = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> middleName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> suffix = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> contactNumber = const Value.absent(),
                Value<String> course = const Value.absent(),
                Value<int?> yearLevel = const Value.absent(),
                Value<int?> sectionId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => StudentsCompanion(
                id: id,
                studentNumber: studentNumber,
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                suffix: suffix,
                gender: gender,
                email: email,
                contactNumber: contactNumber,
                course: course,
                yearLevel: yearLevel,
                sectionId: sectionId,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String studentNumber,
                required String firstName,
                Value<String> middleName = const Value.absent(),
                required String lastName,
                Value<String> suffix = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> contactNumber = const Value.absent(),
                Value<String> course = const Value.absent(),
                Value<int?> yearLevel = const Value.absent(),
                Value<int?> sectionId = const Value.absent(),
                Value<String> status = const Value.absent(),
                required String createdAt,
                required String updatedAt,
              }) => StudentsCompanion.insert(
                id: id,
                studentNumber: studentNumber,
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                suffix: suffix,
                gender: gender,
                email: email,
                contactNumber: contactNumber,
                course: course,
                yearLevel: yearLevel,
                sectionId: sectionId,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudentsTable, Student>(table),
                  $$StudentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sectionId = false,
                subjectEnrollmentsRefs = false,
                studentAssessmentScoresRefs = false,
                studentAttendanceRefs = false,
                studentIndependentLearningScoresRefs = false,
                termGradesRefs = false,
                gradeRankingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (subjectEnrollmentsRefs) db.subjectEnrollments,
                    if (studentAssessmentScoresRefs) db.studentAssessmentScores,
                    if (studentAttendanceRefs) db.studentAttendance,
                    if (studentIndependentLearningScoresRefs)
                      db.studentIndependentLearningScores,
                    if (termGradesRefs) db.termGrades,
                    if (gradeRankingsRefs) db.gradeRankings,
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
                        if (sectionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.sectionId,
                            referencedTable: $$StudentsTableReferences
                                ._sectionIdTable(db),
                            referencedColumn: $$StudentsTableReferences
                                ._sectionIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (subjectEnrollmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Student,
                          $StudentsTable,
                          SubjectEnrollment,
                          $SubjectEnrollmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._subjectEnrollmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).subjectEnrollmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'student_id',
                          typedResults: items,
                        ),
                      if (studentAssessmentScoresRefs)
                        await $_getPrefetchedDataByColumns<
                          Student,
                          $StudentsTable,
                          StudentAssessmentScore,
                          $StudentAssessmentScoresTable
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._studentAssessmentScoresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).studentAssessmentScoresRefs,
                          currentColumn: 'id',
                          referencedColumn: 'student_id',
                          typedResults: items,
                        ),
                      if (studentAttendanceRefs)
                        await $_getPrefetchedDataByColumns<
                          Student,
                          $StudentsTable,
                          StudentAttendanceData,
                          $StudentAttendanceTable
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._studentAttendanceRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).studentAttendanceRefs,
                          currentColumn: 'id',
                          referencedColumn: 'student_id',
                          typedResults: items,
                        ),
                      if (studentIndependentLearningScoresRefs)
                        await $_getPrefetchedDataByColumns<
                          Student,
                          $StudentsTable,
                          StudentIndependentLearningScore,
                          $StudentIndependentLearningScoresTable
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._studentIndependentLearningScoresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).studentIndependentLearningScoresRefs,
                          currentColumn: 'id',
                          referencedColumn: 'student_id',
                          typedResults: items,
                        ),
                      if (termGradesRefs)
                        await $_getPrefetchedDataByColumns<
                          Student,
                          $StudentsTable,
                          TermGrade,
                          $TermGradesTable
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._termGradesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).termGradesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'student_id',
                          typedResults: items,
                        ),
                      if (gradeRankingsRefs)
                        await $_getPrefetchedDataByColumns<
                          Student,
                          $StudentsTable,
                          GradeRanking,
                          $GradeRankingsTable
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._gradeRankingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).gradeRankingsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'student_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StudentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentsTable,
      Student,
      $$StudentsTableFilterComposer,
      $$StudentsTableOrderingComposer,
      $$StudentsTableAnnotationComposer,
      $$StudentsTableCreateCompanionBuilder,
      $$StudentsTableUpdateCompanionBuilder,
      (Student, $$StudentsTableReferences),
      Student,
      PrefetchHooks Function({
        bool sectionId,
        bool subjectEnrollmentsRefs,
        bool studentAssessmentScoresRefs,
        bool studentAttendanceRefs,
        bool studentIndependentLearningScoresRefs,
        bool termGradesRefs,
        bool gradeRankingsRefs,
      })
    >;
typedef $$SubjectEnrollmentsTableCreateCompanionBuilder =
    SubjectEnrollmentsCompanion Function({
      Value<int> id,
      required int subjectId,
      required int studentId,
      required String enrolledAt,
      Value<String> status,
    });
typedef $$SubjectEnrollmentsTableUpdateCompanionBuilder =
    SubjectEnrollmentsCompanion Function({
      Value<int> id,
      Value<int> subjectId,
      Value<int> studentId,
      Value<String> enrolledAt,
      Value<String> status,
    });

final class $$SubjectEnrollmentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SubjectEnrollmentsTable,
          SubjectEnrollment
        > {
  $$SubjectEnrollmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('subject_enrollments__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias('subject_enrollments__student_id__students__id');

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SubjectEnrollmentsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectEnrollmentsTable> {
  $$SubjectEnrollmentsTableFilterComposer({
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

  ColumnFilters<String> get enrolledAt => $composableBuilder(
    column: $table.enrolledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubjectEnrollmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectEnrollmentsTable> {
  $$SubjectEnrollmentsTableOrderingComposer({
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

  ColumnOrderings<String> get enrolledAt => $composableBuilder(
    column: $table.enrolledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubjectEnrollmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectEnrollmentsTable> {
  $$SubjectEnrollmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get enrolledAt => $composableBuilder(
    column: $table.enrolledAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubjectEnrollmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubjectEnrollmentsTable,
          SubjectEnrollment,
          $$SubjectEnrollmentsTableFilterComposer,
          $$SubjectEnrollmentsTableOrderingComposer,
          $$SubjectEnrollmentsTableAnnotationComposer,
          $$SubjectEnrollmentsTableCreateCompanionBuilder,
          $$SubjectEnrollmentsTableUpdateCompanionBuilder,
          (SubjectEnrollment, $$SubjectEnrollmentsTableReferences),
          SubjectEnrollment,
          PrefetchHooks Function({bool subjectId, bool studentId})
        > {
  $$SubjectEnrollmentsTableTableManager(
    _$AppDatabase db,
    $SubjectEnrollmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectEnrollmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectEnrollmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectEnrollmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<String> enrolledAt = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => SubjectEnrollmentsCompanion(
                id: id,
                subjectId: subjectId,
                studentId: studentId,
                enrolledAt: enrolledAt,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subjectId,
                required int studentId,
                required String enrolledAt,
                Value<String> status = const Value.absent(),
              }) => SubjectEnrollmentsCompanion.insert(
                id: id,
                subjectId: subjectId,
                studentId: studentId,
                enrolledAt: enrolledAt,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SubjectEnrollmentsTable, SubjectEnrollment>(
                    table,
                  ),
                  $$SubjectEnrollmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({subjectId = false, studentId = false}) {
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
                    if (subjectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.subjectId,
                        referencedTable: $$SubjectEnrollmentsTableReferences
                            ._subjectIdTable(db),
                        referencedColumn: $$SubjectEnrollmentsTableReferences
                            ._subjectIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (studentId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.studentId,
                        referencedTable: $$SubjectEnrollmentsTableReferences
                            ._studentIdTable(db),
                        referencedColumn: $$SubjectEnrollmentsTableReferences
                            ._studentIdTable(db)
                            .id,
                      ) as T;
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

typedef $$SubjectEnrollmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubjectEnrollmentsTable,
      SubjectEnrollment,
      $$SubjectEnrollmentsTableFilterComposer,
      $$SubjectEnrollmentsTableOrderingComposer,
      $$SubjectEnrollmentsTableAnnotationComposer,
      $$SubjectEnrollmentsTableCreateCompanionBuilder,
      $$SubjectEnrollmentsTableUpdateCompanionBuilder,
      (SubjectEnrollment, $$SubjectEnrollmentsTableReferences),
      SubjectEnrollment,
      PrefetchHooks Function({bool subjectId, bool studentId})
    >;
typedef $$AssessmentsTableCreateCompanionBuilder =
    AssessmentsCompanion Function({
      Value<int> id,
      required int subjectId,
      required int gradingPeriodId,
      required String name,
      required String type,
      Value<String?> date,
      required double totalPossibleScore,
      Value<int> sortOrder,
      required String createdAt,
    });
typedef $$AssessmentsTableUpdateCompanionBuilder =
    AssessmentsCompanion Function({
      Value<int> id,
      Value<int> subjectId,
      Value<int> gradingPeriodId,
      Value<String> name,
      Value<String> type,
      Value<String?> date,
      Value<double> totalPossibleScore,
      Value<int> sortOrder,
      Value<String> createdAt,
    });

final class $$AssessmentsTableReferences
    extends BaseReferences<_$AppDatabase, $AssessmentsTable, Assessment> {
  $$AssessmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('assessments__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GradingPeriodsTable _gradingPeriodIdTable(_$AppDatabase db) => db
      .gradingPeriods
      .createAlias('assessments__grading_period_id__grading_periods__id');

  $$GradingPeriodsTableProcessedTableManager get gradingPeriodId {
    final $_column = $_itemColumn<int>('grading_period_id')!;

    final manager = $$GradingPeriodsTableTableManager(
      $_db,
      $_db.gradingPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gradingPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $StudentAssessmentScoresTable,
    List<StudentAssessmentScore>
  >
  _studentAssessmentScoresRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.studentAssessmentScores,
        aliasName: 'assessments__id__student_assessment_scores__assessment_id',
      );

  $$StudentAssessmentScoresTableProcessedTableManager
  get studentAssessmentScoresRefs {
    final manager = $$StudentAssessmentScoresTableTableManager(
      $_db,
      $_db.studentAssessmentScores,
    ).filter((f) => f.assessmentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _studentAssessmentScoresRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AssessmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AssessmentsTable> {
  $$AssessmentsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPossibleScore => $composableBuilder(
    column: $table.totalPossibleScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableFilterComposer get gradingPeriodId {
    final $$GradingPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> studentAssessmentScoresRefs(
    Expression<bool> Function($$StudentAssessmentScoresTableFilterComposer f) f,
  ) {
    final $$StudentAssessmentScoresTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.studentAssessmentScores,
          getReferencedColumn: (t) => t.assessmentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StudentAssessmentScoresTableFilterComposer(
                $db: $db,
                $table: $db.studentAssessmentScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AssessmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssessmentsTable> {
  $$AssessmentsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPossibleScore => $composableBuilder(
    column: $table.totalPossibleScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableOrderingComposer get gradingPeriodId {
    final $$GradingPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AssessmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssessmentsTable> {
  $$AssessmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get totalPossibleScore => $composableBuilder(
    column: $table.totalPossibleScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableAnnotationComposer get gradingPeriodId {
    final $$GradingPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> studentAssessmentScoresRefs<T extends Object>(
    Expression<T> Function($$StudentAssessmentScoresTableAnnotationComposer a)
    f,
  ) {
    final $$StudentAssessmentScoresTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.studentAssessmentScores,
          getReferencedColumn: (t) => t.assessmentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StudentAssessmentScoresTableAnnotationComposer(
                $db: $db,
                $table: $db.studentAssessmentScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AssessmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssessmentsTable,
          Assessment,
          $$AssessmentsTableFilterComposer,
          $$AssessmentsTableOrderingComposer,
          $$AssessmentsTableAnnotationComposer,
          $$AssessmentsTableCreateCompanionBuilder,
          $$AssessmentsTableUpdateCompanionBuilder,
          (Assessment, $$AssessmentsTableReferences),
          Assessment,
          PrefetchHooks Function({
            bool subjectId,
            bool gradingPeriodId,
            bool studentAssessmentScoresRefs,
          })
        > {
  $$AssessmentsTableTableManager(_$AppDatabase db, $AssessmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssessmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssessmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssessmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<int> gradingPeriodId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> date = const Value.absent(),
                Value<double> totalPossibleScore = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
              }) => AssessmentsCompanion(
                id: id,
                subjectId: subjectId,
                gradingPeriodId: gradingPeriodId,
                name: name,
                type: type,
                date: date,
                totalPossibleScore: totalPossibleScore,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subjectId,
                required int gradingPeriodId,
                required String name,
                required String type,
                Value<String?> date = const Value.absent(),
                required double totalPossibleScore,
                Value<int> sortOrder = const Value.absent(),
                required String createdAt,
              }) => AssessmentsCompanion.insert(
                id: id,
                subjectId: subjectId,
                gradingPeriodId: gradingPeriodId,
                name: name,
                type: type,
                date: date,
                totalPossibleScore: totalPossibleScore,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AssessmentsTable, Assessment>(table),
                  $$AssessmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                subjectId = false,
                gradingPeriodId = false,
                studentAssessmentScoresRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (studentAssessmentScoresRefs) db.studentAssessmentScores,
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
                        if (subjectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$AssessmentsTableReferences
                                ._subjectIdTable(db),
                            referencedColumn: $$AssessmentsTableReferences
                                ._subjectIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (gradingPeriodId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gradingPeriodId,
                            referencedTable: $$AssessmentsTableReferences
                                ._gradingPeriodIdTable(db),
                            referencedColumn: $$AssessmentsTableReferences
                                ._gradingPeriodIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (studentAssessmentScoresRefs)
                        await $_getPrefetchedDataByColumns<
                          Assessment,
                          $AssessmentsTable,
                          StudentAssessmentScore,
                          $StudentAssessmentScoresTable
                        >(
                          currentTable: table,
                          referencedTable: $$AssessmentsTableReferences
                              ._studentAssessmentScoresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AssessmentsTableReferences(
                                db,
                                table,
                                p0,
                              ).studentAssessmentScoresRefs,
                          currentColumn: 'id',
                          referencedColumn: 'assessment_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AssessmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssessmentsTable,
      Assessment,
      $$AssessmentsTableFilterComposer,
      $$AssessmentsTableOrderingComposer,
      $$AssessmentsTableAnnotationComposer,
      $$AssessmentsTableCreateCompanionBuilder,
      $$AssessmentsTableUpdateCompanionBuilder,
      (Assessment, $$AssessmentsTableReferences),
      Assessment,
      PrefetchHooks Function({
        bool subjectId,
        bool gradingPeriodId,
        bool studentAssessmentScoresRefs,
      })
    >;
typedef $$StudentAssessmentScoresTableCreateCompanionBuilder =
    StudentAssessmentScoresCompanion Function({
      Value<int> id,
      required int assessmentId,
      required int studentId,
      Value<double?> score,
      Value<String?> updatedAt,
    });
typedef $$StudentAssessmentScoresTableUpdateCompanionBuilder =
    StudentAssessmentScoresCompanion Function({
      Value<int> id,
      Value<int> assessmentId,
      Value<int> studentId,
      Value<double?> score,
      Value<String?> updatedAt,
    });

final class $$StudentAssessmentScoresTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $StudentAssessmentScoresTable,
          StudentAssessmentScore
        > {
  $$StudentAssessmentScoresTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AssessmentsTable _assessmentIdTable(_$AppDatabase db) => db
      .assessments
      .createAlias('student_assessment_scores__assessment_id__assessments__id');

  $$AssessmentsTableProcessedTableManager get assessmentId {
    final $_column = $_itemColumn<int>('assessment_id')!;

    final manager = $$AssessmentsTableTableManager(
      $_db,
      $_db.assessments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assessmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudentsTable _studentIdTable(_$AppDatabase db) => db.students
      .createAlias('student_assessment_scores__student_id__students__id');

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudentAssessmentScoresTableFilterComposer
    extends Composer<_$AppDatabase, $StudentAssessmentScoresTable> {
  $$StudentAssessmentScoresTableFilterComposer({
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

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AssessmentsTableFilterComposer get assessmentId {
    final $$AssessmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assessmentId,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableFilterComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentAssessmentScoresTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentAssessmentScoresTable> {
  $$StudentAssessmentScoresTableOrderingComposer({
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

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AssessmentsTableOrderingComposer get assessmentId {
    final $$AssessmentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assessmentId,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableOrderingComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentAssessmentScoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentAssessmentScoresTable> {
  $$StudentAssessmentScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AssessmentsTableAnnotationComposer get assessmentId {
    final $$AssessmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assessmentId,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentAssessmentScoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentAssessmentScoresTable,
          StudentAssessmentScore,
          $$StudentAssessmentScoresTableFilterComposer,
          $$StudentAssessmentScoresTableOrderingComposer,
          $$StudentAssessmentScoresTableAnnotationComposer,
          $$StudentAssessmentScoresTableCreateCompanionBuilder,
          $$StudentAssessmentScoresTableUpdateCompanionBuilder,
          (StudentAssessmentScore, $$StudentAssessmentScoresTableReferences),
          StudentAssessmentScore,
          PrefetchHooks Function({bool assessmentId, bool studentId})
        > {
  $$StudentAssessmentScoresTableTableManager(
    _$AppDatabase db,
    $StudentAssessmentScoresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentAssessmentScoresTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$StudentAssessmentScoresTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudentAssessmentScoresTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> assessmentId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<double?> score = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => StudentAssessmentScoresCompanion(
                id: id,
                assessmentId: assessmentId,
                studentId: studentId,
                score: score,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int assessmentId,
                required int studentId,
                Value<double?> score = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => StudentAssessmentScoresCompanion.insert(
                id: id,
                assessmentId: assessmentId,
                studentId: studentId,
                score: score,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $StudentAssessmentScoresTable,
                    StudentAssessmentScore
                  >(table),
                  $$StudentAssessmentScoresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({assessmentId = false, studentId = false}) {
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
                    if (assessmentId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.assessmentId,
                        referencedTable:
                            $$StudentAssessmentScoresTableReferences
                                ._assessmentIdTable(db),
                        referencedColumn:
                            $$StudentAssessmentScoresTableReferences
                                ._assessmentIdTable(db)
                                .id,
                      ) as T;
                    }
                    if (studentId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.studentId,
                        referencedTable:
                            $$StudentAssessmentScoresTableReferences
                                ._studentIdTable(db),
                        referencedColumn:
                            $$StudentAssessmentScoresTableReferences
                                ._studentIdTable(db)
                                .id,
                      ) as T;
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

typedef $$StudentAssessmentScoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentAssessmentScoresTable,
      StudentAssessmentScore,
      $$StudentAssessmentScoresTableFilterComposer,
      $$StudentAssessmentScoresTableOrderingComposer,
      $$StudentAssessmentScoresTableAnnotationComposer,
      $$StudentAssessmentScoresTableCreateCompanionBuilder,
      $$StudentAssessmentScoresTableUpdateCompanionBuilder,
      (StudentAssessmentScore, $$StudentAssessmentScoresTableReferences),
      StudentAssessmentScore,
      PrefetchHooks Function({bool assessmentId, bool studentId})
    >;
typedef $$AttendanceSessionsTableCreateCompanionBuilder =
    AttendanceSessionsCompanion Function({
      Value<int> id,
      required int subjectId,
      required int gradingPeriodId,
      required String sessionDate,
      Value<String> name,
      Value<int> sortOrder,
    });
typedef $$AttendanceSessionsTableUpdateCompanionBuilder =
    AttendanceSessionsCompanion Function({
      Value<int> id,
      Value<int> subjectId,
      Value<int> gradingPeriodId,
      Value<String> sessionDate,
      Value<String> name,
      Value<int> sortOrder,
    });

final class $$AttendanceSessionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AttendanceSessionsTable,
          AttendanceSession
        > {
  $$AttendanceSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('attendance_sessions__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GradingPeriodsTable _gradingPeriodIdTable(_$AppDatabase db) =>
      db.gradingPeriods.createAlias(
        'attendance_sessions__grading_period_id__grading_periods__id',
      );

  $$GradingPeriodsTableProcessedTableManager get gradingPeriodId {
    final $_column = $_itemColumn<int>('grading_period_id')!;

    final manager = $$GradingPeriodsTableTableManager(
      $_db,
      $_db.gradingPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gradingPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $StudentAttendanceTable,
    List<StudentAttendanceData>
  >
  _studentAttendanceRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.studentAttendance,
    aliasName:
        'attendance_sessions__id__student_attendance__attendance_session_id',
  );

  $$StudentAttendanceTableProcessedTableManager get studentAttendanceRefs {
    final manager =
        $$StudentAttendanceTableTableManager(
          $_db,
          $_db.studentAttendance,
        ).filter(
          (f) => f.attendanceSessionId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _studentAttendanceRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AttendanceSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceSessionsTable> {
  $$AttendanceSessionsTableFilterComposer({
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

  ColumnFilters<String> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableFilterComposer get gradingPeriodId {
    final $$GradingPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> studentAttendanceRefs(
    Expression<bool> Function($$StudentAttendanceTableFilterComposer f) f,
  ) {
    final $$StudentAttendanceTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studentAttendance,
      getReferencedColumn: (t) => t.attendanceSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentAttendanceTableFilterComposer(
            $db: $db,
            $table: $db.studentAttendance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AttendanceSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceSessionsTable> {
  $$AttendanceSessionsTableOrderingComposer({
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

  ColumnOrderings<String> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableOrderingComposer get gradingPeriodId {
    final $$GradingPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceSessionsTable> {
  $$AttendanceSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableAnnotationComposer get gradingPeriodId {
    final $$GradingPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> studentAttendanceRefs<T extends Object>(
    Expression<T> Function($$StudentAttendanceTableAnnotationComposer a) f,
  ) {
    final $$StudentAttendanceTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.studentAttendance,
          getReferencedColumn: (t) => t.attendanceSessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StudentAttendanceTableAnnotationComposer(
                $db: $db,
                $table: $db.studentAttendance,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AttendanceSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceSessionsTable,
          AttendanceSession,
          $$AttendanceSessionsTableFilterComposer,
          $$AttendanceSessionsTableOrderingComposer,
          $$AttendanceSessionsTableAnnotationComposer,
          $$AttendanceSessionsTableCreateCompanionBuilder,
          $$AttendanceSessionsTableUpdateCompanionBuilder,
          (AttendanceSession, $$AttendanceSessionsTableReferences),
          AttendanceSession,
          PrefetchHooks Function({
            bool subjectId,
            bool gradingPeriodId,
            bool studentAttendanceRefs,
          })
        > {
  $$AttendanceSessionsTableTableManager(
    _$AppDatabase db,
    $AttendanceSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceSessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<int> gradingPeriodId = const Value.absent(),
                Value<String> sessionDate = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => AttendanceSessionsCompanion(
                id: id,
                subjectId: subjectId,
                gradingPeriodId: gradingPeriodId,
                sessionDate: sessionDate,
                name: name,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subjectId,
                required int gradingPeriodId,
                required String sessionDate,
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => AttendanceSessionsCompanion.insert(
                id: id,
                subjectId: subjectId,
                gradingPeriodId: gradingPeriodId,
                sessionDate: sessionDate,
                name: name,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AttendanceSessionsTable, AttendanceSession>(
                    table,
                  ),
                  $$AttendanceSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                subjectId = false,
                gradingPeriodId = false,
                studentAttendanceRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (studentAttendanceRefs) db.studentAttendance,
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
                        if (subjectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$AttendanceSessionsTableReferences
                                ._subjectIdTable(db),
                            referencedColumn:
                                $$AttendanceSessionsTableReferences
                                    ._subjectIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (gradingPeriodId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gradingPeriodId,
                            referencedTable: $$AttendanceSessionsTableReferences
                                ._gradingPeriodIdTable(db),
                            referencedColumn:
                                $$AttendanceSessionsTableReferences
                                    ._gradingPeriodIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (studentAttendanceRefs)
                        await $_getPrefetchedDataByColumns<
                          AttendanceSession,
                          $AttendanceSessionsTable,
                          StudentAttendanceData,
                          $StudentAttendanceTable
                        >(
                          currentTable: table,
                          referencedTable: $$AttendanceSessionsTableReferences
                              ._studentAttendanceRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AttendanceSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).studentAttendanceRefs,
                          currentColumn: 'id',
                          referencedColumn: 'attendance_session_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AttendanceSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceSessionsTable,
      AttendanceSession,
      $$AttendanceSessionsTableFilterComposer,
      $$AttendanceSessionsTableOrderingComposer,
      $$AttendanceSessionsTableAnnotationComposer,
      $$AttendanceSessionsTableCreateCompanionBuilder,
      $$AttendanceSessionsTableUpdateCompanionBuilder,
      (AttendanceSession, $$AttendanceSessionsTableReferences),
      AttendanceSession,
      PrefetchHooks Function({
        bool subjectId,
        bool gradingPeriodId,
        bool studentAttendanceRefs,
      })
    >;
typedef $$StudentAttendanceTableCreateCompanionBuilder =
    StudentAttendanceCompanion Function({
      Value<int> id,
      required int attendanceSessionId,
      required int studentId,
      required String code,
      Value<String?> updatedAt,
    });
typedef $$StudentAttendanceTableUpdateCompanionBuilder =
    StudentAttendanceCompanion Function({
      Value<int> id,
      Value<int> attendanceSessionId,
      Value<int> studentId,
      Value<String> code,
      Value<String?> updatedAt,
    });

final class $$StudentAttendanceTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $StudentAttendanceTable,
          StudentAttendanceData
        > {
  $$StudentAttendanceTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AttendanceSessionsTable _attendanceSessionIdTable(_$AppDatabase db) =>
      db.attendanceSessions.createAlias(
        'student_attendance__attendance_session_id__attendance_sessions__id',
      );

  $$AttendanceSessionsTableProcessedTableManager get attendanceSessionId {
    final $_column = $_itemColumn<int>('attendance_session_id')!;

    final manager = $$AttendanceSessionsTableTableManager(
      $_db,
      $_db.attendanceSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_attendanceSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias('student_attendance__student_id__students__id');

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudentAttendanceTableFilterComposer
    extends Composer<_$AppDatabase, $StudentAttendanceTable> {
  $$StudentAttendanceTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AttendanceSessionsTableFilterComposer get attendanceSessionId {
    final $$AttendanceSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attendanceSessionId,
      referencedTable: $db.attendanceSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceSessionsTableFilterComposer(
            $db: $db,
            $table: $db.attendanceSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentAttendanceTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentAttendanceTable> {
  $$StudentAttendanceTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AttendanceSessionsTableOrderingComposer get attendanceSessionId {
    final $$AttendanceSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attendanceSessionId,
      referencedTable: $db.attendanceSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.attendanceSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentAttendanceTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentAttendanceTable> {
  $$StudentAttendanceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AttendanceSessionsTableAnnotationComposer get attendanceSessionId {
    final $$AttendanceSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.attendanceSessionId,
          referencedTable: $db.attendanceSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AttendanceSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.attendanceSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentAttendanceTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentAttendanceTable,
          StudentAttendanceData,
          $$StudentAttendanceTableFilterComposer,
          $$StudentAttendanceTableOrderingComposer,
          $$StudentAttendanceTableAnnotationComposer,
          $$StudentAttendanceTableCreateCompanionBuilder,
          $$StudentAttendanceTableUpdateCompanionBuilder,
          (StudentAttendanceData, $$StudentAttendanceTableReferences),
          StudentAttendanceData,
          PrefetchHooks Function({bool attendanceSessionId, bool studentId})
        > {
  $$StudentAttendanceTableTableManager(
    _$AppDatabase db,
    $StudentAttendanceTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentAttendanceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentAttendanceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentAttendanceTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> attendanceSessionId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => StudentAttendanceCompanion(
                id: id,
                attendanceSessionId: attendanceSessionId,
                studentId: studentId,
                code: code,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int attendanceSessionId,
                required int studentId,
                required String code,
                Value<String?> updatedAt = const Value.absent(),
              }) => StudentAttendanceCompanion.insert(
                id: id,
                attendanceSessionId: attendanceSessionId,
                studentId: studentId,
                code: code,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudentAttendanceTable, StudentAttendanceData>(
                    table,
                  ),
                  $$StudentAttendanceTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({attendanceSessionId = false, studentId = false}) {
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
                        if (attendanceSessionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.attendanceSessionId,
                            referencedTable: $$StudentAttendanceTableReferences
                                ._attendanceSessionIdTable(db),
                            referencedColumn: $$StudentAttendanceTableReferences
                                ._attendanceSessionIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (studentId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.studentId,
                            referencedTable: $$StudentAttendanceTableReferences
                                ._studentIdTable(db),
                            referencedColumn: $$StudentAttendanceTableReferences
                                ._studentIdTable(db)
                                .id,
                          ) as T;
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

typedef $$StudentAttendanceTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentAttendanceTable,
      StudentAttendanceData,
      $$StudentAttendanceTableFilterComposer,
      $$StudentAttendanceTableOrderingComposer,
      $$StudentAttendanceTableAnnotationComposer,
      $$StudentAttendanceTableCreateCompanionBuilder,
      $$StudentAttendanceTableUpdateCompanionBuilder,
      (StudentAttendanceData, $$StudentAttendanceTableReferences),
      StudentAttendanceData,
      PrefetchHooks Function({bool attendanceSessionId, bool studentId})
    >;
typedef $$IndependentLearningRecordsTableCreateCompanionBuilder =
    IndependentLearningRecordsCompanion Function({
      Value<int> id,
      required int subjectId,
      required int gradingPeriodId,
      required String activityName,
      Value<String> description,
      Value<String?> activityDate,
      required double totalPossibleScore,
      Value<String> remarks,
      required String createdAt,
    });
typedef $$IndependentLearningRecordsTableUpdateCompanionBuilder =
    IndependentLearningRecordsCompanion Function({
      Value<int> id,
      Value<int> subjectId,
      Value<int> gradingPeriodId,
      Value<String> activityName,
      Value<String> description,
      Value<String?> activityDate,
      Value<double> totalPossibleScore,
      Value<String> remarks,
      Value<String> createdAt,
    });

final class $$IndependentLearningRecordsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $IndependentLearningRecordsTable,
          IndependentLearningRecord
        > {
  $$IndependentLearningRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) => db.subjects
      .createAlias('independent_learning_records__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GradingPeriodsTable _gradingPeriodIdTable(_$AppDatabase db) =>
      db.gradingPeriods.createAlias(
        'independent_learning_records__grading_period_id__grading_periods__id',
      );

  $$GradingPeriodsTableProcessedTableManager get gradingPeriodId {
    final $_column = $_itemColumn<int>('grading_period_id')!;

    final manager = $$GradingPeriodsTableTableManager(
      $_db,
      $_db.gradingPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gradingPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $StudentIndependentLearningScoresTable,
    List<StudentIndependentLearningScore>
  >
  _studentIndependentLearningScoresRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.studentIndependentLearningScores,
        aliasName: 'independent_learning_records__id__student_independent_learning_scores__record_id',
      );

  $$StudentIndependentLearningScoresTableProcessedTableManager
  get studentIndependentLearningScoresRefs {
    final manager = $$StudentIndependentLearningScoresTableTableManager(
      $_db,
      $_db.studentIndependentLearningScores,
    ).filter((f) => f.recordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _studentIndependentLearningScoresRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$IndependentLearningRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $IndependentLearningRecordsTable> {
  $$IndependentLearningRecordsTableFilterComposer({
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

  ColumnFilters<String> get activityName => $composableBuilder(
    column: $table.activityName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityDate => $composableBuilder(
    column: $table.activityDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPossibleScore => $composableBuilder(
    column: $table.totalPossibleScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableFilterComposer get gradingPeriodId {
    final $$GradingPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> studentIndependentLearningScoresRefs(
    Expression<bool> Function(
      $$StudentIndependentLearningScoresTableFilterComposer f,
    )
    f,
  ) {
    final $$StudentIndependentLearningScoresTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.studentIndependentLearningScores,
          getReferencedColumn: (t) => t.recordId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StudentIndependentLearningScoresTableFilterComposer(
                $db: $db,
                $table: $db.studentIndependentLearningScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$IndependentLearningRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $IndependentLearningRecordsTable> {
  $$IndependentLearningRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get activityName => $composableBuilder(
    column: $table.activityName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityDate => $composableBuilder(
    column: $table.activityDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPossibleScore => $composableBuilder(
    column: $table.totalPossibleScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableOrderingComposer get gradingPeriodId {
    final $$GradingPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IndependentLearningRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IndependentLearningRecordsTable> {
  $$IndependentLearningRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get activityName => $composableBuilder(
    column: $table.activityName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityDate => $composableBuilder(
    column: $table.activityDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalPossibleScore => $composableBuilder(
    column: $table.totalPossibleScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableAnnotationComposer get gradingPeriodId {
    final $$GradingPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> studentIndependentLearningScoresRefs<T extends Object>(
    Expression<T> Function(
      $$StudentIndependentLearningScoresTableAnnotationComposer a,
    )
    f,
  ) {
    final $$StudentIndependentLearningScoresTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.studentIndependentLearningScores,
          getReferencedColumn: (t) => t.recordId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StudentIndependentLearningScoresTableAnnotationComposer(
                $db: $db,
                $table: $db.studentIndependentLearningScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$IndependentLearningRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IndependentLearningRecordsTable,
          IndependentLearningRecord,
          $$IndependentLearningRecordsTableFilterComposer,
          $$IndependentLearningRecordsTableOrderingComposer,
          $$IndependentLearningRecordsTableAnnotationComposer,
          $$IndependentLearningRecordsTableCreateCompanionBuilder,
          $$IndependentLearningRecordsTableUpdateCompanionBuilder,
          (
            IndependentLearningRecord,
            $$IndependentLearningRecordsTableReferences,
          ),
          IndependentLearningRecord,
          PrefetchHooks Function({
            bool subjectId,
            bool gradingPeriodId,
            bool studentIndependentLearningScoresRefs,
          })
        > {
  $$IndependentLearningRecordsTableTableManager(
    _$AppDatabase db,
    $IndependentLearningRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IndependentLearningRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$IndependentLearningRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$IndependentLearningRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<int> gradingPeriodId = const Value.absent(),
                Value<String> activityName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> activityDate = const Value.absent(),
                Value<double> totalPossibleScore = const Value.absent(),
                Value<String> remarks = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
              }) => IndependentLearningRecordsCompanion(
                id: id,
                subjectId: subjectId,
                gradingPeriodId: gradingPeriodId,
                activityName: activityName,
                description: description,
                activityDate: activityDate,
                totalPossibleScore: totalPossibleScore,
                remarks: remarks,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subjectId,
                required int gradingPeriodId,
                required String activityName,
                Value<String> description = const Value.absent(),
                Value<String?> activityDate = const Value.absent(),
                required double totalPossibleScore,
                Value<String> remarks = const Value.absent(),
                required String createdAt,
              }) => IndependentLearningRecordsCompanion.insert(
                id: id,
                subjectId: subjectId,
                gradingPeriodId: gradingPeriodId,
                activityName: activityName,
                description: description,
                activityDate: activityDate,
                totalPossibleScore: totalPossibleScore,
                remarks: remarks,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $IndependentLearningRecordsTable,
                    IndependentLearningRecord
                  >(table),
                  $$IndependentLearningRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                subjectId = false,
                gradingPeriodId = false,
                studentIndependentLearningScoresRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (studentIndependentLearningScoresRefs)
                      db.studentIndependentLearningScores,
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
                        if (subjectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable:
                                $$IndependentLearningRecordsTableReferences
                                    ._subjectIdTable(db),
                            referencedColumn:
                                $$IndependentLearningRecordsTableReferences
                                    ._subjectIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (gradingPeriodId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gradingPeriodId,
                            referencedTable:
                                $$IndependentLearningRecordsTableReferences
                                    ._gradingPeriodIdTable(db),
                            referencedColumn:
                                $$IndependentLearningRecordsTableReferences
                                    ._gradingPeriodIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (studentIndependentLearningScoresRefs)
                        await $_getPrefetchedDataByColumns<
                          IndependentLearningRecord,
                          $IndependentLearningRecordsTable,
                          StudentIndependentLearningScore,
                          $StudentIndependentLearningScoresTable
                        >(
                          currentTable: table,
                          referencedTable:
                              $$IndependentLearningRecordsTableReferences
                                  ._studentIndependentLearningScoresRefsTable(
                                    db,
                                  ),
                          managerFromTypedResult: (p0) =>
                              $$IndependentLearningRecordsTableReferences(
                                db,
                                table,
                                p0,
                              ).studentIndependentLearningScoresRefs,
                          currentColumn: 'id',
                          referencedColumn: 'record_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$IndependentLearningRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IndependentLearningRecordsTable,
      IndependentLearningRecord,
      $$IndependentLearningRecordsTableFilterComposer,
      $$IndependentLearningRecordsTableOrderingComposer,
      $$IndependentLearningRecordsTableAnnotationComposer,
      $$IndependentLearningRecordsTableCreateCompanionBuilder,
      $$IndependentLearningRecordsTableUpdateCompanionBuilder,
      (IndependentLearningRecord, $$IndependentLearningRecordsTableReferences),
      IndependentLearningRecord,
      PrefetchHooks Function({
        bool subjectId,
        bool gradingPeriodId,
        bool studentIndependentLearningScoresRefs,
      })
    >;
typedef $$StudentIndependentLearningScoresTableCreateCompanionBuilder =
    StudentIndependentLearningScoresCompanion Function({
      Value<int> id,
      required int recordId,
      required int studentId,
      Value<double?> score,
      Value<String> remarks,
      Value<String?> updatedAt,
    });
typedef $$StudentIndependentLearningScoresTableUpdateCompanionBuilder =
    StudentIndependentLearningScoresCompanion Function({
      Value<int> id,
      Value<int> recordId,
      Value<int> studentId,
      Value<double?> score,
      Value<String> remarks,
      Value<String?> updatedAt,
    });

final class $$StudentIndependentLearningScoresTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $StudentIndependentLearningScoresTable,
          StudentIndependentLearningScore
        > {
  $$StudentIndependentLearningScoresTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $IndependentLearningRecordsTable _recordIdTable(_$AppDatabase db) =>
      db.independentLearningRecords.createAlias(
        'student_independent_learning_scores__record_id__independent_learning_records__id',
      );

  $$IndependentLearningRecordsTableProcessedTableManager get recordId {
    final $_column = $_itemColumn<int>('record_id')!;

    final manager = $$IndependentLearningRecordsTableTableManager(
      $_db,
      $_db.independentLearningRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias(
        'student_independent_learning_scores__student_id__students__id',
      );

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudentIndependentLearningScoresTableFilterComposer
    extends Composer<_$AppDatabase, $StudentIndependentLearningScoresTable> {
  $$StudentIndependentLearningScoresTableFilterComposer({
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

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$IndependentLearningRecordsTableFilterComposer get recordId {
    final $$IndependentLearningRecordsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recordId,
          referencedTable: $db.independentLearningRecords,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$IndependentLearningRecordsTableFilterComposer(
                $db: $db,
                $table: $db.independentLearningRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentIndependentLearningScoresTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentIndependentLearningScoresTable> {
  $$StudentIndependentLearningScoresTableOrderingComposer({
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

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$IndependentLearningRecordsTableOrderingComposer get recordId {
    final $$IndependentLearningRecordsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recordId,
          referencedTable: $db.independentLearningRecords,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$IndependentLearningRecordsTableOrderingComposer(
                $db: $db,
                $table: $db.independentLearningRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentIndependentLearningScoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentIndependentLearningScoresTable> {
  $$StudentIndependentLearningScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$IndependentLearningRecordsTableAnnotationComposer get recordId {
    final $$IndependentLearningRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recordId,
          referencedTable: $db.independentLearningRecords,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$IndependentLearningRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.independentLearningRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentIndependentLearningScoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentIndependentLearningScoresTable,
          StudentIndependentLearningScore,
          $$StudentIndependentLearningScoresTableFilterComposer,
          $$StudentIndependentLearningScoresTableOrderingComposer,
          $$StudentIndependentLearningScoresTableAnnotationComposer,
          $$StudentIndependentLearningScoresTableCreateCompanionBuilder,
          $$StudentIndependentLearningScoresTableUpdateCompanionBuilder,
          (
            StudentIndependentLearningScore,
            $$StudentIndependentLearningScoresTableReferences,
          ),
          StudentIndependentLearningScore,
          PrefetchHooks Function({bool recordId, bool studentId})
        > {
  $$StudentIndependentLearningScoresTableTableManager(
    _$AppDatabase db,
    $StudentIndependentLearningScoresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentIndependentLearningScoresTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$StudentIndependentLearningScoresTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudentIndependentLearningScoresTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> recordId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<double?> score = const Value.absent(),
                Value<String> remarks = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => StudentIndependentLearningScoresCompanion(
                id: id,
                recordId: recordId,
                studentId: studentId,
                score: score,
                remarks: remarks,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int recordId,
                required int studentId,
                Value<double?> score = const Value.absent(),
                Value<String> remarks = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => StudentIndependentLearningScoresCompanion.insert(
                id: id,
                recordId: recordId,
                studentId: studentId,
                score: score,
                remarks: remarks,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $StudentIndependentLearningScoresTable,
                    StudentIndependentLearningScore
                  >(table),
                  $$StudentIndependentLearningScoresTableReferences(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recordId = false, studentId = false}) {
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
                    if (recordId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recordId,
                        referencedTable:
                            $$StudentIndependentLearningScoresTableReferences
                                ._recordIdTable(db),
                        referencedColumn:
                            $$StudentIndependentLearningScoresTableReferences
                                ._recordIdTable(db)
                                .id,
                      ) as T;
                    }
                    if (studentId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.studentId,
                        referencedTable:
                            $$StudentIndependentLearningScoresTableReferences
                                ._studentIdTable(db),
                        referencedColumn:
                            $$StudentIndependentLearningScoresTableReferences
                                ._studentIdTable(db)
                                .id,
                      ) as T;
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

typedef $$StudentIndependentLearningScoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentIndependentLearningScoresTable,
      StudentIndependentLearningScore,
      $$StudentIndependentLearningScoresTableFilterComposer,
      $$StudentIndependentLearningScoresTableOrderingComposer,
      $$StudentIndependentLearningScoresTableAnnotationComposer,
      $$StudentIndependentLearningScoresTableCreateCompanionBuilder,
      $$StudentIndependentLearningScoresTableUpdateCompanionBuilder,
      (
        StudentIndependentLearningScore,
        $$StudentIndependentLearningScoresTableReferences,
      ),
      StudentIndependentLearningScore,
      PrefetchHooks Function({bool recordId, bool studentId})
    >;
typedef $$GradingConfigurationsTableCreateCompanionBuilder =
    GradingConfigurationsCompanion Function({
      Value<int> id,
      Value<int?> subjectId,
      required String name,
      Value<double> quizWeight,
      Value<double> attendanceWeight,
      Value<double> workWeight,
      Value<double> majorExamWeight,
      Value<double> independentLearningWeight,
      Value<int> decimalPlaces,
      Value<bool> isActive,
    });
typedef $$GradingConfigurationsTableUpdateCompanionBuilder =
    GradingConfigurationsCompanion Function({
      Value<int> id,
      Value<int?> subjectId,
      Value<String> name,
      Value<double> quizWeight,
      Value<double> attendanceWeight,
      Value<double> workWeight,
      Value<double> majorExamWeight,
      Value<double> independentLearningWeight,
      Value<int> decimalPlaces,
      Value<bool> isActive,
    });

final class $$GradingConfigurationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GradingConfigurationsTable,
          GradingConfiguration
        > {
  $$GradingConfigurationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) => db.subjects
      .createAlias('grading_configurations__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager? get subjectId {
    final $_column = $_itemColumn<int>('subject_id');
    if ($_column == null) return null;
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GradingConfigurationsTableFilterComposer
    extends Composer<_$AppDatabase, $GradingConfigurationsTable> {
  $$GradingConfigurationsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quizWeight => $composableBuilder(
    column: $table.quizWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get attendanceWeight => $composableBuilder(
    column: $table.attendanceWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get workWeight => $composableBuilder(
    column: $table.workWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get majorExamWeight => $composableBuilder(
    column: $table.majorExamWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get independentLearningWeight => $composableBuilder(
    column: $table.independentLearningWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get decimalPlaces => $composableBuilder(
    column: $table.decimalPlaces,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GradingConfigurationsTableOrderingComposer
    extends Composer<_$AppDatabase, $GradingConfigurationsTable> {
  $$GradingConfigurationsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quizWeight => $composableBuilder(
    column: $table.quizWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get attendanceWeight => $composableBuilder(
    column: $table.attendanceWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get workWeight => $composableBuilder(
    column: $table.workWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get majorExamWeight => $composableBuilder(
    column: $table.majorExamWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get independentLearningWeight => $composableBuilder(
    column: $table.independentLearningWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get decimalPlaces => $composableBuilder(
    column: $table.decimalPlaces,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GradingConfigurationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GradingConfigurationsTable> {
  $$GradingConfigurationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get quizWeight => $composableBuilder(
    column: $table.quizWeight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get attendanceWeight => $composableBuilder(
    column: $table.attendanceWeight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get workWeight => $composableBuilder(
    column: $table.workWeight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get majorExamWeight => $composableBuilder(
    column: $table.majorExamWeight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get independentLearningWeight => $composableBuilder(
    column: $table.independentLearningWeight,
    builder: (column) => column,
  );

  GeneratedColumn<int> get decimalPlaces => $composableBuilder(
    column: $table.decimalPlaces,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GradingConfigurationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GradingConfigurationsTable,
          GradingConfiguration,
          $$GradingConfigurationsTableFilterComposer,
          $$GradingConfigurationsTableOrderingComposer,
          $$GradingConfigurationsTableAnnotationComposer,
          $$GradingConfigurationsTableCreateCompanionBuilder,
          $$GradingConfigurationsTableUpdateCompanionBuilder,
          (GradingConfiguration, $$GradingConfigurationsTableReferences),
          GradingConfiguration,
          PrefetchHooks Function({bool subjectId})
        > {
  $$GradingConfigurationsTableTableManager(
    _$AppDatabase db,
    $GradingConfigurationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GradingConfigurationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$GradingConfigurationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GradingConfigurationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> subjectId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> quizWeight = const Value.absent(),
                Value<double> attendanceWeight = const Value.absent(),
                Value<double> workWeight = const Value.absent(),
                Value<double> majorExamWeight = const Value.absent(),
                Value<double> independentLearningWeight = const Value.absent(),
                Value<int> decimalPlaces = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => GradingConfigurationsCompanion(
                id: id,
                subjectId: subjectId,
                name: name,
                quizWeight: quizWeight,
                attendanceWeight: attendanceWeight,
                workWeight: workWeight,
                majorExamWeight: majorExamWeight,
                independentLearningWeight: independentLearningWeight,
                decimalPlaces: decimalPlaces,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> subjectId = const Value.absent(),
                required String name,
                Value<double> quizWeight = const Value.absent(),
                Value<double> attendanceWeight = const Value.absent(),
                Value<double> workWeight = const Value.absent(),
                Value<double> majorExamWeight = const Value.absent(),
                Value<double> independentLearningWeight = const Value.absent(),
                Value<int> decimalPlaces = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => GradingConfigurationsCompanion.insert(
                id: id,
                subjectId: subjectId,
                name: name,
                quizWeight: quizWeight,
                attendanceWeight: attendanceWeight,
                workWeight: workWeight,
                majorExamWeight: majorExamWeight,
                independentLearningWeight: independentLearningWeight,
                decimalPlaces: decimalPlaces,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $GradingConfigurationsTable,
                    GradingConfiguration
                  >(table),
                  $$GradingConfigurationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({subjectId = false}) {
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
                    if (subjectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.subjectId,
                        referencedTable: $$GradingConfigurationsTableReferences
                            ._subjectIdTable(db),
                        referencedColumn: $$GradingConfigurationsTableReferences
                            ._subjectIdTable(db)
                            .id,
                      ) as T;
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

typedef $$GradingConfigurationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GradingConfigurationsTable,
      GradingConfiguration,
      $$GradingConfigurationsTableFilterComposer,
      $$GradingConfigurationsTableOrderingComposer,
      $$GradingConfigurationsTableAnnotationComposer,
      $$GradingConfigurationsTableCreateCompanionBuilder,
      $$GradingConfigurationsTableUpdateCompanionBuilder,
      (GradingConfiguration, $$GradingConfigurationsTableReferences),
      GradingConfiguration,
      PrefetchHooks Function({bool subjectId})
    >;
typedef $$TermGradesTableCreateCompanionBuilder = TermGradesCompanion Function({
  Value<int> id,
  required int subjectId,
  required int studentId,
  required int gradingPeriodId,
  Value<double?> grade,
  Value<String> remarks,
  Value<String?> calculatedAt,
});
typedef $$TermGradesTableUpdateCompanionBuilder = TermGradesCompanion Function({
  Value<int> id,
  Value<int> subjectId,
  Value<int> studentId,
  Value<int> gradingPeriodId,
  Value<double?> grade,
  Value<String> remarks,
  Value<String?> calculatedAt,
});

final class $$TermGradesTableReferences
    extends BaseReferences<_$AppDatabase, $TermGradesTable, TermGrade> {
  $$TermGradesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('term_grades__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias('term_grades__student_id__students__id');

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GradingPeriodsTable _gradingPeriodIdTable(_$AppDatabase db) => db
      .gradingPeriods
      .createAlias('term_grades__grading_period_id__grading_periods__id');

  $$GradingPeriodsTableProcessedTableManager get gradingPeriodId {
    final $_column = $_itemColumn<int>('grading_period_id')!;

    final manager = $$GradingPeriodsTableTableManager(
      $_db,
      $_db.gradingPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gradingPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TermGradesTableFilterComposer
    extends Composer<_$AppDatabase, $TermGradesTable> {
  $$TermGradesTableFilterComposer({
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

  ColumnFilters<double> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableFilterComposer get gradingPeriodId {
    final $$GradingPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TermGradesTableOrderingComposer
    extends Composer<_$AppDatabase, $TermGradesTable> {
  $$TermGradesTableOrderingComposer({
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

  ColumnOrderings<double> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableOrderingComposer get gradingPeriodId {
    final $$GradingPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TermGradesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TermGradesTable> {
  $$TermGradesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<String> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => column,
  );

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableAnnotationComposer get gradingPeriodId {
    final $$GradingPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TermGradesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TermGradesTable,
          TermGrade,
          $$TermGradesTableFilterComposer,
          $$TermGradesTableOrderingComposer,
          $$TermGradesTableAnnotationComposer,
          $$TermGradesTableCreateCompanionBuilder,
          $$TermGradesTableUpdateCompanionBuilder,
          (TermGrade, $$TermGradesTableReferences),
          TermGrade,
          PrefetchHooks Function({
            bool subjectId,
            bool studentId,
            bool gradingPeriodId,
          })
        > {
  $$TermGradesTableTableManager(_$AppDatabase db, $TermGradesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermGradesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TermGradesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TermGradesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int> gradingPeriodId = const Value.absent(),
                Value<double?> grade = const Value.absent(),
                Value<String> remarks = const Value.absent(),
                Value<String?> calculatedAt = const Value.absent(),
              }) => TermGradesCompanion(
                id: id,
                subjectId: subjectId,
                studentId: studentId,
                gradingPeriodId: gradingPeriodId,
                grade: grade,
                remarks: remarks,
                calculatedAt: calculatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subjectId,
                required int studentId,
                required int gradingPeriodId,
                Value<double?> grade = const Value.absent(),
                Value<String> remarks = const Value.absent(),
                Value<String?> calculatedAt = const Value.absent(),
              }) => TermGradesCompanion.insert(
                id: id,
                subjectId: subjectId,
                studentId: studentId,
                gradingPeriodId: gradingPeriodId,
                grade: grade,
                remarks: remarks,
                calculatedAt: calculatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TermGradesTable, TermGrade>(table),
                  $$TermGradesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                subjectId = false,
                studentId = false,
                gradingPeriodId = false,
              }) {
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
                        if (subjectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$TermGradesTableReferences
                                ._subjectIdTable(db),
                            referencedColumn: $$TermGradesTableReferences
                                ._subjectIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (studentId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.studentId,
                            referencedTable: $$TermGradesTableReferences
                                ._studentIdTable(db),
                            referencedColumn: $$TermGradesTableReferences
                                ._studentIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (gradingPeriodId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gradingPeriodId,
                            referencedTable: $$TermGradesTableReferences
                                ._gradingPeriodIdTable(db),
                            referencedColumn: $$TermGradesTableReferences
                                ._gradingPeriodIdTable(db)
                                .id,
                          ) as T;
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

typedef $$TermGradesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TermGradesTable,
      TermGrade,
      $$TermGradesTableFilterComposer,
      $$TermGradesTableOrderingComposer,
      $$TermGradesTableAnnotationComposer,
      $$TermGradesTableCreateCompanionBuilder,
      $$TermGradesTableUpdateCompanionBuilder,
      (TermGrade, $$TermGradesTableReferences),
      TermGrade,
      PrefetchHooks Function({
        bool subjectId,
        bool studentId,
        bool gradingPeriodId,
      })
    >;
typedef $$GradeRankingsTableCreateCompanionBuilder =
    GradeRankingsCompanion Function({
      Value<int> id,
      required int subjectId,
      required int gradingPeriodId,
      required int studentId,
      required int rank,
      required double grade,
      required String calculatedAt,
    });
typedef $$GradeRankingsTableUpdateCompanionBuilder =
    GradeRankingsCompanion Function({
      Value<int> id,
      Value<int> subjectId,
      Value<int> gradingPeriodId,
      Value<int> studentId,
      Value<int> rank,
      Value<double> grade,
      Value<String> calculatedAt,
    });

final class $$GradeRankingsTableReferences
    extends BaseReferences<_$AppDatabase, $GradeRankingsTable, GradeRanking> {
  $$GradeRankingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('grade_rankings__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GradingPeriodsTable _gradingPeriodIdTable(_$AppDatabase db) => db
      .gradingPeriods
      .createAlias('grade_rankings__grading_period_id__grading_periods__id');

  $$GradingPeriodsTableProcessedTableManager get gradingPeriodId {
    final $_column = $_itemColumn<int>('grading_period_id')!;

    final manager = $$GradingPeriodsTableTableManager(
      $_db,
      $_db.gradingPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gradingPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias('grade_rankings__student_id__students__id');

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GradeRankingsTableFilterComposer
    extends Composer<_$AppDatabase, $GradeRankingsTable> {
  $$GradeRankingsTableFilterComposer({
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

  ColumnFilters<int> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableFilterComposer get gradingPeriodId {
    final $$GradingPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GradeRankingsTableOrderingComposer
    extends Composer<_$AppDatabase, $GradeRankingsTable> {
  $$GradeRankingsTableOrderingComposer({
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

  ColumnOrderings<int> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableOrderingComposer get gradingPeriodId {
    final $$GradingPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GradeRankingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GradeRankingsTable> {
  $$GradeRankingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);

  GeneratedColumn<double> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => column,
  );

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GradingPeriodsTableAnnotationComposer get gradingPeriodId {
    final $$GradingPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingPeriodId,
      referencedTable: $db.gradingPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.gradingPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GradeRankingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GradeRankingsTable,
          GradeRanking,
          $$GradeRankingsTableFilterComposer,
          $$GradeRankingsTableOrderingComposer,
          $$GradeRankingsTableAnnotationComposer,
          $$GradeRankingsTableCreateCompanionBuilder,
          $$GradeRankingsTableUpdateCompanionBuilder,
          (GradeRanking, $$GradeRankingsTableReferences),
          GradeRanking,
          PrefetchHooks Function({
            bool subjectId,
            bool gradingPeriodId,
            bool studentId,
          })
        > {
  $$GradeRankingsTableTableManager(_$AppDatabase db, $GradeRankingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GradeRankingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GradeRankingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GradeRankingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<int> gradingPeriodId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int> rank = const Value.absent(),
                Value<double> grade = const Value.absent(),
                Value<String> calculatedAt = const Value.absent(),
              }) => GradeRankingsCompanion(
                id: id,
                subjectId: subjectId,
                gradingPeriodId: gradingPeriodId,
                studentId: studentId,
                rank: rank,
                grade: grade,
                calculatedAt: calculatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subjectId,
                required int gradingPeriodId,
                required int studentId,
                required int rank,
                required double grade,
                required String calculatedAt,
              }) => GradeRankingsCompanion.insert(
                id: id,
                subjectId: subjectId,
                gradingPeriodId: gradingPeriodId,
                studentId: studentId,
                rank: rank,
                grade: grade,
                calculatedAt: calculatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GradeRankingsTable, GradeRanking>(table),
                  $$GradeRankingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                subjectId = false,
                gradingPeriodId = false,
                studentId = false,
              }) {
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
                        if (subjectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$GradeRankingsTableReferences
                                ._subjectIdTable(db),
                            referencedColumn: $$GradeRankingsTableReferences
                                ._subjectIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (gradingPeriodId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gradingPeriodId,
                            referencedTable: $$GradeRankingsTableReferences
                                ._gradingPeriodIdTable(db),
                            referencedColumn: $$GradeRankingsTableReferences
                                ._gradingPeriodIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (studentId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.studentId,
                            referencedTable: $$GradeRankingsTableReferences
                                ._studentIdTable(db),
                            referencedColumn: $$GradeRankingsTableReferences
                                ._studentIdTable(db)
                                .id,
                          ) as T;
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

typedef $$GradeRankingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GradeRankingsTable,
      GradeRanking,
      $$GradeRankingsTableFilterComposer,
      $$GradeRankingsTableOrderingComposer,
      $$GradeRankingsTableAnnotationComposer,
      $$GradeRankingsTableCreateCompanionBuilder,
      $$GradeRankingsTableUpdateCompanionBuilder,
      (GradeRanking, $$GradeRankingsTableReferences),
      GradeRanking,
      PrefetchHooks Function({
        bool subjectId,
        bool gradingPeriodId,
        bool studentId,
      })
    >;
typedef $$ApplicationSettingsTableCreateCompanionBuilder =
    ApplicationSettingsCompanion Function({
      Value<int> id,
      required String key,
      required String value,
      required String updatedAt,
    });
typedef $$ApplicationSettingsTableUpdateCompanionBuilder =
    ApplicationSettingsCompanion Function({
      Value<int> id,
      Value<String> key,
      Value<String> value,
      Value<String> updatedAt,
    });

class $$ApplicationSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $ApplicationSettingsTable> {
  $$ApplicationSettingsTableFilterComposer({
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

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ApplicationSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ApplicationSettingsTable> {
  $$ApplicationSettingsTableOrderingComposer({
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

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ApplicationSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ApplicationSettingsTable> {
  $$ApplicationSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ApplicationSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ApplicationSettingsTable,
          ApplicationSetting,
          $$ApplicationSettingsTableFilterComposer,
          $$ApplicationSettingsTableOrderingComposer,
          $$ApplicationSettingsTableAnnotationComposer,
          $$ApplicationSettingsTableCreateCompanionBuilder,
          $$ApplicationSettingsTableUpdateCompanionBuilder,
          (
            ApplicationSetting,
            BaseReferences<
              _$AppDatabase,
              $ApplicationSettingsTable,
              ApplicationSetting
            >,
          ),
          ApplicationSetting,
          PrefetchHooks Function()
        > {
  $$ApplicationSettingsTableTableManager(
    _$AppDatabase db,
    $ApplicationSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApplicationSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApplicationSettingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ApplicationSettingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => ApplicationSettingsCompanion(
                id: id,
                key: key,
                value: value,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required String value,
                required String updatedAt,
              }) => ApplicationSettingsCompanion.insert(
                id: id,
                key: key,
                value: value,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ApplicationSettingsTable, ApplicationSetting>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ApplicationSettingsTable,
                    ApplicationSetting
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ApplicationSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ApplicationSettingsTable,
      ApplicationSetting,
      $$ApplicationSettingsTableFilterComposer,
      $$ApplicationSettingsTableOrderingComposer,
      $$ApplicationSettingsTableAnnotationComposer,
      $$ApplicationSettingsTableCreateCompanionBuilder,
      $$ApplicationSettingsTableUpdateCompanionBuilder,
      (
        ApplicationSetting,
        BaseReferences<
          _$AppDatabase,
          $ApplicationSettingsTable,
          ApplicationSetting
        >,
      ),
      ApplicationSetting,
      PrefetchHooks Function()
    >;
typedef $$ActivityLogsTableCreateCompanionBuilder =
    ActivityLogsCompanion Function({
      Value<int> id,
      required String activity,
      Value<String> details,
      Value<String?> entityType,
      Value<int?> entityId,
      required String createdAt,
    });
typedef $$ActivityLogsTableUpdateCompanionBuilder =
    ActivityLogsCompanion Function({
      Value<int> id,
      Value<String> activity,
      Value<String> details,
      Value<String?> entityType,
      Value<int?> entityId,
      Value<String> createdAt,
    });

class $$ActivityLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityLogsTable> {
  $$ActivityLogsTableFilterComposer({
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

  ColumnFilters<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivityLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityLogsTable> {
  $$ActivityLogsTableOrderingComposer({
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

  ColumnOrderings<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivityLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityLogsTable> {
  $$ActivityLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get activity =>
      $composableBuilder(column: $table.activity, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ActivityLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityLogsTable,
          ActivityLog,
          $$ActivityLogsTableFilterComposer,
          $$ActivityLogsTableOrderingComposer,
          $$ActivityLogsTableAnnotationComposer,
          $$ActivityLogsTableCreateCompanionBuilder,
          $$ActivityLogsTableUpdateCompanionBuilder,
          (
            ActivityLog,
            BaseReferences<_$AppDatabase, $ActivityLogsTable, ActivityLog>,
          ),
          ActivityLog,
          PrefetchHooks Function()
        > {
  $$ActivityLogsTableTableManager(_$AppDatabase db, $ActivityLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> activity = const Value.absent(),
                Value<String> details = const Value.absent(),
                Value<String?> entityType = const Value.absent(),
                Value<int?> entityId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
              }) => ActivityLogsCompanion(
                id: id,
                activity: activity,
                details: details,
                entityType: entityType,
                entityId: entityId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String activity,
                Value<String> details = const Value.absent(),
                Value<String?> entityType = const Value.absent(),
                Value<int?> entityId = const Value.absent(),
                required String createdAt,
              }) => ActivityLogsCompanion.insert(
                id: id,
                activity: activity,
                details: details,
                entityType: entityType,
                entityId: entityId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ActivityLogsTable, ActivityLog>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ActivityLogsTable,
                    ActivityLog
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivityLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityLogsTable,
      ActivityLog,
      $$ActivityLogsTableFilterComposer,
      $$ActivityLogsTableOrderingComposer,
      $$ActivityLogsTableAnnotationComposer,
      $$ActivityLogsTableCreateCompanionBuilder,
      $$ActivityLogsTableUpdateCompanionBuilder,
      (
        ActivityLog,
        BaseReferences<_$AppDatabase, $ActivityLogsTable, ActivityLog>,
      ),
      ActivityLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SchoolSettingsTableTableManager get schoolSettings =>
      $$SchoolSettingsTableTableManager(_db, _db.schoolSettings);
  $$AcademicYearsTableTableManager get academicYears =>
      $$AcademicYearsTableTableManager(_db, _db.academicYears);
  $$SemestersTableTableManager get semesters =>
      $$SemestersTableTableManager(_db, _db.semesters);
  $$GradingPeriodsTableTableManager get gradingPeriods =>
      $$GradingPeriodsTableTableManager(_db, _db.gradingPeriods);
  $$InstructorsTableTableManager get instructors =>
      $$InstructorsTableTableManager(_db, _db.instructors);
  $$SectionsTableTableManager get sections =>
      $$SectionsTableTableManager(_db, _db.sections);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$SubjectEnrollmentsTableTableManager get subjectEnrollments =>
      $$SubjectEnrollmentsTableTableManager(_db, _db.subjectEnrollments);
  $$AssessmentsTableTableManager get assessments =>
      $$AssessmentsTableTableManager(_db, _db.assessments);
  $$StudentAssessmentScoresTableTableManager get studentAssessmentScores =>
      $$StudentAssessmentScoresTableTableManager(
        _db,
        _db.studentAssessmentScores,
      );
  $$AttendanceSessionsTableTableManager get attendanceSessions =>
      $$AttendanceSessionsTableTableManager(_db, _db.attendanceSessions);
  $$StudentAttendanceTableTableManager get studentAttendance =>
      $$StudentAttendanceTableTableManager(_db, _db.studentAttendance);
  $$IndependentLearningRecordsTableTableManager
  get independentLearningRecords =>
      $$IndependentLearningRecordsTableTableManager(
        _db,
        _db.independentLearningRecords,
      );
  $$StudentIndependentLearningScoresTableTableManager
  get studentIndependentLearningScores =>
      $$StudentIndependentLearningScoresTableTableManager(
        _db,
        _db.studentIndependentLearningScores,
      );
  $$GradingConfigurationsTableTableManager get gradingConfigurations =>
      $$GradingConfigurationsTableTableManager(_db, _db.gradingConfigurations);
  $$TermGradesTableTableManager get termGrades =>
      $$TermGradesTableTableManager(_db, _db.termGrades);
  $$GradeRankingsTableTableManager get gradeRankings =>
      $$GradeRankingsTableTableManager(_db, _db.gradeRankings);
  $$ApplicationSettingsTableTableManager get applicationSettings =>
      $$ApplicationSettingsTableTableManager(_db, _db.applicationSettings);
  $$ActivityLogsTableTableManager get activityLogs =>
      $$ActivityLogsTableTableManager(_db, _db.activityLogs);
}
