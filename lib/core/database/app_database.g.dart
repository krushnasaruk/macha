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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SyncOutboxTableTable syncOutboxTable =
      $SyncOutboxTableTable(this);
  late final $SyncStateTableTable syncStateTable = $SyncStateTableTable(this);
  late final $AppConfigTableTable appConfigTable = $AppConfigTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [syncOutboxTable, syncStateTable, appConfigTable];
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SyncOutboxTableTableTableManager get syncOutboxTable =>
      $$SyncOutboxTableTableTableManager(_db, _db.syncOutboxTable);
  $$SyncStateTableTableTableManager get syncStateTable =>
      $$SyncStateTableTableTableManager(_db, _db.syncStateTable);
  $$AppConfigTableTableTableManager get appConfigTable =>
      $$AppConfigTableTableTableManager(_db, _db.appConfigTable);
}
