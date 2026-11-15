// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SyncOutboxTableTable extends SyncOutboxTable
    with TableInfo<$SyncOutboxTableTable, SyncOutboxTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationUuidMeta =
      const VerificationMeta('operationUuid');
  @override
  late final GeneratedColumn<String> operationUuid = GeneratedColumn<String>(
      'operation_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        branchId,
        operationUuid,
        entityType,
        entityId,
        operation,
        payload,
        createdAt,
        status,
        retryCount,
        errorMessage
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outbox_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SyncOutboxTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('operation_uuid')) {
      context.handle(
          _operationUuidMeta,
          operationUuid.isAcceptableOrUnknown(
              data['operation_uuid']!, _operationUuidMeta));
    } else if (isInserting) {
      context.missing(_operationUuidMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncOutboxTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOutboxTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      operationUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation_uuid'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
    );
  }

  @override
  $SyncOutboxTableTable createAlias(String alias) {
    return $SyncOutboxTableTable(attachedDatabase, alias);
  }
}

class SyncOutboxTableData extends DataClass
    implements Insertable<SyncOutboxTableData> {
  final String id;
  final String tenantId;
  final String branchId;
  final String operationUuid;
  final String entityType;
  final String entityId;
  final String operation;
  final String payload;
  final DateTime createdAt;
  final String status;
  final int retryCount;
  final String? errorMessage;
  const SyncOutboxTableData(
      {required this.id,
      required this.tenantId,
      required this.branchId,
      required this.operationUuid,
      required this.entityType,
      required this.entityId,
      required this.operation,
      required this.payload,
      required this.createdAt,
      required this.status,
      required this.retryCount,
      this.errorMessage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['operation_uuid'] = Variable<String>(operationUuid);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  SyncOutboxTableCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      operationUuid: Value(operationUuid),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payload: Value(payload),
      createdAt: Value(createdAt),
      status: Value(status),
      retryCount: Value(retryCount),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory SyncOutboxTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOutboxTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      operationUuid: serializer.fromJson<String>(json['operationUuid']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'operationUuid': serializer.toJson<String>(operationUuid),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  SyncOutboxTableData copyWith(
          {String? id,
          String? tenantId,
          String? branchId,
          String? operationUuid,
          String? entityType,
          String? entityId,
          String? operation,
          String? payload,
          DateTime? createdAt,
          String? status,
          int? retryCount,
          Value<String?> errorMessage = const Value.absent()}) =>
      SyncOutboxTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        operationUuid: operationUuid ?? this.operationUuid,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        operation: operation ?? this.operation,
        payload: payload ?? this.payload,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
        retryCount: retryCount ?? this.retryCount,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
      );
  SyncOutboxTableData copyWithCompanion(SyncOutboxTableCompanion data) {
    return SyncOutboxTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      operationUuid: data.operationUuid.present
          ? data.operationUuid.value
          : this.operationUuid,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      status: data.status.present ? data.status.value : this.status,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('operationUuid: $operationUuid, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      branchId,
      operationUuid,
      entityType,
      entityId,
      operation,
      payload,
      createdAt,
      status,
      retryCount,
      errorMessage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOutboxTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.operationUuid == this.operationUuid &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.errorMessage == this.errorMessage);
}

class SyncOutboxTableCompanion extends UpdateCompanion<SyncOutboxTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> operationUuid;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<String?> errorMessage;
  final Value<int> rowid;
  const SyncOutboxTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.operationUuid = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncOutboxTableCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    required String operationUuid,
    required String entityType,
    required String entityId,
    required String operation,
    required String payload,
    required DateTime createdAt,
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        branchId = Value(branchId),
        operationUuid = Value(operationUuid),
        entityType = Value(entityType),
        entityId = Value(entityId),
        operation = Value(operation),
        payload = Value(payload),
        createdAt = Value(createdAt);
  static Insertable<SyncOutboxTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? operationUuid,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<String>? errorMessage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (operationUuid != null) 'operation_uuid': operationUuid,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (errorMessage != null) 'error_message': errorMessage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncOutboxTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String>? operationUuid,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? operation,
      Value<String>? payload,
      Value<DateTime>? createdAt,
      Value<String>? status,
      Value<int>? retryCount,
      Value<String?>? errorMessage,
      Value<int>? rowid}) {
    return SyncOutboxTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      operationUuid: operationUuid ?? this.operationUuid,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      errorMessage: errorMessage ?? this.errorMessage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (operationUuid.present) {
      map['operation_uuid'] = Variable<String>(operationUuid.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('operationUuid: $operationUuid, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStateTableTable extends SyncStateTable
    with TableInfo<$SyncStateTableTable, SyncStateTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStateTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _targetEntityMeta =
      const VerificationMeta('targetEntity');
  @override
  late final GeneratedColumn<String> targetEntity = GeneratedColumn<String>(
      'target_entity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastCursorMeta =
      const VerificationMeta('lastCursor');
  @override
  late final GeneratedColumn<String> lastCursor = GeneratedColumn<String>(
      'last_cursor', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [targetEntity, lastSyncedAt, lastCursor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_state_table';
  @override
  VerificationContext validateIntegrity(Insertable<SyncStateTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('target_entity')) {
      context.handle(
          _targetEntityMeta,
          targetEntity.isAcceptableOrUnknown(
              data['target_entity']!, _targetEntityMeta));
    } else if (isInserting) {
      context.missing(_targetEntityMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    } else if (isInserting) {
      context.missing(_lastSyncedAtMeta);
    }
    if (data.containsKey('last_cursor')) {
      context.handle(
          _lastCursorMeta,
          lastCursor.isAcceptableOrUnknown(
              data['last_cursor']!, _lastCursorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {targetEntity};
  @override
  SyncStateTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateTableData(
      targetEntity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_entity'])!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at'])!,
      lastCursor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_cursor']),
    );
  }

  @override
  $SyncStateTableTable createAlias(String alias) {
    return $SyncStateTableTable(attachedDatabase, alias);
  }
}

class SyncStateTableData extends DataClass
    implements Insertable<SyncStateTableData> {
  final String targetEntity;
  final DateTime lastSyncedAt;
  final String? lastCursor;
  const SyncStateTableData(
      {required this.targetEntity,
      required this.lastSyncedAt,
      this.lastCursor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['target_entity'] = Variable<String>(targetEntity);
    map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    if (!nullToAbsent || lastCursor != null) {
      map['last_cursor'] = Variable<String>(lastCursor);
    }
    return map;
  }

  SyncStateTableCompanion toCompanion(bool nullToAbsent) {
    return SyncStateTableCompanion(
      targetEntity: Value(targetEntity),
      lastSyncedAt: Value(lastSyncedAt),
      lastCursor: lastCursor == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCursor),
    );
  }

  factory SyncStateTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateTableData(
      targetEntity: serializer.fromJson<String>(json['targetEntity']),
      lastSyncedAt: serializer.fromJson<DateTime>(json['lastSyncedAt']),
      lastCursor: serializer.fromJson<String?>(json['lastCursor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'targetEntity': serializer.toJson<String>(targetEntity),
      'lastSyncedAt': serializer.toJson<DateTime>(lastSyncedAt),
      'lastCursor': serializer.toJson<String?>(lastCursor),
    };
  }

  SyncStateTableData copyWith(
          {String? targetEntity,
          DateTime? lastSyncedAt,
          Value<String?> lastCursor = const Value.absent()}) =>
      SyncStateTableData(
        targetEntity: targetEntity ?? this.targetEntity,
        lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
        lastCursor: lastCursor.present ? lastCursor.value : this.lastCursor,
      );
  SyncStateTableData copyWithCompanion(SyncStateTableCompanion data) {
    return SyncStateTableData(
      targetEntity: data.targetEntity.present
          ? data.targetEntity.value
          : this.targetEntity,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      lastCursor:
          data.lastCursor.present ? data.lastCursor.value : this.lastCursor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateTableData(')
          ..write('targetEntity: $targetEntity, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('lastCursor: $lastCursor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(targetEntity, lastSyncedAt, lastCursor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateTableData &&
          other.targetEntity == this.targetEntity &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.lastCursor == this.lastCursor);
}

class SyncStateTableCompanion extends UpdateCompanion<SyncStateTableData> {
  final Value<String> targetEntity;
  final Value<DateTime> lastSyncedAt;
  final Value<String?> lastCursor;
  final Value<int> rowid;
  const SyncStateTableCompanion({
    this.targetEntity = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.lastCursor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStateTableCompanion.insert({
    required String targetEntity,
    required DateTime lastSyncedAt,
    this.lastCursor = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : targetEntity = Value(targetEntity),
        lastSyncedAt = Value(lastSyncedAt);
  static Insertable<SyncStateTableData> custom({
    Expression<String>? targetEntity,
    Expression<DateTime>? lastSyncedAt,
    Expression<String>? lastCursor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (targetEntity != null) 'target_entity': targetEntity,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (lastCursor != null) 'last_cursor': lastCursor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStateTableCompanion copyWith(
      {Value<String>? targetEntity,
      Value<DateTime>? lastSyncedAt,
      Value<String?>? lastCursor,
      Value<int>? rowid}) {
    return SyncStateTableCompanion(
      targetEntity: targetEntity ?? this.targetEntity,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      lastCursor: lastCursor ?? this.lastCursor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (targetEntity.present) {
      map['target_entity'] = Variable<String>(targetEntity.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (lastCursor.present) {
      map['last_cursor'] = Variable<String>(lastCursor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateTableCompanion(')
          ..write('targetEntity: $targetEntity, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('lastCursor: $lastCursor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppConfigTableTable extends AppConfigTable
    with TableInfo<$AppConfigTableTable, AppConfigTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppConfigTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _configKeyMeta =
      const VerificationMeta('configKey');
  @override
  late final GeneratedColumn<String> configKey = GeneratedColumn<String>(
      'config_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _configValueMeta =
      const VerificationMeta('configValue');
  @override
  late final GeneratedColumn<String> configValue = GeneratedColumn<String>(
      'config_value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [configKey, configValue, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_config_table';
  @override
  VerificationContext validateIntegrity(Insertable<AppConfigTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('config_key')) {
      context.handle(_configKeyMeta,
          configKey.isAcceptableOrUnknown(data['config_key']!, _configKeyMeta));
    } else if (isInserting) {
      context.missing(_configKeyMeta);
    }
    if (data.containsKey('config_value')) {
      context.handle(
          _configValueMeta,
          configValue.isAcceptableOrUnknown(
              data['config_value']!, _configValueMeta));
    } else if (isInserting) {
      context.missing(_configValueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {configKey};
  @override
  AppConfigTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppConfigTableData(
      configKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}config_key'])!,
      configValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}config_value'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AppConfigTableTable createAlias(String alias) {
    return $AppConfigTableTable(attachedDatabase, alias);
  }
}

class AppConfigTableData extends DataClass
    implements Insertable<AppConfigTableData> {
  final String configKey;
  final String configValue;
  final DateTime updatedAt;
  const AppConfigTableData(
      {required this.configKey,
      required this.configValue,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['config_key'] = Variable<String>(configKey);
    map['config_value'] = Variable<String>(configValue);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppConfigTableCompanion toCompanion(bool nullToAbsent) {
    return AppConfigTableCompanion(
      configKey: Value(configKey),
      configValue: Value(configValue),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppConfigTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppConfigTableData(
      configKey: serializer.fromJson<String>(json['configKey']),
      configValue: serializer.fromJson<String>(json['configValue']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'configKey': serializer.toJson<String>(configKey),
      'configValue': serializer.toJson<String>(configValue),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppConfigTableData copyWith(
          {String? configKey, String? configValue, DateTime? updatedAt}) =>
      AppConfigTableData(
        configKey: configKey ?? this.configKey,
        configValue: configValue ?? this.configValue,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppConfigTableData copyWithCompanion(AppConfigTableCompanion data) {
    return AppConfigTableData(
      configKey: data.configKey.present ? data.configKey.value : this.configKey,
      configValue:
          data.configValue.present ? data.configValue.value : this.configValue,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppConfigTableData(')
          ..write('configKey: $configKey, ')
          ..write('configValue: $configValue, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(configKey, configValue, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppConfigTableData &&
          other.configKey == this.configKey &&
          other.configValue == this.configValue &&
          other.updatedAt == this.updatedAt);
}

class AppConfigTableCompanion extends UpdateCompanion<AppConfigTableData> {
  final Value<String> configKey;
  final Value<String> configValue;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppConfigTableCompanion({
    this.configKey = const Value.absent(),
    this.configValue = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppConfigTableCompanion.insert({
    required String configKey,
    required String configValue,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : configKey = Value(configKey),
        configValue = Value(configValue),
        updatedAt = Value(updatedAt);
  static Insertable<AppConfigTableData> custom({
    Expression<String>? configKey,
    Expression<String>? configValue,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (configKey != null) 'config_key': configKey,
      if (configValue != null) 'config_value': configValue,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppConfigTableCompanion copyWith(
      {Value<String>? configKey,
      Value<String>? configValue,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return AppConfigTableCompanion(
      configKey: configKey ?? this.configKey,
      configValue: configValue ?? this.configValue,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (configKey.present) {
      map['config_key'] = Variable<String>(configKey.value);
    }
    if (configValue.present) {
      map['config_value'] = Variable<String>(configValue.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppConfigTableCompanion(')
          ..write('configKey: $configKey, ')
          ..write('configValue: $configValue, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TenantsTableTable extends TenantsTable
    with TableInfo<$TenantsTableTable, TenantsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TenantsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, slug, isActive, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tenants_table';
  @override
  VerificationContext validateIntegrity(Insertable<TenantsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TenantsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TenantsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TenantsTableTable createAlias(String alias) {
    return $TenantsTableTable(attachedDatabase, alias);
  }
}

class TenantsTableData extends DataClass
    implements Insertable<TenantsTableData> {
  final String id;
  final String name;
  final String slug;
  final bool isActive;
  final DateTime updatedAt;
  const TenantsTableData(
      {required this.id,
      required this.name,
      required this.slug,
      required this.isActive,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    map['is_active'] = Variable<bool>(isActive);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TenantsTableCompanion toCompanion(bool nullToAbsent) {
    return TenantsTableCompanion(
      id: Value(id),
      name: Value(name),
      slug: Value(slug),
      isActive: Value(isActive),
      updatedAt: Value(updatedAt),
    );
  }

  factory TenantsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TenantsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TenantsTableData copyWith(
          {String? id,
          String? name,
          String? slug,
          bool? isActive,
          DateTime? updatedAt}) =>
      TenantsTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        isActive: isActive ?? this.isActive,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TenantsTableData copyWithCompanion(TenantsTableCompanion data) {
    return TenantsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TenantsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, slug, isActive, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TenantsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.isActive == this.isActive &&
          other.updatedAt == this.updatedAt);
}

class TenantsTableCompanion extends UpdateCompanion<TenantsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> slug;
  final Value<bool> isActive;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TenantsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TenantsTableCompanion.insert({
    required String id,
    required String name,
    required String slug,
    this.isActive = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        slug = Value(slug),
        updatedAt = Value(updatedAt);
  static Insertable<TenantsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<bool>? isActive,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (isActive != null) 'is_active': isActive,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TenantsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? slug,
      Value<bool>? isActive,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return TenantsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      isActive: isActive ?? this.isActive,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TenantsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TenantSettingsTableTable extends TenantSettingsTable
    with TableInfo<$TenantSettingsTableTable, TenantSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TenantSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('INR'));
  static const VerificationMeta _timezoneMeta =
      const VerificationMeta('timezone');
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
      'timezone', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Asia/Kolkata'));
  static const VerificationMeta _gstinMeta = const VerificationMeta('gstin');
  @override
  late final GeneratedColumn<String> gstin = GeneratedColumn<String>(
      'gstin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _invoicePrefixMeta =
      const VerificationMeta('invoicePrefix');
  @override
  late final GeneratedColumn<String> invoicePrefix = GeneratedColumn<String>(
      'invoice_prefix', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('INV'));
  static const VerificationMeta _fiscalYearStartMonthMeta =
      const VerificationMeta('fiscalYearStartMonth');
  @override
  late final GeneratedColumn<int> fiscalYearStartMonth = GeneratedColumn<int>(
      'fiscal_year_start_month', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(4));
  static const VerificationMeta _roundOffStrategyMeta =
      const VerificationMeta('roundOffStrategy');
  @override
  late final GeneratedColumn<String> roundOffStrategy = GeneratedColumn<String>(
      'round_off_strategy', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('HALF_UP'));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        tenantId,
        currency,
        timezone,
        gstin,
        invoicePrefix,
        fiscalYearStartMonth,
        roundOffStrategy,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tenant_settings_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TenantSettingsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('timezone')) {
      context.handle(_timezoneMeta,
          timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta));
    }
    if (data.containsKey('gstin')) {
      context.handle(
          _gstinMeta, gstin.isAcceptableOrUnknown(data['gstin']!, _gstinMeta));
    }
    if (data.containsKey('invoice_prefix')) {
      context.handle(
          _invoicePrefixMeta,
          invoicePrefix.isAcceptableOrUnknown(
              data['invoice_prefix']!, _invoicePrefixMeta));
    }
    if (data.containsKey('fiscal_year_start_month')) {
      context.handle(
          _fiscalYearStartMonthMeta,
          fiscalYearStartMonth.isAcceptableOrUnknown(
              data['fiscal_year_start_month']!, _fiscalYearStartMonthMeta));
    }
    if (data.containsKey('round_off_strategy')) {
      context.handle(
          _roundOffStrategyMeta,
          roundOffStrategy.isAcceptableOrUnknown(
              data['round_off_strategy']!, _roundOffStrategyMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tenantId};
  @override
  TenantSettingsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TenantSettingsTableData(
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      timezone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timezone'])!,
      gstin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gstin']),
      invoicePrefix: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invoice_prefix'])!,
      fiscalYearStartMonth: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}fiscal_year_start_month'])!,
      roundOffStrategy: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}round_off_strategy'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TenantSettingsTableTable createAlias(String alias) {
    return $TenantSettingsTableTable(attachedDatabase, alias);
  }
}

class TenantSettingsTableData extends DataClass
    implements Insertable<TenantSettingsTableData> {
  final String tenantId;
  final String currency;
  final String timezone;
  final String? gstin;
  final String invoicePrefix;
  final int fiscalYearStartMonth;
  final String roundOffStrategy;
  final DateTime updatedAt;
  const TenantSettingsTableData(
      {required this.tenantId,
      required this.currency,
      required this.timezone,
      this.gstin,
      required this.invoicePrefix,
      required this.fiscalYearStartMonth,
      required this.roundOffStrategy,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tenant_id'] = Variable<String>(tenantId);
    map['currency'] = Variable<String>(currency);
    map['timezone'] = Variable<String>(timezone);
    if (!nullToAbsent || gstin != null) {
      map['gstin'] = Variable<String>(gstin);
    }
    map['invoice_prefix'] = Variable<String>(invoicePrefix);
    map['fiscal_year_start_month'] = Variable<int>(fiscalYearStartMonth);
    map['round_off_strategy'] = Variable<String>(roundOffStrategy);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TenantSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return TenantSettingsTableCompanion(
      tenantId: Value(tenantId),
      currency: Value(currency),
      timezone: Value(timezone),
      gstin:
          gstin == null && nullToAbsent ? const Value.absent() : Value(gstin),
      invoicePrefix: Value(invoicePrefix),
      fiscalYearStartMonth: Value(fiscalYearStartMonth),
      roundOffStrategy: Value(roundOffStrategy),
      updatedAt: Value(updatedAt),
    );
  }

  factory TenantSettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TenantSettingsTableData(
      tenantId: serializer.fromJson<String>(json['tenantId']),
      currency: serializer.fromJson<String>(json['currency']),
      timezone: serializer.fromJson<String>(json['timezone']),
      gstin: serializer.fromJson<String?>(json['gstin']),
      invoicePrefix: serializer.fromJson<String>(json['invoicePrefix']),
      fiscalYearStartMonth:
          serializer.fromJson<int>(json['fiscalYearStartMonth']),
      roundOffStrategy: serializer.fromJson<String>(json['roundOffStrategy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tenantId': serializer.toJson<String>(tenantId),
      'currency': serializer.toJson<String>(currency),
      'timezone': serializer.toJson<String>(timezone),
      'gstin': serializer.toJson<String?>(gstin),
      'invoicePrefix': serializer.toJson<String>(invoicePrefix),
      'fiscalYearStartMonth': serializer.toJson<int>(fiscalYearStartMonth),
      'roundOffStrategy': serializer.toJson<String>(roundOffStrategy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TenantSettingsTableData copyWith(
          {String? tenantId,
          String? currency,
          String? timezone,
          Value<String?> gstin = const Value.absent(),
          String? invoicePrefix,
          int? fiscalYearStartMonth,
          String? roundOffStrategy,
          DateTime? updatedAt}) =>
      TenantSettingsTableData(
        tenantId: tenantId ?? this.tenantId,
        currency: currency ?? this.currency,
        timezone: timezone ?? this.timezone,
        gstin: gstin.present ? gstin.value : this.gstin,
        invoicePrefix: invoicePrefix ?? this.invoicePrefix,
        fiscalYearStartMonth: fiscalYearStartMonth ?? this.fiscalYearStartMonth,
        roundOffStrategy: roundOffStrategy ?? this.roundOffStrategy,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TenantSettingsTableData copyWithCompanion(TenantSettingsTableCompanion data) {
    return TenantSettingsTableData(
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      currency: data.currency.present ? data.currency.value : this.currency,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      gstin: data.gstin.present ? data.gstin.value : this.gstin,
      invoicePrefix: data.invoicePrefix.present
          ? data.invoicePrefix.value
          : this.invoicePrefix,
      fiscalYearStartMonth: data.fiscalYearStartMonth.present
          ? data.fiscalYearStartMonth.value
          : this.fiscalYearStartMonth,
      roundOffStrategy: data.roundOffStrategy.present
          ? data.roundOffStrategy.value
          : this.roundOffStrategy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TenantSettingsTableData(')
          ..write('tenantId: $tenantId, ')
          ..write('currency: $currency, ')
          ..write('timezone: $timezone, ')
          ..write('gstin: $gstin, ')
          ..write('invoicePrefix: $invoicePrefix, ')
          ..write('fiscalYearStartMonth: $fiscalYearStartMonth, ')
          ..write('roundOffStrategy: $roundOffStrategy, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(tenantId, currency, timezone, gstin,
      invoicePrefix, fiscalYearStartMonth, roundOffStrategy, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TenantSettingsTableData &&
          other.tenantId == this.tenantId &&
          other.currency == this.currency &&
          other.timezone == this.timezone &&
          other.gstin == this.gstin &&
          other.invoicePrefix == this.invoicePrefix &&
          other.fiscalYearStartMonth == this.fiscalYearStartMonth &&
          other.roundOffStrategy == this.roundOffStrategy &&
          other.updatedAt == this.updatedAt);
}

class TenantSettingsTableCompanion
    extends UpdateCompanion<TenantSettingsTableData> {
  final Value<String> tenantId;
  final Value<String> currency;
  final Value<String> timezone;
  final Value<String?> gstin;
  final Value<String> invoicePrefix;
  final Value<int> fiscalYearStartMonth;
  final Value<String> roundOffStrategy;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TenantSettingsTableCompanion({
    this.tenantId = const Value.absent(),
    this.currency = const Value.absent(),
    this.timezone = const Value.absent(),
    this.gstin = const Value.absent(),
    this.invoicePrefix = const Value.absent(),
    this.fiscalYearStartMonth = const Value.absent(),
    this.roundOffStrategy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TenantSettingsTableCompanion.insert({
    required String tenantId,
    this.currency = const Value.absent(),
    this.timezone = const Value.absent(),
    this.gstin = const Value.absent(),
    this.invoicePrefix = const Value.absent(),
    this.fiscalYearStartMonth = const Value.absent(),
    this.roundOffStrategy = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : tenantId = Value(tenantId),
        updatedAt = Value(updatedAt);
  static Insertable<TenantSettingsTableData> custom({
    Expression<String>? tenantId,
    Expression<String>? currency,
    Expression<String>? timezone,
    Expression<String>? gstin,
    Expression<String>? invoicePrefix,
    Expression<int>? fiscalYearStartMonth,
    Expression<String>? roundOffStrategy,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tenantId != null) 'tenant_id': tenantId,
      if (currency != null) 'currency': currency,
      if (timezone != null) 'timezone': timezone,
      if (gstin != null) 'gstin': gstin,
      if (invoicePrefix != null) 'invoice_prefix': invoicePrefix,
      if (fiscalYearStartMonth != null)
        'fiscal_year_start_month': fiscalYearStartMonth,
      if (roundOffStrategy != null) 'round_off_strategy': roundOffStrategy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TenantSettingsTableCompanion copyWith(
      {Value<String>? tenantId,
      Value<String>? currency,
      Value<String>? timezone,
      Value<String?>? gstin,
      Value<String>? invoicePrefix,
      Value<int>? fiscalYearStartMonth,
      Value<String>? roundOffStrategy,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return TenantSettingsTableCompanion(
      tenantId: tenantId ?? this.tenantId,
      currency: currency ?? this.currency,
      timezone: timezone ?? this.timezone,
      gstin: gstin ?? this.gstin,
      invoicePrefix: invoicePrefix ?? this.invoicePrefix,
      fiscalYearStartMonth: fiscalYearStartMonth ?? this.fiscalYearStartMonth,
      roundOffStrategy: roundOffStrategy ?? this.roundOffStrategy,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (gstin.present) {
      map['gstin'] = Variable<String>(gstin.value);
    }
    if (invoicePrefix.present) {
      map['invoice_prefix'] = Variable<String>(invoicePrefix.value);
    }
    if (fiscalYearStartMonth.present) {
      map['fiscal_year_start_month'] =
          Variable<int>(fiscalYearStartMonth.value);
    }
    if (roundOffStrategy.present) {
      map['round_off_strategy'] = Variable<String>(roundOffStrategy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TenantSettingsTableCompanion(')
          ..write('tenantId: $tenantId, ')
          ..write('currency: $currency, ')
          ..write('timezone: $timezone, ')
          ..write('gstin: $gstin, ')
          ..write('invoicePrefix: $invoicePrefix, ')
          ..write('fiscalYearStartMonth: $fiscalYearStartMonth, ')
          ..write('roundOffStrategy: $roundOffStrategy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BranchesTableTable extends BranchesTable
    with TableInfo<$BranchesTableTable, BranchesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BranchesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        name,
        code,
        address,
        phone,
        isDefault,
        isActive,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'branches_table';
  @override
  VerificationContext validateIntegrity(Insertable<BranchesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BranchesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BranchesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BranchesTableTable createAlias(String alias) {
    return $BranchesTableTable(attachedDatabase, alias);
  }
}

class BranchesTableData extends DataClass
    implements Insertable<BranchesTableData> {
  final String id;
  final String tenantId;
  final String name;
  final String code;
  final String? address;
  final String? phone;
  final bool isDefault;
  final bool isActive;
  final DateTime updatedAt;
  const BranchesTableData(
      {required this.id,
      required this.tenantId,
      required this.name,
      required this.code,
      this.address,
      this.phone,
      required this.isDefault,
      required this.isActive,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['name'] = Variable<String>(name);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['is_active'] = Variable<bool>(isActive);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BranchesTableCompanion toCompanion(bool nullToAbsent) {
    return BranchesTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      code: Value(code),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      isDefault: Value(isDefault),
      isActive: Value(isActive),
      updatedAt: Value(updatedAt),
    );
  }

  factory BranchesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BranchesTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String>(json['code']),
      address: serializer.fromJson<String?>(json['address']),
      phone: serializer.fromJson<String?>(json['phone']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String>(code),
      'address': serializer.toJson<String?>(address),
      'phone': serializer.toJson<String?>(phone),
      'isDefault': serializer.toJson<bool>(isDefault),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BranchesTableData copyWith(
          {String? id,
          String? tenantId,
          String? name,
          String? code,
          Value<String?> address = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          bool? isDefault,
          bool? isActive,
          DateTime? updatedAt}) =>
      BranchesTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        name: name ?? this.name,
        code: code ?? this.code,
        address: address.present ? address.value : this.address,
        phone: phone.present ? phone.value : this.phone,
        isDefault: isDefault ?? this.isDefault,
        isActive: isActive ?? this.isActive,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  BranchesTableData copyWithCompanion(BranchesTableCompanion data) {
    return BranchesTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      address: data.address.present ? data.address.value : this.address,
      phone: data.phone.present ? data.phone.value : this.phone,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BranchesTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('isDefault: $isDefault, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, tenantId, name, code, address, phone, isDefault, isActive, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BranchesTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.name == this.name &&
          other.code == this.code &&
          other.address == this.address &&
          other.phone == this.phone &&
          other.isDefault == this.isDefault &&
          other.isActive == this.isActive &&
          other.updatedAt == this.updatedAt);
}

class BranchesTableCompanion extends UpdateCompanion<BranchesTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> name;
  final Value<String> code;
  final Value<String?> address;
  final Value<String?> phone;
  final Value<bool> isDefault;
  final Value<bool> isActive;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BranchesTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BranchesTableCompanion.insert({
    required String id,
    required String tenantId,
    required String name,
    required String code,
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        name = Value(name),
        code = Value(code),
        updatedAt = Value(updatedAt);
  static Insertable<BranchesTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? address,
    Expression<String>? phone,
    Expression<bool>? isDefault,
    Expression<bool>? isActive,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (isDefault != null) 'is_default': isDefault,
      if (isActive != null) 'is_active': isActive,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BranchesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? name,
      Value<String>? code,
      Value<String?>? address,
      Value<String?>? phone,
      Value<bool>? isDefault,
      Value<bool>? isActive,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return BranchesTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      code: code ?? this.code,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      isDefault: isDefault ?? this.isDefault,
      isActive: isActive ?? this.isActive,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BranchesTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('isDefault: $isDefault, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmployeesTableTable extends EmployeesTable
    with TableInfo<$EmployeesTableTable, EmployeesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleIdMeta = const VerificationMeta('roleId');
  @override
  late final GeneratedColumn<String> roleId = GeneratedColumn<String>(
      'role_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pinHashMeta =
      const VerificationMeta('pinHash');
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
      'pin_hash', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        branchId,
        name,
        email,
        roleId,
        pinHash,
        isActive,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employees_table';
  @override
  VerificationContext validateIntegrity(Insertable<EmployeesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('role_id')) {
      context.handle(_roleIdMeta,
          roleId.isAcceptableOrUnknown(data['role_id']!, _roleIdMeta));
    } else if (isInserting) {
      context.missing(_roleIdMeta);
    }
    if (data.containsKey('pin_hash')) {
      context.handle(_pinHashMeta,
          pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmployeesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmployeesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      roleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role_id'])!,
      pinHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pin_hash']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $EmployeesTableTable createAlias(String alias) {
    return $EmployeesTableTable(attachedDatabase, alias);
  }
}

class EmployeesTableData extends DataClass
    implements Insertable<EmployeesTableData> {
  final String id;
  final String tenantId;
  final String branchId;
  final String name;
  final String email;
  final String roleId;
  final String? pinHash;
  final bool isActive;
  final DateTime updatedAt;
  const EmployeesTableData(
      {required this.id,
      required this.tenantId,
      required this.branchId,
      required this.name,
      required this.email,
      required this.roleId,
      this.pinHash,
      required this.isActive,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['role_id'] = Variable<String>(roleId);
    if (!nullToAbsent || pinHash != null) {
      map['pin_hash'] = Variable<String>(pinHash);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EmployeesTableCompanion toCompanion(bool nullToAbsent) {
    return EmployeesTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      name: Value(name),
      email: Value(email),
      roleId: Value(roleId),
      pinHash: pinHash == null && nullToAbsent
          ? const Value.absent()
          : Value(pinHash),
      isActive: Value(isActive),
      updatedAt: Value(updatedAt),
    );
  }

  factory EmployeesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmployeesTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      roleId: serializer.fromJson<String>(json['roleId']),
      pinHash: serializer.fromJson<String?>(json['pinHash']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'roleId': serializer.toJson<String>(roleId),
      'pinHash': serializer.toJson<String?>(pinHash),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EmployeesTableData copyWith(
          {String? id,
          String? tenantId,
          String? branchId,
          String? name,
          String? email,
          String? roleId,
          Value<String?> pinHash = const Value.absent(),
          bool? isActive,
          DateTime? updatedAt}) =>
      EmployeesTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        name: name ?? this.name,
        email: email ?? this.email,
        roleId: roleId ?? this.roleId,
        pinHash: pinHash.present ? pinHash.value : this.pinHash,
        isActive: isActive ?? this.isActive,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  EmployeesTableData copyWithCompanion(EmployeesTableCompanion data) {
    return EmployeesTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      roleId: data.roleId.present ? data.roleId.value : this.roleId,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('roleId: $roleId, ')
          ..write('pinHash: $pinHash, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, branchId, name, email, roleId,
      pinHash, isActive, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmployeesTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.email == this.email &&
          other.roleId == this.roleId &&
          other.pinHash == this.pinHash &&
          other.isActive == this.isActive &&
          other.updatedAt == this.updatedAt);
}

class EmployeesTableCompanion extends UpdateCompanion<EmployeesTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> name;
  final Value<String> email;
  final Value<String> roleId;
  final Value<String?> pinHash;
  final Value<bool> isActive;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const EmployeesTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.roleId = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmployeesTableCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    required String name,
    required String email,
    required String roleId,
    this.pinHash = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        branchId = Value(branchId),
        name = Value(name),
        email = Value(email),
        roleId = Value(roleId),
        updatedAt = Value(updatedAt);
  static Insertable<EmployeesTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? roleId,
    Expression<String>? pinHash,
    Expression<bool>? isActive,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (roleId != null) 'role_id': roleId,
      if (pinHash != null) 'pin_hash': pinHash,
      if (isActive != null) 'is_active': isActive,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmployeesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String>? name,
      Value<String>? email,
      Value<String>? roleId,
      Value<String?>? pinHash,
      Value<bool>? isActive,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return EmployeesTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      email: email ?? this.email,
      roleId: roleId ?? this.roleId,
      pinHash: pinHash ?? this.pinHash,
      isActive: isActive ?? this.isActive,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (roleId.present) {
      map['role_id'] = Variable<String>(roleId.value);
    }
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('roleId: $roleId, ')
          ..write('pinHash: $pinHash, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DevicesTableTable extends DevicesTable
    with TableInfo<$DevicesTableTable, DevicesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevicesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deviceSeriesMeta =
      const VerificationMeta('deviceSeries');
  @override
  late final GeneratedColumn<String> deviceSeries = GeneratedColumn<String>(
      'device_series', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, tenantId, branchId, deviceSeries, name, isActive, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devices_table';
  @override
  VerificationContext validateIntegrity(Insertable<DevicesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('device_series')) {
      context.handle(
          _deviceSeriesMeta,
          deviceSeries.isAcceptableOrUnknown(
              data['device_series']!, _deviceSeriesMeta));
    } else if (isInserting) {
      context.missing(_deviceSeriesMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DevicesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DevicesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      deviceSeries: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_series'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DevicesTableTable createAlias(String alias) {
    return $DevicesTableTable(attachedDatabase, alias);
  }
}

class DevicesTableData extends DataClass
    implements Insertable<DevicesTableData> {
  final String id;
  final String tenantId;
  final String branchId;
  final String deviceSeries;
  final String name;
  final bool isActive;
  final DateTime updatedAt;
  const DevicesTableData(
      {required this.id,
      required this.tenantId,
      required this.branchId,
      required this.deviceSeries,
      required this.name,
      required this.isActive,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['device_series'] = Variable<String>(deviceSeries);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DevicesTableCompanion toCompanion(bool nullToAbsent) {
    return DevicesTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      deviceSeries: Value(deviceSeries),
      name: Value(name),
      isActive: Value(isActive),
      updatedAt: Value(updatedAt),
    );
  }

  factory DevicesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DevicesTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      deviceSeries: serializer.fromJson<String>(json['deviceSeries']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'deviceSeries': serializer.toJson<String>(deviceSeries),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DevicesTableData copyWith(
          {String? id,
          String? tenantId,
          String? branchId,
          String? deviceSeries,
          String? name,
          bool? isActive,
          DateTime? updatedAt}) =>
      DevicesTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        deviceSeries: deviceSeries ?? this.deviceSeries,
        name: name ?? this.name,
        isActive: isActive ?? this.isActive,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DevicesTableData copyWithCompanion(DevicesTableCompanion data) {
    return DevicesTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      deviceSeries: data.deviceSeries.present
          ? data.deviceSeries.value
          : this.deviceSeries,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DevicesTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('deviceSeries: $deviceSeries, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, tenantId, branchId, deviceSeries, name, isActive, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DevicesTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.deviceSeries == this.deviceSeries &&
          other.name == this.name &&
          other.isActive == this.isActive &&
          other.updatedAt == this.updatedAt);
}

class DevicesTableCompanion extends UpdateCompanion<DevicesTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> deviceSeries;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DevicesTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.deviceSeries = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DevicesTableCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    required String deviceSeries,
    required String name,
    this.isActive = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        branchId = Value(branchId),
        deviceSeries = Value(deviceSeries),
        name = Value(name),
        updatedAt = Value(updatedAt);
  static Insertable<DevicesTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? deviceSeries,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (deviceSeries != null) 'device_series': deviceSeries,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DevicesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String>? deviceSeries,
      Value<String>? name,
      Value<bool>? isActive,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return DevicesTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      deviceSeries: deviceSeries ?? this.deviceSeries,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (deviceSeries.present) {
      map['device_series'] = Variable<String>(deviceSeries.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevicesTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('deviceSeries: $deviceSeries, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTableTable extends AuditLogsTable
    with TableInfo<$AuditLogsTableTable, AuditLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
      'action', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _detailsJsonMeta =
      const VerificationMeta('detailsJson');
  @override
  late final GeneratedColumn<String> detailsJson = GeneratedColumn<String>(
      'details_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        branchId,
        employeeId,
        action,
        entityType,
        entityId,
        detailsJson,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs_table';
  @override
  VerificationContext validateIntegrity(Insertable<AuditLogsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    }
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    }
    if (data.containsKey('details_json')) {
      context.handle(
          _detailsJsonMeta,
          detailsJson.isAcceptableOrUnknown(
              data['details_json']!, _detailsJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLogsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id']),
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id']),
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id']),
      detailsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}details_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AuditLogsTableTable createAlias(String alias) {
    return $AuditLogsTableTable(attachedDatabase, alias);
  }
}

class AuditLogsTableData extends DataClass
    implements Insertable<AuditLogsTableData> {
  final String id;
  final String tenantId;
  final String? branchId;
  final String? employeeId;
  final String action;
  final String entityType;
  final String? entityId;
  final String? detailsJson;
  final DateTime createdAt;
  const AuditLogsTableData(
      {required this.id,
      required this.tenantId,
      this.branchId,
      this.employeeId,
      required this.action,
      required this.entityType,
      this.entityId,
      this.detailsJson,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<String>(branchId);
    }
    if (!nullToAbsent || employeeId != null) {
      map['employee_id'] = Variable<String>(employeeId);
    }
    map['action'] = Variable<String>(action);
    map['entity_type'] = Variable<String>(entityType);
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<String>(entityId);
    }
    if (!nullToAbsent || detailsJson != null) {
      map['details_json'] = Variable<String>(detailsJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditLogsTableCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      employeeId: employeeId == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeId),
      action: Value(action),
      entityType: Value(entityType),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      detailsJson: detailsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(detailsJson),
      createdAt: Value(createdAt),
    );
  }

  factory AuditLogsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLogsTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String?>(json['branchId']),
      employeeId: serializer.fromJson<String?>(json['employeeId']),
      action: serializer.fromJson<String>(json['action']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String?>(json['entityId']),
      detailsJson: serializer.fromJson<String?>(json['detailsJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String?>(branchId),
      'employeeId': serializer.toJson<String?>(employeeId),
      'action': serializer.toJson<String>(action),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String?>(entityId),
      'detailsJson': serializer.toJson<String?>(detailsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditLogsTableData copyWith(
          {String? id,
          String? tenantId,
          Value<String?> branchId = const Value.absent(),
          Value<String?> employeeId = const Value.absent(),
          String? action,
          String? entityType,
          Value<String?> entityId = const Value.absent(),
          Value<String?> detailsJson = const Value.absent(),
          DateTime? createdAt}) =>
      AuditLogsTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId.present ? branchId.value : this.branchId,
        employeeId: employeeId.present ? employeeId.value : this.employeeId,
        action: action ?? this.action,
        entityType: entityType ?? this.entityType,
        entityId: entityId.present ? entityId.value : this.entityId,
        detailsJson: detailsJson.present ? detailsJson.value : this.detailsJson,
        createdAt: createdAt ?? this.createdAt,
      );
  AuditLogsTableData copyWithCompanion(AuditLogsTableCompanion data) {
    return AuditLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      action: data.action.present ? data.action.value : this.action,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      detailsJson:
          data.detailsJson.present ? data.detailsJson.value : this.detailsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('employeeId: $employeeId, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('detailsJson: $detailsJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, branchId, employeeId, action,
      entityType, entityId, detailsJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLogsTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.employeeId == this.employeeId &&
          other.action == this.action &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.detailsJson == this.detailsJson &&
          other.createdAt == this.createdAt);
}

class AuditLogsTableCompanion extends UpdateCompanion<AuditLogsTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String?> branchId;
  final Value<String?> employeeId;
  final Value<String> action;
  final Value<String> entityType;
  final Value<String?> entityId;
  final Value<String?> detailsJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AuditLogsTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.action = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.detailsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditLogsTableCompanion.insert({
    required String id,
    required String tenantId,
    this.branchId = const Value.absent(),
    this.employeeId = const Value.absent(),
    required String action,
    required String entityType,
    this.entityId = const Value.absent(),
    this.detailsJson = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        action = Value(action),
        entityType = Value(entityType),
        createdAt = Value(createdAt);
  static Insertable<AuditLogsTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? employeeId,
    Expression<String>? action,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? detailsJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (employeeId != null) 'employee_id': employeeId,
      if (action != null) 'action': action,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (detailsJson != null) 'details_json': detailsJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditLogsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String?>? branchId,
      Value<String?>? employeeId,
      Value<String>? action,
      Value<String>? entityType,
      Value<String?>? entityId,
      Value<String?>? detailsJson,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return AuditLogsTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      employeeId: employeeId ?? this.employeeId,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      detailsJson: detailsJson ?? this.detailsJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (detailsJson.present) {
      map['details_json'] = Variable<String>(detailsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('employeeId: $employeeId, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('detailsJson: $detailsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SyncOutboxTableTable syncOutboxTable =
      $SyncOutboxTableTable(this);
  late final $SyncStateTableTable syncStateTable = $SyncStateTableTable(this);
  late final $AppConfigTableTable appConfigTable = $AppConfigTableTable(this);
  late final $TenantsTableTable tenantsTable = $TenantsTableTable(this);
  late final $TenantSettingsTableTable tenantSettingsTable =
      $TenantSettingsTableTable(this);
  late final $BranchesTableTable branchesTable = $BranchesTableTable(this);
  late final $EmployeesTableTable employeesTable = $EmployeesTableTable(this);
  late final $DevicesTableTable devicesTable = $DevicesTableTable(this);
  late final $AuditLogsTableTable auditLogsTable = $AuditLogsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        syncOutboxTable,
        syncStateTable,
        appConfigTable,
        tenantsTable,
        tenantSettingsTable,
        branchesTable,
        employeesTable,
        devicesTable,
        auditLogsTable
      ];
}

typedef $$SyncOutboxTableTableCreateCompanionBuilder = SyncOutboxTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String branchId,
  required String operationUuid,
  required String entityType,
  required String entityId,
  required String operation,
  required String payload,
  required DateTime createdAt,
  Value<String> status,
  Value<int> retryCount,
  Value<String?> errorMessage,
  Value<int> rowid,
});
typedef $$SyncOutboxTableTableUpdateCompanionBuilder = SyncOutboxTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String> operationUuid,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> operation,
  Value<String> payload,
  Value<DateTime> createdAt,
  Value<String> status,
  Value<int> retryCount,
  Value<String?> errorMessage,
  Value<int> rowid,
});

class $$SyncOutboxTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOutboxTableTable> {
  $$SyncOutboxTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operationUuid => $composableBuilder(
      column: $table.operationUuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));
}

class $$SyncOutboxTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOutboxTableTable> {
  $$SyncOutboxTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operationUuid => $composableBuilder(
      column: $table.operationUuid,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));
}

class $$SyncOutboxTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOutboxTableTable> {
  $$SyncOutboxTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get operationUuid => $composableBuilder(
      column: $table.operationUuid, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);
}

class $$SyncOutboxTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncOutboxTableTable,
    SyncOutboxTableData,
    $$SyncOutboxTableTableFilterComposer,
    $$SyncOutboxTableTableOrderingComposer,
    $$SyncOutboxTableTableAnnotationComposer,
    $$SyncOutboxTableTableCreateCompanionBuilder,
    $$SyncOutboxTableTableUpdateCompanionBuilder,
    (
      SyncOutboxTableData,
      BaseReferences<_$AppDatabase, $SyncOutboxTableTable, SyncOutboxTableData>
    ),
    SyncOutboxTableData,
    PrefetchHooks Function()> {
  $$SyncOutboxTableTableTableManager(
      _$AppDatabase db, $SyncOutboxTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOutboxTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOutboxTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOutboxTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> operationUuid = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncOutboxTableCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            operationUuid: operationUuid,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: payload,
            createdAt: createdAt,
            status: status,
            retryCount: retryCount,
            errorMessage: errorMessage,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String branchId,
            required String operationUuid,
            required String entityType,
            required String entityId,
            required String operation,
            required String payload,
            required DateTime createdAt,
            Value<String> status = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncOutboxTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            operationUuid: operationUuid,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: payload,
            createdAt: createdAt,
            status: status,
            retryCount: retryCount,
            errorMessage: errorMessage,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncOutboxTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncOutboxTableTable,
    SyncOutboxTableData,
    $$SyncOutboxTableTableFilterComposer,
    $$SyncOutboxTableTableOrderingComposer,
    $$SyncOutboxTableTableAnnotationComposer,
    $$SyncOutboxTableTableCreateCompanionBuilder,
    $$SyncOutboxTableTableUpdateCompanionBuilder,
    (
      SyncOutboxTableData,
      BaseReferences<_$AppDatabase, $SyncOutboxTableTable, SyncOutboxTableData>
    ),
    SyncOutboxTableData,
    PrefetchHooks Function()>;
typedef $$SyncStateTableTableCreateCompanionBuilder = SyncStateTableCompanion
    Function({
  required String targetEntity,
  required DateTime lastSyncedAt,
  Value<String?> lastCursor,
  Value<int> rowid,
});
typedef $$SyncStateTableTableUpdateCompanionBuilder = SyncStateTableCompanion
    Function({
  Value<String> targetEntity,
  Value<DateTime> lastSyncedAt,
  Value<String?> lastCursor,
  Value<int> rowid,
});

class $$SyncStateTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStateTableTable> {
  $$SyncStateTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get targetEntity => $composableBuilder(
      column: $table.targetEntity, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastCursor => $composableBuilder(
      column: $table.lastCursor, builder: (column) => ColumnFilters(column));
}

class $$SyncStateTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStateTableTable> {
  $$SyncStateTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get targetEntity => $composableBuilder(
      column: $table.targetEntity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastCursor => $composableBuilder(
      column: $table.lastCursor, builder: (column) => ColumnOrderings(column));
}

class $$SyncStateTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStateTableTable> {
  $$SyncStateTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get targetEntity => $composableBuilder(
      column: $table.targetEntity, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<String> get lastCursor => $composableBuilder(
      column: $table.lastCursor, builder: (column) => column);
}

class $$SyncStateTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncStateTableTable,
    SyncStateTableData,
    $$SyncStateTableTableFilterComposer,
    $$SyncStateTableTableOrderingComposer,
    $$SyncStateTableTableAnnotationComposer,
    $$SyncStateTableTableCreateCompanionBuilder,
    $$SyncStateTableTableUpdateCompanionBuilder,
    (
      SyncStateTableData,
      BaseReferences<_$AppDatabase, $SyncStateTableTable, SyncStateTableData>
    ),
    SyncStateTableData,
    PrefetchHooks Function()> {
  $$SyncStateTableTableTableManager(
      _$AppDatabase db, $SyncStateTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStateTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStateTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStateTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> targetEntity = const Value.absent(),
            Value<DateTime> lastSyncedAt = const Value.absent(),
            Value<String?> lastCursor = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncStateTableCompanion(
            targetEntity: targetEntity,
            lastSyncedAt: lastSyncedAt,
            lastCursor: lastCursor,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String targetEntity,
            required DateTime lastSyncedAt,
            Value<String?> lastCursor = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncStateTableCompanion.insert(
            targetEntity: targetEntity,
            lastSyncedAt: lastSyncedAt,
            lastCursor: lastCursor,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncStateTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncStateTableTable,
    SyncStateTableData,
    $$SyncStateTableTableFilterComposer,
    $$SyncStateTableTableOrderingComposer,
    $$SyncStateTableTableAnnotationComposer,
    $$SyncStateTableTableCreateCompanionBuilder,
    $$SyncStateTableTableUpdateCompanionBuilder,
    (
      SyncStateTableData,
      BaseReferences<_$AppDatabase, $SyncStateTableTable, SyncStateTableData>
    ),
    SyncStateTableData,
    PrefetchHooks Function()>;
typedef $$AppConfigTableTableCreateCompanionBuilder = AppConfigTableCompanion
    Function({
  required String configKey,
  required String configValue,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$AppConfigTableTableUpdateCompanionBuilder = AppConfigTableCompanion
    Function({
  Value<String> configKey,
  Value<String> configValue,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$AppConfigTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppConfigTableTable> {
  $$AppConfigTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get configKey => $composableBuilder(
      column: $table.configKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get configValue => $composableBuilder(
      column: $table.configValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AppConfigTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppConfigTableTable> {
  $$AppConfigTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get configKey => $composableBuilder(
      column: $table.configKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get configValue => $composableBuilder(
      column: $table.configValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AppConfigTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppConfigTableTable> {
  $$AppConfigTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get configKey =>
      $composableBuilder(column: $table.configKey, builder: (column) => column);

  GeneratedColumn<String> get configValue => $composableBuilder(
      column: $table.configValue, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppConfigTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppConfigTableTable,
    AppConfigTableData,
    $$AppConfigTableTableFilterComposer,
    $$AppConfigTableTableOrderingComposer,
    $$AppConfigTableTableAnnotationComposer,
    $$AppConfigTableTableCreateCompanionBuilder,
    $$AppConfigTableTableUpdateCompanionBuilder,
    (
      AppConfigTableData,
      BaseReferences<_$AppDatabase, $AppConfigTableTable, AppConfigTableData>
    ),
    AppConfigTableData,
    PrefetchHooks Function()> {
  $$AppConfigTableTableTableManager(
      _$AppDatabase db, $AppConfigTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppConfigTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppConfigTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppConfigTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> configKey = const Value.absent(),
            Value<String> configValue = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppConfigTableCompanion(
            configKey: configKey,
            configValue: configValue,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String configKey,
            required String configValue,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppConfigTableCompanion.insert(
            configKey: configKey,
            configValue: configValue,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppConfigTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppConfigTableTable,
    AppConfigTableData,
    $$AppConfigTableTableFilterComposer,
    $$AppConfigTableTableOrderingComposer,
    $$AppConfigTableTableAnnotationComposer,
    $$AppConfigTableTableCreateCompanionBuilder,
    $$AppConfigTableTableUpdateCompanionBuilder,
    (
      AppConfigTableData,
      BaseReferences<_$AppDatabase, $AppConfigTableTable, AppConfigTableData>
    ),
    AppConfigTableData,
    PrefetchHooks Function()>;
typedef $$TenantsTableTableCreateCompanionBuilder = TenantsTableCompanion
    Function({
  required String id,
  required String name,
  required String slug,
  Value<bool> isActive,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$TenantsTableTableUpdateCompanionBuilder = TenantsTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> slug,
  Value<bool> isActive,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$TenantsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TenantsTableTable> {
  $$TenantsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$TenantsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TenantsTableTable> {
  $$TenantsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TenantsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TenantsTableTable> {
  $$TenantsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TenantsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TenantsTableTable,
    TenantsTableData,
    $$TenantsTableTableFilterComposer,
    $$TenantsTableTableOrderingComposer,
    $$TenantsTableTableAnnotationComposer,
    $$TenantsTableTableCreateCompanionBuilder,
    $$TenantsTableTableUpdateCompanionBuilder,
    (
      TenantsTableData,
      BaseReferences<_$AppDatabase, $TenantsTableTable, TenantsTableData>
    ),
    TenantsTableData,
    PrefetchHooks Function()> {
  $$TenantsTableTableTableManager(_$AppDatabase db, $TenantsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TenantsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TenantsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TenantsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> slug = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TenantsTableCompanion(
            id: id,
            name: name,
            slug: slug,
            isActive: isActive,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String slug,
            Value<bool> isActive = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TenantsTableCompanion.insert(
            id: id,
            name: name,
            slug: slug,
            isActive: isActive,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TenantsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TenantsTableTable,
    TenantsTableData,
    $$TenantsTableTableFilterComposer,
    $$TenantsTableTableOrderingComposer,
    $$TenantsTableTableAnnotationComposer,
    $$TenantsTableTableCreateCompanionBuilder,
    $$TenantsTableTableUpdateCompanionBuilder,
    (
      TenantsTableData,
      BaseReferences<_$AppDatabase, $TenantsTableTable, TenantsTableData>
    ),
    TenantsTableData,
    PrefetchHooks Function()>;
typedef $$TenantSettingsTableTableCreateCompanionBuilder
    = TenantSettingsTableCompanion Function({
  required String tenantId,
  Value<String> currency,
  Value<String> timezone,
  Value<String?> gstin,
  Value<String> invoicePrefix,
  Value<int> fiscalYearStartMonth,
  Value<String> roundOffStrategy,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$TenantSettingsTableTableUpdateCompanionBuilder
    = TenantSettingsTableCompanion Function({
  Value<String> tenantId,
  Value<String> currency,
  Value<String> timezone,
  Value<String?> gstin,
  Value<String> invoicePrefix,
  Value<int> fiscalYearStartMonth,
  Value<String> roundOffStrategy,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$TenantSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TenantSettingsTableTable> {
  $$TenantSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gstin => $composableBuilder(
      column: $table.gstin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get invoicePrefix => $composableBuilder(
      column: $table.invoicePrefix, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fiscalYearStartMonth => $composableBuilder(
      column: $table.fiscalYearStartMonth,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get roundOffStrategy => $composableBuilder(
      column: $table.roundOffStrategy,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$TenantSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TenantSettingsTableTable> {
  $$TenantSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gstin => $composableBuilder(
      column: $table.gstin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get invoicePrefix => $composableBuilder(
      column: $table.invoicePrefix,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fiscalYearStartMonth => $composableBuilder(
      column: $table.fiscalYearStartMonth,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get roundOffStrategy => $composableBuilder(
      column: $table.roundOffStrategy,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TenantSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TenantSettingsTableTable> {
  $$TenantSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get gstin =>
      $composableBuilder(column: $table.gstin, builder: (column) => column);

  GeneratedColumn<String> get invoicePrefix => $composableBuilder(
      column: $table.invoicePrefix, builder: (column) => column);

  GeneratedColumn<int> get fiscalYearStartMonth => $composableBuilder(
      column: $table.fiscalYearStartMonth, builder: (column) => column);

  GeneratedColumn<String> get roundOffStrategy => $composableBuilder(
      column: $table.roundOffStrategy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TenantSettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TenantSettingsTableTable,
    TenantSettingsTableData,
    $$TenantSettingsTableTableFilterComposer,
    $$TenantSettingsTableTableOrderingComposer,
    $$TenantSettingsTableTableAnnotationComposer,
    $$TenantSettingsTableTableCreateCompanionBuilder,
    $$TenantSettingsTableTableUpdateCompanionBuilder,
    (
      TenantSettingsTableData,
      BaseReferences<_$AppDatabase, $TenantSettingsTableTable,
          TenantSettingsTableData>
    ),
    TenantSettingsTableData,
    PrefetchHooks Function()> {
  $$TenantSettingsTableTableTableManager(
      _$AppDatabase db, $TenantSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TenantSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TenantSettingsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TenantSettingsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> tenantId = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String> timezone = const Value.absent(),
            Value<String?> gstin = const Value.absent(),
            Value<String> invoicePrefix = const Value.absent(),
            Value<int> fiscalYearStartMonth = const Value.absent(),
            Value<String> roundOffStrategy = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TenantSettingsTableCompanion(
            tenantId: tenantId,
            currency: currency,
            timezone: timezone,
            gstin: gstin,
            invoicePrefix: invoicePrefix,
            fiscalYearStartMonth: fiscalYearStartMonth,
            roundOffStrategy: roundOffStrategy,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String tenantId,
            Value<String> currency = const Value.absent(),
            Value<String> timezone = const Value.absent(),
            Value<String?> gstin = const Value.absent(),
            Value<String> invoicePrefix = const Value.absent(),
            Value<int> fiscalYearStartMonth = const Value.absent(),
            Value<String> roundOffStrategy = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TenantSettingsTableCompanion.insert(
            tenantId: tenantId,
            currency: currency,
            timezone: timezone,
            gstin: gstin,
            invoicePrefix: invoicePrefix,
            fiscalYearStartMonth: fiscalYearStartMonth,
            roundOffStrategy: roundOffStrategy,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TenantSettingsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TenantSettingsTableTable,
    TenantSettingsTableData,
    $$TenantSettingsTableTableFilterComposer,
    $$TenantSettingsTableTableOrderingComposer,
    $$TenantSettingsTableTableAnnotationComposer,
    $$TenantSettingsTableTableCreateCompanionBuilder,
    $$TenantSettingsTableTableUpdateCompanionBuilder,
    (
      TenantSettingsTableData,
      BaseReferences<_$AppDatabase, $TenantSettingsTableTable,
          TenantSettingsTableData>
    ),
    TenantSettingsTableData,
    PrefetchHooks Function()>;
typedef $$BranchesTableTableCreateCompanionBuilder = BranchesTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String name,
  required String code,
  Value<String?> address,
  Value<String?> phone,
  Value<bool> isDefault,
  Value<bool> isActive,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$BranchesTableTableUpdateCompanionBuilder = BranchesTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> name,
  Value<String> code,
  Value<String?> address,
  Value<String?> phone,
  Value<bool> isDefault,
  Value<bool> isActive,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$BranchesTableTableFilterComposer
    extends Composer<_$AppDatabase, $BranchesTableTable> {
  $$BranchesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$BranchesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BranchesTableTable> {
  $$BranchesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$BranchesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BranchesTableTable> {
  $$BranchesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BranchesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BranchesTableTable,
    BranchesTableData,
    $$BranchesTableTableFilterComposer,
    $$BranchesTableTableOrderingComposer,
    $$BranchesTableTableAnnotationComposer,
    $$BranchesTableTableCreateCompanionBuilder,
    $$BranchesTableTableUpdateCompanionBuilder,
    (
      BranchesTableData,
      BaseReferences<_$AppDatabase, $BranchesTableTable, BranchesTableData>
    ),
    BranchesTableData,
    PrefetchHooks Function()> {
  $$BranchesTableTableTableManager(_$AppDatabase db, $BranchesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BranchesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BranchesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BranchesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BranchesTableCompanion(
            id: id,
            tenantId: tenantId,
            name: name,
            code: code,
            address: address,
            phone: phone,
            isDefault: isDefault,
            isActive: isActive,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String name,
            required String code,
            Value<String?> address = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              BranchesTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            name: name,
            code: code,
            address: address,
            phone: phone,
            isDefault: isDefault,
            isActive: isActive,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BranchesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BranchesTableTable,
    BranchesTableData,
    $$BranchesTableTableFilterComposer,
    $$BranchesTableTableOrderingComposer,
    $$BranchesTableTableAnnotationComposer,
    $$BranchesTableTableCreateCompanionBuilder,
    $$BranchesTableTableUpdateCompanionBuilder,
    (
      BranchesTableData,
      BaseReferences<_$AppDatabase, $BranchesTableTable, BranchesTableData>
    ),
    BranchesTableData,
    PrefetchHooks Function()>;
typedef $$EmployeesTableTableCreateCompanionBuilder = EmployeesTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String branchId,
  required String name,
  required String email,
  required String roleId,
  Value<String?> pinHash,
  Value<bool> isActive,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$EmployeesTableTableUpdateCompanionBuilder = EmployeesTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String> name,
  Value<String> email,
  Value<String> roleId,
  Value<String?> pinHash,
  Value<bool> isActive,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$EmployeesTableTableFilterComposer
    extends Composer<_$AppDatabase, $EmployeesTableTable> {
  $$EmployeesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get roleId => $composableBuilder(
      column: $table.roleId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pinHash => $composableBuilder(
      column: $table.pinHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$EmployeesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EmployeesTableTable> {
  $$EmployeesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get roleId => $composableBuilder(
      column: $table.roleId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pinHash => $composableBuilder(
      column: $table.pinHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$EmployeesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmployeesTableTable> {
  $$EmployeesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get roleId =>
      $composableBuilder(column: $table.roleId, builder: (column) => column);

  GeneratedColumn<String> get pinHash =>
      $composableBuilder(column: $table.pinHash, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EmployeesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EmployeesTableTable,
    EmployeesTableData,
    $$EmployeesTableTableFilterComposer,
    $$EmployeesTableTableOrderingComposer,
    $$EmployeesTableTableAnnotationComposer,
    $$EmployeesTableTableCreateCompanionBuilder,
    $$EmployeesTableTableUpdateCompanionBuilder,
    (
      EmployeesTableData,
      BaseReferences<_$AppDatabase, $EmployeesTableTable, EmployeesTableData>
    ),
    EmployeesTableData,
    PrefetchHooks Function()> {
  $$EmployeesTableTableTableManager(
      _$AppDatabase db, $EmployeesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> roleId = const Value.absent(),
            Value<String?> pinHash = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EmployeesTableCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            name: name,
            email: email,
            roleId: roleId,
            pinHash: pinHash,
            isActive: isActive,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String branchId,
            required String name,
            required String email,
            required String roleId,
            Value<String?> pinHash = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              EmployeesTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            name: name,
            email: email,
            roleId: roleId,
            pinHash: pinHash,
            isActive: isActive,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EmployeesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EmployeesTableTable,
    EmployeesTableData,
    $$EmployeesTableTableFilterComposer,
    $$EmployeesTableTableOrderingComposer,
    $$EmployeesTableTableAnnotationComposer,
    $$EmployeesTableTableCreateCompanionBuilder,
    $$EmployeesTableTableUpdateCompanionBuilder,
    (
      EmployeesTableData,
      BaseReferences<_$AppDatabase, $EmployeesTableTable, EmployeesTableData>
    ),
    EmployeesTableData,
    PrefetchHooks Function()>;
typedef $$DevicesTableTableCreateCompanionBuilder = DevicesTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String branchId,
  required String deviceSeries,
  required String name,
  Value<bool> isActive,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$DevicesTableTableUpdateCompanionBuilder = DevicesTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String> deviceSeries,
  Value<String> name,
  Value<bool> isActive,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$DevicesTableTableFilterComposer
    extends Composer<_$AppDatabase, $DevicesTableTable> {
  $$DevicesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceSeries => $composableBuilder(
      column: $table.deviceSeries, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DevicesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DevicesTableTable> {
  $$DevicesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceSeries => $composableBuilder(
      column: $table.deviceSeries,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DevicesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DevicesTableTable> {
  $$DevicesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get deviceSeries => $composableBuilder(
      column: $table.deviceSeries, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DevicesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DevicesTableTable,
    DevicesTableData,
    $$DevicesTableTableFilterComposer,
    $$DevicesTableTableOrderingComposer,
    $$DevicesTableTableAnnotationComposer,
    $$DevicesTableTableCreateCompanionBuilder,
    $$DevicesTableTableUpdateCompanionBuilder,
    (
      DevicesTableData,
      BaseReferences<_$AppDatabase, $DevicesTableTable, DevicesTableData>
    ),
    DevicesTableData,
    PrefetchHooks Function()> {
  $$DevicesTableTableTableManager(_$AppDatabase db, $DevicesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevicesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevicesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevicesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> deviceSeries = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DevicesTableCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            deviceSeries: deviceSeries,
            name: name,
            isActive: isActive,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String branchId,
            required String deviceSeries,
            required String name,
            Value<bool> isActive = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              DevicesTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            deviceSeries: deviceSeries,
            name: name,
            isActive: isActive,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DevicesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DevicesTableTable,
    DevicesTableData,
    $$DevicesTableTableFilterComposer,
    $$DevicesTableTableOrderingComposer,
    $$DevicesTableTableAnnotationComposer,
    $$DevicesTableTableCreateCompanionBuilder,
    $$DevicesTableTableUpdateCompanionBuilder,
    (
      DevicesTableData,
      BaseReferences<_$AppDatabase, $DevicesTableTable, DevicesTableData>
    ),
    DevicesTableData,
    PrefetchHooks Function()>;
typedef $$AuditLogsTableTableCreateCompanionBuilder = AuditLogsTableCompanion
    Function({
  required String id,
  required String tenantId,
  Value<String?> branchId,
  Value<String?> employeeId,
  required String action,
  required String entityType,
  Value<String?> entityId,
  Value<String?> detailsJson,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$AuditLogsTableTableUpdateCompanionBuilder = AuditLogsTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String?> branchId,
  Value<String?> employeeId,
  Value<String> action,
  Value<String> entityType,
  Value<String?> entityId,
  Value<String?> detailsJson,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$AuditLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTableTable> {
  $$AuditLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get detailsJson => $composableBuilder(
      column: $table.detailsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$AuditLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTableTable> {
  $$AuditLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get detailsJson => $composableBuilder(
      column: $table.detailsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AuditLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTableTable> {
  $$AuditLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get detailsJson => $composableBuilder(
      column: $table.detailsJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AuditLogsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AuditLogsTableTable,
    AuditLogsTableData,
    $$AuditLogsTableTableFilterComposer,
    $$AuditLogsTableTableOrderingComposer,
    $$AuditLogsTableTableAnnotationComposer,
    $$AuditLogsTableTableCreateCompanionBuilder,
    $$AuditLogsTableTableUpdateCompanionBuilder,
    (
      AuditLogsTableData,
      BaseReferences<_$AppDatabase, $AuditLogsTableTable, AuditLogsTableData>
    ),
    AuditLogsTableData,
    PrefetchHooks Function()> {
  $$AuditLogsTableTableTableManager(
      _$AppDatabase db, $AuditLogsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String?> branchId = const Value.absent(),
            Value<String?> employeeId = const Value.absent(),
            Value<String> action = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String?> entityId = const Value.absent(),
            Value<String?> detailsJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AuditLogsTableCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            employeeId: employeeId,
            action: action,
            entityType: entityType,
            entityId: entityId,
            detailsJson: detailsJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            Value<String?> branchId = const Value.absent(),
            Value<String?> employeeId = const Value.absent(),
            required String action,
            required String entityType,
            Value<String?> entityId = const Value.absent(),
            Value<String?> detailsJson = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AuditLogsTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            employeeId: employeeId,
            action: action,
            entityType: entityType,
            entityId: entityId,
            detailsJson: detailsJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AuditLogsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AuditLogsTableTable,
    AuditLogsTableData,
    $$AuditLogsTableTableFilterComposer,
    $$AuditLogsTableTableOrderingComposer,
    $$AuditLogsTableTableAnnotationComposer,
    $$AuditLogsTableTableCreateCompanionBuilder,
    $$AuditLogsTableTableUpdateCompanionBuilder,
    (
      AuditLogsTableData,
      BaseReferences<_$AppDatabase, $AuditLogsTableTable, AuditLogsTableData>
    ),
    AuditLogsTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SyncOutboxTableTableTableManager get syncOutboxTable =>
      $$SyncOutboxTableTableTableManager(_db, _db.syncOutboxTable);
  $$SyncStateTableTableTableManager get syncStateTable =>
      $$SyncStateTableTableTableManager(_db, _db.syncStateTable);
  $$AppConfigTableTableTableManager get appConfigTable =>
      $$AppConfigTableTableTableManager(_db, _db.appConfigTable);
  $$TenantsTableTableTableManager get tenantsTable =>
      $$TenantsTableTableTableManager(_db, _db.tenantsTable);
  $$TenantSettingsTableTableTableManager get tenantSettingsTable =>
      $$TenantSettingsTableTableTableManager(_db, _db.tenantSettingsTable);
  $$BranchesTableTableTableManager get branchesTable =>
      $$BranchesTableTableTableManager(_db, _db.branchesTable);
  $$EmployeesTableTableTableManager get employeesTable =>
      $$EmployeesTableTableTableManager(_db, _db.employeesTable);
  $$DevicesTableTableTableManager get devicesTable =>
      $$DevicesTableTableTableManager(_db, _db.devicesTable);
  $$AuditLogsTableTableTableManager get auditLogsTable =>
      $$AuditLogsTableTableTableManager(_db, _db.auditLogsTable);
}
