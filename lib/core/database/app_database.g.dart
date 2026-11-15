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

class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, tenantId, name, slug, sortOrder, isArchived, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<CategoriesTableData> instance,
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
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
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
  CategoriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }
}

class CategoriesTableData extends DataClass
    implements Insertable<CategoriesTableData> {
  final String id;
  final String tenantId;
  final String name;
  final String slug;
  final int sortOrder;
  final bool isArchived;
  final DateTime updatedAt;
  const CategoriesTableData(
      {required this.id,
      required this.tenantId,
      required this.name,
      required this.slug,
      required this.sortOrder,
      required this.isArchived,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_archived'] = Variable<bool>(isArchived);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      slug: Value(slug),
      sortOrder: Value(sortOrder),
      isArchived: Value(isArchived),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
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
      'slug': serializer.toJson<String>(slug),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isArchived': serializer.toJson<bool>(isArchived),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoriesTableData copyWith(
          {String? id,
          String? tenantId,
          String? name,
          String? slug,
          int? sortOrder,
          bool? isArchived,
          DateTime? updatedAt}) =>
      CategoriesTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        sortOrder: sortOrder ?? this.sortOrder,
        isArchived: isArchived ?? this.isArchived,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CategoriesTableData copyWithCompanion(CategoriesTableCompanion data) {
    return CategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tenantId, name, slug, sortOrder, isArchived, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.sortOrder == this.sortOrder &&
          other.isArchived == this.isArchived &&
          other.updatedAt == this.updatedAt);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoriesTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> name;
  final Value<String> slug;
  final Value<int> sortOrder;
  final Value<bool> isArchived;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    required String id,
    required String tenantId,
    required String name,
    required String slug,
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        name = Value(name),
        slug = Value(slug),
        updatedAt = Value(updatedAt);
  static Insertable<CategoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<int>? sortOrder,
    Expression<bool>? isArchived,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isArchived != null) 'is_archived': isArchived,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? name,
      Value<String>? slug,
      Value<int>? sortOrder,
      Value<bool>? isArchived,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      sortOrder: sortOrder ?? this.sortOrder,
      isArchived: isArchived ?? this.isArchived,
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
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
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
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaxCategoriesTableTable extends TaxCategoriesTable
    with TableInfo<$TaxCategoriesTableTable, TaxCategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaxCategoriesTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _hsnCodeMeta =
      const VerificationMeta('hsnCode');
  @override
  late final GeneratedColumn<String> hsnCode = GeneratedColumn<String>(
      'hsn_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cgstRateBpsMeta =
      const VerificationMeta('cgstRateBps');
  @override
  late final GeneratedColumn<int> cgstRateBps = GeneratedColumn<int>(
      'cgst_rate_bps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(250));
  static const VerificationMeta _sgstRateBpsMeta =
      const VerificationMeta('sgstRateBps');
  @override
  late final GeneratedColumn<int> sgstRateBps = GeneratedColumn<int>(
      'sgst_rate_bps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(250));
  static const VerificationMeta _igstRateBpsMeta =
      const VerificationMeta('igstRateBps');
  @override
  late final GeneratedColumn<int> igstRateBps = GeneratedColumn<int>(
      'igst_rate_bps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(500));
  static const VerificationMeta _isInclusiveMeta =
      const VerificationMeta('isInclusive');
  @override
  late final GeneratedColumn<bool> isInclusive = GeneratedColumn<bool>(
      'is_inclusive', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_inclusive" IN (0, 1))'),
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
        hsnCode,
        cgstRateBps,
        sgstRateBps,
        igstRateBps,
        isInclusive,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tax_categories_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TaxCategoriesTableData> instance,
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
    if (data.containsKey('hsn_code')) {
      context.handle(_hsnCodeMeta,
          hsnCode.isAcceptableOrUnknown(data['hsn_code']!, _hsnCodeMeta));
    }
    if (data.containsKey('cgst_rate_bps')) {
      context.handle(
          _cgstRateBpsMeta,
          cgstRateBps.isAcceptableOrUnknown(
              data['cgst_rate_bps']!, _cgstRateBpsMeta));
    }
    if (data.containsKey('sgst_rate_bps')) {
      context.handle(
          _sgstRateBpsMeta,
          sgstRateBps.isAcceptableOrUnknown(
              data['sgst_rate_bps']!, _sgstRateBpsMeta));
    }
    if (data.containsKey('igst_rate_bps')) {
      context.handle(
          _igstRateBpsMeta,
          igstRateBps.isAcceptableOrUnknown(
              data['igst_rate_bps']!, _igstRateBpsMeta));
    }
    if (data.containsKey('is_inclusive')) {
      context.handle(
          _isInclusiveMeta,
          isInclusive.isAcceptableOrUnknown(
              data['is_inclusive']!, _isInclusiveMeta));
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
  TaxCategoriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaxCategoriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      hsnCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hsn_code']),
      cgstRateBps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cgst_rate_bps'])!,
      sgstRateBps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sgst_rate_bps'])!,
      igstRateBps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}igst_rate_bps'])!,
      isInclusive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_inclusive'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TaxCategoriesTableTable createAlias(String alias) {
    return $TaxCategoriesTableTable(attachedDatabase, alias);
  }
}

class TaxCategoriesTableData extends DataClass
    implements Insertable<TaxCategoriesTableData> {
  final String id;
  final String tenantId;
  final String name;
  final String? hsnCode;
  final int cgstRateBps;
  final int sgstRateBps;
  final int igstRateBps;
  final bool isInclusive;
  final DateTime updatedAt;
  const TaxCategoriesTableData(
      {required this.id,
      required this.tenantId,
      required this.name,
      this.hsnCode,
      required this.cgstRateBps,
      required this.sgstRateBps,
      required this.igstRateBps,
      required this.isInclusive,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || hsnCode != null) {
      map['hsn_code'] = Variable<String>(hsnCode);
    }
    map['cgst_rate_bps'] = Variable<int>(cgstRateBps);
    map['sgst_rate_bps'] = Variable<int>(sgstRateBps);
    map['igst_rate_bps'] = Variable<int>(igstRateBps);
    map['is_inclusive'] = Variable<bool>(isInclusive);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TaxCategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return TaxCategoriesTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      hsnCode: hsnCode == null && nullToAbsent
          ? const Value.absent()
          : Value(hsnCode),
      cgstRateBps: Value(cgstRateBps),
      sgstRateBps: Value(sgstRateBps),
      igstRateBps: Value(igstRateBps),
      isInclusive: Value(isInclusive),
      updatedAt: Value(updatedAt),
    );
  }

  factory TaxCategoriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaxCategoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      name: serializer.fromJson<String>(json['name']),
      hsnCode: serializer.fromJson<String?>(json['hsnCode']),
      cgstRateBps: serializer.fromJson<int>(json['cgstRateBps']),
      sgstRateBps: serializer.fromJson<int>(json['sgstRateBps']),
      igstRateBps: serializer.fromJson<int>(json['igstRateBps']),
      isInclusive: serializer.fromJson<bool>(json['isInclusive']),
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
      'hsnCode': serializer.toJson<String?>(hsnCode),
      'cgstRateBps': serializer.toJson<int>(cgstRateBps),
      'sgstRateBps': serializer.toJson<int>(sgstRateBps),
      'igstRateBps': serializer.toJson<int>(igstRateBps),
      'isInclusive': serializer.toJson<bool>(isInclusive),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TaxCategoriesTableData copyWith(
          {String? id,
          String? tenantId,
          String? name,
          Value<String?> hsnCode = const Value.absent(),
          int? cgstRateBps,
          int? sgstRateBps,
          int? igstRateBps,
          bool? isInclusive,
          DateTime? updatedAt}) =>
      TaxCategoriesTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        name: name ?? this.name,
        hsnCode: hsnCode.present ? hsnCode.value : this.hsnCode,
        cgstRateBps: cgstRateBps ?? this.cgstRateBps,
        sgstRateBps: sgstRateBps ?? this.sgstRateBps,
        igstRateBps: igstRateBps ?? this.igstRateBps,
        isInclusive: isInclusive ?? this.isInclusive,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TaxCategoriesTableData copyWithCompanion(TaxCategoriesTableCompanion data) {
    return TaxCategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      name: data.name.present ? data.name.value : this.name,
      hsnCode: data.hsnCode.present ? data.hsnCode.value : this.hsnCode,
      cgstRateBps:
          data.cgstRateBps.present ? data.cgstRateBps.value : this.cgstRateBps,
      sgstRateBps:
          data.sgstRateBps.present ? data.sgstRateBps.value : this.sgstRateBps,
      igstRateBps:
          data.igstRateBps.present ? data.igstRateBps.value : this.igstRateBps,
      isInclusive:
          data.isInclusive.present ? data.isInclusive.value : this.isInclusive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaxCategoriesTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('hsnCode: $hsnCode, ')
          ..write('cgstRateBps: $cgstRateBps, ')
          ..write('sgstRateBps: $sgstRateBps, ')
          ..write('igstRateBps: $igstRateBps, ')
          ..write('isInclusive: $isInclusive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, name, hsnCode, cgstRateBps,
      sgstRateBps, igstRateBps, isInclusive, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaxCategoriesTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.name == this.name &&
          other.hsnCode == this.hsnCode &&
          other.cgstRateBps == this.cgstRateBps &&
          other.sgstRateBps == this.sgstRateBps &&
          other.igstRateBps == this.igstRateBps &&
          other.isInclusive == this.isInclusive &&
          other.updatedAt == this.updatedAt);
}

class TaxCategoriesTableCompanion
    extends UpdateCompanion<TaxCategoriesTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> name;
  final Value<String?> hsnCode;
  final Value<int> cgstRateBps;
  final Value<int> sgstRateBps;
  final Value<int> igstRateBps;
  final Value<bool> isInclusive;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TaxCategoriesTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.name = const Value.absent(),
    this.hsnCode = const Value.absent(),
    this.cgstRateBps = const Value.absent(),
    this.sgstRateBps = const Value.absent(),
    this.igstRateBps = const Value.absent(),
    this.isInclusive = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaxCategoriesTableCompanion.insert({
    required String id,
    required String tenantId,
    required String name,
    this.hsnCode = const Value.absent(),
    this.cgstRateBps = const Value.absent(),
    this.sgstRateBps = const Value.absent(),
    this.igstRateBps = const Value.absent(),
    this.isInclusive = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        name = Value(name),
        updatedAt = Value(updatedAt);
  static Insertable<TaxCategoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? name,
    Expression<String>? hsnCode,
    Expression<int>? cgstRateBps,
    Expression<int>? sgstRateBps,
    Expression<int>? igstRateBps,
    Expression<bool>? isInclusive,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (name != null) 'name': name,
      if (hsnCode != null) 'hsn_code': hsnCode,
      if (cgstRateBps != null) 'cgst_rate_bps': cgstRateBps,
      if (sgstRateBps != null) 'sgst_rate_bps': sgstRateBps,
      if (igstRateBps != null) 'igst_rate_bps': igstRateBps,
      if (isInclusive != null) 'is_inclusive': isInclusive,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaxCategoriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? name,
      Value<String?>? hsnCode,
      Value<int>? cgstRateBps,
      Value<int>? sgstRateBps,
      Value<int>? igstRateBps,
      Value<bool>? isInclusive,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return TaxCategoriesTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      hsnCode: hsnCode ?? this.hsnCode,
      cgstRateBps: cgstRateBps ?? this.cgstRateBps,
      sgstRateBps: sgstRateBps ?? this.sgstRateBps,
      igstRateBps: igstRateBps ?? this.igstRateBps,
      isInclusive: isInclusive ?? this.isInclusive,
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
    if (hsnCode.present) {
      map['hsn_code'] = Variable<String>(hsnCode.value);
    }
    if (cgstRateBps.present) {
      map['cgst_rate_bps'] = Variable<int>(cgstRateBps.value);
    }
    if (sgstRateBps.present) {
      map['sgst_rate_bps'] = Variable<int>(sgstRateBps.value);
    }
    if (igstRateBps.present) {
      map['igst_rate_bps'] = Variable<int>(igstRateBps.value);
    }
    if (isInclusive.present) {
      map['is_inclusive'] = Variable<bool>(isInclusive.value);
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
    return (StringBuffer('TaxCategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('hsnCode: $hsnCode, ')
          ..write('cgstRateBps: $cgstRateBps, ')
          ..write('sgstRateBps: $sgstRateBps, ')
          ..write('igstRateBps: $igstRateBps, ')
          ..write('isInclusive: $isInclusive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTableTable extends ProductsTable
    with TableInfo<$ProductsTableTable, ProductsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taxCategoryIdMeta =
      const VerificationMeta('taxCategoryId');
  @override
  late final GeneratedColumn<String> taxCategoryId = GeneratedColumn<String>(
      'tax_category_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _basePricePaiseMeta =
      const VerificationMeta('basePricePaise');
  @override
  late final GeneratedColumn<int> basePricePaise = GeneratedColumn<int>(
      'base_price_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
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
        categoryId,
        taxCategoryId,
        name,
        description,
        basePricePaise,
        imageUrl,
        isArchived,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products_table';
  @override
  VerificationContext validateIntegrity(Insertable<ProductsTableData> instance,
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
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('tax_category_id')) {
      context.handle(
          _taxCategoryIdMeta,
          taxCategoryId.isAcceptableOrUnknown(
              data['tax_category_id']!, _taxCategoryIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('base_price_paise')) {
      context.handle(
          _basePricePaiseMeta,
          basePricePaise.isAcceptableOrUnknown(
              data['base_price_paise']!, _basePricePaiseMeta));
    } else if (isInserting) {
      context.missing(_basePricePaiseMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
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
  ProductsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      taxCategoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tax_category_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      basePricePaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}base_price_paise'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProductsTableTable createAlias(String alias) {
    return $ProductsTableTable(attachedDatabase, alias);
  }
}

class ProductsTableData extends DataClass
    implements Insertable<ProductsTableData> {
  final String id;
  final String tenantId;
  final String categoryId;
  final String? taxCategoryId;
  final String name;
  final String? description;
  final int basePricePaise;
  final String? imageUrl;
  final bool isArchived;
  final DateTime updatedAt;
  const ProductsTableData(
      {required this.id,
      required this.tenantId,
      required this.categoryId,
      this.taxCategoryId,
      required this.name,
      this.description,
      required this.basePricePaise,
      this.imageUrl,
      required this.isArchived,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['category_id'] = Variable<String>(categoryId);
    if (!nullToAbsent || taxCategoryId != null) {
      map['tax_category_id'] = Variable<String>(taxCategoryId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['base_price_paise'] = Variable<int>(basePricePaise);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsTableCompanion toCompanion(bool nullToAbsent) {
    return ProductsTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      categoryId: Value(categoryId),
      taxCategoryId: taxCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(taxCategoryId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      basePricePaise: Value(basePricePaise),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      isArchived: Value(isArchived),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProductsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductsTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      taxCategoryId: serializer.fromJson<String?>(json['taxCategoryId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      basePricePaise: serializer.fromJson<int>(json['basePricePaise']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'categoryId': serializer.toJson<String>(categoryId),
      'taxCategoryId': serializer.toJson<String?>(taxCategoryId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'basePricePaise': serializer.toJson<int>(basePricePaise),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'isArchived': serializer.toJson<bool>(isArchived),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProductsTableData copyWith(
          {String? id,
          String? tenantId,
          String? categoryId,
          Value<String?> taxCategoryId = const Value.absent(),
          String? name,
          Value<String?> description = const Value.absent(),
          int? basePricePaise,
          Value<String?> imageUrl = const Value.absent(),
          bool? isArchived,
          DateTime? updatedAt}) =>
      ProductsTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        categoryId: categoryId ?? this.categoryId,
        taxCategoryId:
            taxCategoryId.present ? taxCategoryId.value : this.taxCategoryId,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        basePricePaise: basePricePaise ?? this.basePricePaise,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        isArchived: isArchived ?? this.isArchived,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ProductsTableData copyWithCompanion(ProductsTableCompanion data) {
    return ProductsTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      taxCategoryId: data.taxCategoryId.present
          ? data.taxCategoryId.value
          : this.taxCategoryId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      basePricePaise: data.basePricePaise.present
          ? data.basePricePaise.value
          : this.basePricePaise,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('categoryId: $categoryId, ')
          ..write('taxCategoryId: $taxCategoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('basePricePaise: $basePricePaise, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isArchived: $isArchived, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, categoryId, taxCategoryId, name,
      description, basePricePaise, imageUrl, isArchived, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.categoryId == this.categoryId &&
          other.taxCategoryId == this.taxCategoryId &&
          other.name == this.name &&
          other.description == this.description &&
          other.basePricePaise == this.basePricePaise &&
          other.imageUrl == this.imageUrl &&
          other.isArchived == this.isArchived &&
          other.updatedAt == this.updatedAt);
}

class ProductsTableCompanion extends UpdateCompanion<ProductsTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> categoryId;
  final Value<String?> taxCategoryId;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> basePricePaise;
  final Value<String?> imageUrl;
  final Value<bool> isArchived;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProductsTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.taxCategoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.basePricePaise = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsTableCompanion.insert({
    required String id,
    required String tenantId,
    required String categoryId,
    this.taxCategoryId = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required int basePricePaise,
    this.imageUrl = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        categoryId = Value(categoryId),
        name = Value(name),
        basePricePaise = Value(basePricePaise),
        updatedAt = Value(updatedAt);
  static Insertable<ProductsTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? categoryId,
    Expression<String>? taxCategoryId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? basePricePaise,
    Expression<String>? imageUrl,
    Expression<bool>? isArchived,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (categoryId != null) 'category_id': categoryId,
      if (taxCategoryId != null) 'tax_category_id': taxCategoryId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (basePricePaise != null) 'base_price_paise': basePricePaise,
      if (imageUrl != null) 'image_url': imageUrl,
      if (isArchived != null) 'is_archived': isArchived,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? categoryId,
      Value<String?>? taxCategoryId,
      Value<String>? name,
      Value<String?>? description,
      Value<int>? basePricePaise,
      Value<String?>? imageUrl,
      Value<bool>? isArchived,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ProductsTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      categoryId: categoryId ?? this.categoryId,
      taxCategoryId: taxCategoryId ?? this.taxCategoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      basePricePaise: basePricePaise ?? this.basePricePaise,
      imageUrl: imageUrl ?? this.imageUrl,
      isArchived: isArchived ?? this.isArchived,
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
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (taxCategoryId.present) {
      map['tax_category_id'] = Variable<String>(taxCategoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (basePricePaise.present) {
      map['base_price_paise'] = Variable<int>(basePricePaise.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
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
    return (StringBuffer('ProductsTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('categoryId: $categoryId, ')
          ..write('taxCategoryId: $taxCategoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('basePricePaise: $basePricePaise, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isArchived: $isArchived, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductVariantsTableTable extends ProductVariantsTable
    with TableInfo<$ProductVariantsTableTable, ProductVariantsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductVariantsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceDeltaPaiseMeta =
      const VerificationMeta('priceDeltaPaise');
  @override
  late final GeneratedColumn<int> priceDeltaPaise = GeneratedColumn<int>(
      'price_delta_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
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
  @override
  List<GeneratedColumn> get $columns =>
      [id, productId, name, priceDeltaPaise, sku, sortOrder, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_variants_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductVariantsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_delta_paise')) {
      context.handle(
          _priceDeltaPaiseMeta,
          priceDeltaPaise.isAcceptableOrUnknown(
              data['price_delta_paise']!, _priceDeltaPaiseMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductVariantsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductVariantsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      priceDeltaPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price_delta_paise'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $ProductVariantsTableTable createAlias(String alias) {
    return $ProductVariantsTableTable(attachedDatabase, alias);
  }
}

class ProductVariantsTableData extends DataClass
    implements Insertable<ProductVariantsTableData> {
  final String id;
  final String productId;
  final String name;
  final int priceDeltaPaise;
  final String? sku;
  final int sortOrder;
  final bool isActive;
  const ProductVariantsTableData(
      {required this.id,
      required this.productId,
      required this.name,
      required this.priceDeltaPaise,
      this.sku,
      required this.sortOrder,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['name'] = Variable<String>(name);
    map['price_delta_paise'] = Variable<int>(priceDeltaPaise);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ProductVariantsTableCompanion toCompanion(bool nullToAbsent) {
    return ProductVariantsTableCompanion(
      id: Value(id),
      productId: Value(productId),
      name: Value(name),
      priceDeltaPaise: Value(priceDeltaPaise),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
    );
  }

  factory ProductVariantsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductVariantsTableData(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      name: serializer.fromJson<String>(json['name']),
      priceDeltaPaise: serializer.fromJson<int>(json['priceDeltaPaise']),
      sku: serializer.fromJson<String?>(json['sku']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'name': serializer.toJson<String>(name),
      'priceDeltaPaise': serializer.toJson<int>(priceDeltaPaise),
      'sku': serializer.toJson<String?>(sku),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  ProductVariantsTableData copyWith(
          {String? id,
          String? productId,
          String? name,
          int? priceDeltaPaise,
          Value<String?> sku = const Value.absent(),
          int? sortOrder,
          bool? isActive}) =>
      ProductVariantsTableData(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        name: name ?? this.name,
        priceDeltaPaise: priceDeltaPaise ?? this.priceDeltaPaise,
        sku: sku.present ? sku.value : this.sku,
        sortOrder: sortOrder ?? this.sortOrder,
        isActive: isActive ?? this.isActive,
      );
  ProductVariantsTableData copyWithCompanion(
      ProductVariantsTableCompanion data) {
    return ProductVariantsTableData(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      name: data.name.present ? data.name.value : this.name,
      priceDeltaPaise: data.priceDeltaPaise.present
          ? data.priceDeltaPaise.value
          : this.priceDeltaPaise,
      sku: data.sku.present ? data.sku.value : this.sku,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductVariantsTableData(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('priceDeltaPaise: $priceDeltaPaise, ')
          ..write('sku: $sku, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, productId, name, priceDeltaPaise, sku, sortOrder, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductVariantsTableData &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.name == this.name &&
          other.priceDeltaPaise == this.priceDeltaPaise &&
          other.sku == this.sku &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive);
}

class ProductVariantsTableCompanion
    extends UpdateCompanion<ProductVariantsTableData> {
  final Value<String> id;
  final Value<String> productId;
  final Value<String> name;
  final Value<int> priceDeltaPaise;
  final Value<String?> sku;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<int> rowid;
  const ProductVariantsTableCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.name = const Value.absent(),
    this.priceDeltaPaise = const Value.absent(),
    this.sku = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductVariantsTableCompanion.insert({
    required String id,
    required String productId,
    required String name,
    this.priceDeltaPaise = const Value.absent(),
    this.sku = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        productId = Value(productId),
        name = Value(name);
  static Insertable<ProductVariantsTableData> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? name,
    Expression<int>? priceDeltaPaise,
    Expression<String>? sku,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (name != null) 'name': name,
      if (priceDeltaPaise != null) 'price_delta_paise': priceDeltaPaise,
      if (sku != null) 'sku': sku,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductVariantsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? productId,
      Value<String>? name,
      Value<int>? priceDeltaPaise,
      Value<String?>? sku,
      Value<int>? sortOrder,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return ProductVariantsTableCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      priceDeltaPaise: priceDeltaPaise ?? this.priceDeltaPaise,
      sku: sku ?? this.sku,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceDeltaPaise.present) {
      map['price_delta_paise'] = Variable<int>(priceDeltaPaise.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductVariantsTableCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('priceDeltaPaise: $priceDeltaPaise, ')
          ..write('sku: $sku, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ModifierGroupsTableTable extends ModifierGroupsTable
    with TableInfo<$ModifierGroupsTableTable, ModifierGroupsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModifierGroupsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _minSelectionMeta =
      const VerificationMeta('minSelection');
  @override
  late final GeneratedColumn<int> minSelection = GeneratedColumn<int>(
      'min_selection', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _maxSelectionMeta =
      const VerificationMeta('maxSelection');
  @override
  late final GeneratedColumn<int> maxSelection = GeneratedColumn<int>(
      'max_selection', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _isMandatoryMeta =
      const VerificationMeta('isMandatory');
  @override
  late final GeneratedColumn<bool> isMandatory = GeneratedColumn<bool>(
      'is_mandatory', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_mandatory" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, tenantId, name, minSelection, maxSelection, isMandatory];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'modifier_groups_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ModifierGroupsTableData> instance,
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
    if (data.containsKey('min_selection')) {
      context.handle(
          _minSelectionMeta,
          minSelection.isAcceptableOrUnknown(
              data['min_selection']!, _minSelectionMeta));
    }
    if (data.containsKey('max_selection')) {
      context.handle(
          _maxSelectionMeta,
          maxSelection.isAcceptableOrUnknown(
              data['max_selection']!, _maxSelectionMeta));
    }
    if (data.containsKey('is_mandatory')) {
      context.handle(
          _isMandatoryMeta,
          isMandatory.isAcceptableOrUnknown(
              data['is_mandatory']!, _isMandatoryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ModifierGroupsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ModifierGroupsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      minSelection: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_selection'])!,
      maxSelection: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_selection'])!,
      isMandatory: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_mandatory'])!,
    );
  }

  @override
  $ModifierGroupsTableTable createAlias(String alias) {
    return $ModifierGroupsTableTable(attachedDatabase, alias);
  }
}

class ModifierGroupsTableData extends DataClass
    implements Insertable<ModifierGroupsTableData> {
  final String id;
  final String tenantId;
  final String name;
  final int minSelection;
  final int maxSelection;
  final bool isMandatory;
  const ModifierGroupsTableData(
      {required this.id,
      required this.tenantId,
      required this.name,
      required this.minSelection,
      required this.maxSelection,
      required this.isMandatory});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['name'] = Variable<String>(name);
    map['min_selection'] = Variable<int>(minSelection);
    map['max_selection'] = Variable<int>(maxSelection);
    map['is_mandatory'] = Variable<bool>(isMandatory);
    return map;
  }

  ModifierGroupsTableCompanion toCompanion(bool nullToAbsent) {
    return ModifierGroupsTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      minSelection: Value(minSelection),
      maxSelection: Value(maxSelection),
      isMandatory: Value(isMandatory),
    );
  }

  factory ModifierGroupsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModifierGroupsTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      name: serializer.fromJson<String>(json['name']),
      minSelection: serializer.fromJson<int>(json['minSelection']),
      maxSelection: serializer.fromJson<int>(json['maxSelection']),
      isMandatory: serializer.fromJson<bool>(json['isMandatory']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'name': serializer.toJson<String>(name),
      'minSelection': serializer.toJson<int>(minSelection),
      'maxSelection': serializer.toJson<int>(maxSelection),
      'isMandatory': serializer.toJson<bool>(isMandatory),
    };
  }

  ModifierGroupsTableData copyWith(
          {String? id,
          String? tenantId,
          String? name,
          int? minSelection,
          int? maxSelection,
          bool? isMandatory}) =>
      ModifierGroupsTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        name: name ?? this.name,
        minSelection: minSelection ?? this.minSelection,
        maxSelection: maxSelection ?? this.maxSelection,
        isMandatory: isMandatory ?? this.isMandatory,
      );
  ModifierGroupsTableData copyWithCompanion(ModifierGroupsTableCompanion data) {
    return ModifierGroupsTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      name: data.name.present ? data.name.value : this.name,
      minSelection: data.minSelection.present
          ? data.minSelection.value
          : this.minSelection,
      maxSelection: data.maxSelection.present
          ? data.maxSelection.value
          : this.maxSelection,
      isMandatory:
          data.isMandatory.present ? data.isMandatory.value : this.isMandatory,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ModifierGroupsTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('minSelection: $minSelection, ')
          ..write('maxSelection: $maxSelection, ')
          ..write('isMandatory: $isMandatory')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tenantId, name, minSelection, maxSelection, isMandatory);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModifierGroupsTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.name == this.name &&
          other.minSelection == this.minSelection &&
          other.maxSelection == this.maxSelection &&
          other.isMandatory == this.isMandatory);
}

class ModifierGroupsTableCompanion
    extends UpdateCompanion<ModifierGroupsTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> name;
  final Value<int> minSelection;
  final Value<int> maxSelection;
  final Value<bool> isMandatory;
  final Value<int> rowid;
  const ModifierGroupsTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.name = const Value.absent(),
    this.minSelection = const Value.absent(),
    this.maxSelection = const Value.absent(),
    this.isMandatory = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ModifierGroupsTableCompanion.insert({
    required String id,
    required String tenantId,
    required String name,
    this.minSelection = const Value.absent(),
    this.maxSelection = const Value.absent(),
    this.isMandatory = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        name = Value(name);
  static Insertable<ModifierGroupsTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? name,
    Expression<int>? minSelection,
    Expression<int>? maxSelection,
    Expression<bool>? isMandatory,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (name != null) 'name': name,
      if (minSelection != null) 'min_selection': minSelection,
      if (maxSelection != null) 'max_selection': maxSelection,
      if (isMandatory != null) 'is_mandatory': isMandatory,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ModifierGroupsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? name,
      Value<int>? minSelection,
      Value<int>? maxSelection,
      Value<bool>? isMandatory,
      Value<int>? rowid}) {
    return ModifierGroupsTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      minSelection: minSelection ?? this.minSelection,
      maxSelection: maxSelection ?? this.maxSelection,
      isMandatory: isMandatory ?? this.isMandatory,
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
    if (minSelection.present) {
      map['min_selection'] = Variable<int>(minSelection.value);
    }
    if (maxSelection.present) {
      map['max_selection'] = Variable<int>(maxSelection.value);
    }
    if (isMandatory.present) {
      map['is_mandatory'] = Variable<bool>(isMandatory.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModifierGroupsTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('minSelection: $minSelection, ')
          ..write('maxSelection: $maxSelection, ')
          ..write('isMandatory: $isMandatory, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ModifiersTableTable extends ModifiersTable
    with TableInfo<$ModifiersTableTable, ModifiersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModifiersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceDeltaPaiseMeta =
      const VerificationMeta('priceDeltaPaise');
  @override
  late final GeneratedColumn<int> priceDeltaPaise = GeneratedColumn<int>(
      'price_delta_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
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
  @override
  List<GeneratedColumn> get $columns =>
      [id, groupId, name, priceDeltaPaise, sortOrder, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'modifiers_table';
  @override
  VerificationContext validateIntegrity(Insertable<ModifiersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_delta_paise')) {
      context.handle(
          _priceDeltaPaiseMeta,
          priceDeltaPaise.isAcceptableOrUnknown(
              data['price_delta_paise']!, _priceDeltaPaiseMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ModifiersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ModifiersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      priceDeltaPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price_delta_paise'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $ModifiersTableTable createAlias(String alias) {
    return $ModifiersTableTable(attachedDatabase, alias);
  }
}

class ModifiersTableData extends DataClass
    implements Insertable<ModifiersTableData> {
  final String id;
  final String groupId;
  final String name;
  final int priceDeltaPaise;
  final int sortOrder;
  final bool isActive;
  const ModifiersTableData(
      {required this.id,
      required this.groupId,
      required this.name,
      required this.priceDeltaPaise,
      required this.sortOrder,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['name'] = Variable<String>(name);
    map['price_delta_paise'] = Variable<int>(priceDeltaPaise);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ModifiersTableCompanion toCompanion(bool nullToAbsent) {
    return ModifiersTableCompanion(
      id: Value(id),
      groupId: Value(groupId),
      name: Value(name),
      priceDeltaPaise: Value(priceDeltaPaise),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
    );
  }

  factory ModifiersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModifiersTableData(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      name: serializer.fromJson<String>(json['name']),
      priceDeltaPaise: serializer.fromJson<int>(json['priceDeltaPaise']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'name': serializer.toJson<String>(name),
      'priceDeltaPaise': serializer.toJson<int>(priceDeltaPaise),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  ModifiersTableData copyWith(
          {String? id,
          String? groupId,
          String? name,
          int? priceDeltaPaise,
          int? sortOrder,
          bool? isActive}) =>
      ModifiersTableData(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        name: name ?? this.name,
        priceDeltaPaise: priceDeltaPaise ?? this.priceDeltaPaise,
        sortOrder: sortOrder ?? this.sortOrder,
        isActive: isActive ?? this.isActive,
      );
  ModifiersTableData copyWithCompanion(ModifiersTableCompanion data) {
    return ModifiersTableData(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      name: data.name.present ? data.name.value : this.name,
      priceDeltaPaise: data.priceDeltaPaise.present
          ? data.priceDeltaPaise.value
          : this.priceDeltaPaise,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ModifiersTableData(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('priceDeltaPaise: $priceDeltaPaise, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, groupId, name, priceDeltaPaise, sortOrder, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModifiersTableData &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.name == this.name &&
          other.priceDeltaPaise == this.priceDeltaPaise &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive);
}

class ModifiersTableCompanion extends UpdateCompanion<ModifiersTableData> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> name;
  final Value<int> priceDeltaPaise;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<int> rowid;
  const ModifiersTableCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.name = const Value.absent(),
    this.priceDeltaPaise = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ModifiersTableCompanion.insert({
    required String id,
    required String groupId,
    required String name,
    this.priceDeltaPaise = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        groupId = Value(groupId),
        name = Value(name);
  static Insertable<ModifiersTableData> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? name,
    Expression<int>? priceDeltaPaise,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (name != null) 'name': name,
      if (priceDeltaPaise != null) 'price_delta_paise': priceDeltaPaise,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ModifiersTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupId,
      Value<String>? name,
      Value<int>? priceDeltaPaise,
      Value<int>? sortOrder,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return ModifiersTableCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      priceDeltaPaise: priceDeltaPaise ?? this.priceDeltaPaise,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceDeltaPaise.present) {
      map['price_delta_paise'] = Variable<int>(priceDeltaPaise.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModifiersTableCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('priceDeltaPaise: $priceDeltaPaise, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductModifierGroupsTableTable extends ProductModifierGroupsTable
    with
        TableInfo<$ProductModifierGroupsTableTable,
            ProductModifierGroupsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductModifierGroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modifierGroupIdMeta =
      const VerificationMeta('modifierGroupId');
  @override
  late final GeneratedColumn<String> modifierGroupId = GeneratedColumn<String>(
      'modifier_group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [productId, modifierGroupId, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_modifier_groups_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductModifierGroupsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('modifier_group_id')) {
      context.handle(
          _modifierGroupIdMeta,
          modifierGroupId.isAcceptableOrUnknown(
              data['modifier_group_id']!, _modifierGroupIdMeta));
    } else if (isInserting) {
      context.missing(_modifierGroupIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId, modifierGroupId};
  @override
  ProductModifierGroupsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductModifierGroupsTableData(
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      modifierGroupId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}modifier_group_id'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $ProductModifierGroupsTableTable createAlias(String alias) {
    return $ProductModifierGroupsTableTable(attachedDatabase, alias);
  }
}

class ProductModifierGroupsTableData extends DataClass
    implements Insertable<ProductModifierGroupsTableData> {
  final String productId;
  final String modifierGroupId;
  final int sortOrder;
  const ProductModifierGroupsTableData(
      {required this.productId,
      required this.modifierGroupId,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    map['modifier_group_id'] = Variable<String>(modifierGroupId);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ProductModifierGroupsTableCompanion toCompanion(bool nullToAbsent) {
    return ProductModifierGroupsTableCompanion(
      productId: Value(productId),
      modifierGroupId: Value(modifierGroupId),
      sortOrder: Value(sortOrder),
    );
  }

  factory ProductModifierGroupsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductModifierGroupsTableData(
      productId: serializer.fromJson<String>(json['productId']),
      modifierGroupId: serializer.fromJson<String>(json['modifierGroupId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'modifierGroupId': serializer.toJson<String>(modifierGroupId),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ProductModifierGroupsTableData copyWith(
          {String? productId, String? modifierGroupId, int? sortOrder}) =>
      ProductModifierGroupsTableData(
        productId: productId ?? this.productId,
        modifierGroupId: modifierGroupId ?? this.modifierGroupId,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  ProductModifierGroupsTableData copyWithCompanion(
      ProductModifierGroupsTableCompanion data) {
    return ProductModifierGroupsTableData(
      productId: data.productId.present ? data.productId.value : this.productId,
      modifierGroupId: data.modifierGroupId.present
          ? data.modifierGroupId.value
          : this.modifierGroupId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductModifierGroupsTableData(')
          ..write('productId: $productId, ')
          ..write('modifierGroupId: $modifierGroupId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productId, modifierGroupId, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductModifierGroupsTableData &&
          other.productId == this.productId &&
          other.modifierGroupId == this.modifierGroupId &&
          other.sortOrder == this.sortOrder);
}

class ProductModifierGroupsTableCompanion
    extends UpdateCompanion<ProductModifierGroupsTableData> {
  final Value<String> productId;
  final Value<String> modifierGroupId;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ProductModifierGroupsTableCompanion({
    this.productId = const Value.absent(),
    this.modifierGroupId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductModifierGroupsTableCompanion.insert({
    required String productId,
    required String modifierGroupId,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : productId = Value(productId),
        modifierGroupId = Value(modifierGroupId);
  static Insertable<ProductModifierGroupsTableData> custom({
    Expression<String>? productId,
    Expression<String>? modifierGroupId,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (modifierGroupId != null) 'modifier_group_id': modifierGroupId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductModifierGroupsTableCompanion copyWith(
      {Value<String>? productId,
      Value<String>? modifierGroupId,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return ProductModifierGroupsTableCompanion(
      productId: productId ?? this.productId,
      modifierGroupId: modifierGroupId ?? this.modifierGroupId,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (modifierGroupId.present) {
      map['modifier_group_id'] = Variable<String>(modifierGroupId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductModifierGroupsTableCompanion(')
          ..write('productId: $productId, ')
          ..write('modifierGroupId: $modifierGroupId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductBranchAvailabilityTableTable
    extends ProductBranchAvailabilityTable
    with
        TableInfo<$ProductBranchAvailabilityTableTable,
            ProductBranchAvailabilityTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductBranchAvailabilityTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isAvailableMeta =
      const VerificationMeta('isAvailable');
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
      'is_available', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_available" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _overridePricePaiseMeta =
      const VerificationMeta('overridePricePaise');
  @override
  late final GeneratedColumn<int> overridePricePaise = GeneratedColumn<int>(
      'override_price_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [productId, branchId, isAvailable, overridePricePaise];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_branch_availability_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductBranchAvailabilityTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('is_available')) {
      context.handle(
          _isAvailableMeta,
          isAvailable.isAcceptableOrUnknown(
              data['is_available']!, _isAvailableMeta));
    }
    if (data.containsKey('override_price_paise')) {
      context.handle(
          _overridePricePaiseMeta,
          overridePricePaise.isAcceptableOrUnknown(
              data['override_price_paise']!, _overridePricePaiseMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId, branchId};
  @override
  ProductBranchAvailabilityTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductBranchAvailabilityTableData(
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      isAvailable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_available'])!,
      overridePricePaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}override_price_paise']),
    );
  }

  @override
  $ProductBranchAvailabilityTableTable createAlias(String alias) {
    return $ProductBranchAvailabilityTableTable(attachedDatabase, alias);
  }
}

class ProductBranchAvailabilityTableData extends DataClass
    implements Insertable<ProductBranchAvailabilityTableData> {
  final String productId;
  final String branchId;
  final bool isAvailable;
  final int? overridePricePaise;
  const ProductBranchAvailabilityTableData(
      {required this.productId,
      required this.branchId,
      required this.isAvailable,
      this.overridePricePaise});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    map['branch_id'] = Variable<String>(branchId);
    map['is_available'] = Variable<bool>(isAvailable);
    if (!nullToAbsent || overridePricePaise != null) {
      map['override_price_paise'] = Variable<int>(overridePricePaise);
    }
    return map;
  }

  ProductBranchAvailabilityTableCompanion toCompanion(bool nullToAbsent) {
    return ProductBranchAvailabilityTableCompanion(
      productId: Value(productId),
      branchId: Value(branchId),
      isAvailable: Value(isAvailable),
      overridePricePaise: overridePricePaise == null && nullToAbsent
          ? const Value.absent()
          : Value(overridePricePaise),
    );
  }

  factory ProductBranchAvailabilityTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductBranchAvailabilityTableData(
      productId: serializer.fromJson<String>(json['productId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      overridePricePaise: serializer.fromJson<int?>(json['overridePricePaise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'branchId': serializer.toJson<String>(branchId),
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'overridePricePaise': serializer.toJson<int?>(overridePricePaise),
    };
  }

  ProductBranchAvailabilityTableData copyWith(
          {String? productId,
          String? branchId,
          bool? isAvailable,
          Value<int?> overridePricePaise = const Value.absent()}) =>
      ProductBranchAvailabilityTableData(
        productId: productId ?? this.productId,
        branchId: branchId ?? this.branchId,
        isAvailable: isAvailable ?? this.isAvailable,
        overridePricePaise: overridePricePaise.present
            ? overridePricePaise.value
            : this.overridePricePaise,
      );
  ProductBranchAvailabilityTableData copyWithCompanion(
      ProductBranchAvailabilityTableCompanion data) {
    return ProductBranchAvailabilityTableData(
      productId: data.productId.present ? data.productId.value : this.productId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      isAvailable:
          data.isAvailable.present ? data.isAvailable.value : this.isAvailable,
      overridePricePaise: data.overridePricePaise.present
          ? data.overridePricePaise.value
          : this.overridePricePaise,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductBranchAvailabilityTableData(')
          ..write('productId: $productId, ')
          ..write('branchId: $branchId, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('overridePricePaise: $overridePricePaise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(productId, branchId, isAvailable, overridePricePaise);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductBranchAvailabilityTableData &&
          other.productId == this.productId &&
          other.branchId == this.branchId &&
          other.isAvailable == this.isAvailable &&
          other.overridePricePaise == this.overridePricePaise);
}

class ProductBranchAvailabilityTableCompanion
    extends UpdateCompanion<ProductBranchAvailabilityTableData> {
  final Value<String> productId;
  final Value<String> branchId;
  final Value<bool> isAvailable;
  final Value<int?> overridePricePaise;
  final Value<int> rowid;
  const ProductBranchAvailabilityTableCompanion({
    this.productId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.overridePricePaise = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductBranchAvailabilityTableCompanion.insert({
    required String productId,
    required String branchId,
    this.isAvailable = const Value.absent(),
    this.overridePricePaise = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : productId = Value(productId),
        branchId = Value(branchId);
  static Insertable<ProductBranchAvailabilityTableData> custom({
    Expression<String>? productId,
    Expression<String>? branchId,
    Expression<bool>? isAvailable,
    Expression<int>? overridePricePaise,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (branchId != null) 'branch_id': branchId,
      if (isAvailable != null) 'is_available': isAvailable,
      if (overridePricePaise != null)
        'override_price_paise': overridePricePaise,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductBranchAvailabilityTableCompanion copyWith(
      {Value<String>? productId,
      Value<String>? branchId,
      Value<bool>? isAvailable,
      Value<int?>? overridePricePaise,
      Value<int>? rowid}) {
    return ProductBranchAvailabilityTableCompanion(
      productId: productId ?? this.productId,
      branchId: branchId ?? this.branchId,
      isAvailable: isAvailable ?? this.isAvailable,
      overridePricePaise: overridePricePaise ?? this.overridePricePaise,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    if (overridePricePaise.present) {
      map['override_price_paise'] = Variable<int>(overridePricePaise.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductBranchAvailabilityTableCompanion(')
          ..write('productId: $productId, ')
          ..write('branchId: $branchId, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('overridePricePaise: $overridePricePaise, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdersTableTable extends OrdersTable
    with TableInfo<$OrdersTableTable, OrdersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _orderNumberMeta =
      const VerificationMeta('orderNumber');
  @override
  late final GeneratedColumn<String> orderNumber = GeneratedColumn<String>(
      'order_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderTypeMeta =
      const VerificationMeta('orderType');
  @override
  late final GeneratedColumn<String> orderType = GeneratedColumn<String>(
      'order_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('dine_in'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('created'));
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pos'));
  static const VerificationMeta _tableIdMeta =
      const VerificationMeta('tableId');
  @override
  late final GeneratedColumn<String> tableId = GeneratedColumn<String>(
      'table_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customerNameMeta =
      const VerificationMeta('customerName');
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
      'customer_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customerPhoneMeta =
      const VerificationMeta('customerPhone');
  @override
  late final GeneratedColumn<String> customerPhone = GeneratedColumn<String>(
      'customer_phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subtotalPaiseMeta =
      const VerificationMeta('subtotalPaise');
  @override
  late final GeneratedColumn<int> subtotalPaise = GeneratedColumn<int>(
      'subtotal_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _discountPaiseMeta =
      const VerificationMeta('discountPaise');
  @override
  late final GeneratedColumn<int> discountPaise = GeneratedColumn<int>(
      'discount_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _taxPaiseMeta =
      const VerificationMeta('taxPaise');
  @override
  late final GeneratedColumn<int> taxPaise = GeneratedColumn<int>(
      'tax_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _roundingPaiseMeta =
      const VerificationMeta('roundingPaise');
  @override
  late final GeneratedColumn<int> roundingPaise = GeneratedColumn<int>(
      'rounding_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _finalTotalPaiseMeta =
      const VerificationMeta('finalTotalPaise');
  @override
  late final GeneratedColumn<int> finalTotalPaise = GeneratedColumn<int>(
      'final_total_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        branchId,
        orderNumber,
        orderType,
        status,
        source,
        tableId,
        customerName,
        customerPhone,
        notes,
        subtotalPaise,
        discountPaise,
        taxPaise,
        roundingPaise,
        finalTotalPaise,
        createdBy,
        createdAt,
        updatedAt,
        version
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<OrdersTableData> instance,
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
    if (data.containsKey('order_number')) {
      context.handle(
          _orderNumberMeta,
          orderNumber.isAcceptableOrUnknown(
              data['order_number']!, _orderNumberMeta));
    } else if (isInserting) {
      context.missing(_orderNumberMeta);
    }
    if (data.containsKey('order_type')) {
      context.handle(_orderTypeMeta,
          orderType.isAcceptableOrUnknown(data['order_type']!, _orderTypeMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('table_id')) {
      context.handle(_tableIdMeta,
          tableId.isAcceptableOrUnknown(data['table_id']!, _tableIdMeta));
    }
    if (data.containsKey('customer_name')) {
      context.handle(
          _customerNameMeta,
          customerName.isAcceptableOrUnknown(
              data['customer_name']!, _customerNameMeta));
    }
    if (data.containsKey('customer_phone')) {
      context.handle(
          _customerPhoneMeta,
          customerPhone.isAcceptableOrUnknown(
              data['customer_phone']!, _customerPhoneMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('subtotal_paise')) {
      context.handle(
          _subtotalPaiseMeta,
          subtotalPaise.isAcceptableOrUnknown(
              data['subtotal_paise']!, _subtotalPaiseMeta));
    }
    if (data.containsKey('discount_paise')) {
      context.handle(
          _discountPaiseMeta,
          discountPaise.isAcceptableOrUnknown(
              data['discount_paise']!, _discountPaiseMeta));
    }
    if (data.containsKey('tax_paise')) {
      context.handle(_taxPaiseMeta,
          taxPaise.isAcceptableOrUnknown(data['tax_paise']!, _taxPaiseMeta));
    }
    if (data.containsKey('rounding_paise')) {
      context.handle(
          _roundingPaiseMeta,
          roundingPaise.isAcceptableOrUnknown(
              data['rounding_paise']!, _roundingPaiseMeta));
    }
    if (data.containsKey('final_total_paise')) {
      context.handle(
          _finalTotalPaiseMeta,
          finalTotalPaise.isAcceptableOrUnknown(
              data['final_total_paise']!, _finalTotalPaiseMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      orderNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_number'])!,
      orderType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_type'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      tableId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}table_id']),
      customerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_name']),
      customerPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_phone']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      subtotalPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subtotal_paise'])!,
      discountPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}discount_paise'])!,
      taxPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tax_paise'])!,
      roundingPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rounding_paise'])!,
      finalTotalPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}final_total_paise'])!,
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
    );
  }

  @override
  $OrdersTableTable createAlias(String alias) {
    return $OrdersTableTable(attachedDatabase, alias);
  }
}

class OrdersTableData extends DataClass implements Insertable<OrdersTableData> {
  final String id;
  final String tenantId;
  final String branchId;
  final String orderNumber;
  final String orderType;
  final String status;
  final String source;
  final String? tableId;
  final String? customerName;
  final String? customerPhone;
  final String? notes;
  final int subtotalPaise;
  final int discountPaise;
  final int taxPaise;
  final int roundingPaise;
  final int finalTotalPaise;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  const OrdersTableData(
      {required this.id,
      required this.tenantId,
      required this.branchId,
      required this.orderNumber,
      required this.orderType,
      required this.status,
      required this.source,
      this.tableId,
      this.customerName,
      this.customerPhone,
      this.notes,
      required this.subtotalPaise,
      required this.discountPaise,
      required this.taxPaise,
      required this.roundingPaise,
      required this.finalTotalPaise,
      required this.createdBy,
      required this.createdAt,
      required this.updatedAt,
      required this.version});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['order_number'] = Variable<String>(orderNumber);
    map['order_type'] = Variable<String>(orderType);
    map['status'] = Variable<String>(status);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || tableId != null) {
      map['table_id'] = Variable<String>(tableId);
    }
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    if (!nullToAbsent || customerPhone != null) {
      map['customer_phone'] = Variable<String>(customerPhone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['subtotal_paise'] = Variable<int>(subtotalPaise);
    map['discount_paise'] = Variable<int>(discountPaise);
    map['tax_paise'] = Variable<int>(taxPaise);
    map['rounding_paise'] = Variable<int>(roundingPaise);
    map['final_total_paise'] = Variable<int>(finalTotalPaise);
    map['created_by'] = Variable<String>(createdBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['version'] = Variable<int>(version);
    return map;
  }

  OrdersTableCompanion toCompanion(bool nullToAbsent) {
    return OrdersTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      orderNumber: Value(orderNumber),
      orderType: Value(orderType),
      status: Value(status),
      source: Value(source),
      tableId: tableId == null && nullToAbsent
          ? const Value.absent()
          : Value(tableId),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      customerPhone: customerPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(customerPhone),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      subtotalPaise: Value(subtotalPaise),
      discountPaise: Value(discountPaise),
      taxPaise: Value(taxPaise),
      roundingPaise: Value(roundingPaise),
      finalTotalPaise: Value(finalTotalPaise),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: Value(version),
    );
  }

  factory OrdersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdersTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      orderNumber: serializer.fromJson<String>(json['orderNumber']),
      orderType: serializer.fromJson<String>(json['orderType']),
      status: serializer.fromJson<String>(json['status']),
      source: serializer.fromJson<String>(json['source']),
      tableId: serializer.fromJson<String?>(json['tableId']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      customerPhone: serializer.fromJson<String?>(json['customerPhone']),
      notes: serializer.fromJson<String?>(json['notes']),
      subtotalPaise: serializer.fromJson<int>(json['subtotalPaise']),
      discountPaise: serializer.fromJson<int>(json['discountPaise']),
      taxPaise: serializer.fromJson<int>(json['taxPaise']),
      roundingPaise: serializer.fromJson<int>(json['roundingPaise']),
      finalTotalPaise: serializer.fromJson<int>(json['finalTotalPaise']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'orderNumber': serializer.toJson<String>(orderNumber),
      'orderType': serializer.toJson<String>(orderType),
      'status': serializer.toJson<String>(status),
      'source': serializer.toJson<String>(source),
      'tableId': serializer.toJson<String?>(tableId),
      'customerName': serializer.toJson<String?>(customerName),
      'customerPhone': serializer.toJson<String?>(customerPhone),
      'notes': serializer.toJson<String?>(notes),
      'subtotalPaise': serializer.toJson<int>(subtotalPaise),
      'discountPaise': serializer.toJson<int>(discountPaise),
      'taxPaise': serializer.toJson<int>(taxPaise),
      'roundingPaise': serializer.toJson<int>(roundingPaise),
      'finalTotalPaise': serializer.toJson<int>(finalTotalPaise),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'version': serializer.toJson<int>(version),
    };
  }

  OrdersTableData copyWith(
          {String? id,
          String? tenantId,
          String? branchId,
          String? orderNumber,
          String? orderType,
          String? status,
          String? source,
          Value<String?> tableId = const Value.absent(),
          Value<String?> customerName = const Value.absent(),
          Value<String?> customerPhone = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          int? subtotalPaise,
          int? discountPaise,
          int? taxPaise,
          int? roundingPaise,
          int? finalTotalPaise,
          String? createdBy,
          DateTime? createdAt,
          DateTime? updatedAt,
          int? version}) =>
      OrdersTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        orderNumber: orderNumber ?? this.orderNumber,
        orderType: orderType ?? this.orderType,
        status: status ?? this.status,
        source: source ?? this.source,
        tableId: tableId.present ? tableId.value : this.tableId,
        customerName:
            customerName.present ? customerName.value : this.customerName,
        customerPhone:
            customerPhone.present ? customerPhone.value : this.customerPhone,
        notes: notes.present ? notes.value : this.notes,
        subtotalPaise: subtotalPaise ?? this.subtotalPaise,
        discountPaise: discountPaise ?? this.discountPaise,
        taxPaise: taxPaise ?? this.taxPaise,
        roundingPaise: roundingPaise ?? this.roundingPaise,
        finalTotalPaise: finalTotalPaise ?? this.finalTotalPaise,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        version: version ?? this.version,
      );
  OrdersTableData copyWithCompanion(OrdersTableCompanion data) {
    return OrdersTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      orderNumber:
          data.orderNumber.present ? data.orderNumber.value : this.orderNumber,
      orderType: data.orderType.present ? data.orderType.value : this.orderType,
      status: data.status.present ? data.status.value : this.status,
      source: data.source.present ? data.source.value : this.source,
      tableId: data.tableId.present ? data.tableId.value : this.tableId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      customerPhone: data.customerPhone.present
          ? data.customerPhone.value
          : this.customerPhone,
      notes: data.notes.present ? data.notes.value : this.notes,
      subtotalPaise: data.subtotalPaise.present
          ? data.subtotalPaise.value
          : this.subtotalPaise,
      discountPaise: data.discountPaise.present
          ? data.discountPaise.value
          : this.discountPaise,
      taxPaise: data.taxPaise.present ? data.taxPaise.value : this.taxPaise,
      roundingPaise: data.roundingPaise.present
          ? data.roundingPaise.value
          : this.roundingPaise,
      finalTotalPaise: data.finalTotalPaise.present
          ? data.finalTotalPaise.value
          : this.finalTotalPaise,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrdersTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('orderType: $orderType, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('tableId: $tableId, ')
          ..write('customerName: $customerName, ')
          ..write('customerPhone: $customerPhone, ')
          ..write('notes: $notes, ')
          ..write('subtotalPaise: $subtotalPaise, ')
          ..write('discountPaise: $discountPaise, ')
          ..write('taxPaise: $taxPaise, ')
          ..write('roundingPaise: $roundingPaise, ')
          ..write('finalTotalPaise: $finalTotalPaise, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      branchId,
      orderNumber,
      orderType,
      status,
      source,
      tableId,
      customerName,
      customerPhone,
      notes,
      subtotalPaise,
      discountPaise,
      taxPaise,
      roundingPaise,
      finalTotalPaise,
      createdBy,
      createdAt,
      updatedAt,
      version);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdersTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.orderNumber == this.orderNumber &&
          other.orderType == this.orderType &&
          other.status == this.status &&
          other.source == this.source &&
          other.tableId == this.tableId &&
          other.customerName == this.customerName &&
          other.customerPhone == this.customerPhone &&
          other.notes == this.notes &&
          other.subtotalPaise == this.subtotalPaise &&
          other.discountPaise == this.discountPaise &&
          other.taxPaise == this.taxPaise &&
          other.roundingPaise == this.roundingPaise &&
          other.finalTotalPaise == this.finalTotalPaise &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.version == this.version);
}

class OrdersTableCompanion extends UpdateCompanion<OrdersTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> orderNumber;
  final Value<String> orderType;
  final Value<String> status;
  final Value<String> source;
  final Value<String?> tableId;
  final Value<String?> customerName;
  final Value<String?> customerPhone;
  final Value<String?> notes;
  final Value<int> subtotalPaise;
  final Value<int> discountPaise;
  final Value<int> taxPaise;
  final Value<int> roundingPaise;
  final Value<int> finalTotalPaise;
  final Value<String> createdBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> version;
  final Value<int> rowid;
  const OrdersTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.orderType = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    this.tableId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.customerPhone = const Value.absent(),
    this.notes = const Value.absent(),
    this.subtotalPaise = const Value.absent(),
    this.discountPaise = const Value.absent(),
    this.taxPaise = const Value.absent(),
    this.roundingPaise = const Value.absent(),
    this.finalTotalPaise = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdersTableCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    required String orderNumber,
    this.orderType = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    this.tableId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.customerPhone = const Value.absent(),
    this.notes = const Value.absent(),
    this.subtotalPaise = const Value.absent(),
    this.discountPaise = const Value.absent(),
    this.taxPaise = const Value.absent(),
    this.roundingPaise = const Value.absent(),
    this.finalTotalPaise = const Value.absent(),
    required String createdBy,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        branchId = Value(branchId),
        orderNumber = Value(orderNumber),
        createdBy = Value(createdBy);
  static Insertable<OrdersTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? orderNumber,
    Expression<String>? orderType,
    Expression<String>? status,
    Expression<String>? source,
    Expression<String>? tableId,
    Expression<String>? customerName,
    Expression<String>? customerPhone,
    Expression<String>? notes,
    Expression<int>? subtotalPaise,
    Expression<int>? discountPaise,
    Expression<int>? taxPaise,
    Expression<int>? roundingPaise,
    Expression<int>? finalTotalPaise,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (orderNumber != null) 'order_number': orderNumber,
      if (orderType != null) 'order_type': orderType,
      if (status != null) 'status': status,
      if (source != null) 'source': source,
      if (tableId != null) 'table_id': tableId,
      if (customerName != null) 'customer_name': customerName,
      if (customerPhone != null) 'customer_phone': customerPhone,
      if (notes != null) 'notes': notes,
      if (subtotalPaise != null) 'subtotal_paise': subtotalPaise,
      if (discountPaise != null) 'discount_paise': discountPaise,
      if (taxPaise != null) 'tax_paise': taxPaise,
      if (roundingPaise != null) 'rounding_paise': roundingPaise,
      if (finalTotalPaise != null) 'final_total_paise': finalTotalPaise,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdersTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String>? orderNumber,
      Value<String>? orderType,
      Value<String>? status,
      Value<String>? source,
      Value<String?>? tableId,
      Value<String?>? customerName,
      Value<String?>? customerPhone,
      Value<String?>? notes,
      Value<int>? subtotalPaise,
      Value<int>? discountPaise,
      Value<int>? taxPaise,
      Value<int>? roundingPaise,
      Value<int>? finalTotalPaise,
      Value<String>? createdBy,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? version,
      Value<int>? rowid}) {
    return OrdersTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      orderNumber: orderNumber ?? this.orderNumber,
      orderType: orderType ?? this.orderType,
      status: status ?? this.status,
      source: source ?? this.source,
      tableId: tableId ?? this.tableId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      notes: notes ?? this.notes,
      subtotalPaise: subtotalPaise ?? this.subtotalPaise,
      discountPaise: discountPaise ?? this.discountPaise,
      taxPaise: taxPaise ?? this.taxPaise,
      roundingPaise: roundingPaise ?? this.roundingPaise,
      finalTotalPaise: finalTotalPaise ?? this.finalTotalPaise,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
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
    if (orderNumber.present) {
      map['order_number'] = Variable<String>(orderNumber.value);
    }
    if (orderType.present) {
      map['order_type'] = Variable<String>(orderType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (tableId.present) {
      map['table_id'] = Variable<String>(tableId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (customerPhone.present) {
      map['customer_phone'] = Variable<String>(customerPhone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (subtotalPaise.present) {
      map['subtotal_paise'] = Variable<int>(subtotalPaise.value);
    }
    if (discountPaise.present) {
      map['discount_paise'] = Variable<int>(discountPaise.value);
    }
    if (taxPaise.present) {
      map['tax_paise'] = Variable<int>(taxPaise.value);
    }
    if (roundingPaise.present) {
      map['rounding_paise'] = Variable<int>(roundingPaise.value);
    }
    if (finalTotalPaise.present) {
      map['final_total_paise'] = Variable<int>(finalTotalPaise.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('orderType: $orderType, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('tableId: $tableId, ')
          ..write('customerName: $customerName, ')
          ..write('customerPhone: $customerPhone, ')
          ..write('notes: $notes, ')
          ..write('subtotalPaise: $subtotalPaise, ')
          ..write('discountPaise: $discountPaise, ')
          ..write('taxPaise: $taxPaise, ')
          ..write('roundingPaise: $roundingPaise, ')
          ..write('finalTotalPaise: $finalTotalPaise, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrderItemsTableTable extends OrderItemsTable
    with TableInfo<$OrderItemsTableTable, OrderItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
      'order_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _variantIdMeta =
      const VerificationMeta('variantId');
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
      'variant_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _variantNameMeta =
      const VerificationMeta('variantName');
  @override
  late final GeneratedColumn<String> variantName = GeneratedColumn<String>(
      'variant_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _unitPricePaiseMeta =
      const VerificationMeta('unitPricePaise');
  @override
  late final GeneratedColumn<int> unitPricePaise = GeneratedColumn<int>(
      'unit_price_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _subtotalPaiseMeta =
      const VerificationMeta('subtotalPaise');
  @override
  late final GeneratedColumn<int> subtotalPaise = GeneratedColumn<int>(
      'subtotal_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _discountPaiseMeta =
      const VerificationMeta('discountPaise');
  @override
  late final GeneratedColumn<int> discountPaise = GeneratedColumn<int>(
      'discount_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _taxablePaiseMeta =
      const VerificationMeta('taxablePaise');
  @override
  late final GeneratedColumn<int> taxablePaise = GeneratedColumn<int>(
      'taxable_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cgstPaiseMeta =
      const VerificationMeta('cgstPaise');
  @override
  late final GeneratedColumn<int> cgstPaise = GeneratedColumn<int>(
      'cgst_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sgstPaiseMeta =
      const VerificationMeta('sgstPaise');
  @override
  late final GeneratedColumn<int> sgstPaise = GeneratedColumn<int>(
      'sgst_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _igstPaiseMeta =
      const VerificationMeta('igstPaise');
  @override
  late final GeneratedColumn<int> igstPaise = GeneratedColumn<int>(
      'igst_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalTaxPaiseMeta =
      const VerificationMeta('totalTaxPaise');
  @override
  late final GeneratedColumn<int> totalTaxPaise = GeneratedColumn<int>(
      'total_tax_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lineTotalPaiseMeta =
      const VerificationMeta('lineTotalPaise');
  @override
  late final GeneratedColumn<int> lineTotalPaise = GeneratedColumn<int>(
      'line_total_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _taxRateBpsMeta =
      const VerificationMeta('taxRateBps');
  @override
  late final GeneratedColumn<int> taxRateBps = GeneratedColumn<int>(
      'tax_rate_bps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isTaxInclusiveMeta =
      const VerificationMeta('isTaxInclusive');
  @override
  late final GeneratedColumn<bool> isTaxInclusive = GeneratedColumn<bool>(
      'is_tax_inclusive', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_tax_inclusive" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        orderId,
        tenantId,
        productId,
        variantId,
        productName,
        variantName,
        quantity,
        unitPricePaise,
        subtotalPaise,
        discountPaise,
        taxablePaise,
        cgstPaise,
        sgstPaise,
        igstPaise,
        totalTaxPaise,
        lineTotalPaise,
        taxRateBps,
        isTaxInclusive,
        notes,
        status,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_items';
  @override
  VerificationContext validateIntegrity(
      Insertable<OrderItemsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(_variantIdMeta,
          variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('variant_name')) {
      context.handle(
          _variantNameMeta,
          variantName.isAcceptableOrUnknown(
              data['variant_name']!, _variantNameMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('unit_price_paise')) {
      context.handle(
          _unitPricePaiseMeta,
          unitPricePaise.isAcceptableOrUnknown(
              data['unit_price_paise']!, _unitPricePaiseMeta));
    } else if (isInserting) {
      context.missing(_unitPricePaiseMeta);
    }
    if (data.containsKey('subtotal_paise')) {
      context.handle(
          _subtotalPaiseMeta,
          subtotalPaise.isAcceptableOrUnknown(
              data['subtotal_paise']!, _subtotalPaiseMeta));
    } else if (isInserting) {
      context.missing(_subtotalPaiseMeta);
    }
    if (data.containsKey('discount_paise')) {
      context.handle(
          _discountPaiseMeta,
          discountPaise.isAcceptableOrUnknown(
              data['discount_paise']!, _discountPaiseMeta));
    }
    if (data.containsKey('taxable_paise')) {
      context.handle(
          _taxablePaiseMeta,
          taxablePaise.isAcceptableOrUnknown(
              data['taxable_paise']!, _taxablePaiseMeta));
    } else if (isInserting) {
      context.missing(_taxablePaiseMeta);
    }
    if (data.containsKey('cgst_paise')) {
      context.handle(_cgstPaiseMeta,
          cgstPaise.isAcceptableOrUnknown(data['cgst_paise']!, _cgstPaiseMeta));
    }
    if (data.containsKey('sgst_paise')) {
      context.handle(_sgstPaiseMeta,
          sgstPaise.isAcceptableOrUnknown(data['sgst_paise']!, _sgstPaiseMeta));
    }
    if (data.containsKey('igst_paise')) {
      context.handle(_igstPaiseMeta,
          igstPaise.isAcceptableOrUnknown(data['igst_paise']!, _igstPaiseMeta));
    }
    if (data.containsKey('total_tax_paise')) {
      context.handle(
          _totalTaxPaiseMeta,
          totalTaxPaise.isAcceptableOrUnknown(
              data['total_tax_paise']!, _totalTaxPaiseMeta));
    }
    if (data.containsKey('line_total_paise')) {
      context.handle(
          _lineTotalPaiseMeta,
          lineTotalPaise.isAcceptableOrUnknown(
              data['line_total_paise']!, _lineTotalPaiseMeta));
    } else if (isInserting) {
      context.missing(_lineTotalPaiseMeta);
    }
    if (data.containsKey('tax_rate_bps')) {
      context.handle(
          _taxRateBpsMeta,
          taxRateBps.isAcceptableOrUnknown(
              data['tax_rate_bps']!, _taxRateBpsMeta));
    }
    if (data.containsKey('is_tax_inclusive')) {
      context.handle(
          _isTaxInclusiveMeta,
          isTaxInclusive.isAcceptableOrUnknown(
              data['is_tax_inclusive']!, _isTaxInclusiveMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderItemsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderItemsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      variantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variant_id']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name'])!,
      variantName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variant_name']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      unitPricePaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unit_price_paise'])!,
      subtotalPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subtotal_paise'])!,
      discountPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}discount_paise'])!,
      taxablePaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}taxable_paise'])!,
      cgstPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cgst_paise'])!,
      sgstPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sgst_paise'])!,
      igstPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}igst_paise'])!,
      totalTaxPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_tax_paise'])!,
      lineTotalPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}line_total_paise'])!,
      taxRateBps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tax_rate_bps'])!,
      isTaxInclusive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_tax_inclusive'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $OrderItemsTableTable createAlias(String alias) {
    return $OrderItemsTableTable(attachedDatabase, alias);
  }
}

class OrderItemsTableData extends DataClass
    implements Insertable<OrderItemsTableData> {
  final String id;
  final String orderId;
  final String tenantId;
  final String productId;
  final String? variantId;
  final String productName;
  final String? variantName;
  final int quantity;
  final int unitPricePaise;
  final int subtotalPaise;
  final int discountPaise;
  final int taxablePaise;
  final int cgstPaise;
  final int sgstPaise;
  final int igstPaise;
  final int totalTaxPaise;
  final int lineTotalPaise;
  final int taxRateBps;
  final bool isTaxInclusive;
  final String? notes;
  final String status;
  final DateTime createdAt;
  const OrderItemsTableData(
      {required this.id,
      required this.orderId,
      required this.tenantId,
      required this.productId,
      this.variantId,
      required this.productName,
      this.variantName,
      required this.quantity,
      required this.unitPricePaise,
      required this.subtotalPaise,
      required this.discountPaise,
      required this.taxablePaise,
      required this.cgstPaise,
      required this.sgstPaise,
      required this.igstPaise,
      required this.totalTaxPaise,
      required this.lineTotalPaise,
      required this.taxRateBps,
      required this.isTaxInclusive,
      this.notes,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['order_id'] = Variable<String>(orderId);
    map['tenant_id'] = Variable<String>(tenantId);
    map['product_id'] = Variable<String>(productId);
    if (!nullToAbsent || variantId != null) {
      map['variant_id'] = Variable<String>(variantId);
    }
    map['product_name'] = Variable<String>(productName);
    if (!nullToAbsent || variantName != null) {
      map['variant_name'] = Variable<String>(variantName);
    }
    map['quantity'] = Variable<int>(quantity);
    map['unit_price_paise'] = Variable<int>(unitPricePaise);
    map['subtotal_paise'] = Variable<int>(subtotalPaise);
    map['discount_paise'] = Variable<int>(discountPaise);
    map['taxable_paise'] = Variable<int>(taxablePaise);
    map['cgst_paise'] = Variable<int>(cgstPaise);
    map['sgst_paise'] = Variable<int>(sgstPaise);
    map['igst_paise'] = Variable<int>(igstPaise);
    map['total_tax_paise'] = Variable<int>(totalTaxPaise);
    map['line_total_paise'] = Variable<int>(lineTotalPaise);
    map['tax_rate_bps'] = Variable<int>(taxRateBps);
    map['is_tax_inclusive'] = Variable<bool>(isTaxInclusive);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OrderItemsTableCompanion toCompanion(bool nullToAbsent) {
    return OrderItemsTableCompanion(
      id: Value(id),
      orderId: Value(orderId),
      tenantId: Value(tenantId),
      productId: Value(productId),
      variantId: variantId == null && nullToAbsent
          ? const Value.absent()
          : Value(variantId),
      productName: Value(productName),
      variantName: variantName == null && nullToAbsent
          ? const Value.absent()
          : Value(variantName),
      quantity: Value(quantity),
      unitPricePaise: Value(unitPricePaise),
      subtotalPaise: Value(subtotalPaise),
      discountPaise: Value(discountPaise),
      taxablePaise: Value(taxablePaise),
      cgstPaise: Value(cgstPaise),
      sgstPaise: Value(sgstPaise),
      igstPaise: Value(igstPaise),
      totalTaxPaise: Value(totalTaxPaise),
      lineTotalPaise: Value(lineTotalPaise),
      taxRateBps: Value(taxRateBps),
      isTaxInclusive: Value(isTaxInclusive),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory OrderItemsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderItemsTableData(
      id: serializer.fromJson<String>(json['id']),
      orderId: serializer.fromJson<String>(json['orderId']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      productId: serializer.fromJson<String>(json['productId']),
      variantId: serializer.fromJson<String?>(json['variantId']),
      productName: serializer.fromJson<String>(json['productName']),
      variantName: serializer.fromJson<String?>(json['variantName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPricePaise: serializer.fromJson<int>(json['unitPricePaise']),
      subtotalPaise: serializer.fromJson<int>(json['subtotalPaise']),
      discountPaise: serializer.fromJson<int>(json['discountPaise']),
      taxablePaise: serializer.fromJson<int>(json['taxablePaise']),
      cgstPaise: serializer.fromJson<int>(json['cgstPaise']),
      sgstPaise: serializer.fromJson<int>(json['sgstPaise']),
      igstPaise: serializer.fromJson<int>(json['igstPaise']),
      totalTaxPaise: serializer.fromJson<int>(json['totalTaxPaise']),
      lineTotalPaise: serializer.fromJson<int>(json['lineTotalPaise']),
      taxRateBps: serializer.fromJson<int>(json['taxRateBps']),
      isTaxInclusive: serializer.fromJson<bool>(json['isTaxInclusive']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'orderId': serializer.toJson<String>(orderId),
      'tenantId': serializer.toJson<String>(tenantId),
      'productId': serializer.toJson<String>(productId),
      'variantId': serializer.toJson<String?>(variantId),
      'productName': serializer.toJson<String>(productName),
      'variantName': serializer.toJson<String?>(variantName),
      'quantity': serializer.toJson<int>(quantity),
      'unitPricePaise': serializer.toJson<int>(unitPricePaise),
      'subtotalPaise': serializer.toJson<int>(subtotalPaise),
      'discountPaise': serializer.toJson<int>(discountPaise),
      'taxablePaise': serializer.toJson<int>(taxablePaise),
      'cgstPaise': serializer.toJson<int>(cgstPaise),
      'sgstPaise': serializer.toJson<int>(sgstPaise),
      'igstPaise': serializer.toJson<int>(igstPaise),
      'totalTaxPaise': serializer.toJson<int>(totalTaxPaise),
      'lineTotalPaise': serializer.toJson<int>(lineTotalPaise),
      'taxRateBps': serializer.toJson<int>(taxRateBps),
      'isTaxInclusive': serializer.toJson<bool>(isTaxInclusive),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OrderItemsTableData copyWith(
          {String? id,
          String? orderId,
          String? tenantId,
          String? productId,
          Value<String?> variantId = const Value.absent(),
          String? productName,
          Value<String?> variantName = const Value.absent(),
          int? quantity,
          int? unitPricePaise,
          int? subtotalPaise,
          int? discountPaise,
          int? taxablePaise,
          int? cgstPaise,
          int? sgstPaise,
          int? igstPaise,
          int? totalTaxPaise,
          int? lineTotalPaise,
          int? taxRateBps,
          bool? isTaxInclusive,
          Value<String?> notes = const Value.absent(),
          String? status,
          DateTime? createdAt}) =>
      OrderItemsTableData(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        tenantId: tenantId ?? this.tenantId,
        productId: productId ?? this.productId,
        variantId: variantId.present ? variantId.value : this.variantId,
        productName: productName ?? this.productName,
        variantName: variantName.present ? variantName.value : this.variantName,
        quantity: quantity ?? this.quantity,
        unitPricePaise: unitPricePaise ?? this.unitPricePaise,
        subtotalPaise: subtotalPaise ?? this.subtotalPaise,
        discountPaise: discountPaise ?? this.discountPaise,
        taxablePaise: taxablePaise ?? this.taxablePaise,
        cgstPaise: cgstPaise ?? this.cgstPaise,
        sgstPaise: sgstPaise ?? this.sgstPaise,
        igstPaise: igstPaise ?? this.igstPaise,
        totalTaxPaise: totalTaxPaise ?? this.totalTaxPaise,
        lineTotalPaise: lineTotalPaise ?? this.lineTotalPaise,
        taxRateBps: taxRateBps ?? this.taxRateBps,
        isTaxInclusive: isTaxInclusive ?? this.isTaxInclusive,
        notes: notes.present ? notes.value : this.notes,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  OrderItemsTableData copyWithCompanion(OrderItemsTableCompanion data) {
    return OrderItemsTableData(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      productId: data.productId.present ? data.productId.value : this.productId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      productName:
          data.productName.present ? data.productName.value : this.productName,
      variantName:
          data.variantName.present ? data.variantName.value : this.variantName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPricePaise: data.unitPricePaise.present
          ? data.unitPricePaise.value
          : this.unitPricePaise,
      subtotalPaise: data.subtotalPaise.present
          ? data.subtotalPaise.value
          : this.subtotalPaise,
      discountPaise: data.discountPaise.present
          ? data.discountPaise.value
          : this.discountPaise,
      taxablePaise: data.taxablePaise.present
          ? data.taxablePaise.value
          : this.taxablePaise,
      cgstPaise: data.cgstPaise.present ? data.cgstPaise.value : this.cgstPaise,
      sgstPaise: data.sgstPaise.present ? data.sgstPaise.value : this.sgstPaise,
      igstPaise: data.igstPaise.present ? data.igstPaise.value : this.igstPaise,
      totalTaxPaise: data.totalTaxPaise.present
          ? data.totalTaxPaise.value
          : this.totalTaxPaise,
      lineTotalPaise: data.lineTotalPaise.present
          ? data.lineTotalPaise.value
          : this.lineTotalPaise,
      taxRateBps:
          data.taxRateBps.present ? data.taxRateBps.value : this.taxRateBps,
      isTaxInclusive: data.isTaxInclusive.present
          ? data.isTaxInclusive.value
          : this.isTaxInclusive,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderItemsTableData(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('tenantId: $tenantId, ')
          ..write('productId: $productId, ')
          ..write('variantId: $variantId, ')
          ..write('productName: $productName, ')
          ..write('variantName: $variantName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPricePaise: $unitPricePaise, ')
          ..write('subtotalPaise: $subtotalPaise, ')
          ..write('discountPaise: $discountPaise, ')
          ..write('taxablePaise: $taxablePaise, ')
          ..write('cgstPaise: $cgstPaise, ')
          ..write('sgstPaise: $sgstPaise, ')
          ..write('igstPaise: $igstPaise, ')
          ..write('totalTaxPaise: $totalTaxPaise, ')
          ..write('lineTotalPaise: $lineTotalPaise, ')
          ..write('taxRateBps: $taxRateBps, ')
          ..write('isTaxInclusive: $isTaxInclusive, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        orderId,
        tenantId,
        productId,
        variantId,
        productName,
        variantName,
        quantity,
        unitPricePaise,
        subtotalPaise,
        discountPaise,
        taxablePaise,
        cgstPaise,
        sgstPaise,
        igstPaise,
        totalTaxPaise,
        lineTotalPaise,
        taxRateBps,
        isTaxInclusive,
        notes,
        status,
        createdAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderItemsTableData &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.tenantId == this.tenantId &&
          other.productId == this.productId &&
          other.variantId == this.variantId &&
          other.productName == this.productName &&
          other.variantName == this.variantName &&
          other.quantity == this.quantity &&
          other.unitPricePaise == this.unitPricePaise &&
          other.subtotalPaise == this.subtotalPaise &&
          other.discountPaise == this.discountPaise &&
          other.taxablePaise == this.taxablePaise &&
          other.cgstPaise == this.cgstPaise &&
          other.sgstPaise == this.sgstPaise &&
          other.igstPaise == this.igstPaise &&
          other.totalTaxPaise == this.totalTaxPaise &&
          other.lineTotalPaise == this.lineTotalPaise &&
          other.taxRateBps == this.taxRateBps &&
          other.isTaxInclusive == this.isTaxInclusive &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class OrderItemsTableCompanion extends UpdateCompanion<OrderItemsTableData> {
  final Value<String> id;
  final Value<String> orderId;
  final Value<String> tenantId;
  final Value<String> productId;
  final Value<String?> variantId;
  final Value<String> productName;
  final Value<String?> variantName;
  final Value<int> quantity;
  final Value<int> unitPricePaise;
  final Value<int> subtotalPaise;
  final Value<int> discountPaise;
  final Value<int> taxablePaise;
  final Value<int> cgstPaise;
  final Value<int> sgstPaise;
  final Value<int> igstPaise;
  final Value<int> totalTaxPaise;
  final Value<int> lineTotalPaise;
  final Value<int> taxRateBps;
  final Value<bool> isTaxInclusive;
  final Value<String?> notes;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const OrderItemsTableCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.productId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.productName = const Value.absent(),
    this.variantName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPricePaise = const Value.absent(),
    this.subtotalPaise = const Value.absent(),
    this.discountPaise = const Value.absent(),
    this.taxablePaise = const Value.absent(),
    this.cgstPaise = const Value.absent(),
    this.sgstPaise = const Value.absent(),
    this.igstPaise = const Value.absent(),
    this.totalTaxPaise = const Value.absent(),
    this.lineTotalPaise = const Value.absent(),
    this.taxRateBps = const Value.absent(),
    this.isTaxInclusive = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderItemsTableCompanion.insert({
    required String id,
    required String orderId,
    required String tenantId,
    required String productId,
    this.variantId = const Value.absent(),
    required String productName,
    this.variantName = const Value.absent(),
    this.quantity = const Value.absent(),
    required int unitPricePaise,
    required int subtotalPaise,
    this.discountPaise = const Value.absent(),
    required int taxablePaise,
    this.cgstPaise = const Value.absent(),
    this.sgstPaise = const Value.absent(),
    this.igstPaise = const Value.absent(),
    this.totalTaxPaise = const Value.absent(),
    required int lineTotalPaise,
    this.taxRateBps = const Value.absent(),
    this.isTaxInclusive = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        orderId = Value(orderId),
        tenantId = Value(tenantId),
        productId = Value(productId),
        productName = Value(productName),
        unitPricePaise = Value(unitPricePaise),
        subtotalPaise = Value(subtotalPaise),
        taxablePaise = Value(taxablePaise),
        lineTotalPaise = Value(lineTotalPaise);
  static Insertable<OrderItemsTableData> custom({
    Expression<String>? id,
    Expression<String>? orderId,
    Expression<String>? tenantId,
    Expression<String>? productId,
    Expression<String>? variantId,
    Expression<String>? productName,
    Expression<String>? variantName,
    Expression<int>? quantity,
    Expression<int>? unitPricePaise,
    Expression<int>? subtotalPaise,
    Expression<int>? discountPaise,
    Expression<int>? taxablePaise,
    Expression<int>? cgstPaise,
    Expression<int>? sgstPaise,
    Expression<int>? igstPaise,
    Expression<int>? totalTaxPaise,
    Expression<int>? lineTotalPaise,
    Expression<int>? taxRateBps,
    Expression<bool>? isTaxInclusive,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (tenantId != null) 'tenant_id': tenantId,
      if (productId != null) 'product_id': productId,
      if (variantId != null) 'variant_id': variantId,
      if (productName != null) 'product_name': productName,
      if (variantName != null) 'variant_name': variantName,
      if (quantity != null) 'quantity': quantity,
      if (unitPricePaise != null) 'unit_price_paise': unitPricePaise,
      if (subtotalPaise != null) 'subtotal_paise': subtotalPaise,
      if (discountPaise != null) 'discount_paise': discountPaise,
      if (taxablePaise != null) 'taxable_paise': taxablePaise,
      if (cgstPaise != null) 'cgst_paise': cgstPaise,
      if (sgstPaise != null) 'sgst_paise': sgstPaise,
      if (igstPaise != null) 'igst_paise': igstPaise,
      if (totalTaxPaise != null) 'total_tax_paise': totalTaxPaise,
      if (lineTotalPaise != null) 'line_total_paise': lineTotalPaise,
      if (taxRateBps != null) 'tax_rate_bps': taxRateBps,
      if (isTaxInclusive != null) 'is_tax_inclusive': isTaxInclusive,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderItemsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? orderId,
      Value<String>? tenantId,
      Value<String>? productId,
      Value<String?>? variantId,
      Value<String>? productName,
      Value<String?>? variantName,
      Value<int>? quantity,
      Value<int>? unitPricePaise,
      Value<int>? subtotalPaise,
      Value<int>? discountPaise,
      Value<int>? taxablePaise,
      Value<int>? cgstPaise,
      Value<int>? sgstPaise,
      Value<int>? igstPaise,
      Value<int>? totalTaxPaise,
      Value<int>? lineTotalPaise,
      Value<int>? taxRateBps,
      Value<bool>? isTaxInclusive,
      Value<String?>? notes,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return OrderItemsTableCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      tenantId: tenantId ?? this.tenantId,
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      productName: productName ?? this.productName,
      variantName: variantName ?? this.variantName,
      quantity: quantity ?? this.quantity,
      unitPricePaise: unitPricePaise ?? this.unitPricePaise,
      subtotalPaise: subtotalPaise ?? this.subtotalPaise,
      discountPaise: discountPaise ?? this.discountPaise,
      taxablePaise: taxablePaise ?? this.taxablePaise,
      cgstPaise: cgstPaise ?? this.cgstPaise,
      sgstPaise: sgstPaise ?? this.sgstPaise,
      igstPaise: igstPaise ?? this.igstPaise,
      totalTaxPaise: totalTaxPaise ?? this.totalTaxPaise,
      lineTotalPaise: lineTotalPaise ?? this.lineTotalPaise,
      taxRateBps: taxRateBps ?? this.taxRateBps,
      isTaxInclusive: isTaxInclusive ?? this.isTaxInclusive,
      notes: notes ?? this.notes,
      status: status ?? this.status,
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
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (variantName.present) {
      map['variant_name'] = Variable<String>(variantName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPricePaise.present) {
      map['unit_price_paise'] = Variable<int>(unitPricePaise.value);
    }
    if (subtotalPaise.present) {
      map['subtotal_paise'] = Variable<int>(subtotalPaise.value);
    }
    if (discountPaise.present) {
      map['discount_paise'] = Variable<int>(discountPaise.value);
    }
    if (taxablePaise.present) {
      map['taxable_paise'] = Variable<int>(taxablePaise.value);
    }
    if (cgstPaise.present) {
      map['cgst_paise'] = Variable<int>(cgstPaise.value);
    }
    if (sgstPaise.present) {
      map['sgst_paise'] = Variable<int>(sgstPaise.value);
    }
    if (igstPaise.present) {
      map['igst_paise'] = Variable<int>(igstPaise.value);
    }
    if (totalTaxPaise.present) {
      map['total_tax_paise'] = Variable<int>(totalTaxPaise.value);
    }
    if (lineTotalPaise.present) {
      map['line_total_paise'] = Variable<int>(lineTotalPaise.value);
    }
    if (taxRateBps.present) {
      map['tax_rate_bps'] = Variable<int>(taxRateBps.value);
    }
    if (isTaxInclusive.present) {
      map['is_tax_inclusive'] = Variable<bool>(isTaxInclusive.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
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
    return (StringBuffer('OrderItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('tenantId: $tenantId, ')
          ..write('productId: $productId, ')
          ..write('variantId: $variantId, ')
          ..write('productName: $productName, ')
          ..write('variantName: $variantName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPricePaise: $unitPricePaise, ')
          ..write('subtotalPaise: $subtotalPaise, ')
          ..write('discountPaise: $discountPaise, ')
          ..write('taxablePaise: $taxablePaise, ')
          ..write('cgstPaise: $cgstPaise, ')
          ..write('sgstPaise: $sgstPaise, ')
          ..write('igstPaise: $igstPaise, ')
          ..write('totalTaxPaise: $totalTaxPaise, ')
          ..write('lineTotalPaise: $lineTotalPaise, ')
          ..write('taxRateBps: $taxRateBps, ')
          ..write('isTaxInclusive: $isTaxInclusive, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrderItemModifiersTableTable extends OrderItemModifiersTable
    with TableInfo<$OrderItemModifiersTableTable, OrderItemModifiersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderItemModifiersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderItemIdMeta =
      const VerificationMeta('orderItemId');
  @override
  late final GeneratedColumn<String> orderItemId = GeneratedColumn<String>(
      'order_item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modifierIdMeta =
      const VerificationMeta('modifierId');
  @override
  late final GeneratedColumn<String> modifierId = GeneratedColumn<String>(
      'modifier_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modifierNameMeta =
      const VerificationMeta('modifierName');
  @override
  late final GeneratedColumn<String> modifierName = GeneratedColumn<String>(
      'modifier_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceDeltaPaiseMeta =
      const VerificationMeta('priceDeltaPaise');
  @override
  late final GeneratedColumn<int> priceDeltaPaise = GeneratedColumn<int>(
      'price_delta_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, orderItemId, modifierId, modifierName, priceDeltaPaise];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_item_modifiers';
  @override
  VerificationContext validateIntegrity(
      Insertable<OrderItemModifiersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('order_item_id')) {
      context.handle(
          _orderItemIdMeta,
          orderItemId.isAcceptableOrUnknown(
              data['order_item_id']!, _orderItemIdMeta));
    } else if (isInserting) {
      context.missing(_orderItemIdMeta);
    }
    if (data.containsKey('modifier_id')) {
      context.handle(
          _modifierIdMeta,
          modifierId.isAcceptableOrUnknown(
              data['modifier_id']!, _modifierIdMeta));
    } else if (isInserting) {
      context.missing(_modifierIdMeta);
    }
    if (data.containsKey('modifier_name')) {
      context.handle(
          _modifierNameMeta,
          modifierName.isAcceptableOrUnknown(
              data['modifier_name']!, _modifierNameMeta));
    } else if (isInserting) {
      context.missing(_modifierNameMeta);
    }
    if (data.containsKey('price_delta_paise')) {
      context.handle(
          _priceDeltaPaiseMeta,
          priceDeltaPaise.isAcceptableOrUnknown(
              data['price_delta_paise']!, _priceDeltaPaiseMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderItemModifiersTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderItemModifiersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      orderItemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_item_id'])!,
      modifierId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}modifier_id'])!,
      modifierName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}modifier_name'])!,
      priceDeltaPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price_delta_paise'])!,
    );
  }

  @override
  $OrderItemModifiersTableTable createAlias(String alias) {
    return $OrderItemModifiersTableTable(attachedDatabase, alias);
  }
}

class OrderItemModifiersTableData extends DataClass
    implements Insertable<OrderItemModifiersTableData> {
  final String id;
  final String orderItemId;
  final String modifierId;
  final String modifierName;
  final int priceDeltaPaise;
  const OrderItemModifiersTableData(
      {required this.id,
      required this.orderItemId,
      required this.modifierId,
      required this.modifierName,
      required this.priceDeltaPaise});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['order_item_id'] = Variable<String>(orderItemId);
    map['modifier_id'] = Variable<String>(modifierId);
    map['modifier_name'] = Variable<String>(modifierName);
    map['price_delta_paise'] = Variable<int>(priceDeltaPaise);
    return map;
  }

  OrderItemModifiersTableCompanion toCompanion(bool nullToAbsent) {
    return OrderItemModifiersTableCompanion(
      id: Value(id),
      orderItemId: Value(orderItemId),
      modifierId: Value(modifierId),
      modifierName: Value(modifierName),
      priceDeltaPaise: Value(priceDeltaPaise),
    );
  }

  factory OrderItemModifiersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderItemModifiersTableData(
      id: serializer.fromJson<String>(json['id']),
      orderItemId: serializer.fromJson<String>(json['orderItemId']),
      modifierId: serializer.fromJson<String>(json['modifierId']),
      modifierName: serializer.fromJson<String>(json['modifierName']),
      priceDeltaPaise: serializer.fromJson<int>(json['priceDeltaPaise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'orderItemId': serializer.toJson<String>(orderItemId),
      'modifierId': serializer.toJson<String>(modifierId),
      'modifierName': serializer.toJson<String>(modifierName),
      'priceDeltaPaise': serializer.toJson<int>(priceDeltaPaise),
    };
  }

  OrderItemModifiersTableData copyWith(
          {String? id,
          String? orderItemId,
          String? modifierId,
          String? modifierName,
          int? priceDeltaPaise}) =>
      OrderItemModifiersTableData(
        id: id ?? this.id,
        orderItemId: orderItemId ?? this.orderItemId,
        modifierId: modifierId ?? this.modifierId,
        modifierName: modifierName ?? this.modifierName,
        priceDeltaPaise: priceDeltaPaise ?? this.priceDeltaPaise,
      );
  OrderItemModifiersTableData copyWithCompanion(
      OrderItemModifiersTableCompanion data) {
    return OrderItemModifiersTableData(
      id: data.id.present ? data.id.value : this.id,
      orderItemId:
          data.orderItemId.present ? data.orderItemId.value : this.orderItemId,
      modifierId:
          data.modifierId.present ? data.modifierId.value : this.modifierId,
      modifierName: data.modifierName.present
          ? data.modifierName.value
          : this.modifierName,
      priceDeltaPaise: data.priceDeltaPaise.present
          ? data.priceDeltaPaise.value
          : this.priceDeltaPaise,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderItemModifiersTableData(')
          ..write('id: $id, ')
          ..write('orderItemId: $orderItemId, ')
          ..write('modifierId: $modifierId, ')
          ..write('modifierName: $modifierName, ')
          ..write('priceDeltaPaise: $priceDeltaPaise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, orderItemId, modifierId, modifierName, priceDeltaPaise);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderItemModifiersTableData &&
          other.id == this.id &&
          other.orderItemId == this.orderItemId &&
          other.modifierId == this.modifierId &&
          other.modifierName == this.modifierName &&
          other.priceDeltaPaise == this.priceDeltaPaise);
}

class OrderItemModifiersTableCompanion
    extends UpdateCompanion<OrderItemModifiersTableData> {
  final Value<String> id;
  final Value<String> orderItemId;
  final Value<String> modifierId;
  final Value<String> modifierName;
  final Value<int> priceDeltaPaise;
  final Value<int> rowid;
  const OrderItemModifiersTableCompanion({
    this.id = const Value.absent(),
    this.orderItemId = const Value.absent(),
    this.modifierId = const Value.absent(),
    this.modifierName = const Value.absent(),
    this.priceDeltaPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderItemModifiersTableCompanion.insert({
    required String id,
    required String orderItemId,
    required String modifierId,
    required String modifierName,
    this.priceDeltaPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        orderItemId = Value(orderItemId),
        modifierId = Value(modifierId),
        modifierName = Value(modifierName);
  static Insertable<OrderItemModifiersTableData> custom({
    Expression<String>? id,
    Expression<String>? orderItemId,
    Expression<String>? modifierId,
    Expression<String>? modifierName,
    Expression<int>? priceDeltaPaise,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderItemId != null) 'order_item_id': orderItemId,
      if (modifierId != null) 'modifier_id': modifierId,
      if (modifierName != null) 'modifier_name': modifierName,
      if (priceDeltaPaise != null) 'price_delta_paise': priceDeltaPaise,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderItemModifiersTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? orderItemId,
      Value<String>? modifierId,
      Value<String>? modifierName,
      Value<int>? priceDeltaPaise,
      Value<int>? rowid}) {
    return OrderItemModifiersTableCompanion(
      id: id ?? this.id,
      orderItemId: orderItemId ?? this.orderItemId,
      modifierId: modifierId ?? this.modifierId,
      modifierName: modifierName ?? this.modifierName,
      priceDeltaPaise: priceDeltaPaise ?? this.priceDeltaPaise,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (orderItemId.present) {
      map['order_item_id'] = Variable<String>(orderItemId.value);
    }
    if (modifierId.present) {
      map['modifier_id'] = Variable<String>(modifierId.value);
    }
    if (modifierName.present) {
      map['modifier_name'] = Variable<String>(modifierName.value);
    }
    if (priceDeltaPaise.present) {
      map['price_delta_paise'] = Variable<int>(priceDeltaPaise.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderItemModifiersTableCompanion(')
          ..write('id: $id, ')
          ..write('orderItemId: $orderItemId, ')
          ..write('modifierId: $modifierId, ')
          ..write('modifierName: $modifierName, ')
          ..write('priceDeltaPaise: $priceDeltaPaise, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTableTable extends InvoicesTable
    with TableInfo<$InvoicesTableTable, InvoicesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceNumberMeta =
      const VerificationMeta('invoiceNumber');
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
      'invoice_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
      'order_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subtotalPaiseMeta =
      const VerificationMeta('subtotalPaise');
  @override
  late final GeneratedColumn<int> subtotalPaise = GeneratedColumn<int>(
      'subtotal_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _discountPaiseMeta =
      const VerificationMeta('discountPaise');
  @override
  late final GeneratedColumn<int> discountPaise = GeneratedColumn<int>(
      'discount_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _taxablePaiseMeta =
      const VerificationMeta('taxablePaise');
  @override
  late final GeneratedColumn<int> taxablePaise = GeneratedColumn<int>(
      'taxable_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cgstPaiseMeta =
      const VerificationMeta('cgstPaise');
  @override
  late final GeneratedColumn<int> cgstPaise = GeneratedColumn<int>(
      'cgst_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sgstPaiseMeta =
      const VerificationMeta('sgstPaise');
  @override
  late final GeneratedColumn<int> sgstPaise = GeneratedColumn<int>(
      'sgst_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _igstPaiseMeta =
      const VerificationMeta('igstPaise');
  @override
  late final GeneratedColumn<int> igstPaise = GeneratedColumn<int>(
      'igst_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalTaxPaiseMeta =
      const VerificationMeta('totalTaxPaise');
  @override
  late final GeneratedColumn<int> totalTaxPaise = GeneratedColumn<int>(
      'total_tax_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _roundingPaiseMeta =
      const VerificationMeta('roundingPaise');
  @override
  late final GeneratedColumn<int> roundingPaise = GeneratedColumn<int>(
      'rounding_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _finalTotalPaiseMeta =
      const VerificationMeta('finalTotalPaise');
  @override
  late final GeneratedColumn<int> finalTotalPaise = GeneratedColumn<int>(
      'final_total_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('issued'));
  static const VerificationMeta _customerNameMeta =
      const VerificationMeta('customerName');
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
      'customer_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customerPhoneMeta =
      const VerificationMeta('customerPhone');
  @override
  late final GeneratedColumn<String> customerPhone = GeneratedColumn<String>(
      'customer_phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customerGstinMeta =
      const VerificationMeta('customerGstin');
  @override
  late final GeneratedColumn<String> customerGstin = GeneratedColumn<String>(
      'customer_gstin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fiscalYearMeta =
      const VerificationMeta('fiscalYear');
  @override
  late final GeneratedColumn<String> fiscalYear = GeneratedColumn<String>(
      'fiscal_year', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deviceSeriesMeta =
      const VerificationMeta('deviceSeries');
  @override
  late final GeneratedColumn<String> deviceSeries = GeneratedColumn<String>(
      'device_series', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sequenceNumberMeta =
      const VerificationMeta('sequenceNumber');
  @override
  late final GeneratedColumn<int> sequenceNumber = GeneratedColumn<int>(
      'sequence_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _issuedAtMeta =
      const VerificationMeta('issuedAt');
  @override
  late final GeneratedColumn<DateTime> issuedAt = GeneratedColumn<DateTime>(
      'issued_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _issuedByMeta =
      const VerificationMeta('issuedBy');
  @override
  late final GeneratedColumn<String> issuedBy = GeneratedColumn<String>(
      'issued_by', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        branchId,
        invoiceNumber,
        orderId,
        subtotalPaise,
        discountPaise,
        taxablePaise,
        cgstPaise,
        sgstPaise,
        igstPaise,
        totalTaxPaise,
        roundingPaise,
        finalTotalPaise,
        status,
        customerName,
        customerPhone,
        customerGstin,
        fiscalYear,
        deviceSeries,
        sequenceNumber,
        issuedAt,
        issuedBy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(Insertable<InvoicesTableData> instance,
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
    if (data.containsKey('invoice_number')) {
      context.handle(
          _invoiceNumberMeta,
          invoiceNumber.isAcceptableOrUnknown(
              data['invoice_number']!, _invoiceNumberMeta));
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    }
    if (data.containsKey('subtotal_paise')) {
      context.handle(
          _subtotalPaiseMeta,
          subtotalPaise.isAcceptableOrUnknown(
              data['subtotal_paise']!, _subtotalPaiseMeta));
    } else if (isInserting) {
      context.missing(_subtotalPaiseMeta);
    }
    if (data.containsKey('discount_paise')) {
      context.handle(
          _discountPaiseMeta,
          discountPaise.isAcceptableOrUnknown(
              data['discount_paise']!, _discountPaiseMeta));
    }
    if (data.containsKey('taxable_paise')) {
      context.handle(
          _taxablePaiseMeta,
          taxablePaise.isAcceptableOrUnknown(
              data['taxable_paise']!, _taxablePaiseMeta));
    } else if (isInserting) {
      context.missing(_taxablePaiseMeta);
    }
    if (data.containsKey('cgst_paise')) {
      context.handle(_cgstPaiseMeta,
          cgstPaise.isAcceptableOrUnknown(data['cgst_paise']!, _cgstPaiseMeta));
    }
    if (data.containsKey('sgst_paise')) {
      context.handle(_sgstPaiseMeta,
          sgstPaise.isAcceptableOrUnknown(data['sgst_paise']!, _sgstPaiseMeta));
    }
    if (data.containsKey('igst_paise')) {
      context.handle(_igstPaiseMeta,
          igstPaise.isAcceptableOrUnknown(data['igst_paise']!, _igstPaiseMeta));
    }
    if (data.containsKey('total_tax_paise')) {
      context.handle(
          _totalTaxPaiseMeta,
          totalTaxPaise.isAcceptableOrUnknown(
              data['total_tax_paise']!, _totalTaxPaiseMeta));
    }
    if (data.containsKey('rounding_paise')) {
      context.handle(
          _roundingPaiseMeta,
          roundingPaise.isAcceptableOrUnknown(
              data['rounding_paise']!, _roundingPaiseMeta));
    }
    if (data.containsKey('final_total_paise')) {
      context.handle(
          _finalTotalPaiseMeta,
          finalTotalPaise.isAcceptableOrUnknown(
              data['final_total_paise']!, _finalTotalPaiseMeta));
    } else if (isInserting) {
      context.missing(_finalTotalPaiseMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('customer_name')) {
      context.handle(
          _customerNameMeta,
          customerName.isAcceptableOrUnknown(
              data['customer_name']!, _customerNameMeta));
    }
    if (data.containsKey('customer_phone')) {
      context.handle(
          _customerPhoneMeta,
          customerPhone.isAcceptableOrUnknown(
              data['customer_phone']!, _customerPhoneMeta));
    }
    if (data.containsKey('customer_gstin')) {
      context.handle(
          _customerGstinMeta,
          customerGstin.isAcceptableOrUnknown(
              data['customer_gstin']!, _customerGstinMeta));
    }
    if (data.containsKey('fiscal_year')) {
      context.handle(
          _fiscalYearMeta,
          fiscalYear.isAcceptableOrUnknown(
              data['fiscal_year']!, _fiscalYearMeta));
    } else if (isInserting) {
      context.missing(_fiscalYearMeta);
    }
    if (data.containsKey('device_series')) {
      context.handle(
          _deviceSeriesMeta,
          deviceSeries.isAcceptableOrUnknown(
              data['device_series']!, _deviceSeriesMeta));
    } else if (isInserting) {
      context.missing(_deviceSeriesMeta);
    }
    if (data.containsKey('sequence_number')) {
      context.handle(
          _sequenceNumberMeta,
          sequenceNumber.isAcceptableOrUnknown(
              data['sequence_number']!, _sequenceNumberMeta));
    } else if (isInserting) {
      context.missing(_sequenceNumberMeta);
    }
    if (data.containsKey('issued_at')) {
      context.handle(_issuedAtMeta,
          issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta));
    }
    if (data.containsKey('issued_by')) {
      context.handle(_issuedByMeta,
          issuedBy.isAcceptableOrUnknown(data['issued_by']!, _issuedByMeta));
    } else if (isInserting) {
      context.missing(_issuedByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoicesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoicesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      invoiceNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invoice_number'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_id']),
      subtotalPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subtotal_paise'])!,
      discountPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}discount_paise'])!,
      taxablePaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}taxable_paise'])!,
      cgstPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cgst_paise'])!,
      sgstPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sgst_paise'])!,
      igstPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}igst_paise'])!,
      totalTaxPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_tax_paise'])!,
      roundingPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rounding_paise'])!,
      finalTotalPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}final_total_paise'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      customerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_name']),
      customerPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_phone']),
      customerGstin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_gstin']),
      fiscalYear: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fiscal_year'])!,
      deviceSeries: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_series'])!,
      sequenceNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sequence_number'])!,
      issuedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}issued_at'])!,
      issuedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}issued_by'])!,
    );
  }

  @override
  $InvoicesTableTable createAlias(String alias) {
    return $InvoicesTableTable(attachedDatabase, alias);
  }
}

class InvoicesTableData extends DataClass
    implements Insertable<InvoicesTableData> {
  final String id;
  final String tenantId;
  final String branchId;
  final String invoiceNumber;
  final String? orderId;
  final int subtotalPaise;
  final int discountPaise;
  final int taxablePaise;
  final int cgstPaise;
  final int sgstPaise;
  final int igstPaise;
  final int totalTaxPaise;
  final int roundingPaise;
  final int finalTotalPaise;
  final String status;
  final String? customerName;
  final String? customerPhone;
  final String? customerGstin;
  final String fiscalYear;
  final String deviceSeries;
  final int sequenceNumber;
  final DateTime issuedAt;
  final String issuedBy;
  const InvoicesTableData(
      {required this.id,
      required this.tenantId,
      required this.branchId,
      required this.invoiceNumber,
      this.orderId,
      required this.subtotalPaise,
      required this.discountPaise,
      required this.taxablePaise,
      required this.cgstPaise,
      required this.sgstPaise,
      required this.igstPaise,
      required this.totalTaxPaise,
      required this.roundingPaise,
      required this.finalTotalPaise,
      required this.status,
      this.customerName,
      this.customerPhone,
      this.customerGstin,
      required this.fiscalYear,
      required this.deviceSeries,
      required this.sequenceNumber,
      required this.issuedAt,
      required this.issuedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    if (!nullToAbsent || orderId != null) {
      map['order_id'] = Variable<String>(orderId);
    }
    map['subtotal_paise'] = Variable<int>(subtotalPaise);
    map['discount_paise'] = Variable<int>(discountPaise);
    map['taxable_paise'] = Variable<int>(taxablePaise);
    map['cgst_paise'] = Variable<int>(cgstPaise);
    map['sgst_paise'] = Variable<int>(sgstPaise);
    map['igst_paise'] = Variable<int>(igstPaise);
    map['total_tax_paise'] = Variable<int>(totalTaxPaise);
    map['rounding_paise'] = Variable<int>(roundingPaise);
    map['final_total_paise'] = Variable<int>(finalTotalPaise);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    if (!nullToAbsent || customerPhone != null) {
      map['customer_phone'] = Variable<String>(customerPhone);
    }
    if (!nullToAbsent || customerGstin != null) {
      map['customer_gstin'] = Variable<String>(customerGstin);
    }
    map['fiscal_year'] = Variable<String>(fiscalYear);
    map['device_series'] = Variable<String>(deviceSeries);
    map['sequence_number'] = Variable<int>(sequenceNumber);
    map['issued_at'] = Variable<DateTime>(issuedAt);
    map['issued_by'] = Variable<String>(issuedBy);
    return map;
  }

  InvoicesTableCompanion toCompanion(bool nullToAbsent) {
    return InvoicesTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      invoiceNumber: Value(invoiceNumber),
      orderId: orderId == null && nullToAbsent
          ? const Value.absent()
          : Value(orderId),
      subtotalPaise: Value(subtotalPaise),
      discountPaise: Value(discountPaise),
      taxablePaise: Value(taxablePaise),
      cgstPaise: Value(cgstPaise),
      sgstPaise: Value(sgstPaise),
      igstPaise: Value(igstPaise),
      totalTaxPaise: Value(totalTaxPaise),
      roundingPaise: Value(roundingPaise),
      finalTotalPaise: Value(finalTotalPaise),
      status: Value(status),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      customerPhone: customerPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(customerPhone),
      customerGstin: customerGstin == null && nullToAbsent
          ? const Value.absent()
          : Value(customerGstin),
      fiscalYear: Value(fiscalYear),
      deviceSeries: Value(deviceSeries),
      sequenceNumber: Value(sequenceNumber),
      issuedAt: Value(issuedAt),
      issuedBy: Value(issuedBy),
    );
  }

  factory InvoicesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoicesTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      orderId: serializer.fromJson<String?>(json['orderId']),
      subtotalPaise: serializer.fromJson<int>(json['subtotalPaise']),
      discountPaise: serializer.fromJson<int>(json['discountPaise']),
      taxablePaise: serializer.fromJson<int>(json['taxablePaise']),
      cgstPaise: serializer.fromJson<int>(json['cgstPaise']),
      sgstPaise: serializer.fromJson<int>(json['sgstPaise']),
      igstPaise: serializer.fromJson<int>(json['igstPaise']),
      totalTaxPaise: serializer.fromJson<int>(json['totalTaxPaise']),
      roundingPaise: serializer.fromJson<int>(json['roundingPaise']),
      finalTotalPaise: serializer.fromJson<int>(json['finalTotalPaise']),
      status: serializer.fromJson<String>(json['status']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      customerPhone: serializer.fromJson<String?>(json['customerPhone']),
      customerGstin: serializer.fromJson<String?>(json['customerGstin']),
      fiscalYear: serializer.fromJson<String>(json['fiscalYear']),
      deviceSeries: serializer.fromJson<String>(json['deviceSeries']),
      sequenceNumber: serializer.fromJson<int>(json['sequenceNumber']),
      issuedAt: serializer.fromJson<DateTime>(json['issuedAt']),
      issuedBy: serializer.fromJson<String>(json['issuedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'orderId': serializer.toJson<String?>(orderId),
      'subtotalPaise': serializer.toJson<int>(subtotalPaise),
      'discountPaise': serializer.toJson<int>(discountPaise),
      'taxablePaise': serializer.toJson<int>(taxablePaise),
      'cgstPaise': serializer.toJson<int>(cgstPaise),
      'sgstPaise': serializer.toJson<int>(sgstPaise),
      'igstPaise': serializer.toJson<int>(igstPaise),
      'totalTaxPaise': serializer.toJson<int>(totalTaxPaise),
      'roundingPaise': serializer.toJson<int>(roundingPaise),
      'finalTotalPaise': serializer.toJson<int>(finalTotalPaise),
      'status': serializer.toJson<String>(status),
      'customerName': serializer.toJson<String?>(customerName),
      'customerPhone': serializer.toJson<String?>(customerPhone),
      'customerGstin': serializer.toJson<String?>(customerGstin),
      'fiscalYear': serializer.toJson<String>(fiscalYear),
      'deviceSeries': serializer.toJson<String>(deviceSeries),
      'sequenceNumber': serializer.toJson<int>(sequenceNumber),
      'issuedAt': serializer.toJson<DateTime>(issuedAt),
      'issuedBy': serializer.toJson<String>(issuedBy),
    };
  }

  InvoicesTableData copyWith(
          {String? id,
          String? tenantId,
          String? branchId,
          String? invoiceNumber,
          Value<String?> orderId = const Value.absent(),
          int? subtotalPaise,
          int? discountPaise,
          int? taxablePaise,
          int? cgstPaise,
          int? sgstPaise,
          int? igstPaise,
          int? totalTaxPaise,
          int? roundingPaise,
          int? finalTotalPaise,
          String? status,
          Value<String?> customerName = const Value.absent(),
          Value<String?> customerPhone = const Value.absent(),
          Value<String?> customerGstin = const Value.absent(),
          String? fiscalYear,
          String? deviceSeries,
          int? sequenceNumber,
          DateTime? issuedAt,
          String? issuedBy}) =>
      InvoicesTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        orderId: orderId.present ? orderId.value : this.orderId,
        subtotalPaise: subtotalPaise ?? this.subtotalPaise,
        discountPaise: discountPaise ?? this.discountPaise,
        taxablePaise: taxablePaise ?? this.taxablePaise,
        cgstPaise: cgstPaise ?? this.cgstPaise,
        sgstPaise: sgstPaise ?? this.sgstPaise,
        igstPaise: igstPaise ?? this.igstPaise,
        totalTaxPaise: totalTaxPaise ?? this.totalTaxPaise,
        roundingPaise: roundingPaise ?? this.roundingPaise,
        finalTotalPaise: finalTotalPaise ?? this.finalTotalPaise,
        status: status ?? this.status,
        customerName:
            customerName.present ? customerName.value : this.customerName,
        customerPhone:
            customerPhone.present ? customerPhone.value : this.customerPhone,
        customerGstin:
            customerGstin.present ? customerGstin.value : this.customerGstin,
        fiscalYear: fiscalYear ?? this.fiscalYear,
        deviceSeries: deviceSeries ?? this.deviceSeries,
        sequenceNumber: sequenceNumber ?? this.sequenceNumber,
        issuedAt: issuedAt ?? this.issuedAt,
        issuedBy: issuedBy ?? this.issuedBy,
      );
  InvoicesTableData copyWithCompanion(InvoicesTableCompanion data) {
    return InvoicesTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      subtotalPaise: data.subtotalPaise.present
          ? data.subtotalPaise.value
          : this.subtotalPaise,
      discountPaise: data.discountPaise.present
          ? data.discountPaise.value
          : this.discountPaise,
      taxablePaise: data.taxablePaise.present
          ? data.taxablePaise.value
          : this.taxablePaise,
      cgstPaise: data.cgstPaise.present ? data.cgstPaise.value : this.cgstPaise,
      sgstPaise: data.sgstPaise.present ? data.sgstPaise.value : this.sgstPaise,
      igstPaise: data.igstPaise.present ? data.igstPaise.value : this.igstPaise,
      totalTaxPaise: data.totalTaxPaise.present
          ? data.totalTaxPaise.value
          : this.totalTaxPaise,
      roundingPaise: data.roundingPaise.present
          ? data.roundingPaise.value
          : this.roundingPaise,
      finalTotalPaise: data.finalTotalPaise.present
          ? data.finalTotalPaise.value
          : this.finalTotalPaise,
      status: data.status.present ? data.status.value : this.status,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      customerPhone: data.customerPhone.present
          ? data.customerPhone.value
          : this.customerPhone,
      customerGstin: data.customerGstin.present
          ? data.customerGstin.value
          : this.customerGstin,
      fiscalYear:
          data.fiscalYear.present ? data.fiscalYear.value : this.fiscalYear,
      deviceSeries: data.deviceSeries.present
          ? data.deviceSeries.value
          : this.deviceSeries,
      sequenceNumber: data.sequenceNumber.present
          ? data.sequenceNumber.value
          : this.sequenceNumber,
      issuedAt: data.issuedAt.present ? data.issuedAt.value : this.issuedAt,
      issuedBy: data.issuedBy.present ? data.issuedBy.value : this.issuedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('orderId: $orderId, ')
          ..write('subtotalPaise: $subtotalPaise, ')
          ..write('discountPaise: $discountPaise, ')
          ..write('taxablePaise: $taxablePaise, ')
          ..write('cgstPaise: $cgstPaise, ')
          ..write('sgstPaise: $sgstPaise, ')
          ..write('igstPaise: $igstPaise, ')
          ..write('totalTaxPaise: $totalTaxPaise, ')
          ..write('roundingPaise: $roundingPaise, ')
          ..write('finalTotalPaise: $finalTotalPaise, ')
          ..write('status: $status, ')
          ..write('customerName: $customerName, ')
          ..write('customerPhone: $customerPhone, ')
          ..write('customerGstin: $customerGstin, ')
          ..write('fiscalYear: $fiscalYear, ')
          ..write('deviceSeries: $deviceSeries, ')
          ..write('sequenceNumber: $sequenceNumber, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('issuedBy: $issuedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        tenantId,
        branchId,
        invoiceNumber,
        orderId,
        subtotalPaise,
        discountPaise,
        taxablePaise,
        cgstPaise,
        sgstPaise,
        igstPaise,
        totalTaxPaise,
        roundingPaise,
        finalTotalPaise,
        status,
        customerName,
        customerPhone,
        customerGstin,
        fiscalYear,
        deviceSeries,
        sequenceNumber,
        issuedAt,
        issuedBy
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoicesTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.invoiceNumber == this.invoiceNumber &&
          other.orderId == this.orderId &&
          other.subtotalPaise == this.subtotalPaise &&
          other.discountPaise == this.discountPaise &&
          other.taxablePaise == this.taxablePaise &&
          other.cgstPaise == this.cgstPaise &&
          other.sgstPaise == this.sgstPaise &&
          other.igstPaise == this.igstPaise &&
          other.totalTaxPaise == this.totalTaxPaise &&
          other.roundingPaise == this.roundingPaise &&
          other.finalTotalPaise == this.finalTotalPaise &&
          other.status == this.status &&
          other.customerName == this.customerName &&
          other.customerPhone == this.customerPhone &&
          other.customerGstin == this.customerGstin &&
          other.fiscalYear == this.fiscalYear &&
          other.deviceSeries == this.deviceSeries &&
          other.sequenceNumber == this.sequenceNumber &&
          other.issuedAt == this.issuedAt &&
          other.issuedBy == this.issuedBy);
}

class InvoicesTableCompanion extends UpdateCompanion<InvoicesTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> invoiceNumber;
  final Value<String?> orderId;
  final Value<int> subtotalPaise;
  final Value<int> discountPaise;
  final Value<int> taxablePaise;
  final Value<int> cgstPaise;
  final Value<int> sgstPaise;
  final Value<int> igstPaise;
  final Value<int> totalTaxPaise;
  final Value<int> roundingPaise;
  final Value<int> finalTotalPaise;
  final Value<String> status;
  final Value<String?> customerName;
  final Value<String?> customerPhone;
  final Value<String?> customerGstin;
  final Value<String> fiscalYear;
  final Value<String> deviceSeries;
  final Value<int> sequenceNumber;
  final Value<DateTime> issuedAt;
  final Value<String> issuedBy;
  final Value<int> rowid;
  const InvoicesTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.orderId = const Value.absent(),
    this.subtotalPaise = const Value.absent(),
    this.discountPaise = const Value.absent(),
    this.taxablePaise = const Value.absent(),
    this.cgstPaise = const Value.absent(),
    this.sgstPaise = const Value.absent(),
    this.igstPaise = const Value.absent(),
    this.totalTaxPaise = const Value.absent(),
    this.roundingPaise = const Value.absent(),
    this.finalTotalPaise = const Value.absent(),
    this.status = const Value.absent(),
    this.customerName = const Value.absent(),
    this.customerPhone = const Value.absent(),
    this.customerGstin = const Value.absent(),
    this.fiscalYear = const Value.absent(),
    this.deviceSeries = const Value.absent(),
    this.sequenceNumber = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.issuedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoicesTableCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    required String invoiceNumber,
    this.orderId = const Value.absent(),
    required int subtotalPaise,
    this.discountPaise = const Value.absent(),
    required int taxablePaise,
    this.cgstPaise = const Value.absent(),
    this.sgstPaise = const Value.absent(),
    this.igstPaise = const Value.absent(),
    this.totalTaxPaise = const Value.absent(),
    this.roundingPaise = const Value.absent(),
    required int finalTotalPaise,
    this.status = const Value.absent(),
    this.customerName = const Value.absent(),
    this.customerPhone = const Value.absent(),
    this.customerGstin = const Value.absent(),
    required String fiscalYear,
    required String deviceSeries,
    required int sequenceNumber,
    this.issuedAt = const Value.absent(),
    required String issuedBy,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        branchId = Value(branchId),
        invoiceNumber = Value(invoiceNumber),
        subtotalPaise = Value(subtotalPaise),
        taxablePaise = Value(taxablePaise),
        finalTotalPaise = Value(finalTotalPaise),
        fiscalYear = Value(fiscalYear),
        deviceSeries = Value(deviceSeries),
        sequenceNumber = Value(sequenceNumber),
        issuedBy = Value(issuedBy);
  static Insertable<InvoicesTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? invoiceNumber,
    Expression<String>? orderId,
    Expression<int>? subtotalPaise,
    Expression<int>? discountPaise,
    Expression<int>? taxablePaise,
    Expression<int>? cgstPaise,
    Expression<int>? sgstPaise,
    Expression<int>? igstPaise,
    Expression<int>? totalTaxPaise,
    Expression<int>? roundingPaise,
    Expression<int>? finalTotalPaise,
    Expression<String>? status,
    Expression<String>? customerName,
    Expression<String>? customerPhone,
    Expression<String>? customerGstin,
    Expression<String>? fiscalYear,
    Expression<String>? deviceSeries,
    Expression<int>? sequenceNumber,
    Expression<DateTime>? issuedAt,
    Expression<String>? issuedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (orderId != null) 'order_id': orderId,
      if (subtotalPaise != null) 'subtotal_paise': subtotalPaise,
      if (discountPaise != null) 'discount_paise': discountPaise,
      if (taxablePaise != null) 'taxable_paise': taxablePaise,
      if (cgstPaise != null) 'cgst_paise': cgstPaise,
      if (sgstPaise != null) 'sgst_paise': sgstPaise,
      if (igstPaise != null) 'igst_paise': igstPaise,
      if (totalTaxPaise != null) 'total_tax_paise': totalTaxPaise,
      if (roundingPaise != null) 'rounding_paise': roundingPaise,
      if (finalTotalPaise != null) 'final_total_paise': finalTotalPaise,
      if (status != null) 'status': status,
      if (customerName != null) 'customer_name': customerName,
      if (customerPhone != null) 'customer_phone': customerPhone,
      if (customerGstin != null) 'customer_gstin': customerGstin,
      if (fiscalYear != null) 'fiscal_year': fiscalYear,
      if (deviceSeries != null) 'device_series': deviceSeries,
      if (sequenceNumber != null) 'sequence_number': sequenceNumber,
      if (issuedAt != null) 'issued_at': issuedAt,
      if (issuedBy != null) 'issued_by': issuedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoicesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String>? invoiceNumber,
      Value<String?>? orderId,
      Value<int>? subtotalPaise,
      Value<int>? discountPaise,
      Value<int>? taxablePaise,
      Value<int>? cgstPaise,
      Value<int>? sgstPaise,
      Value<int>? igstPaise,
      Value<int>? totalTaxPaise,
      Value<int>? roundingPaise,
      Value<int>? finalTotalPaise,
      Value<String>? status,
      Value<String?>? customerName,
      Value<String?>? customerPhone,
      Value<String?>? customerGstin,
      Value<String>? fiscalYear,
      Value<String>? deviceSeries,
      Value<int>? sequenceNumber,
      Value<DateTime>? issuedAt,
      Value<String>? issuedBy,
      Value<int>? rowid}) {
    return InvoicesTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      orderId: orderId ?? this.orderId,
      subtotalPaise: subtotalPaise ?? this.subtotalPaise,
      discountPaise: discountPaise ?? this.discountPaise,
      taxablePaise: taxablePaise ?? this.taxablePaise,
      cgstPaise: cgstPaise ?? this.cgstPaise,
      sgstPaise: sgstPaise ?? this.sgstPaise,
      igstPaise: igstPaise ?? this.igstPaise,
      totalTaxPaise: totalTaxPaise ?? this.totalTaxPaise,
      roundingPaise: roundingPaise ?? this.roundingPaise,
      finalTotalPaise: finalTotalPaise ?? this.finalTotalPaise,
      status: status ?? this.status,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerGstin: customerGstin ?? this.customerGstin,
      fiscalYear: fiscalYear ?? this.fiscalYear,
      deviceSeries: deviceSeries ?? this.deviceSeries,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      issuedAt: issuedAt ?? this.issuedAt,
      issuedBy: issuedBy ?? this.issuedBy,
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
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (subtotalPaise.present) {
      map['subtotal_paise'] = Variable<int>(subtotalPaise.value);
    }
    if (discountPaise.present) {
      map['discount_paise'] = Variable<int>(discountPaise.value);
    }
    if (taxablePaise.present) {
      map['taxable_paise'] = Variable<int>(taxablePaise.value);
    }
    if (cgstPaise.present) {
      map['cgst_paise'] = Variable<int>(cgstPaise.value);
    }
    if (sgstPaise.present) {
      map['sgst_paise'] = Variable<int>(sgstPaise.value);
    }
    if (igstPaise.present) {
      map['igst_paise'] = Variable<int>(igstPaise.value);
    }
    if (totalTaxPaise.present) {
      map['total_tax_paise'] = Variable<int>(totalTaxPaise.value);
    }
    if (roundingPaise.present) {
      map['rounding_paise'] = Variable<int>(roundingPaise.value);
    }
    if (finalTotalPaise.present) {
      map['final_total_paise'] = Variable<int>(finalTotalPaise.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (customerPhone.present) {
      map['customer_phone'] = Variable<String>(customerPhone.value);
    }
    if (customerGstin.present) {
      map['customer_gstin'] = Variable<String>(customerGstin.value);
    }
    if (fiscalYear.present) {
      map['fiscal_year'] = Variable<String>(fiscalYear.value);
    }
    if (deviceSeries.present) {
      map['device_series'] = Variable<String>(deviceSeries.value);
    }
    if (sequenceNumber.present) {
      map['sequence_number'] = Variable<int>(sequenceNumber.value);
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<DateTime>(issuedAt.value);
    }
    if (issuedBy.present) {
      map['issued_by'] = Variable<String>(issuedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('orderId: $orderId, ')
          ..write('subtotalPaise: $subtotalPaise, ')
          ..write('discountPaise: $discountPaise, ')
          ..write('taxablePaise: $taxablePaise, ')
          ..write('cgstPaise: $cgstPaise, ')
          ..write('sgstPaise: $sgstPaise, ')
          ..write('igstPaise: $igstPaise, ')
          ..write('totalTaxPaise: $totalTaxPaise, ')
          ..write('roundingPaise: $roundingPaise, ')
          ..write('finalTotalPaise: $finalTotalPaise, ')
          ..write('status: $status, ')
          ..write('customerName: $customerName, ')
          ..write('customerPhone: $customerPhone, ')
          ..write('customerGstin: $customerGstin, ')
          ..write('fiscalYear: $fiscalYear, ')
          ..write('deviceSeries: $deviceSeries, ')
          ..write('sequenceNumber: $sequenceNumber, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('issuedBy: $issuedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTableTable extends PaymentsTable
    with TableInfo<$PaymentsTableTable, PaymentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceIdMeta =
      const VerificationMeta('invoiceId');
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
      'invoice_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
      'order_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('completed'));
  static const VerificationMeta _amountPaiseMeta =
      const VerificationMeta('amountPaise');
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
      'amount_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tenderedPaiseMeta =
      const VerificationMeta('tenderedPaise');
  @override
  late final GeneratedColumn<int> tenderedPaise = GeneratedColumn<int>(
      'tendered_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _changeDuePaiseMeta =
      const VerificationMeta('changeDuePaise');
  @override
  late final GeneratedColumn<int> changeDuePaise = GeneratedColumn<int>(
      'change_due_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _referenceNumberMeta =
      const VerificationMeta('referenceNumber');
  @override
  late final GeneratedColumn<String> referenceNumber = GeneratedColumn<String>(
      'reference_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _recordedByMeta =
      const VerificationMeta('recordedBy');
  @override
  late final GeneratedColumn<String> recordedBy = GeneratedColumn<String>(
      'recorded_by', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
      'recorded_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        branchId,
        invoiceId,
        orderId,
        method,
        status,
        amountPaise,
        tenderedPaise,
        changeDuePaise,
        referenceNumber,
        recordedBy,
        recordedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(Insertable<PaymentsTableData> instance,
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
    if (data.containsKey('invoice_id')) {
      context.handle(_invoiceIdMeta,
          invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    }
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
          _amountPaiseMeta,
          amountPaise.isAcceptableOrUnknown(
              data['amount_paise']!, _amountPaiseMeta));
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('tendered_paise')) {
      context.handle(
          _tenderedPaiseMeta,
          tenderedPaise.isAcceptableOrUnknown(
              data['tendered_paise']!, _tenderedPaiseMeta));
    }
    if (data.containsKey('change_due_paise')) {
      context.handle(
          _changeDuePaiseMeta,
          changeDuePaise.isAcceptableOrUnknown(
              data['change_due_paise']!, _changeDuePaiseMeta));
    }
    if (data.containsKey('reference_number')) {
      context.handle(
          _referenceNumberMeta,
          referenceNumber.isAcceptableOrUnknown(
              data['reference_number']!, _referenceNumberMeta));
    }
    if (data.containsKey('recorded_by')) {
      context.handle(
          _recordedByMeta,
          recordedBy.isAcceptableOrUnknown(
              data['recorded_by']!, _recordedByMeta));
    } else if (isInserting) {
      context.missing(_recordedByMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['recorded_at']!, _recordedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      invoiceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invoice_id']),
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_id']),
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      amountPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_paise'])!,
      tenderedPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tendered_paise']),
      changeDuePaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}change_due_paise']),
      referenceNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}reference_number']),
      recordedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recorded_by'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}recorded_at'])!,
    );
  }

  @override
  $PaymentsTableTable createAlias(String alias) {
    return $PaymentsTableTable(attachedDatabase, alias);
  }
}

class PaymentsTableData extends DataClass
    implements Insertable<PaymentsTableData> {
  final String id;
  final String tenantId;
  final String branchId;
  final String? invoiceId;
  final String? orderId;
  final String method;
  final String status;
  final int amountPaise;
  final int? tenderedPaise;
  final int? changeDuePaise;
  final String? referenceNumber;
  final String recordedBy;
  final DateTime recordedAt;
  const PaymentsTableData(
      {required this.id,
      required this.tenantId,
      required this.branchId,
      this.invoiceId,
      this.orderId,
      required this.method,
      required this.status,
      required this.amountPaise,
      this.tenderedPaise,
      this.changeDuePaise,
      this.referenceNumber,
      required this.recordedBy,
      required this.recordedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<String>(invoiceId);
    }
    if (!nullToAbsent || orderId != null) {
      map['order_id'] = Variable<String>(orderId);
    }
    map['method'] = Variable<String>(method);
    map['status'] = Variable<String>(status);
    map['amount_paise'] = Variable<int>(amountPaise);
    if (!nullToAbsent || tenderedPaise != null) {
      map['tendered_paise'] = Variable<int>(tenderedPaise);
    }
    if (!nullToAbsent || changeDuePaise != null) {
      map['change_due_paise'] = Variable<int>(changeDuePaise);
    }
    if (!nullToAbsent || referenceNumber != null) {
      map['reference_number'] = Variable<String>(referenceNumber);
    }
    map['recorded_by'] = Variable<String>(recordedBy);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    return map;
  }

  PaymentsTableCompanion toCompanion(bool nullToAbsent) {
    return PaymentsTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
      orderId: orderId == null && nullToAbsent
          ? const Value.absent()
          : Value(orderId),
      method: Value(method),
      status: Value(status),
      amountPaise: Value(amountPaise),
      tenderedPaise: tenderedPaise == null && nullToAbsent
          ? const Value.absent()
          : Value(tenderedPaise),
      changeDuePaise: changeDuePaise == null && nullToAbsent
          ? const Value.absent()
          : Value(changeDuePaise),
      referenceNumber: referenceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceNumber),
      recordedBy: Value(recordedBy),
      recordedAt: Value(recordedAt),
    );
  }

  factory PaymentsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentsTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      invoiceId: serializer.fromJson<String?>(json['invoiceId']),
      orderId: serializer.fromJson<String?>(json['orderId']),
      method: serializer.fromJson<String>(json['method']),
      status: serializer.fromJson<String>(json['status']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      tenderedPaise: serializer.fromJson<int?>(json['tenderedPaise']),
      changeDuePaise: serializer.fromJson<int?>(json['changeDuePaise']),
      referenceNumber: serializer.fromJson<String?>(json['referenceNumber']),
      recordedBy: serializer.fromJson<String>(json['recordedBy']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'invoiceId': serializer.toJson<String?>(invoiceId),
      'orderId': serializer.toJson<String?>(orderId),
      'method': serializer.toJson<String>(method),
      'status': serializer.toJson<String>(status),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'tenderedPaise': serializer.toJson<int?>(tenderedPaise),
      'changeDuePaise': serializer.toJson<int?>(changeDuePaise),
      'referenceNumber': serializer.toJson<String?>(referenceNumber),
      'recordedBy': serializer.toJson<String>(recordedBy),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
    };
  }

  PaymentsTableData copyWith(
          {String? id,
          String? tenantId,
          String? branchId,
          Value<String?> invoiceId = const Value.absent(),
          Value<String?> orderId = const Value.absent(),
          String? method,
          String? status,
          int? amountPaise,
          Value<int?> tenderedPaise = const Value.absent(),
          Value<int?> changeDuePaise = const Value.absent(),
          Value<String?> referenceNumber = const Value.absent(),
          String? recordedBy,
          DateTime? recordedAt}) =>
      PaymentsTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
        orderId: orderId.present ? orderId.value : this.orderId,
        method: method ?? this.method,
        status: status ?? this.status,
        amountPaise: amountPaise ?? this.amountPaise,
        tenderedPaise:
            tenderedPaise.present ? tenderedPaise.value : this.tenderedPaise,
        changeDuePaise:
            changeDuePaise.present ? changeDuePaise.value : this.changeDuePaise,
        referenceNumber: referenceNumber.present
            ? referenceNumber.value
            : this.referenceNumber,
        recordedBy: recordedBy ?? this.recordedBy,
        recordedAt: recordedAt ?? this.recordedAt,
      );
  PaymentsTableData copyWithCompanion(PaymentsTableCompanion data) {
    return PaymentsTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      method: data.method.present ? data.method.value : this.method,
      status: data.status.present ? data.status.value : this.status,
      amountPaise:
          data.amountPaise.present ? data.amountPaise.value : this.amountPaise,
      tenderedPaise: data.tenderedPaise.present
          ? data.tenderedPaise.value
          : this.tenderedPaise,
      changeDuePaise: data.changeDuePaise.present
          ? data.changeDuePaise.value
          : this.changeDuePaise,
      referenceNumber: data.referenceNumber.present
          ? data.referenceNumber.value
          : this.referenceNumber,
      recordedBy:
          data.recordedBy.present ? data.recordedBy.value : this.recordedBy,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('orderId: $orderId, ')
          ..write('method: $method, ')
          ..write('status: $status, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('tenderedPaise: $tenderedPaise, ')
          ..write('changeDuePaise: $changeDuePaise, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('recordedBy: $recordedBy, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      branchId,
      invoiceId,
      orderId,
      method,
      status,
      amountPaise,
      tenderedPaise,
      changeDuePaise,
      referenceNumber,
      recordedBy,
      recordedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentsTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.invoiceId == this.invoiceId &&
          other.orderId == this.orderId &&
          other.method == this.method &&
          other.status == this.status &&
          other.amountPaise == this.amountPaise &&
          other.tenderedPaise == this.tenderedPaise &&
          other.changeDuePaise == this.changeDuePaise &&
          other.referenceNumber == this.referenceNumber &&
          other.recordedBy == this.recordedBy &&
          other.recordedAt == this.recordedAt);
}

class PaymentsTableCompanion extends UpdateCompanion<PaymentsTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String?> invoiceId;
  final Value<String?> orderId;
  final Value<String> method;
  final Value<String> status;
  final Value<int> amountPaise;
  final Value<int?> tenderedPaise;
  final Value<int?> changeDuePaise;
  final Value<String?> referenceNumber;
  final Value<String> recordedBy;
  final Value<DateTime> recordedAt;
  final Value<int> rowid;
  const PaymentsTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.method = const Value.absent(),
    this.status = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.tenderedPaise = const Value.absent(),
    this.changeDuePaise = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    this.recordedBy = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsTableCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    this.invoiceId = const Value.absent(),
    this.orderId = const Value.absent(),
    required String method,
    this.status = const Value.absent(),
    required int amountPaise,
    this.tenderedPaise = const Value.absent(),
    this.changeDuePaise = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    required String recordedBy,
    this.recordedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        branchId = Value(branchId),
        method = Value(method),
        amountPaise = Value(amountPaise),
        recordedBy = Value(recordedBy);
  static Insertable<PaymentsTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? invoiceId,
    Expression<String>? orderId,
    Expression<String>? method,
    Expression<String>? status,
    Expression<int>? amountPaise,
    Expression<int>? tenderedPaise,
    Expression<int>? changeDuePaise,
    Expression<String>? referenceNumber,
    Expression<String>? recordedBy,
    Expression<DateTime>? recordedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (orderId != null) 'order_id': orderId,
      if (method != null) 'method': method,
      if (status != null) 'status': status,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (tenderedPaise != null) 'tendered_paise': tenderedPaise,
      if (changeDuePaise != null) 'change_due_paise': changeDuePaise,
      if (referenceNumber != null) 'reference_number': referenceNumber,
      if (recordedBy != null) 'recorded_by': recordedBy,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String?>? invoiceId,
      Value<String?>? orderId,
      Value<String>? method,
      Value<String>? status,
      Value<int>? amountPaise,
      Value<int?>? tenderedPaise,
      Value<int?>? changeDuePaise,
      Value<String?>? referenceNumber,
      Value<String>? recordedBy,
      Value<DateTime>? recordedAt,
      Value<int>? rowid}) {
    return PaymentsTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      invoiceId: invoiceId ?? this.invoiceId,
      orderId: orderId ?? this.orderId,
      method: method ?? this.method,
      status: status ?? this.status,
      amountPaise: amountPaise ?? this.amountPaise,
      tenderedPaise: tenderedPaise ?? this.tenderedPaise,
      changeDuePaise: changeDuePaise ?? this.changeDuePaise,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      recordedBy: recordedBy ?? this.recordedBy,
      recordedAt: recordedAt ?? this.recordedAt,
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
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (tenderedPaise.present) {
      map['tendered_paise'] = Variable<int>(tenderedPaise.value);
    }
    if (changeDuePaise.present) {
      map['change_due_paise'] = Variable<int>(changeDuePaise.value);
    }
    if (referenceNumber.present) {
      map['reference_number'] = Variable<String>(referenceNumber.value);
    }
    if (recordedBy.present) {
      map['recorded_by'] = Variable<String>(recordedBy.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('orderId: $orderId, ')
          ..write('method: $method, ')
          ..write('status: $status, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('tenderedPaise: $tenderedPaise, ')
          ..write('changeDuePaise: $changeDuePaise, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('recordedBy: $recordedBy, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RefundsTableTable extends RefundsTable
    with TableInfo<$RefundsTableTable, RefundsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RefundsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceIdMeta =
      const VerificationMeta('invoiceId');
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
      'invoice_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentIdMeta =
      const VerificationMeta('paymentId');
  @override
  late final GeneratedColumn<String> paymentId = GeneratedColumn<String>(
      'payment_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _amountPaiseMeta =
      const VerificationMeta('amountPaise');
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
      'amount_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _approvedByMeta =
      const VerificationMeta('approvedBy');
  @override
  late final GeneratedColumn<String> approvedBy = GeneratedColumn<String>(
      'approved_by', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _refundMethodMeta =
      const VerificationMeta('refundMethod');
  @override
  late final GeneratedColumn<String> refundMethod = GeneratedColumn<String>(
      'refund_method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _refundReferenceMeta =
      const VerificationMeta('refundReference');
  @override
  late final GeneratedColumn<String> refundReference = GeneratedColumn<String>(
      'refund_reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        branchId,
        invoiceId,
        paymentId,
        amountPaise,
        reason,
        approvedBy,
        refundMethod,
        refundReference,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'refunds';
  @override
  VerificationContext validateIntegrity(Insertable<RefundsTableData> instance,
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
    if (data.containsKey('invoice_id')) {
      context.handle(_invoiceIdMeta,
          invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta));
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('payment_id')) {
      context.handle(_paymentIdMeta,
          paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta));
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
          _amountPaiseMeta,
          amountPaise.isAcceptableOrUnknown(
              data['amount_paise']!, _amountPaiseMeta));
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('approved_by')) {
      context.handle(
          _approvedByMeta,
          approvedBy.isAcceptableOrUnknown(
              data['approved_by']!, _approvedByMeta));
    } else if (isInserting) {
      context.missing(_approvedByMeta);
    }
    if (data.containsKey('refund_method')) {
      context.handle(
          _refundMethodMeta,
          refundMethod.isAcceptableOrUnknown(
              data['refund_method']!, _refundMethodMeta));
    } else if (isInserting) {
      context.missing(_refundMethodMeta);
    }
    if (data.containsKey('refund_reference')) {
      context.handle(
          _refundReferenceMeta,
          refundReference.isAcceptableOrUnknown(
              data['refund_reference']!, _refundReferenceMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RefundsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RefundsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      invoiceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invoice_id'])!,
      paymentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_id']),
      amountPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_paise'])!,
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason'])!,
      approvedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}approved_by'])!,
      refundMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}refund_method'])!,
      refundReference: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}refund_reference']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RefundsTableTable createAlias(String alias) {
    return $RefundsTableTable(attachedDatabase, alias);
  }
}

class RefundsTableData extends DataClass
    implements Insertable<RefundsTableData> {
  final String id;
  final String tenantId;
  final String branchId;
  final String invoiceId;
  final String? paymentId;
  final int amountPaise;
  final String reason;
  final String approvedBy;
  final String refundMethod;
  final String? refundReference;
  final DateTime createdAt;
  const RefundsTableData(
      {required this.id,
      required this.tenantId,
      required this.branchId,
      required this.invoiceId,
      this.paymentId,
      required this.amountPaise,
      required this.reason,
      required this.approvedBy,
      required this.refundMethod,
      this.refundReference,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['invoice_id'] = Variable<String>(invoiceId);
    if (!nullToAbsent || paymentId != null) {
      map['payment_id'] = Variable<String>(paymentId);
    }
    map['amount_paise'] = Variable<int>(amountPaise);
    map['reason'] = Variable<String>(reason);
    map['approved_by'] = Variable<String>(approvedBy);
    map['refund_method'] = Variable<String>(refundMethod);
    if (!nullToAbsent || refundReference != null) {
      map['refund_reference'] = Variable<String>(refundReference);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RefundsTableCompanion toCompanion(bool nullToAbsent) {
    return RefundsTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      invoiceId: Value(invoiceId),
      paymentId: paymentId == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentId),
      amountPaise: Value(amountPaise),
      reason: Value(reason),
      approvedBy: Value(approvedBy),
      refundMethod: Value(refundMethod),
      refundReference: refundReference == null && nullToAbsent
          ? const Value.absent()
          : Value(refundReference),
      createdAt: Value(createdAt),
    );
  }

  factory RefundsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RefundsTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      paymentId: serializer.fromJson<String?>(json['paymentId']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      reason: serializer.fromJson<String>(json['reason']),
      approvedBy: serializer.fromJson<String>(json['approvedBy']),
      refundMethod: serializer.fromJson<String>(json['refundMethod']),
      refundReference: serializer.fromJson<String?>(json['refundReference']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'paymentId': serializer.toJson<String?>(paymentId),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'reason': serializer.toJson<String>(reason),
      'approvedBy': serializer.toJson<String>(approvedBy),
      'refundMethod': serializer.toJson<String>(refundMethod),
      'refundReference': serializer.toJson<String?>(refundReference),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RefundsTableData copyWith(
          {String? id,
          String? tenantId,
          String? branchId,
          String? invoiceId,
          Value<String?> paymentId = const Value.absent(),
          int? amountPaise,
          String? reason,
          String? approvedBy,
          String? refundMethod,
          Value<String?> refundReference = const Value.absent(),
          DateTime? createdAt}) =>
      RefundsTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        invoiceId: invoiceId ?? this.invoiceId,
        paymentId: paymentId.present ? paymentId.value : this.paymentId,
        amountPaise: amountPaise ?? this.amountPaise,
        reason: reason ?? this.reason,
        approvedBy: approvedBy ?? this.approvedBy,
        refundMethod: refundMethod ?? this.refundMethod,
        refundReference: refundReference.present
            ? refundReference.value
            : this.refundReference,
        createdAt: createdAt ?? this.createdAt,
      );
  RefundsTableData copyWithCompanion(RefundsTableCompanion data) {
    return RefundsTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      amountPaise:
          data.amountPaise.present ? data.amountPaise.value : this.amountPaise,
      reason: data.reason.present ? data.reason.value : this.reason,
      approvedBy:
          data.approvedBy.present ? data.approvedBy.value : this.approvedBy,
      refundMethod: data.refundMethod.present
          ? data.refundMethod.value
          : this.refundMethod,
      refundReference: data.refundReference.present
          ? data.refundReference.value
          : this.refundReference,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RefundsTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('paymentId: $paymentId, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('reason: $reason, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('refundMethod: $refundMethod, ')
          ..write('refundReference: $refundReference, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      branchId,
      invoiceId,
      paymentId,
      amountPaise,
      reason,
      approvedBy,
      refundMethod,
      refundReference,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RefundsTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.invoiceId == this.invoiceId &&
          other.paymentId == this.paymentId &&
          other.amountPaise == this.amountPaise &&
          other.reason == this.reason &&
          other.approvedBy == this.approvedBy &&
          other.refundMethod == this.refundMethod &&
          other.refundReference == this.refundReference &&
          other.createdAt == this.createdAt);
}

class RefundsTableCompanion extends UpdateCompanion<RefundsTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> invoiceId;
  final Value<String?> paymentId;
  final Value<int> amountPaise;
  final Value<String> reason;
  final Value<String> approvedBy;
  final Value<String> refundMethod;
  final Value<String?> refundReference;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RefundsTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.reason = const Value.absent(),
    this.approvedBy = const Value.absent(),
    this.refundMethod = const Value.absent(),
    this.refundReference = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RefundsTableCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    required String invoiceId,
    this.paymentId = const Value.absent(),
    required int amountPaise,
    required String reason,
    required String approvedBy,
    required String refundMethod,
    this.refundReference = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        branchId = Value(branchId),
        invoiceId = Value(invoiceId),
        amountPaise = Value(amountPaise),
        reason = Value(reason),
        approvedBy = Value(approvedBy),
        refundMethod = Value(refundMethod);
  static Insertable<RefundsTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? invoiceId,
    Expression<String>? paymentId,
    Expression<int>? amountPaise,
    Expression<String>? reason,
    Expression<String>? approvedBy,
    Expression<String>? refundMethod,
    Expression<String>? refundReference,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (paymentId != null) 'payment_id': paymentId,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (reason != null) 'reason': reason,
      if (approvedBy != null) 'approved_by': approvedBy,
      if (refundMethod != null) 'refund_method': refundMethod,
      if (refundReference != null) 'refund_reference': refundReference,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RefundsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String>? invoiceId,
      Value<String?>? paymentId,
      Value<int>? amountPaise,
      Value<String>? reason,
      Value<String>? approvedBy,
      Value<String>? refundMethod,
      Value<String?>? refundReference,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return RefundsTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      invoiceId: invoiceId ?? this.invoiceId,
      paymentId: paymentId ?? this.paymentId,
      amountPaise: amountPaise ?? this.amountPaise,
      reason: reason ?? this.reason,
      approvedBy: approvedBy ?? this.approvedBy,
      refundMethod: refundMethod ?? this.refundMethod,
      refundReference: refundReference ?? this.refundReference,
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
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<String>(paymentId.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (approvedBy.present) {
      map['approved_by'] = Variable<String>(approvedBy.value);
    }
    if (refundMethod.present) {
      map['refund_method'] = Variable<String>(refundMethod.value);
    }
    if (refundReference.present) {
      map['refund_reference'] = Variable<String>(refundReference.value);
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
    return (StringBuffer('RefundsTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('paymentId: $paymentId, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('reason: $reason, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('refundMethod: $refundMethod, ')
          ..write('refundReference: $refundReference, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CashSessionsTableTable extends CashSessionsTable
    with TableInfo<$CashSessionsTableTable, CashSessionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashSessionsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _openedByMeta =
      const VerificationMeta('openedBy');
  @override
  late final GeneratedColumn<String> openedBy = GeneratedColumn<String>(
      'opened_by', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _closedByMeta =
      const VerificationMeta('closedBy');
  @override
  late final GeneratedColumn<String> closedBy = GeneratedColumn<String>(
      'closed_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _openingFloatPaiseMeta =
      const VerificationMeta('openingFloatPaise');
  @override
  late final GeneratedColumn<int> openingFloatPaise = GeneratedColumn<int>(
      'opening_float_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _closingCashActualPaiseMeta =
      const VerificationMeta('closingCashActualPaise');
  @override
  late final GeneratedColumn<int> closingCashActualPaise = GeneratedColumn<int>(
      'closing_cash_actual_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _expectedCashPaiseMeta =
      const VerificationMeta('expectedCashPaise');
  @override
  late final GeneratedColumn<int> expectedCashPaise = GeneratedColumn<int>(
      'expected_cash_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _variancePaiseMeta =
      const VerificationMeta('variancePaise');
  @override
  late final GeneratedColumn<int> variancePaise = GeneratedColumn<int>(
      'variance_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('open'));
  static const VerificationMeta _openedAtMeta =
      const VerificationMeta('openedAt');
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
      'opened_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _closedAtMeta =
      const VerificationMeta('closedAt');
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
      'closed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        branchId,
        deviceId,
        openedBy,
        closedBy,
        openingFloatPaise,
        closingCashActualPaise,
        expectedCashPaise,
        variancePaise,
        status,
        openedAt,
        closedAt,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_sessions';
  @override
  VerificationContext validateIntegrity(
      Insertable<CashSessionsTableData> instance,
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
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('opened_by')) {
      context.handle(_openedByMeta,
          openedBy.isAcceptableOrUnknown(data['opened_by']!, _openedByMeta));
    } else if (isInserting) {
      context.missing(_openedByMeta);
    }
    if (data.containsKey('closed_by')) {
      context.handle(_closedByMeta,
          closedBy.isAcceptableOrUnknown(data['closed_by']!, _closedByMeta));
    }
    if (data.containsKey('opening_float_paise')) {
      context.handle(
          _openingFloatPaiseMeta,
          openingFloatPaise.isAcceptableOrUnknown(
              data['opening_float_paise']!, _openingFloatPaiseMeta));
    }
    if (data.containsKey('closing_cash_actual_paise')) {
      context.handle(
          _closingCashActualPaiseMeta,
          closingCashActualPaise.isAcceptableOrUnknown(
              data['closing_cash_actual_paise']!, _closingCashActualPaiseMeta));
    }
    if (data.containsKey('expected_cash_paise')) {
      context.handle(
          _expectedCashPaiseMeta,
          expectedCashPaise.isAcceptableOrUnknown(
              data['expected_cash_paise']!, _expectedCashPaiseMeta));
    }
    if (data.containsKey('variance_paise')) {
      context.handle(
          _variancePaiseMeta,
          variancePaise.isAcceptableOrUnknown(
              data['variance_paise']!, _variancePaiseMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('opened_at')) {
      context.handle(_openedAtMeta,
          openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta));
    }
    if (data.containsKey('closed_at')) {
      context.handle(_closedAtMeta,
          closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashSessionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashSessionsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id'])!,
      openedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}opened_by'])!,
      closedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}closed_by']),
      openingFloatPaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}opening_float_paise'])!,
      closingCashActualPaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}closing_cash_actual_paise']),
      expectedCashPaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}expected_cash_paise'])!,
      variancePaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}variance_paise'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      openedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}opened_at'])!,
      closedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}closed_at']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $CashSessionsTableTable createAlias(String alias) {
    return $CashSessionsTableTable(attachedDatabase, alias);
  }
}

class CashSessionsTableData extends DataClass
    implements Insertable<CashSessionsTableData> {
  final String id;
  final String tenantId;
  final String branchId;
  final String deviceId;
  final String openedBy;
  final String? closedBy;
  final int openingFloatPaise;
  final int? closingCashActualPaise;
  final int expectedCashPaise;
  final int variancePaise;
  final String status;
  final DateTime openedAt;
  final DateTime? closedAt;
  final String? notes;
  const CashSessionsTableData(
      {required this.id,
      required this.tenantId,
      required this.branchId,
      required this.deviceId,
      required this.openedBy,
      this.closedBy,
      required this.openingFloatPaise,
      this.closingCashActualPaise,
      required this.expectedCashPaise,
      required this.variancePaise,
      required this.status,
      required this.openedAt,
      this.closedAt,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['device_id'] = Variable<String>(deviceId);
    map['opened_by'] = Variable<String>(openedBy);
    if (!nullToAbsent || closedBy != null) {
      map['closed_by'] = Variable<String>(closedBy);
    }
    map['opening_float_paise'] = Variable<int>(openingFloatPaise);
    if (!nullToAbsent || closingCashActualPaise != null) {
      map['closing_cash_actual_paise'] = Variable<int>(closingCashActualPaise);
    }
    map['expected_cash_paise'] = Variable<int>(expectedCashPaise);
    map['variance_paise'] = Variable<int>(variancePaise);
    map['status'] = Variable<String>(status);
    map['opened_at'] = Variable<DateTime>(openedAt);
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  CashSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return CashSessionsTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      deviceId: Value(deviceId),
      openedBy: Value(openedBy),
      closedBy: closedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(closedBy),
      openingFloatPaise: Value(openingFloatPaise),
      closingCashActualPaise: closingCashActualPaise == null && nullToAbsent
          ? const Value.absent()
          : Value(closingCashActualPaise),
      expectedCashPaise: Value(expectedCashPaise),
      variancePaise: Value(variancePaise),
      status: Value(status),
      openedAt: Value(openedAt),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory CashSessionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashSessionsTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      openedBy: serializer.fromJson<String>(json['openedBy']),
      closedBy: serializer.fromJson<String?>(json['closedBy']),
      openingFloatPaise: serializer.fromJson<int>(json['openingFloatPaise']),
      closingCashActualPaise:
          serializer.fromJson<int?>(json['closingCashActualPaise']),
      expectedCashPaise: serializer.fromJson<int>(json['expectedCashPaise']),
      variancePaise: serializer.fromJson<int>(json['variancePaise']),
      status: serializer.fromJson<String>(json['status']),
      openedAt: serializer.fromJson<DateTime>(json['openedAt']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'deviceId': serializer.toJson<String>(deviceId),
      'openedBy': serializer.toJson<String>(openedBy),
      'closedBy': serializer.toJson<String?>(closedBy),
      'openingFloatPaise': serializer.toJson<int>(openingFloatPaise),
      'closingCashActualPaise': serializer.toJson<int?>(closingCashActualPaise),
      'expectedCashPaise': serializer.toJson<int>(expectedCashPaise),
      'variancePaise': serializer.toJson<int>(variancePaise),
      'status': serializer.toJson<String>(status),
      'openedAt': serializer.toJson<DateTime>(openedAt),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  CashSessionsTableData copyWith(
          {String? id,
          String? tenantId,
          String? branchId,
          String? deviceId,
          String? openedBy,
          Value<String?> closedBy = const Value.absent(),
          int? openingFloatPaise,
          Value<int?> closingCashActualPaise = const Value.absent(),
          int? expectedCashPaise,
          int? variancePaise,
          String? status,
          DateTime? openedAt,
          Value<DateTime?> closedAt = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      CashSessionsTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        deviceId: deviceId ?? this.deviceId,
        openedBy: openedBy ?? this.openedBy,
        closedBy: closedBy.present ? closedBy.value : this.closedBy,
        openingFloatPaise: openingFloatPaise ?? this.openingFloatPaise,
        closingCashActualPaise: closingCashActualPaise.present
            ? closingCashActualPaise.value
            : this.closingCashActualPaise,
        expectedCashPaise: expectedCashPaise ?? this.expectedCashPaise,
        variancePaise: variancePaise ?? this.variancePaise,
        status: status ?? this.status,
        openedAt: openedAt ?? this.openedAt,
        closedAt: closedAt.present ? closedAt.value : this.closedAt,
        notes: notes.present ? notes.value : this.notes,
      );
  CashSessionsTableData copyWithCompanion(CashSessionsTableCompanion data) {
    return CashSessionsTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      openedBy: data.openedBy.present ? data.openedBy.value : this.openedBy,
      closedBy: data.closedBy.present ? data.closedBy.value : this.closedBy,
      openingFloatPaise: data.openingFloatPaise.present
          ? data.openingFloatPaise.value
          : this.openingFloatPaise,
      closingCashActualPaise: data.closingCashActualPaise.present
          ? data.closingCashActualPaise.value
          : this.closingCashActualPaise,
      expectedCashPaise: data.expectedCashPaise.present
          ? data.expectedCashPaise.value
          : this.expectedCashPaise,
      variancePaise: data.variancePaise.present
          ? data.variancePaise.value
          : this.variancePaise,
      status: data.status.present ? data.status.value : this.status,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashSessionsTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('deviceId: $deviceId, ')
          ..write('openedBy: $openedBy, ')
          ..write('closedBy: $closedBy, ')
          ..write('openingFloatPaise: $openingFloatPaise, ')
          ..write('closingCashActualPaise: $closingCashActualPaise, ')
          ..write('expectedCashPaise: $expectedCashPaise, ')
          ..write('variancePaise: $variancePaise, ')
          ..write('status: $status, ')
          ..write('openedAt: $openedAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      branchId,
      deviceId,
      openedBy,
      closedBy,
      openingFloatPaise,
      closingCashActualPaise,
      expectedCashPaise,
      variancePaise,
      status,
      openedAt,
      closedAt,
      notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashSessionsTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.deviceId == this.deviceId &&
          other.openedBy == this.openedBy &&
          other.closedBy == this.closedBy &&
          other.openingFloatPaise == this.openingFloatPaise &&
          other.closingCashActualPaise == this.closingCashActualPaise &&
          other.expectedCashPaise == this.expectedCashPaise &&
          other.variancePaise == this.variancePaise &&
          other.status == this.status &&
          other.openedAt == this.openedAt &&
          other.closedAt == this.closedAt &&
          other.notes == this.notes);
}

class CashSessionsTableCompanion
    extends UpdateCompanion<CashSessionsTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> deviceId;
  final Value<String> openedBy;
  final Value<String?> closedBy;
  final Value<int> openingFloatPaise;
  final Value<int?> closingCashActualPaise;
  final Value<int> expectedCashPaise;
  final Value<int> variancePaise;
  final Value<String> status;
  final Value<DateTime> openedAt;
  final Value<DateTime?> closedAt;
  final Value<String?> notes;
  final Value<int> rowid;
  const CashSessionsTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.openedBy = const Value.absent(),
    this.closedBy = const Value.absent(),
    this.openingFloatPaise = const Value.absent(),
    this.closingCashActualPaise = const Value.absent(),
    this.expectedCashPaise = const Value.absent(),
    this.variancePaise = const Value.absent(),
    this.status = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CashSessionsTableCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    required String deviceId,
    required String openedBy,
    this.closedBy = const Value.absent(),
    this.openingFloatPaise = const Value.absent(),
    this.closingCashActualPaise = const Value.absent(),
    this.expectedCashPaise = const Value.absent(),
    this.variancePaise = const Value.absent(),
    this.status = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        branchId = Value(branchId),
        deviceId = Value(deviceId),
        openedBy = Value(openedBy);
  static Insertable<CashSessionsTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? deviceId,
    Expression<String>? openedBy,
    Expression<String>? closedBy,
    Expression<int>? openingFloatPaise,
    Expression<int>? closingCashActualPaise,
    Expression<int>? expectedCashPaise,
    Expression<int>? variancePaise,
    Expression<String>? status,
    Expression<DateTime>? openedAt,
    Expression<DateTime>? closedAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (deviceId != null) 'device_id': deviceId,
      if (openedBy != null) 'opened_by': openedBy,
      if (closedBy != null) 'closed_by': closedBy,
      if (openingFloatPaise != null) 'opening_float_paise': openingFloatPaise,
      if (closingCashActualPaise != null)
        'closing_cash_actual_paise': closingCashActualPaise,
      if (expectedCashPaise != null) 'expected_cash_paise': expectedCashPaise,
      if (variancePaise != null) 'variance_paise': variancePaise,
      if (status != null) 'status': status,
      if (openedAt != null) 'opened_at': openedAt,
      if (closedAt != null) 'closed_at': closedAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CashSessionsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String>? deviceId,
      Value<String>? openedBy,
      Value<String?>? closedBy,
      Value<int>? openingFloatPaise,
      Value<int?>? closingCashActualPaise,
      Value<int>? expectedCashPaise,
      Value<int>? variancePaise,
      Value<String>? status,
      Value<DateTime>? openedAt,
      Value<DateTime?>? closedAt,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return CashSessionsTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      deviceId: deviceId ?? this.deviceId,
      openedBy: openedBy ?? this.openedBy,
      closedBy: closedBy ?? this.closedBy,
      openingFloatPaise: openingFloatPaise ?? this.openingFloatPaise,
      closingCashActualPaise:
          closingCashActualPaise ?? this.closingCashActualPaise,
      expectedCashPaise: expectedCashPaise ?? this.expectedCashPaise,
      variancePaise: variancePaise ?? this.variancePaise,
      status: status ?? this.status,
      openedAt: openedAt ?? this.openedAt,
      closedAt: closedAt ?? this.closedAt,
      notes: notes ?? this.notes,
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
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (openedBy.present) {
      map['opened_by'] = Variable<String>(openedBy.value);
    }
    if (closedBy.present) {
      map['closed_by'] = Variable<String>(closedBy.value);
    }
    if (openingFloatPaise.present) {
      map['opening_float_paise'] = Variable<int>(openingFloatPaise.value);
    }
    if (closingCashActualPaise.present) {
      map['closing_cash_actual_paise'] =
          Variable<int>(closingCashActualPaise.value);
    }
    if (expectedCashPaise.present) {
      map['expected_cash_paise'] = Variable<int>(expectedCashPaise.value);
    }
    if (variancePaise.present) {
      map['variance_paise'] = Variable<int>(variancePaise.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('deviceId: $deviceId, ')
          ..write('openedBy: $openedBy, ')
          ..write('closedBy: $closedBy, ')
          ..write('openingFloatPaise: $openingFloatPaise, ')
          ..write('closingCashActualPaise: $closingCashActualPaise, ')
          ..write('expectedCashPaise: $expectedCashPaise, ')
          ..write('variancePaise: $variancePaise, ')
          ..write('status: $status, ')
          ..write('openedAt: $openedAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CashMovementsTableTable extends CashMovementsTable
    with TableInfo<$CashMovementsTableTable, CashMovementsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashMovementsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountPaiseMeta =
      const VerificationMeta('amountPaise');
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
      'amount_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _performedByMeta =
      const VerificationMeta('performedBy');
  @override
  late final GeneratedColumn<String> performedBy = GeneratedColumn<String>(
      'performed_by', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionId,
        tenantId,
        branchId,
        type,
        amountPaise,
        reason,
        performedBy,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_movements';
  @override
  VerificationContext validateIntegrity(
      Insertable<CashMovementsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
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
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
          _amountPaiseMeta,
          amountPaise.isAcceptableOrUnknown(
              data['amount_paise']!, _amountPaiseMeta));
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    }
    if (data.containsKey('performed_by')) {
      context.handle(
          _performedByMeta,
          performedBy.isAcceptableOrUnknown(
              data['performed_by']!, _performedByMeta));
    } else if (isInserting) {
      context.missing(_performedByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashMovementsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashMovementsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      amountPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_paise'])!,
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason']),
      performedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}performed_by'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CashMovementsTableTable createAlias(String alias) {
    return $CashMovementsTableTable(attachedDatabase, alias);
  }
}

class CashMovementsTableData extends DataClass
    implements Insertable<CashMovementsTableData> {
  final String id;
  final String sessionId;
  final String tenantId;
  final String branchId;
  final String type;
  final int amountPaise;
  final String? reason;
  final String performedBy;
  final DateTime createdAt;
  const CashMovementsTableData(
      {required this.id,
      required this.sessionId,
      required this.tenantId,
      required this.branchId,
      required this.type,
      required this.amountPaise,
      this.reason,
      required this.performedBy,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['type'] = Variable<String>(type);
    map['amount_paise'] = Variable<int>(amountPaise);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['performed_by'] = Variable<String>(performedBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CashMovementsTableCompanion toCompanion(bool nullToAbsent) {
    return CashMovementsTableCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      type: Value(type),
      amountPaise: Value(amountPaise),
      reason:
          reason == null && nullToAbsent ? const Value.absent() : Value(reason),
      performedBy: Value(performedBy),
      createdAt: Value(createdAt),
    );
  }

  factory CashMovementsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashMovementsTableData(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      type: serializer.fromJson<String>(json['type']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      reason: serializer.fromJson<String?>(json['reason']),
      performedBy: serializer.fromJson<String>(json['performedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'type': serializer.toJson<String>(type),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'reason': serializer.toJson<String?>(reason),
      'performedBy': serializer.toJson<String>(performedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CashMovementsTableData copyWith(
          {String? id,
          String? sessionId,
          String? tenantId,
          String? branchId,
          String? type,
          int? amountPaise,
          Value<String?> reason = const Value.absent(),
          String? performedBy,
          DateTime? createdAt}) =>
      CashMovementsTableData(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        type: type ?? this.type,
        amountPaise: amountPaise ?? this.amountPaise,
        reason: reason.present ? reason.value : this.reason,
        performedBy: performedBy ?? this.performedBy,
        createdAt: createdAt ?? this.createdAt,
      );
  CashMovementsTableData copyWithCompanion(CashMovementsTableCompanion data) {
    return CashMovementsTableData(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      type: data.type.present ? data.type.value : this.type,
      amountPaise:
          data.amountPaise.present ? data.amountPaise.value : this.amountPaise,
      reason: data.reason.present ? data.reason.value : this.reason,
      performedBy:
          data.performedBy.present ? data.performedBy.value : this.performedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashMovementsTableData(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('type: $type, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('reason: $reason, ')
          ..write('performedBy: $performedBy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, tenantId, branchId, type,
      amountPaise, reason, performedBy, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashMovementsTableData &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.type == this.type &&
          other.amountPaise == this.amountPaise &&
          other.reason == this.reason &&
          other.performedBy == this.performedBy &&
          other.createdAt == this.createdAt);
}

class CashMovementsTableCompanion
    extends UpdateCompanion<CashMovementsTableData> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> type;
  final Value<int> amountPaise;
  final Value<String?> reason;
  final Value<String> performedBy;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CashMovementsTableCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.type = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.reason = const Value.absent(),
    this.performedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CashMovementsTableCompanion.insert({
    required String id,
    required String sessionId,
    required String tenantId,
    required String branchId,
    required String type,
    required int amountPaise,
    this.reason = const Value.absent(),
    required String performedBy,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionId = Value(sessionId),
        tenantId = Value(tenantId),
        branchId = Value(branchId),
        type = Value(type),
        amountPaise = Value(amountPaise),
        performedBy = Value(performedBy);
  static Insertable<CashMovementsTableData> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? type,
    Expression<int>? amountPaise,
    Expression<String>? reason,
    Expression<String>? performedBy,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (type != null) 'type': type,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (reason != null) 'reason': reason,
      if (performedBy != null) 'performed_by': performedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CashMovementsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String>? type,
      Value<int>? amountPaise,
      Value<String?>? reason,
      Value<String>? performedBy,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return CashMovementsTableCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      type: type ?? this.type,
      amountPaise: amountPaise ?? this.amountPaise,
      reason: reason ?? this.reason,
      performedBy: performedBy ?? this.performedBy,
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
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (performedBy.present) {
      map['performed_by'] = Variable<String>(performedBy.value);
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
    return (StringBuffer('CashMovementsTableCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('type: $type, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('reason: $reason, ')
          ..write('performedBy: $performedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CartHoldTableTable extends CartHoldTable
    with TableInfo<$CartHoldTableTable, CartHoldTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartHoldTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cartJsonMeta =
      const VerificationMeta('cartJson');
  @override
  late final GeneratedColumn<String> cartJson = GeneratedColumn<String>(
      'cart_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _heldAtMeta = const VerificationMeta('heldAt');
  @override
  late final GeneratedColumn<DateTime> heldAt = GeneratedColumn<DateTime>(
      'held_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _heldByMeta = const VerificationMeta('heldBy');
  @override
  late final GeneratedColumn<String> heldBy = GeneratedColumn<String>(
      'held_by', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, tenantId, branchId, label, cartJson, heldAt, heldBy];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_holds';
  @override
  VerificationContext validateIntegrity(Insertable<CartHoldTableData> instance,
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
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('cart_json')) {
      context.handle(_cartJsonMeta,
          cartJson.isAcceptableOrUnknown(data['cart_json']!, _cartJsonMeta));
    } else if (isInserting) {
      context.missing(_cartJsonMeta);
    }
    if (data.containsKey('held_at')) {
      context.handle(_heldAtMeta,
          heldAt.isAcceptableOrUnknown(data['held_at']!, _heldAtMeta));
    }
    if (data.containsKey('held_by')) {
      context.handle(_heldByMeta,
          heldBy.isAcceptableOrUnknown(data['held_by']!, _heldByMeta));
    } else if (isInserting) {
      context.missing(_heldByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartHoldTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartHoldTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      cartJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cart_json'])!,
      heldAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}held_at'])!,
      heldBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}held_by'])!,
    );
  }

  @override
  $CartHoldTableTable createAlias(String alias) {
    return $CartHoldTableTable(attachedDatabase, alias);
  }
}

class CartHoldTableData extends DataClass
    implements Insertable<CartHoldTableData> {
  final String id;
  final String tenantId;
  final String branchId;
  final String label;
  final String cartJson;
  final DateTime heldAt;
  final String heldBy;
  const CartHoldTableData(
      {required this.id,
      required this.tenantId,
      required this.branchId,
      required this.label,
      required this.cartJson,
      required this.heldAt,
      required this.heldBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['label'] = Variable<String>(label);
    map['cart_json'] = Variable<String>(cartJson);
    map['held_at'] = Variable<DateTime>(heldAt);
    map['held_by'] = Variable<String>(heldBy);
    return map;
  }

  CartHoldTableCompanion toCompanion(bool nullToAbsent) {
    return CartHoldTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      label: Value(label),
      cartJson: Value(cartJson),
      heldAt: Value(heldAt),
      heldBy: Value(heldBy),
    );
  }

  factory CartHoldTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartHoldTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      label: serializer.fromJson<String>(json['label']),
      cartJson: serializer.fromJson<String>(json['cartJson']),
      heldAt: serializer.fromJson<DateTime>(json['heldAt']),
      heldBy: serializer.fromJson<String>(json['heldBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'label': serializer.toJson<String>(label),
      'cartJson': serializer.toJson<String>(cartJson),
      'heldAt': serializer.toJson<DateTime>(heldAt),
      'heldBy': serializer.toJson<String>(heldBy),
    };
  }

  CartHoldTableData copyWith(
          {String? id,
          String? tenantId,
          String? branchId,
          String? label,
          String? cartJson,
          DateTime? heldAt,
          String? heldBy}) =>
      CartHoldTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        label: label ?? this.label,
        cartJson: cartJson ?? this.cartJson,
        heldAt: heldAt ?? this.heldAt,
        heldBy: heldBy ?? this.heldBy,
      );
  CartHoldTableData copyWithCompanion(CartHoldTableCompanion data) {
    return CartHoldTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      label: data.label.present ? data.label.value : this.label,
      cartJson: data.cartJson.present ? data.cartJson.value : this.cartJson,
      heldAt: data.heldAt.present ? data.heldAt.value : this.heldAt,
      heldBy: data.heldBy.present ? data.heldBy.value : this.heldBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartHoldTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('label: $label, ')
          ..write('cartJson: $cartJson, ')
          ..write('heldAt: $heldAt, ')
          ..write('heldBy: $heldBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tenantId, branchId, label, cartJson, heldAt, heldBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartHoldTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.label == this.label &&
          other.cartJson == this.cartJson &&
          other.heldAt == this.heldAt &&
          other.heldBy == this.heldBy);
}

class CartHoldTableCompanion extends UpdateCompanion<CartHoldTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> label;
  final Value<String> cartJson;
  final Value<DateTime> heldAt;
  final Value<String> heldBy;
  final Value<int> rowid;
  const CartHoldTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.label = const Value.absent(),
    this.cartJson = const Value.absent(),
    this.heldAt = const Value.absent(),
    this.heldBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CartHoldTableCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    required String label,
    required String cartJson,
    this.heldAt = const Value.absent(),
    required String heldBy,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        branchId = Value(branchId),
        label = Value(label),
        cartJson = Value(cartJson),
        heldBy = Value(heldBy);
  static Insertable<CartHoldTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? label,
    Expression<String>? cartJson,
    Expression<DateTime>? heldAt,
    Expression<String>? heldBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (label != null) 'label': label,
      if (cartJson != null) 'cart_json': cartJson,
      if (heldAt != null) 'held_at': heldAt,
      if (heldBy != null) 'held_by': heldBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CartHoldTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String>? label,
      Value<String>? cartJson,
      Value<DateTime>? heldAt,
      Value<String>? heldBy,
      Value<int>? rowid}) {
    return CartHoldTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      label: label ?? this.label,
      cartJson: cartJson ?? this.cartJson,
      heldAt: heldAt ?? this.heldAt,
      heldBy: heldBy ?? this.heldBy,
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
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (cartJson.present) {
      map['cart_json'] = Variable<String>(cartJson.value);
    }
    if (heldAt.present) {
      map['held_at'] = Variable<DateTime>(heldAt.value);
    }
    if (heldBy.present) {
      map['held_by'] = Variable<String>(heldBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartHoldTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('label: $label, ')
          ..write('cartJson: $cartJson, ')
          ..write('heldAt: $heldAt, ')
          ..write('heldBy: $heldBy, ')
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
  late final $CategoriesTableTable categoriesTable =
      $CategoriesTableTable(this);
  late final $TaxCategoriesTableTable taxCategoriesTable =
      $TaxCategoriesTableTable(this);
  late final $ProductsTableTable productsTable = $ProductsTableTable(this);
  late final $ProductVariantsTableTable productVariantsTable =
      $ProductVariantsTableTable(this);
  late final $ModifierGroupsTableTable modifierGroupsTable =
      $ModifierGroupsTableTable(this);
  late final $ModifiersTableTable modifiersTable = $ModifiersTableTable(this);
  late final $ProductModifierGroupsTableTable productModifierGroupsTable =
      $ProductModifierGroupsTableTable(this);
  late final $ProductBranchAvailabilityTableTable
      productBranchAvailabilityTable =
      $ProductBranchAvailabilityTableTable(this);
  late final $OrdersTableTable ordersTable = $OrdersTableTable(this);
  late final $OrderItemsTableTable orderItemsTable =
      $OrderItemsTableTable(this);
  late final $OrderItemModifiersTableTable orderItemModifiersTable =
      $OrderItemModifiersTableTable(this);
  late final $InvoicesTableTable invoicesTable = $InvoicesTableTable(this);
  late final $PaymentsTableTable paymentsTable = $PaymentsTableTable(this);
  late final $RefundsTableTable refundsTable = $RefundsTableTable(this);
  late final $CashSessionsTableTable cashSessionsTable =
      $CashSessionsTableTable(this);
  late final $CashMovementsTableTable cashMovementsTable =
      $CashMovementsTableTable(this);
  late final $CartHoldTableTable cartHoldTable = $CartHoldTableTable(this);
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
        auditLogsTable,
        categoriesTable,
        taxCategoriesTable,
        productsTable,
        productVariantsTable,
        modifierGroupsTable,
        modifiersTable,
        productModifierGroupsTable,
        productBranchAvailabilityTable,
        ordersTable,
        orderItemsTable,
        orderItemModifiersTable,
        invoicesTable,
        paymentsTable,
        refundsTable,
        cashSessionsTable,
        cashMovementsTable,
        cartHoldTable
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
typedef $$CategoriesTableTableCreateCompanionBuilder = CategoriesTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String name,
  required String slug,
  Value<int> sortOrder,
  Value<bool> isArchived,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CategoriesTableTableUpdateCompanionBuilder = CategoriesTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> name,
  Value<String> slug,
  Value<int> sortOrder,
  Value<bool> isArchived,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableFilterComposer({
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

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableOrderingComposer({
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

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableAnnotationComposer({
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

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CategoriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTableTable,
    CategoriesTableData,
    $$CategoriesTableTableFilterComposer,
    $$CategoriesTableTableOrderingComposer,
    $$CategoriesTableTableAnnotationComposer,
    $$CategoriesTableTableCreateCompanionBuilder,
    $$CategoriesTableTableUpdateCompanionBuilder,
    (
      CategoriesTableData,
      BaseReferences<_$AppDatabase, $CategoriesTableTable, CategoriesTableData>
    ),
    CategoriesTableData,
    PrefetchHooks Function()> {
  $$CategoriesTableTableTableManager(
      _$AppDatabase db, $CategoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> slug = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesTableCompanion(
            id: id,
            tenantId: tenantId,
            name: name,
            slug: slug,
            sortOrder: sortOrder,
            isArchived: isArchived,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String name,
            required String slug,
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            name: name,
            slug: slug,
            sortOrder: sortOrder,
            isArchived: isArchived,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoriesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTableTable,
    CategoriesTableData,
    $$CategoriesTableTableFilterComposer,
    $$CategoriesTableTableOrderingComposer,
    $$CategoriesTableTableAnnotationComposer,
    $$CategoriesTableTableCreateCompanionBuilder,
    $$CategoriesTableTableUpdateCompanionBuilder,
    (
      CategoriesTableData,
      BaseReferences<_$AppDatabase, $CategoriesTableTable, CategoriesTableData>
    ),
    CategoriesTableData,
    PrefetchHooks Function()>;
typedef $$TaxCategoriesTableTableCreateCompanionBuilder
    = TaxCategoriesTableCompanion Function({
  required String id,
  required String tenantId,
  required String name,
  Value<String?> hsnCode,
  Value<int> cgstRateBps,
  Value<int> sgstRateBps,
  Value<int> igstRateBps,
  Value<bool> isInclusive,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$TaxCategoriesTableTableUpdateCompanionBuilder
    = TaxCategoriesTableCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> name,
  Value<String?> hsnCode,
  Value<int> cgstRateBps,
  Value<int> sgstRateBps,
  Value<int> igstRateBps,
  Value<bool> isInclusive,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$TaxCategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $TaxCategoriesTableTable> {
  $$TaxCategoriesTableTableFilterComposer({
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

  ColumnFilters<String> get hsnCode => $composableBuilder(
      column: $table.hsnCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cgstRateBps => $composableBuilder(
      column: $table.cgstRateBps, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sgstRateBps => $composableBuilder(
      column: $table.sgstRateBps, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get igstRateBps => $composableBuilder(
      column: $table.igstRateBps, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isInclusive => $composableBuilder(
      column: $table.isInclusive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$TaxCategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TaxCategoriesTableTable> {
  $$TaxCategoriesTableTableOrderingComposer({
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

  ColumnOrderings<String> get hsnCode => $composableBuilder(
      column: $table.hsnCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cgstRateBps => $composableBuilder(
      column: $table.cgstRateBps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sgstRateBps => $composableBuilder(
      column: $table.sgstRateBps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get igstRateBps => $composableBuilder(
      column: $table.igstRateBps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isInclusive => $composableBuilder(
      column: $table.isInclusive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TaxCategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaxCategoriesTableTable> {
  $$TaxCategoriesTableTableAnnotationComposer({
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

  GeneratedColumn<String> get hsnCode =>
      $composableBuilder(column: $table.hsnCode, builder: (column) => column);

  GeneratedColumn<int> get cgstRateBps => $composableBuilder(
      column: $table.cgstRateBps, builder: (column) => column);

  GeneratedColumn<int> get sgstRateBps => $composableBuilder(
      column: $table.sgstRateBps, builder: (column) => column);

  GeneratedColumn<int> get igstRateBps => $composableBuilder(
      column: $table.igstRateBps, builder: (column) => column);

  GeneratedColumn<bool> get isInclusive => $composableBuilder(
      column: $table.isInclusive, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TaxCategoriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TaxCategoriesTableTable,
    TaxCategoriesTableData,
    $$TaxCategoriesTableTableFilterComposer,
    $$TaxCategoriesTableTableOrderingComposer,
    $$TaxCategoriesTableTableAnnotationComposer,
    $$TaxCategoriesTableTableCreateCompanionBuilder,
    $$TaxCategoriesTableTableUpdateCompanionBuilder,
    (
      TaxCategoriesTableData,
      BaseReferences<_$AppDatabase, $TaxCategoriesTableTable,
          TaxCategoriesTableData>
    ),
    TaxCategoriesTableData,
    PrefetchHooks Function()> {
  $$TaxCategoriesTableTableTableManager(
      _$AppDatabase db, $TaxCategoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaxCategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaxCategoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaxCategoriesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> hsnCode = const Value.absent(),
            Value<int> cgstRateBps = const Value.absent(),
            Value<int> sgstRateBps = const Value.absent(),
            Value<int> igstRateBps = const Value.absent(),
            Value<bool> isInclusive = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaxCategoriesTableCompanion(
            id: id,
            tenantId: tenantId,
            name: name,
            hsnCode: hsnCode,
            cgstRateBps: cgstRateBps,
            sgstRateBps: sgstRateBps,
            igstRateBps: igstRateBps,
            isInclusive: isInclusive,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String name,
            Value<String?> hsnCode = const Value.absent(),
            Value<int> cgstRateBps = const Value.absent(),
            Value<int> sgstRateBps = const Value.absent(),
            Value<int> igstRateBps = const Value.absent(),
            Value<bool> isInclusive = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TaxCategoriesTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            name: name,
            hsnCode: hsnCode,
            cgstRateBps: cgstRateBps,
            sgstRateBps: sgstRateBps,
            igstRateBps: igstRateBps,
            isInclusive: isInclusive,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TaxCategoriesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TaxCategoriesTableTable,
    TaxCategoriesTableData,
    $$TaxCategoriesTableTableFilterComposer,
    $$TaxCategoriesTableTableOrderingComposer,
    $$TaxCategoriesTableTableAnnotationComposer,
    $$TaxCategoriesTableTableCreateCompanionBuilder,
    $$TaxCategoriesTableTableUpdateCompanionBuilder,
    (
      TaxCategoriesTableData,
      BaseReferences<_$AppDatabase, $TaxCategoriesTableTable,
          TaxCategoriesTableData>
    ),
    TaxCategoriesTableData,
    PrefetchHooks Function()>;
typedef $$ProductsTableTableCreateCompanionBuilder = ProductsTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String categoryId,
  Value<String?> taxCategoryId,
  required String name,
  Value<String?> description,
  required int basePricePaise,
  Value<String?> imageUrl,
  Value<bool> isArchived,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ProductsTableTableUpdateCompanionBuilder = ProductsTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> categoryId,
  Value<String?> taxCategoryId,
  Value<String> name,
  Value<String?> description,
  Value<int> basePricePaise,
  Value<String?> imageUrl,
  Value<bool> isArchived,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ProductsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableFilterComposer({
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

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get taxCategoryId => $composableBuilder(
      column: $table.taxCategoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get basePricePaise => $composableBuilder(
      column: $table.basePricePaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ProductsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableOrderingComposer({
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

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taxCategoryId => $composableBuilder(
      column: $table.taxCategoryId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get basePricePaise => $composableBuilder(
      column: $table.basePricePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProductsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get taxCategoryId => $composableBuilder(
      column: $table.taxCategoryId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get basePricePaise => $composableBuilder(
      column: $table.basePricePaise, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProductsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTableTable,
    ProductsTableData,
    $$ProductsTableTableFilterComposer,
    $$ProductsTableTableOrderingComposer,
    $$ProductsTableTableAnnotationComposer,
    $$ProductsTableTableCreateCompanionBuilder,
    $$ProductsTableTableUpdateCompanionBuilder,
    (
      ProductsTableData,
      BaseReferences<_$AppDatabase, $ProductsTableTable, ProductsTableData>
    ),
    ProductsTableData,
    PrefetchHooks Function()> {
  $$ProductsTableTableTableManager(_$AppDatabase db, $ProductsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<String?> taxCategoryId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> basePricePaise = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsTableCompanion(
            id: id,
            tenantId: tenantId,
            categoryId: categoryId,
            taxCategoryId: taxCategoryId,
            name: name,
            description: description,
            basePricePaise: basePricePaise,
            imageUrl: imageUrl,
            isArchived: isArchived,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String categoryId,
            Value<String?> taxCategoryId = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            required int basePricePaise,
            Value<String?> imageUrl = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            categoryId: categoryId,
            taxCategoryId: taxCategoryId,
            name: name,
            description: description,
            basePricePaise: basePricePaise,
            imageUrl: imageUrl,
            isArchived: isArchived,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductsTableTable,
    ProductsTableData,
    $$ProductsTableTableFilterComposer,
    $$ProductsTableTableOrderingComposer,
    $$ProductsTableTableAnnotationComposer,
    $$ProductsTableTableCreateCompanionBuilder,
    $$ProductsTableTableUpdateCompanionBuilder,
    (
      ProductsTableData,
      BaseReferences<_$AppDatabase, $ProductsTableTable, ProductsTableData>
    ),
    ProductsTableData,
    PrefetchHooks Function()>;
typedef $$ProductVariantsTableTableCreateCompanionBuilder
    = ProductVariantsTableCompanion Function({
  required String id,
  required String productId,
  required String name,
  Value<int> priceDeltaPaise,
  Value<String?> sku,
  Value<int> sortOrder,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$ProductVariantsTableTableUpdateCompanionBuilder
    = ProductVariantsTableCompanion Function({
  Value<String> id,
  Value<String> productId,
  Value<String> name,
  Value<int> priceDeltaPaise,
  Value<String?> sku,
  Value<int> sortOrder,
  Value<bool> isActive,
  Value<int> rowid,
});

class $$ProductVariantsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductVariantsTableTable> {
  $$ProductVariantsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priceDeltaPaise => $composableBuilder(
      column: $table.priceDeltaPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));
}

class $$ProductVariantsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductVariantsTableTable> {
  $$ProductVariantsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priceDeltaPaise => $composableBuilder(
      column: $table.priceDeltaPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$ProductVariantsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductVariantsTableTable> {
  $$ProductVariantsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priceDeltaPaise => $composableBuilder(
      column: $table.priceDeltaPaise, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$ProductVariantsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductVariantsTableTable,
    ProductVariantsTableData,
    $$ProductVariantsTableTableFilterComposer,
    $$ProductVariantsTableTableOrderingComposer,
    $$ProductVariantsTableTableAnnotationComposer,
    $$ProductVariantsTableTableCreateCompanionBuilder,
    $$ProductVariantsTableTableUpdateCompanionBuilder,
    (
      ProductVariantsTableData,
      BaseReferences<_$AppDatabase, $ProductVariantsTableTable,
          ProductVariantsTableData>
    ),
    ProductVariantsTableData,
    PrefetchHooks Function()> {
  $$ProductVariantsTableTableTableManager(
      _$AppDatabase db, $ProductVariantsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductVariantsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductVariantsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductVariantsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> priceDeltaPaise = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductVariantsTableCompanion(
            id: id,
            productId: productId,
            name: name,
            priceDeltaPaise: priceDeltaPaise,
            sku: sku,
            sortOrder: sortOrder,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String productId,
            required String name,
            Value<int> priceDeltaPaise = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductVariantsTableCompanion.insert(
            id: id,
            productId: productId,
            name: name,
            priceDeltaPaise: priceDeltaPaise,
            sku: sku,
            sortOrder: sortOrder,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductVariantsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ProductVariantsTableTable,
        ProductVariantsTableData,
        $$ProductVariantsTableTableFilterComposer,
        $$ProductVariantsTableTableOrderingComposer,
        $$ProductVariantsTableTableAnnotationComposer,
        $$ProductVariantsTableTableCreateCompanionBuilder,
        $$ProductVariantsTableTableUpdateCompanionBuilder,
        (
          ProductVariantsTableData,
          BaseReferences<_$AppDatabase, $ProductVariantsTableTable,
              ProductVariantsTableData>
        ),
        ProductVariantsTableData,
        PrefetchHooks Function()>;
typedef $$ModifierGroupsTableTableCreateCompanionBuilder
    = ModifierGroupsTableCompanion Function({
  required String id,
  required String tenantId,
  required String name,
  Value<int> minSelection,
  Value<int> maxSelection,
  Value<bool> isMandatory,
  Value<int> rowid,
});
typedef $$ModifierGroupsTableTableUpdateCompanionBuilder
    = ModifierGroupsTableCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> name,
  Value<int> minSelection,
  Value<int> maxSelection,
  Value<bool> isMandatory,
  Value<int> rowid,
});

class $$ModifierGroupsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ModifierGroupsTableTable> {
  $$ModifierGroupsTableTableFilterComposer({
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

  ColumnFilters<int> get minSelection => $composableBuilder(
      column: $table.minSelection, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxSelection => $composableBuilder(
      column: $table.maxSelection, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMandatory => $composableBuilder(
      column: $table.isMandatory, builder: (column) => ColumnFilters(column));
}

class $$ModifierGroupsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ModifierGroupsTableTable> {
  $$ModifierGroupsTableTableOrderingComposer({
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

  ColumnOrderings<int> get minSelection => $composableBuilder(
      column: $table.minSelection,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxSelection => $composableBuilder(
      column: $table.maxSelection,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMandatory => $composableBuilder(
      column: $table.isMandatory, builder: (column) => ColumnOrderings(column));
}

class $$ModifierGroupsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ModifierGroupsTableTable> {
  $$ModifierGroupsTableTableAnnotationComposer({
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

  GeneratedColumn<int> get minSelection => $composableBuilder(
      column: $table.minSelection, builder: (column) => column);

  GeneratedColumn<int> get maxSelection => $composableBuilder(
      column: $table.maxSelection, builder: (column) => column);

  GeneratedColumn<bool> get isMandatory => $composableBuilder(
      column: $table.isMandatory, builder: (column) => column);
}

class $$ModifierGroupsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ModifierGroupsTableTable,
    ModifierGroupsTableData,
    $$ModifierGroupsTableTableFilterComposer,
    $$ModifierGroupsTableTableOrderingComposer,
    $$ModifierGroupsTableTableAnnotationComposer,
    $$ModifierGroupsTableTableCreateCompanionBuilder,
    $$ModifierGroupsTableTableUpdateCompanionBuilder,
    (
      ModifierGroupsTableData,
      BaseReferences<_$AppDatabase, $ModifierGroupsTableTable,
          ModifierGroupsTableData>
    ),
    ModifierGroupsTableData,
    PrefetchHooks Function()> {
  $$ModifierGroupsTableTableTableManager(
      _$AppDatabase db, $ModifierGroupsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ModifierGroupsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ModifierGroupsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ModifierGroupsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> minSelection = const Value.absent(),
            Value<int> maxSelection = const Value.absent(),
            Value<bool> isMandatory = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ModifierGroupsTableCompanion(
            id: id,
            tenantId: tenantId,
            name: name,
            minSelection: minSelection,
            maxSelection: maxSelection,
            isMandatory: isMandatory,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String name,
            Value<int> minSelection = const Value.absent(),
            Value<int> maxSelection = const Value.absent(),
            Value<bool> isMandatory = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ModifierGroupsTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            name: name,
            minSelection: minSelection,
            maxSelection: maxSelection,
            isMandatory: isMandatory,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ModifierGroupsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ModifierGroupsTableTable,
    ModifierGroupsTableData,
    $$ModifierGroupsTableTableFilterComposer,
    $$ModifierGroupsTableTableOrderingComposer,
    $$ModifierGroupsTableTableAnnotationComposer,
    $$ModifierGroupsTableTableCreateCompanionBuilder,
    $$ModifierGroupsTableTableUpdateCompanionBuilder,
    (
      ModifierGroupsTableData,
      BaseReferences<_$AppDatabase, $ModifierGroupsTableTable,
          ModifierGroupsTableData>
    ),
    ModifierGroupsTableData,
    PrefetchHooks Function()>;
typedef $$ModifiersTableTableCreateCompanionBuilder = ModifiersTableCompanion
    Function({
  required String id,
  required String groupId,
  required String name,
  Value<int> priceDeltaPaise,
  Value<int> sortOrder,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$ModifiersTableTableUpdateCompanionBuilder = ModifiersTableCompanion
    Function({
  Value<String> id,
  Value<String> groupId,
  Value<String> name,
  Value<int> priceDeltaPaise,
  Value<int> sortOrder,
  Value<bool> isActive,
  Value<int> rowid,
});

class $$ModifiersTableTableFilterComposer
    extends Composer<_$AppDatabase, $ModifiersTableTable> {
  $$ModifiersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priceDeltaPaise => $composableBuilder(
      column: $table.priceDeltaPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));
}

class $$ModifiersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ModifiersTableTable> {
  $$ModifiersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priceDeltaPaise => $composableBuilder(
      column: $table.priceDeltaPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$ModifiersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ModifiersTableTable> {
  $$ModifiersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priceDeltaPaise => $composableBuilder(
      column: $table.priceDeltaPaise, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$ModifiersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ModifiersTableTable,
    ModifiersTableData,
    $$ModifiersTableTableFilterComposer,
    $$ModifiersTableTableOrderingComposer,
    $$ModifiersTableTableAnnotationComposer,
    $$ModifiersTableTableCreateCompanionBuilder,
    $$ModifiersTableTableUpdateCompanionBuilder,
    (
      ModifiersTableData,
      BaseReferences<_$AppDatabase, $ModifiersTableTable, ModifiersTableData>
    ),
    ModifiersTableData,
    PrefetchHooks Function()> {
  $$ModifiersTableTableTableManager(
      _$AppDatabase db, $ModifiersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ModifiersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ModifiersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ModifiersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> groupId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> priceDeltaPaise = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ModifiersTableCompanion(
            id: id,
            groupId: groupId,
            name: name,
            priceDeltaPaise: priceDeltaPaise,
            sortOrder: sortOrder,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String groupId,
            required String name,
            Value<int> priceDeltaPaise = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ModifiersTableCompanion.insert(
            id: id,
            groupId: groupId,
            name: name,
            priceDeltaPaise: priceDeltaPaise,
            sortOrder: sortOrder,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ModifiersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ModifiersTableTable,
    ModifiersTableData,
    $$ModifiersTableTableFilterComposer,
    $$ModifiersTableTableOrderingComposer,
    $$ModifiersTableTableAnnotationComposer,
    $$ModifiersTableTableCreateCompanionBuilder,
    $$ModifiersTableTableUpdateCompanionBuilder,
    (
      ModifiersTableData,
      BaseReferences<_$AppDatabase, $ModifiersTableTable, ModifiersTableData>
    ),
    ModifiersTableData,
    PrefetchHooks Function()>;
typedef $$ProductModifierGroupsTableTableCreateCompanionBuilder
    = ProductModifierGroupsTableCompanion Function({
  required String productId,
  required String modifierGroupId,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$ProductModifierGroupsTableTableUpdateCompanionBuilder
    = ProductModifierGroupsTableCompanion Function({
  Value<String> productId,
  Value<String> modifierGroupId,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$ProductModifierGroupsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductModifierGroupsTableTable> {
  $$ProductModifierGroupsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get modifierGroupId => $composableBuilder(
      column: $table.modifierGroupId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));
}

class $$ProductModifierGroupsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductModifierGroupsTableTable> {
  $$ProductModifierGroupsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get modifierGroupId => $composableBuilder(
      column: $table.modifierGroupId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
}

class $$ProductModifierGroupsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductModifierGroupsTableTable> {
  $$ProductModifierGroupsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get modifierGroupId => $composableBuilder(
      column: $table.modifierGroupId, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$ProductModifierGroupsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductModifierGroupsTableTable,
    ProductModifierGroupsTableData,
    $$ProductModifierGroupsTableTableFilterComposer,
    $$ProductModifierGroupsTableTableOrderingComposer,
    $$ProductModifierGroupsTableTableAnnotationComposer,
    $$ProductModifierGroupsTableTableCreateCompanionBuilder,
    $$ProductModifierGroupsTableTableUpdateCompanionBuilder,
    (
      ProductModifierGroupsTableData,
      BaseReferences<_$AppDatabase, $ProductModifierGroupsTableTable,
          ProductModifierGroupsTableData>
    ),
    ProductModifierGroupsTableData,
    PrefetchHooks Function()> {
  $$ProductModifierGroupsTableTableTableManager(
      _$AppDatabase db, $ProductModifierGroupsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductModifierGroupsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductModifierGroupsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductModifierGroupsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> productId = const Value.absent(),
            Value<String> modifierGroupId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductModifierGroupsTableCompanion(
            productId: productId,
            modifierGroupId: modifierGroupId,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String productId,
            required String modifierGroupId,
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductModifierGroupsTableCompanion.insert(
            productId: productId,
            modifierGroupId: modifierGroupId,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductModifierGroupsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ProductModifierGroupsTableTable,
        ProductModifierGroupsTableData,
        $$ProductModifierGroupsTableTableFilterComposer,
        $$ProductModifierGroupsTableTableOrderingComposer,
        $$ProductModifierGroupsTableTableAnnotationComposer,
        $$ProductModifierGroupsTableTableCreateCompanionBuilder,
        $$ProductModifierGroupsTableTableUpdateCompanionBuilder,
        (
          ProductModifierGroupsTableData,
          BaseReferences<_$AppDatabase, $ProductModifierGroupsTableTable,
              ProductModifierGroupsTableData>
        ),
        ProductModifierGroupsTableData,
        PrefetchHooks Function()>;
typedef $$ProductBranchAvailabilityTableTableCreateCompanionBuilder
    = ProductBranchAvailabilityTableCompanion Function({
  required String productId,
  required String branchId,
  Value<bool> isAvailable,
  Value<int?> overridePricePaise,
  Value<int> rowid,
});
typedef $$ProductBranchAvailabilityTableTableUpdateCompanionBuilder
    = ProductBranchAvailabilityTableCompanion Function({
  Value<String> productId,
  Value<String> branchId,
  Value<bool> isAvailable,
  Value<int?> overridePricePaise,
  Value<int> rowid,
});

class $$ProductBranchAvailabilityTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductBranchAvailabilityTableTable> {
  $$ProductBranchAvailabilityTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isAvailable => $composableBuilder(
      column: $table.isAvailable, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get overridePricePaise => $composableBuilder(
      column: $table.overridePricePaise,
      builder: (column) => ColumnFilters(column));
}

class $$ProductBranchAvailabilityTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductBranchAvailabilityTableTable> {
  $$ProductBranchAvailabilityTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
      column: $table.isAvailable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get overridePricePaise => $composableBuilder(
      column: $table.overridePricePaise,
      builder: (column) => ColumnOrderings(column));
}

class $$ProductBranchAvailabilityTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductBranchAvailabilityTableTable> {
  $$ProductBranchAvailabilityTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
      column: $table.isAvailable, builder: (column) => column);

  GeneratedColumn<int> get overridePricePaise => $composableBuilder(
      column: $table.overridePricePaise, builder: (column) => column);
}

class $$ProductBranchAvailabilityTableTableTableManager
    extends RootTableManager<
        _$AppDatabase,
        $ProductBranchAvailabilityTableTable,
        ProductBranchAvailabilityTableData,
        $$ProductBranchAvailabilityTableTableFilterComposer,
        $$ProductBranchAvailabilityTableTableOrderingComposer,
        $$ProductBranchAvailabilityTableTableAnnotationComposer,
        $$ProductBranchAvailabilityTableTableCreateCompanionBuilder,
        $$ProductBranchAvailabilityTableTableUpdateCompanionBuilder,
        (
          ProductBranchAvailabilityTableData,
          BaseReferences<_$AppDatabase, $ProductBranchAvailabilityTableTable,
              ProductBranchAvailabilityTableData>
        ),
        ProductBranchAvailabilityTableData,
        PrefetchHooks Function()> {
  $$ProductBranchAvailabilityTableTableTableManager(
      _$AppDatabase db, $ProductBranchAvailabilityTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductBranchAvailabilityTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductBranchAvailabilityTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductBranchAvailabilityTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> productId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<bool> isAvailable = const Value.absent(),
            Value<int?> overridePricePaise = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductBranchAvailabilityTableCompanion(
            productId: productId,
            branchId: branchId,
            isAvailable: isAvailable,
            overridePricePaise: overridePricePaise,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String productId,
            required String branchId,
            Value<bool> isAvailable = const Value.absent(),
            Value<int?> overridePricePaise = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductBranchAvailabilityTableCompanion.insert(
            productId: productId,
            branchId: branchId,
            isAvailable: isAvailable,
            overridePricePaise: overridePricePaise,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductBranchAvailabilityTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ProductBranchAvailabilityTableTable,
        ProductBranchAvailabilityTableData,
        $$ProductBranchAvailabilityTableTableFilterComposer,
        $$ProductBranchAvailabilityTableTableOrderingComposer,
        $$ProductBranchAvailabilityTableTableAnnotationComposer,
        $$ProductBranchAvailabilityTableTableCreateCompanionBuilder,
        $$ProductBranchAvailabilityTableTableUpdateCompanionBuilder,
        (
          ProductBranchAvailabilityTableData,
          BaseReferences<_$AppDatabase, $ProductBranchAvailabilityTableTable,
              ProductBranchAvailabilityTableData>
        ),
        ProductBranchAvailabilityTableData,
        PrefetchHooks Function()>;
typedef $$OrdersTableTableCreateCompanionBuilder = OrdersTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String branchId,
  required String orderNumber,
  Value<String> orderType,
  Value<String> status,
  Value<String> source,
  Value<String?> tableId,
  Value<String?> customerName,
  Value<String?> customerPhone,
  Value<String?> notes,
  Value<int> subtotalPaise,
  Value<int> discountPaise,
  Value<int> taxPaise,
  Value<int> roundingPaise,
  Value<int> finalTotalPaise,
  required String createdBy,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> version,
  Value<int> rowid,
});
typedef $$OrdersTableTableUpdateCompanionBuilder = OrdersTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String> orderNumber,
  Value<String> orderType,
  Value<String> status,
  Value<String> source,
  Value<String?> tableId,
  Value<String?> customerName,
  Value<String?> customerPhone,
  Value<String?> notes,
  Value<int> subtotalPaise,
  Value<int> discountPaise,
  Value<int> taxPaise,
  Value<int> roundingPaise,
  Value<int> finalTotalPaise,
  Value<String> createdBy,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> version,
  Value<int> rowid,
});

class $$OrdersTableTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTableTable> {
  $$OrdersTableTableFilterComposer({
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

  ColumnFilters<String> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderType => $composableBuilder(
      column: $table.orderType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tableId => $composableBuilder(
      column: $table.tableId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerPhone => $composableBuilder(
      column: $table.customerPhone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get subtotalPaise => $composableBuilder(
      column: $table.subtotalPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get discountPaise => $composableBuilder(
      column: $table.discountPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get taxPaise => $composableBuilder(
      column: $table.taxPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get roundingPaise => $composableBuilder(
      column: $table.roundingPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get finalTotalPaise => $composableBuilder(
      column: $table.finalTotalPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));
}

class $$OrdersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTableTable> {
  $$OrdersTableTableOrderingComposer({
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

  ColumnOrderings<String> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderType => $composableBuilder(
      column: $table.orderType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tableId => $composableBuilder(
      column: $table.tableId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerName => $composableBuilder(
      column: $table.customerName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerPhone => $composableBuilder(
      column: $table.customerPhone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get subtotalPaise => $composableBuilder(
      column: $table.subtotalPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get discountPaise => $composableBuilder(
      column: $table.discountPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get taxPaise => $composableBuilder(
      column: $table.taxPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get roundingPaise => $composableBuilder(
      column: $table.roundingPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get finalTotalPaise => $composableBuilder(
      column: $table.finalTotalPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));
}

class $$OrdersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTableTable> {
  $$OrdersTableTableAnnotationComposer({
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

  GeneratedColumn<String> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => column);

  GeneratedColumn<String> get orderType =>
      $composableBuilder(column: $table.orderType, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get tableId =>
      $composableBuilder(column: $table.tableId, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => column);

  GeneratedColumn<String> get customerPhone => $composableBuilder(
      column: $table.customerPhone, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get subtotalPaise => $composableBuilder(
      column: $table.subtotalPaise, builder: (column) => column);

  GeneratedColumn<int> get discountPaise => $composableBuilder(
      column: $table.discountPaise, builder: (column) => column);

  GeneratedColumn<int> get taxPaise =>
      $composableBuilder(column: $table.taxPaise, builder: (column) => column);

  GeneratedColumn<int> get roundingPaise => $composableBuilder(
      column: $table.roundingPaise, builder: (column) => column);

  GeneratedColumn<int> get finalTotalPaise => $composableBuilder(
      column: $table.finalTotalPaise, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);
}

class $$OrdersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdersTableTable,
    OrdersTableData,
    $$OrdersTableTableFilterComposer,
    $$OrdersTableTableOrderingComposer,
    $$OrdersTableTableAnnotationComposer,
    $$OrdersTableTableCreateCompanionBuilder,
    $$OrdersTableTableUpdateCompanionBuilder,
    (
      OrdersTableData,
      BaseReferences<_$AppDatabase, $OrdersTableTable, OrdersTableData>
    ),
    OrdersTableData,
    PrefetchHooks Function()> {
  $$OrdersTableTableTableManager(_$AppDatabase db, $OrdersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> orderNumber = const Value.absent(),
            Value<String> orderType = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> tableId = const Value.absent(),
            Value<String?> customerName = const Value.absent(),
            Value<String?> customerPhone = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> subtotalPaise = const Value.absent(),
            Value<int> discountPaise = const Value.absent(),
            Value<int> taxPaise = const Value.absent(),
            Value<int> roundingPaise = const Value.absent(),
            Value<int> finalTotalPaise = const Value.absent(),
            Value<String> createdBy = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrdersTableCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            orderNumber: orderNumber,
            orderType: orderType,
            status: status,
            source: source,
            tableId: tableId,
            customerName: customerName,
            customerPhone: customerPhone,
            notes: notes,
            subtotalPaise: subtotalPaise,
            discountPaise: discountPaise,
            taxPaise: taxPaise,
            roundingPaise: roundingPaise,
            finalTotalPaise: finalTotalPaise,
            createdBy: createdBy,
            createdAt: createdAt,
            updatedAt: updatedAt,
            version: version,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String branchId,
            required String orderNumber,
            Value<String> orderType = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> tableId = const Value.absent(),
            Value<String?> customerName = const Value.absent(),
            Value<String?> customerPhone = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> subtotalPaise = const Value.absent(),
            Value<int> discountPaise = const Value.absent(),
            Value<int> taxPaise = const Value.absent(),
            Value<int> roundingPaise = const Value.absent(),
            Value<int> finalTotalPaise = const Value.absent(),
            required String createdBy,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrdersTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            orderNumber: orderNumber,
            orderType: orderType,
            status: status,
            source: source,
            tableId: tableId,
            customerName: customerName,
            customerPhone: customerPhone,
            notes: notes,
            subtotalPaise: subtotalPaise,
            discountPaise: discountPaise,
            taxPaise: taxPaise,
            roundingPaise: roundingPaise,
            finalTotalPaise: finalTotalPaise,
            createdBy: createdBy,
            createdAt: createdAt,
            updatedAt: updatedAt,
            version: version,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrdersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrdersTableTable,
    OrdersTableData,
    $$OrdersTableTableFilterComposer,
    $$OrdersTableTableOrderingComposer,
    $$OrdersTableTableAnnotationComposer,
    $$OrdersTableTableCreateCompanionBuilder,
    $$OrdersTableTableUpdateCompanionBuilder,
    (
      OrdersTableData,
      BaseReferences<_$AppDatabase, $OrdersTableTable, OrdersTableData>
    ),
    OrdersTableData,
    PrefetchHooks Function()>;
typedef $$OrderItemsTableTableCreateCompanionBuilder = OrderItemsTableCompanion
    Function({
  required String id,
  required String orderId,
  required String tenantId,
  required String productId,
  Value<String?> variantId,
  required String productName,
  Value<String?> variantName,
  Value<int> quantity,
  required int unitPricePaise,
  required int subtotalPaise,
  Value<int> discountPaise,
  required int taxablePaise,
  Value<int> cgstPaise,
  Value<int> sgstPaise,
  Value<int> igstPaise,
  Value<int> totalTaxPaise,
  required int lineTotalPaise,
  Value<int> taxRateBps,
  Value<bool> isTaxInclusive,
  Value<String?> notes,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$OrderItemsTableTableUpdateCompanionBuilder = OrderItemsTableCompanion
    Function({
  Value<String> id,
  Value<String> orderId,
  Value<String> tenantId,
  Value<String> productId,
  Value<String?> variantId,
  Value<String> productName,
  Value<String?> variantName,
  Value<int> quantity,
  Value<int> unitPricePaise,
  Value<int> subtotalPaise,
  Value<int> discountPaise,
  Value<int> taxablePaise,
  Value<int> cgstPaise,
  Value<int> sgstPaise,
  Value<int> igstPaise,
  Value<int> totalTaxPaise,
  Value<int> lineTotalPaise,
  Value<int> taxRateBps,
  Value<bool> isTaxInclusive,
  Value<String?> notes,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$OrderItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $OrderItemsTableTable> {
  $$OrderItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get variantId => $composableBuilder(
      column: $table.variantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productName => $composableBuilder(
      column: $table.productName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get variantName => $composableBuilder(
      column: $table.variantName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unitPricePaise => $composableBuilder(
      column: $table.unitPricePaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get subtotalPaise => $composableBuilder(
      column: $table.subtotalPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get discountPaise => $composableBuilder(
      column: $table.discountPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get taxablePaise => $composableBuilder(
      column: $table.taxablePaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cgstPaise => $composableBuilder(
      column: $table.cgstPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sgstPaise => $composableBuilder(
      column: $table.sgstPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get igstPaise => $composableBuilder(
      column: $table.igstPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalTaxPaise => $composableBuilder(
      column: $table.totalTaxPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lineTotalPaise => $composableBuilder(
      column: $table.lineTotalPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get taxRateBps => $composableBuilder(
      column: $table.taxRateBps, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isTaxInclusive => $composableBuilder(
      column: $table.isTaxInclusive,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$OrderItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderItemsTableTable> {
  $$OrderItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get variantId => $composableBuilder(
      column: $table.variantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productName => $composableBuilder(
      column: $table.productName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get variantName => $composableBuilder(
      column: $table.variantName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unitPricePaise => $composableBuilder(
      column: $table.unitPricePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get subtotalPaise => $composableBuilder(
      column: $table.subtotalPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get discountPaise => $composableBuilder(
      column: $table.discountPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get taxablePaise => $composableBuilder(
      column: $table.taxablePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cgstPaise => $composableBuilder(
      column: $table.cgstPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sgstPaise => $composableBuilder(
      column: $table.sgstPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get igstPaise => $composableBuilder(
      column: $table.igstPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalTaxPaise => $composableBuilder(
      column: $table.totalTaxPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lineTotalPaise => $composableBuilder(
      column: $table.lineTotalPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get taxRateBps => $composableBuilder(
      column: $table.taxRateBps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isTaxInclusive => $composableBuilder(
      column: $table.isTaxInclusive,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$OrderItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderItemsTableTable> {
  $$OrderItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
      column: $table.productName, builder: (column) => column);

  GeneratedColumn<String> get variantName => $composableBuilder(
      column: $table.variantName, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get unitPricePaise => $composableBuilder(
      column: $table.unitPricePaise, builder: (column) => column);

  GeneratedColumn<int> get subtotalPaise => $composableBuilder(
      column: $table.subtotalPaise, builder: (column) => column);

  GeneratedColumn<int> get discountPaise => $composableBuilder(
      column: $table.discountPaise, builder: (column) => column);

  GeneratedColumn<int> get taxablePaise => $composableBuilder(
      column: $table.taxablePaise, builder: (column) => column);

  GeneratedColumn<int> get cgstPaise =>
      $composableBuilder(column: $table.cgstPaise, builder: (column) => column);

  GeneratedColumn<int> get sgstPaise =>
      $composableBuilder(column: $table.sgstPaise, builder: (column) => column);

  GeneratedColumn<int> get igstPaise =>
      $composableBuilder(column: $table.igstPaise, builder: (column) => column);

  GeneratedColumn<int> get totalTaxPaise => $composableBuilder(
      column: $table.totalTaxPaise, builder: (column) => column);

  GeneratedColumn<int> get lineTotalPaise => $composableBuilder(
      column: $table.lineTotalPaise, builder: (column) => column);

  GeneratedColumn<int> get taxRateBps => $composableBuilder(
      column: $table.taxRateBps, builder: (column) => column);

  GeneratedColumn<bool> get isTaxInclusive => $composableBuilder(
      column: $table.isTaxInclusive, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$OrderItemsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrderItemsTableTable,
    OrderItemsTableData,
    $$OrderItemsTableTableFilterComposer,
    $$OrderItemsTableTableOrderingComposer,
    $$OrderItemsTableTableAnnotationComposer,
    $$OrderItemsTableTableCreateCompanionBuilder,
    $$OrderItemsTableTableUpdateCompanionBuilder,
    (
      OrderItemsTableData,
      BaseReferences<_$AppDatabase, $OrderItemsTableTable, OrderItemsTableData>
    ),
    OrderItemsTableData,
    PrefetchHooks Function()> {
  $$OrderItemsTableTableTableManager(
      _$AppDatabase db, $OrderItemsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderItemsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> orderId = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<String?> variantId = const Value.absent(),
            Value<String> productName = const Value.absent(),
            Value<String?> variantName = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<int> unitPricePaise = const Value.absent(),
            Value<int> subtotalPaise = const Value.absent(),
            Value<int> discountPaise = const Value.absent(),
            Value<int> taxablePaise = const Value.absent(),
            Value<int> cgstPaise = const Value.absent(),
            Value<int> sgstPaise = const Value.absent(),
            Value<int> igstPaise = const Value.absent(),
            Value<int> totalTaxPaise = const Value.absent(),
            Value<int> lineTotalPaise = const Value.absent(),
            Value<int> taxRateBps = const Value.absent(),
            Value<bool> isTaxInclusive = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrderItemsTableCompanion(
            id: id,
            orderId: orderId,
            tenantId: tenantId,
            productId: productId,
            variantId: variantId,
            productName: productName,
            variantName: variantName,
            quantity: quantity,
            unitPricePaise: unitPricePaise,
            subtotalPaise: subtotalPaise,
            discountPaise: discountPaise,
            taxablePaise: taxablePaise,
            cgstPaise: cgstPaise,
            sgstPaise: sgstPaise,
            igstPaise: igstPaise,
            totalTaxPaise: totalTaxPaise,
            lineTotalPaise: lineTotalPaise,
            taxRateBps: taxRateBps,
            isTaxInclusive: isTaxInclusive,
            notes: notes,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String orderId,
            required String tenantId,
            required String productId,
            Value<String?> variantId = const Value.absent(),
            required String productName,
            Value<String?> variantName = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            required int unitPricePaise,
            required int subtotalPaise,
            Value<int> discountPaise = const Value.absent(),
            required int taxablePaise,
            Value<int> cgstPaise = const Value.absent(),
            Value<int> sgstPaise = const Value.absent(),
            Value<int> igstPaise = const Value.absent(),
            Value<int> totalTaxPaise = const Value.absent(),
            required int lineTotalPaise,
            Value<int> taxRateBps = const Value.absent(),
            Value<bool> isTaxInclusive = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrderItemsTableCompanion.insert(
            id: id,
            orderId: orderId,
            tenantId: tenantId,
            productId: productId,
            variantId: variantId,
            productName: productName,
            variantName: variantName,
            quantity: quantity,
            unitPricePaise: unitPricePaise,
            subtotalPaise: subtotalPaise,
            discountPaise: discountPaise,
            taxablePaise: taxablePaise,
            cgstPaise: cgstPaise,
            sgstPaise: sgstPaise,
            igstPaise: igstPaise,
            totalTaxPaise: totalTaxPaise,
            lineTotalPaise: lineTotalPaise,
            taxRateBps: taxRateBps,
            isTaxInclusive: isTaxInclusive,
            notes: notes,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrderItemsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrderItemsTableTable,
    OrderItemsTableData,
    $$OrderItemsTableTableFilterComposer,
    $$OrderItemsTableTableOrderingComposer,
    $$OrderItemsTableTableAnnotationComposer,
    $$OrderItemsTableTableCreateCompanionBuilder,
    $$OrderItemsTableTableUpdateCompanionBuilder,
    (
      OrderItemsTableData,
      BaseReferences<_$AppDatabase, $OrderItemsTableTable, OrderItemsTableData>
    ),
    OrderItemsTableData,
    PrefetchHooks Function()>;
typedef $$OrderItemModifiersTableTableCreateCompanionBuilder
    = OrderItemModifiersTableCompanion Function({
  required String id,
  required String orderItemId,
  required String modifierId,
  required String modifierName,
  Value<int> priceDeltaPaise,
  Value<int> rowid,
});
typedef $$OrderItemModifiersTableTableUpdateCompanionBuilder
    = OrderItemModifiersTableCompanion Function({
  Value<String> id,
  Value<String> orderItemId,
  Value<String> modifierId,
  Value<String> modifierName,
  Value<int> priceDeltaPaise,
  Value<int> rowid,
});

class $$OrderItemModifiersTableTableFilterComposer
    extends Composer<_$AppDatabase, $OrderItemModifiersTableTable> {
  $$OrderItemModifiersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderItemId => $composableBuilder(
      column: $table.orderItemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get modifierId => $composableBuilder(
      column: $table.modifierId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get modifierName => $composableBuilder(
      column: $table.modifierName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priceDeltaPaise => $composableBuilder(
      column: $table.priceDeltaPaise,
      builder: (column) => ColumnFilters(column));
}

class $$OrderItemModifiersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderItemModifiersTableTable> {
  $$OrderItemModifiersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderItemId => $composableBuilder(
      column: $table.orderItemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get modifierId => $composableBuilder(
      column: $table.modifierId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get modifierName => $composableBuilder(
      column: $table.modifierName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priceDeltaPaise => $composableBuilder(
      column: $table.priceDeltaPaise,
      builder: (column) => ColumnOrderings(column));
}

class $$OrderItemModifiersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderItemModifiersTableTable> {
  $$OrderItemModifiersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orderItemId => $composableBuilder(
      column: $table.orderItemId, builder: (column) => column);

  GeneratedColumn<String> get modifierId => $composableBuilder(
      column: $table.modifierId, builder: (column) => column);

  GeneratedColumn<String> get modifierName => $composableBuilder(
      column: $table.modifierName, builder: (column) => column);

  GeneratedColumn<int> get priceDeltaPaise => $composableBuilder(
      column: $table.priceDeltaPaise, builder: (column) => column);
}

class $$OrderItemModifiersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrderItemModifiersTableTable,
    OrderItemModifiersTableData,
    $$OrderItemModifiersTableTableFilterComposer,
    $$OrderItemModifiersTableTableOrderingComposer,
    $$OrderItemModifiersTableTableAnnotationComposer,
    $$OrderItemModifiersTableTableCreateCompanionBuilder,
    $$OrderItemModifiersTableTableUpdateCompanionBuilder,
    (
      OrderItemModifiersTableData,
      BaseReferences<_$AppDatabase, $OrderItemModifiersTableTable,
          OrderItemModifiersTableData>
    ),
    OrderItemModifiersTableData,
    PrefetchHooks Function()> {
  $$OrderItemModifiersTableTableTableManager(
      _$AppDatabase db, $OrderItemModifiersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderItemModifiersTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderItemModifiersTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderItemModifiersTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> orderItemId = const Value.absent(),
            Value<String> modifierId = const Value.absent(),
            Value<String> modifierName = const Value.absent(),
            Value<int> priceDeltaPaise = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrderItemModifiersTableCompanion(
            id: id,
            orderItemId: orderItemId,
            modifierId: modifierId,
            modifierName: modifierName,
            priceDeltaPaise: priceDeltaPaise,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String orderItemId,
            required String modifierId,
            required String modifierName,
            Value<int> priceDeltaPaise = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrderItemModifiersTableCompanion.insert(
            id: id,
            orderItemId: orderItemId,
            modifierId: modifierId,
            modifierName: modifierName,
            priceDeltaPaise: priceDeltaPaise,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrderItemModifiersTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $OrderItemModifiersTableTable,
        OrderItemModifiersTableData,
        $$OrderItemModifiersTableTableFilterComposer,
        $$OrderItemModifiersTableTableOrderingComposer,
        $$OrderItemModifiersTableTableAnnotationComposer,
        $$OrderItemModifiersTableTableCreateCompanionBuilder,
        $$OrderItemModifiersTableTableUpdateCompanionBuilder,
        (
          OrderItemModifiersTableData,
          BaseReferences<_$AppDatabase, $OrderItemModifiersTableTable,
              OrderItemModifiersTableData>
        ),
        OrderItemModifiersTableData,
        PrefetchHooks Function()>;
typedef $$InvoicesTableTableCreateCompanionBuilder = InvoicesTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String branchId,
  required String invoiceNumber,
  Value<String?> orderId,
  required int subtotalPaise,
  Value<int> discountPaise,
  required int taxablePaise,
  Value<int> cgstPaise,
  Value<int> sgstPaise,
  Value<int> igstPaise,
  Value<int> totalTaxPaise,
  Value<int> roundingPaise,
  required int finalTotalPaise,
  Value<String> status,
  Value<String?> customerName,
  Value<String?> customerPhone,
  Value<String?> customerGstin,
  required String fiscalYear,
  required String deviceSeries,
  required int sequenceNumber,
  Value<DateTime> issuedAt,
  required String issuedBy,
  Value<int> rowid,
});
typedef $$InvoicesTableTableUpdateCompanionBuilder = InvoicesTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String> invoiceNumber,
  Value<String?> orderId,
  Value<int> subtotalPaise,
  Value<int> discountPaise,
  Value<int> taxablePaise,
  Value<int> cgstPaise,
  Value<int> sgstPaise,
  Value<int> igstPaise,
  Value<int> totalTaxPaise,
  Value<int> roundingPaise,
  Value<int> finalTotalPaise,
  Value<String> status,
  Value<String?> customerName,
  Value<String?> customerPhone,
  Value<String?> customerGstin,
  Value<String> fiscalYear,
  Value<String> deviceSeries,
  Value<int> sequenceNumber,
  Value<DateTime> issuedAt,
  Value<String> issuedBy,
  Value<int> rowid,
});

class $$InvoicesTableTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTableTable> {
  $$InvoicesTableTableFilterComposer({
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

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get subtotalPaise => $composableBuilder(
      column: $table.subtotalPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get discountPaise => $composableBuilder(
      column: $table.discountPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get taxablePaise => $composableBuilder(
      column: $table.taxablePaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cgstPaise => $composableBuilder(
      column: $table.cgstPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sgstPaise => $composableBuilder(
      column: $table.sgstPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get igstPaise => $composableBuilder(
      column: $table.igstPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalTaxPaise => $composableBuilder(
      column: $table.totalTaxPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get roundingPaise => $composableBuilder(
      column: $table.roundingPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get finalTotalPaise => $composableBuilder(
      column: $table.finalTotalPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerPhone => $composableBuilder(
      column: $table.customerPhone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerGstin => $composableBuilder(
      column: $table.customerGstin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fiscalYear => $composableBuilder(
      column: $table.fiscalYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceSeries => $composableBuilder(
      column: $table.deviceSeries, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sequenceNumber => $composableBuilder(
      column: $table.sequenceNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get issuedAt => $composableBuilder(
      column: $table.issuedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get issuedBy => $composableBuilder(
      column: $table.issuedBy, builder: (column) => ColumnFilters(column));
}

class $$InvoicesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTableTable> {
  $$InvoicesTableTableOrderingComposer({
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

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get subtotalPaise => $composableBuilder(
      column: $table.subtotalPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get discountPaise => $composableBuilder(
      column: $table.discountPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get taxablePaise => $composableBuilder(
      column: $table.taxablePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cgstPaise => $composableBuilder(
      column: $table.cgstPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sgstPaise => $composableBuilder(
      column: $table.sgstPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get igstPaise => $composableBuilder(
      column: $table.igstPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalTaxPaise => $composableBuilder(
      column: $table.totalTaxPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get roundingPaise => $composableBuilder(
      column: $table.roundingPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get finalTotalPaise => $composableBuilder(
      column: $table.finalTotalPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerName => $composableBuilder(
      column: $table.customerName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerPhone => $composableBuilder(
      column: $table.customerPhone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerGstin => $composableBuilder(
      column: $table.customerGstin,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fiscalYear => $composableBuilder(
      column: $table.fiscalYear, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceSeries => $composableBuilder(
      column: $table.deviceSeries,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sequenceNumber => $composableBuilder(
      column: $table.sequenceNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get issuedAt => $composableBuilder(
      column: $table.issuedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get issuedBy => $composableBuilder(
      column: $table.issuedBy, builder: (column) => ColumnOrderings(column));
}

class $$InvoicesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTableTable> {
  $$InvoicesTableTableAnnotationComposer({
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

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber, builder: (column) => column);

  GeneratedColumn<String> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<int> get subtotalPaise => $composableBuilder(
      column: $table.subtotalPaise, builder: (column) => column);

  GeneratedColumn<int> get discountPaise => $composableBuilder(
      column: $table.discountPaise, builder: (column) => column);

  GeneratedColumn<int> get taxablePaise => $composableBuilder(
      column: $table.taxablePaise, builder: (column) => column);

  GeneratedColumn<int> get cgstPaise =>
      $composableBuilder(column: $table.cgstPaise, builder: (column) => column);

  GeneratedColumn<int> get sgstPaise =>
      $composableBuilder(column: $table.sgstPaise, builder: (column) => column);

  GeneratedColumn<int> get igstPaise =>
      $composableBuilder(column: $table.igstPaise, builder: (column) => column);

  GeneratedColumn<int> get totalTaxPaise => $composableBuilder(
      column: $table.totalTaxPaise, builder: (column) => column);

  GeneratedColumn<int> get roundingPaise => $composableBuilder(
      column: $table.roundingPaise, builder: (column) => column);

  GeneratedColumn<int> get finalTotalPaise => $composableBuilder(
      column: $table.finalTotalPaise, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => column);

  GeneratedColumn<String> get customerPhone => $composableBuilder(
      column: $table.customerPhone, builder: (column) => column);

  GeneratedColumn<String> get customerGstin => $composableBuilder(
      column: $table.customerGstin, builder: (column) => column);

  GeneratedColumn<String> get fiscalYear => $composableBuilder(
      column: $table.fiscalYear, builder: (column) => column);

  GeneratedColumn<String> get deviceSeries => $composableBuilder(
      column: $table.deviceSeries, builder: (column) => column);

  GeneratedColumn<int> get sequenceNumber => $composableBuilder(
      column: $table.sequenceNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get issuedAt =>
      $composableBuilder(column: $table.issuedAt, builder: (column) => column);

  GeneratedColumn<String> get issuedBy =>
      $composableBuilder(column: $table.issuedBy, builder: (column) => column);
}

class $$InvoicesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InvoicesTableTable,
    InvoicesTableData,
    $$InvoicesTableTableFilterComposer,
    $$InvoicesTableTableOrderingComposer,
    $$InvoicesTableTableAnnotationComposer,
    $$InvoicesTableTableCreateCompanionBuilder,
    $$InvoicesTableTableUpdateCompanionBuilder,
    (
      InvoicesTableData,
      BaseReferences<_$AppDatabase, $InvoicesTableTable, InvoicesTableData>
    ),
    InvoicesTableData,
    PrefetchHooks Function()> {
  $$InvoicesTableTableTableManager(_$AppDatabase db, $InvoicesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> invoiceNumber = const Value.absent(),
            Value<String?> orderId = const Value.absent(),
            Value<int> subtotalPaise = const Value.absent(),
            Value<int> discountPaise = const Value.absent(),
            Value<int> taxablePaise = const Value.absent(),
            Value<int> cgstPaise = const Value.absent(),
            Value<int> sgstPaise = const Value.absent(),
            Value<int> igstPaise = const Value.absent(),
            Value<int> totalTaxPaise = const Value.absent(),
            Value<int> roundingPaise = const Value.absent(),
            Value<int> finalTotalPaise = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> customerName = const Value.absent(),
            Value<String?> customerPhone = const Value.absent(),
            Value<String?> customerGstin = const Value.absent(),
            Value<String> fiscalYear = const Value.absent(),
            Value<String> deviceSeries = const Value.absent(),
            Value<int> sequenceNumber = const Value.absent(),
            Value<DateTime> issuedAt = const Value.absent(),
            Value<String> issuedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InvoicesTableCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            invoiceNumber: invoiceNumber,
            orderId: orderId,
            subtotalPaise: subtotalPaise,
            discountPaise: discountPaise,
            taxablePaise: taxablePaise,
            cgstPaise: cgstPaise,
            sgstPaise: sgstPaise,
            igstPaise: igstPaise,
            totalTaxPaise: totalTaxPaise,
            roundingPaise: roundingPaise,
            finalTotalPaise: finalTotalPaise,
            status: status,
            customerName: customerName,
            customerPhone: customerPhone,
            customerGstin: customerGstin,
            fiscalYear: fiscalYear,
            deviceSeries: deviceSeries,
            sequenceNumber: sequenceNumber,
            issuedAt: issuedAt,
            issuedBy: issuedBy,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String branchId,
            required String invoiceNumber,
            Value<String?> orderId = const Value.absent(),
            required int subtotalPaise,
            Value<int> discountPaise = const Value.absent(),
            required int taxablePaise,
            Value<int> cgstPaise = const Value.absent(),
            Value<int> sgstPaise = const Value.absent(),
            Value<int> igstPaise = const Value.absent(),
            Value<int> totalTaxPaise = const Value.absent(),
            Value<int> roundingPaise = const Value.absent(),
            required int finalTotalPaise,
            Value<String> status = const Value.absent(),
            Value<String?> customerName = const Value.absent(),
            Value<String?> customerPhone = const Value.absent(),
            Value<String?> customerGstin = const Value.absent(),
            required String fiscalYear,
            required String deviceSeries,
            required int sequenceNumber,
            Value<DateTime> issuedAt = const Value.absent(),
            required String issuedBy,
            Value<int> rowid = const Value.absent(),
          }) =>
              InvoicesTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            invoiceNumber: invoiceNumber,
            orderId: orderId,
            subtotalPaise: subtotalPaise,
            discountPaise: discountPaise,
            taxablePaise: taxablePaise,
            cgstPaise: cgstPaise,
            sgstPaise: sgstPaise,
            igstPaise: igstPaise,
            totalTaxPaise: totalTaxPaise,
            roundingPaise: roundingPaise,
            finalTotalPaise: finalTotalPaise,
            status: status,
            customerName: customerName,
            customerPhone: customerPhone,
            customerGstin: customerGstin,
            fiscalYear: fiscalYear,
            deviceSeries: deviceSeries,
            sequenceNumber: sequenceNumber,
            issuedAt: issuedAt,
            issuedBy: issuedBy,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InvoicesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InvoicesTableTable,
    InvoicesTableData,
    $$InvoicesTableTableFilterComposer,
    $$InvoicesTableTableOrderingComposer,
    $$InvoicesTableTableAnnotationComposer,
    $$InvoicesTableTableCreateCompanionBuilder,
    $$InvoicesTableTableUpdateCompanionBuilder,
    (
      InvoicesTableData,
      BaseReferences<_$AppDatabase, $InvoicesTableTable, InvoicesTableData>
    ),
    InvoicesTableData,
    PrefetchHooks Function()>;
typedef $$PaymentsTableTableCreateCompanionBuilder = PaymentsTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String branchId,
  Value<String?> invoiceId,
  Value<String?> orderId,
  required String method,
  Value<String> status,
  required int amountPaise,
  Value<int?> tenderedPaise,
  Value<int?> changeDuePaise,
  Value<String?> referenceNumber,
  required String recordedBy,
  Value<DateTime> recordedAt,
  Value<int> rowid,
});
typedef $$PaymentsTableTableUpdateCompanionBuilder = PaymentsTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String?> invoiceId,
  Value<String?> orderId,
  Value<String> method,
  Value<String> status,
  Value<int> amountPaise,
  Value<int?> tenderedPaise,
  Value<int?> changeDuePaise,
  Value<String?> referenceNumber,
  Value<String> recordedBy,
  Value<DateTime> recordedAt,
  Value<int> rowid,
});

class $$PaymentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTableTable> {
  $$PaymentsTableTableFilterComposer({
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

  ColumnFilters<String> get invoiceId => $composableBuilder(
      column: $table.invoiceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tenderedPaise => $composableBuilder(
      column: $table.tenderedPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get changeDuePaise => $composableBuilder(
      column: $table.changeDuePaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get referenceNumber => $composableBuilder(
      column: $table.referenceNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordedBy => $composableBuilder(
      column: $table.recordedBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));
}

class $$PaymentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTableTable> {
  $$PaymentsTableTableOrderingComposer({
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

  ColumnOrderings<String> get invoiceId => $composableBuilder(
      column: $table.invoiceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tenderedPaise => $composableBuilder(
      column: $table.tenderedPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get changeDuePaise => $composableBuilder(
      column: $table.changeDuePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get referenceNumber => $composableBuilder(
      column: $table.referenceNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordedBy => $composableBuilder(
      column: $table.recordedBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));
}

class $$PaymentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTableTable> {
  $$PaymentsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<String> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => column);

  GeneratedColumn<int> get tenderedPaise => $composableBuilder(
      column: $table.tenderedPaise, builder: (column) => column);

  GeneratedColumn<int> get changeDuePaise => $composableBuilder(
      column: $table.changeDuePaise, builder: (column) => column);

  GeneratedColumn<String> get referenceNumber => $composableBuilder(
      column: $table.referenceNumber, builder: (column) => column);

  GeneratedColumn<String> get recordedBy => $composableBuilder(
      column: $table.recordedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);
}

class $$PaymentsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentsTableTable,
    PaymentsTableData,
    $$PaymentsTableTableFilterComposer,
    $$PaymentsTableTableOrderingComposer,
    $$PaymentsTableTableAnnotationComposer,
    $$PaymentsTableTableCreateCompanionBuilder,
    $$PaymentsTableTableUpdateCompanionBuilder,
    (
      PaymentsTableData,
      BaseReferences<_$AppDatabase, $PaymentsTableTable, PaymentsTableData>
    ),
    PaymentsTableData,
    PrefetchHooks Function()> {
  $$PaymentsTableTableTableManager(_$AppDatabase db, $PaymentsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String?> invoiceId = const Value.absent(),
            Value<String?> orderId = const Value.absent(),
            Value<String> method = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> amountPaise = const Value.absent(),
            Value<int?> tenderedPaise = const Value.absent(),
            Value<int?> changeDuePaise = const Value.absent(),
            Value<String?> referenceNumber = const Value.absent(),
            Value<String> recordedBy = const Value.absent(),
            Value<DateTime> recordedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentsTableCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            invoiceId: invoiceId,
            orderId: orderId,
            method: method,
            status: status,
            amountPaise: amountPaise,
            tenderedPaise: tenderedPaise,
            changeDuePaise: changeDuePaise,
            referenceNumber: referenceNumber,
            recordedBy: recordedBy,
            recordedAt: recordedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String branchId,
            Value<String?> invoiceId = const Value.absent(),
            Value<String?> orderId = const Value.absent(),
            required String method,
            Value<String> status = const Value.absent(),
            required int amountPaise,
            Value<int?> tenderedPaise = const Value.absent(),
            Value<int?> changeDuePaise = const Value.absent(),
            Value<String?> referenceNumber = const Value.absent(),
            required String recordedBy,
            Value<DateTime> recordedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentsTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            invoiceId: invoiceId,
            orderId: orderId,
            method: method,
            status: status,
            amountPaise: amountPaise,
            tenderedPaise: tenderedPaise,
            changeDuePaise: changeDuePaise,
            referenceNumber: referenceNumber,
            recordedBy: recordedBy,
            recordedAt: recordedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PaymentsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaymentsTableTable,
    PaymentsTableData,
    $$PaymentsTableTableFilterComposer,
    $$PaymentsTableTableOrderingComposer,
    $$PaymentsTableTableAnnotationComposer,
    $$PaymentsTableTableCreateCompanionBuilder,
    $$PaymentsTableTableUpdateCompanionBuilder,
    (
      PaymentsTableData,
      BaseReferences<_$AppDatabase, $PaymentsTableTable, PaymentsTableData>
    ),
    PaymentsTableData,
    PrefetchHooks Function()>;
typedef $$RefundsTableTableCreateCompanionBuilder = RefundsTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String branchId,
  required String invoiceId,
  Value<String?> paymentId,
  required int amountPaise,
  required String reason,
  required String approvedBy,
  required String refundMethod,
  Value<String?> refundReference,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$RefundsTableTableUpdateCompanionBuilder = RefundsTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String> invoiceId,
  Value<String?> paymentId,
  Value<int> amountPaise,
  Value<String> reason,
  Value<String> approvedBy,
  Value<String> refundMethod,
  Value<String?> refundReference,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$RefundsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RefundsTableTable> {
  $$RefundsTableTableFilterComposer({
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

  ColumnFilters<String> get invoiceId => $composableBuilder(
      column: $table.invoiceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentId => $composableBuilder(
      column: $table.paymentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get approvedBy => $composableBuilder(
      column: $table.approvedBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get refundMethod => $composableBuilder(
      column: $table.refundMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get refundReference => $composableBuilder(
      column: $table.refundReference,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$RefundsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RefundsTableTable> {
  $$RefundsTableTableOrderingComposer({
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

  ColumnOrderings<String> get invoiceId => $composableBuilder(
      column: $table.invoiceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentId => $composableBuilder(
      column: $table.paymentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get approvedBy => $composableBuilder(
      column: $table.approvedBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get refundMethod => $composableBuilder(
      column: $table.refundMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get refundReference => $composableBuilder(
      column: $table.refundReference,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$RefundsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RefundsTableTable> {
  $$RefundsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<String> get paymentId =>
      $composableBuilder(column: $table.paymentId, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get approvedBy => $composableBuilder(
      column: $table.approvedBy, builder: (column) => column);

  GeneratedColumn<String> get refundMethod => $composableBuilder(
      column: $table.refundMethod, builder: (column) => column);

  GeneratedColumn<String> get refundReference => $composableBuilder(
      column: $table.refundReference, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RefundsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RefundsTableTable,
    RefundsTableData,
    $$RefundsTableTableFilterComposer,
    $$RefundsTableTableOrderingComposer,
    $$RefundsTableTableAnnotationComposer,
    $$RefundsTableTableCreateCompanionBuilder,
    $$RefundsTableTableUpdateCompanionBuilder,
    (
      RefundsTableData,
      BaseReferences<_$AppDatabase, $RefundsTableTable, RefundsTableData>
    ),
    RefundsTableData,
    PrefetchHooks Function()> {
  $$RefundsTableTableTableManager(_$AppDatabase db, $RefundsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RefundsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RefundsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RefundsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> invoiceId = const Value.absent(),
            Value<String?> paymentId = const Value.absent(),
            Value<int> amountPaise = const Value.absent(),
            Value<String> reason = const Value.absent(),
            Value<String> approvedBy = const Value.absent(),
            Value<String> refundMethod = const Value.absent(),
            Value<String?> refundReference = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RefundsTableCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            invoiceId: invoiceId,
            paymentId: paymentId,
            amountPaise: amountPaise,
            reason: reason,
            approvedBy: approvedBy,
            refundMethod: refundMethod,
            refundReference: refundReference,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String branchId,
            required String invoiceId,
            Value<String?> paymentId = const Value.absent(),
            required int amountPaise,
            required String reason,
            required String approvedBy,
            required String refundMethod,
            Value<String?> refundReference = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RefundsTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            invoiceId: invoiceId,
            paymentId: paymentId,
            amountPaise: amountPaise,
            reason: reason,
            approvedBy: approvedBy,
            refundMethod: refundMethod,
            refundReference: refundReference,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RefundsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RefundsTableTable,
    RefundsTableData,
    $$RefundsTableTableFilterComposer,
    $$RefundsTableTableOrderingComposer,
    $$RefundsTableTableAnnotationComposer,
    $$RefundsTableTableCreateCompanionBuilder,
    $$RefundsTableTableUpdateCompanionBuilder,
    (
      RefundsTableData,
      BaseReferences<_$AppDatabase, $RefundsTableTable, RefundsTableData>
    ),
    RefundsTableData,
    PrefetchHooks Function()>;
typedef $$CashSessionsTableTableCreateCompanionBuilder
    = CashSessionsTableCompanion Function({
  required String id,
  required String tenantId,
  required String branchId,
  required String deviceId,
  required String openedBy,
  Value<String?> closedBy,
  Value<int> openingFloatPaise,
  Value<int?> closingCashActualPaise,
  Value<int> expectedCashPaise,
  Value<int> variancePaise,
  Value<String> status,
  Value<DateTime> openedAt,
  Value<DateTime?> closedAt,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$CashSessionsTableTableUpdateCompanionBuilder
    = CashSessionsTableCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String> deviceId,
  Value<String> openedBy,
  Value<String?> closedBy,
  Value<int> openingFloatPaise,
  Value<int?> closingCashActualPaise,
  Value<int> expectedCashPaise,
  Value<int> variancePaise,
  Value<String> status,
  Value<DateTime> openedAt,
  Value<DateTime?> closedAt,
  Value<String?> notes,
  Value<int> rowid,
});

class $$CashSessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CashSessionsTableTable> {
  $$CashSessionsTableTableFilterComposer({
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

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get openedBy => $composableBuilder(
      column: $table.openedBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get closedBy => $composableBuilder(
      column: $table.closedBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get openingFloatPaise => $composableBuilder(
      column: $table.openingFloatPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get closingCashActualPaise => $composableBuilder(
      column: $table.closingCashActualPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get expectedCashPaise => $composableBuilder(
      column: $table.expectedCashPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get variancePaise => $composableBuilder(
      column: $table.variancePaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
      column: $table.openedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$CashSessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CashSessionsTableTable> {
  $$CashSessionsTableTableOrderingComposer({
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

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get openedBy => $composableBuilder(
      column: $table.openedBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get closedBy => $composableBuilder(
      column: $table.closedBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get openingFloatPaise => $composableBuilder(
      column: $table.openingFloatPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get closingCashActualPaise => $composableBuilder(
      column: $table.closingCashActualPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get expectedCashPaise => $composableBuilder(
      column: $table.expectedCashPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get variancePaise => $composableBuilder(
      column: $table.variancePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
      column: $table.openedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$CashSessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashSessionsTableTable> {
  $$CashSessionsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get openedBy =>
      $composableBuilder(column: $table.openedBy, builder: (column) => column);

  GeneratedColumn<String> get closedBy =>
      $composableBuilder(column: $table.closedBy, builder: (column) => column);

  GeneratedColumn<int> get openingFloatPaise => $composableBuilder(
      column: $table.openingFloatPaise, builder: (column) => column);

  GeneratedColumn<int> get closingCashActualPaise => $composableBuilder(
      column: $table.closingCashActualPaise, builder: (column) => column);

  GeneratedColumn<int> get expectedCashPaise => $composableBuilder(
      column: $table.expectedCashPaise, builder: (column) => column);

  GeneratedColumn<int> get variancePaise => $composableBuilder(
      column: $table.variancePaise, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$CashSessionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CashSessionsTableTable,
    CashSessionsTableData,
    $$CashSessionsTableTableFilterComposer,
    $$CashSessionsTableTableOrderingComposer,
    $$CashSessionsTableTableAnnotationComposer,
    $$CashSessionsTableTableCreateCompanionBuilder,
    $$CashSessionsTableTableUpdateCompanionBuilder,
    (
      CashSessionsTableData,
      BaseReferences<_$AppDatabase, $CashSessionsTableTable,
          CashSessionsTableData>
    ),
    CashSessionsTableData,
    PrefetchHooks Function()> {
  $$CashSessionsTableTableTableManager(
      _$AppDatabase db, $CashSessionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashSessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashSessionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashSessionsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> deviceId = const Value.absent(),
            Value<String> openedBy = const Value.absent(),
            Value<String?> closedBy = const Value.absent(),
            Value<int> openingFloatPaise = const Value.absent(),
            Value<int?> closingCashActualPaise = const Value.absent(),
            Value<int> expectedCashPaise = const Value.absent(),
            Value<int> variancePaise = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> openedAt = const Value.absent(),
            Value<DateTime?> closedAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CashSessionsTableCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            deviceId: deviceId,
            openedBy: openedBy,
            closedBy: closedBy,
            openingFloatPaise: openingFloatPaise,
            closingCashActualPaise: closingCashActualPaise,
            expectedCashPaise: expectedCashPaise,
            variancePaise: variancePaise,
            status: status,
            openedAt: openedAt,
            closedAt: closedAt,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String branchId,
            required String deviceId,
            required String openedBy,
            Value<String?> closedBy = const Value.absent(),
            Value<int> openingFloatPaise = const Value.absent(),
            Value<int?> closingCashActualPaise = const Value.absent(),
            Value<int> expectedCashPaise = const Value.absent(),
            Value<int> variancePaise = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> openedAt = const Value.absent(),
            Value<DateTime?> closedAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CashSessionsTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            deviceId: deviceId,
            openedBy: openedBy,
            closedBy: closedBy,
            openingFloatPaise: openingFloatPaise,
            closingCashActualPaise: closingCashActualPaise,
            expectedCashPaise: expectedCashPaise,
            variancePaise: variancePaise,
            status: status,
            openedAt: openedAt,
            closedAt: closedAt,
            notes: notes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CashSessionsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CashSessionsTableTable,
    CashSessionsTableData,
    $$CashSessionsTableTableFilterComposer,
    $$CashSessionsTableTableOrderingComposer,
    $$CashSessionsTableTableAnnotationComposer,
    $$CashSessionsTableTableCreateCompanionBuilder,
    $$CashSessionsTableTableUpdateCompanionBuilder,
    (
      CashSessionsTableData,
      BaseReferences<_$AppDatabase, $CashSessionsTableTable,
          CashSessionsTableData>
    ),
    CashSessionsTableData,
    PrefetchHooks Function()>;
typedef $$CashMovementsTableTableCreateCompanionBuilder
    = CashMovementsTableCompanion Function({
  required String id,
  required String sessionId,
  required String tenantId,
  required String branchId,
  required String type,
  required int amountPaise,
  Value<String?> reason,
  required String performedBy,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$CashMovementsTableTableUpdateCompanionBuilder
    = CashMovementsTableCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String> type,
  Value<int> amountPaise,
  Value<String?> reason,
  Value<String> performedBy,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$CashMovementsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CashMovementsTableTable> {
  $$CashMovementsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get performedBy => $composableBuilder(
      column: $table.performedBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$CashMovementsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CashMovementsTableTable> {
  $$CashMovementsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get performedBy => $composableBuilder(
      column: $table.performedBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$CashMovementsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashMovementsTableTable> {
  $$CashMovementsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get performedBy => $composableBuilder(
      column: $table.performedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CashMovementsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CashMovementsTableTable,
    CashMovementsTableData,
    $$CashMovementsTableTableFilterComposer,
    $$CashMovementsTableTableOrderingComposer,
    $$CashMovementsTableTableAnnotationComposer,
    $$CashMovementsTableTableCreateCompanionBuilder,
    $$CashMovementsTableTableUpdateCompanionBuilder,
    (
      CashMovementsTableData,
      BaseReferences<_$AppDatabase, $CashMovementsTableTable,
          CashMovementsTableData>
    ),
    CashMovementsTableData,
    PrefetchHooks Function()> {
  $$CashMovementsTableTableTableManager(
      _$AppDatabase db, $CashMovementsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashMovementsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashMovementsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashMovementsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionId = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> amountPaise = const Value.absent(),
            Value<String?> reason = const Value.absent(),
            Value<String> performedBy = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CashMovementsTableCompanion(
            id: id,
            sessionId: sessionId,
            tenantId: tenantId,
            branchId: branchId,
            type: type,
            amountPaise: amountPaise,
            reason: reason,
            performedBy: performedBy,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessionId,
            required String tenantId,
            required String branchId,
            required String type,
            required int amountPaise,
            Value<String?> reason = const Value.absent(),
            required String performedBy,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CashMovementsTableCompanion.insert(
            id: id,
            sessionId: sessionId,
            tenantId: tenantId,
            branchId: branchId,
            type: type,
            amountPaise: amountPaise,
            reason: reason,
            performedBy: performedBy,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CashMovementsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CashMovementsTableTable,
    CashMovementsTableData,
    $$CashMovementsTableTableFilterComposer,
    $$CashMovementsTableTableOrderingComposer,
    $$CashMovementsTableTableAnnotationComposer,
    $$CashMovementsTableTableCreateCompanionBuilder,
    $$CashMovementsTableTableUpdateCompanionBuilder,
    (
      CashMovementsTableData,
      BaseReferences<_$AppDatabase, $CashMovementsTableTable,
          CashMovementsTableData>
    ),
    CashMovementsTableData,
    PrefetchHooks Function()>;
typedef $$CartHoldTableTableCreateCompanionBuilder = CartHoldTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String branchId,
  required String label,
  required String cartJson,
  Value<DateTime> heldAt,
  required String heldBy,
  Value<int> rowid,
});
typedef $$CartHoldTableTableUpdateCompanionBuilder = CartHoldTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String> label,
  Value<String> cartJson,
  Value<DateTime> heldAt,
  Value<String> heldBy,
  Value<int> rowid,
});

class $$CartHoldTableTableFilterComposer
    extends Composer<_$AppDatabase, $CartHoldTableTable> {
  $$CartHoldTableTableFilterComposer({
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

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cartJson => $composableBuilder(
      column: $table.cartJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get heldAt => $composableBuilder(
      column: $table.heldAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get heldBy => $composableBuilder(
      column: $table.heldBy, builder: (column) => ColumnFilters(column));
}

class $$CartHoldTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CartHoldTableTable> {
  $$CartHoldTableTableOrderingComposer({
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

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cartJson => $composableBuilder(
      column: $table.cartJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get heldAt => $composableBuilder(
      column: $table.heldAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get heldBy => $composableBuilder(
      column: $table.heldBy, builder: (column) => ColumnOrderings(column));
}

class $$CartHoldTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CartHoldTableTable> {
  $$CartHoldTableTableAnnotationComposer({
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

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get cartJson =>
      $composableBuilder(column: $table.cartJson, builder: (column) => column);

  GeneratedColumn<DateTime> get heldAt =>
      $composableBuilder(column: $table.heldAt, builder: (column) => column);

  GeneratedColumn<String> get heldBy =>
      $composableBuilder(column: $table.heldBy, builder: (column) => column);
}

class $$CartHoldTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CartHoldTableTable,
    CartHoldTableData,
    $$CartHoldTableTableFilterComposer,
    $$CartHoldTableTableOrderingComposer,
    $$CartHoldTableTableAnnotationComposer,
    $$CartHoldTableTableCreateCompanionBuilder,
    $$CartHoldTableTableUpdateCompanionBuilder,
    (
      CartHoldTableData,
      BaseReferences<_$AppDatabase, $CartHoldTableTable, CartHoldTableData>
    ),
    CartHoldTableData,
    PrefetchHooks Function()> {
  $$CartHoldTableTableTableManager(_$AppDatabase db, $CartHoldTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartHoldTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartHoldTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartHoldTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> cartJson = const Value.absent(),
            Value<DateTime> heldAt = const Value.absent(),
            Value<String> heldBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CartHoldTableCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            label: label,
            cartJson: cartJson,
            heldAt: heldAt,
            heldBy: heldBy,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String branchId,
            required String label,
            required String cartJson,
            Value<DateTime> heldAt = const Value.absent(),
            required String heldBy,
            Value<int> rowid = const Value.absent(),
          }) =>
              CartHoldTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            label: label,
            cartJson: cartJson,
            heldAt: heldAt,
            heldBy: heldBy,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CartHoldTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CartHoldTableTable,
    CartHoldTableData,
    $$CartHoldTableTableFilterComposer,
    $$CartHoldTableTableOrderingComposer,
    $$CartHoldTableTableAnnotationComposer,
    $$CartHoldTableTableCreateCompanionBuilder,
    $$CartHoldTableTableUpdateCompanionBuilder,
    (
      CartHoldTableData,
      BaseReferences<_$AppDatabase, $CartHoldTableTable, CartHoldTableData>
    ),
    CartHoldTableData,
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
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$TaxCategoriesTableTableTableManager get taxCategoriesTable =>
      $$TaxCategoriesTableTableTableManager(_db, _db.taxCategoriesTable);
  $$ProductsTableTableTableManager get productsTable =>
      $$ProductsTableTableTableManager(_db, _db.productsTable);
  $$ProductVariantsTableTableTableManager get productVariantsTable =>
      $$ProductVariantsTableTableTableManager(_db, _db.productVariantsTable);
  $$ModifierGroupsTableTableTableManager get modifierGroupsTable =>
      $$ModifierGroupsTableTableTableManager(_db, _db.modifierGroupsTable);
  $$ModifiersTableTableTableManager get modifiersTable =>
      $$ModifiersTableTableTableManager(_db, _db.modifiersTable);
  $$ProductModifierGroupsTableTableTableManager
      get productModifierGroupsTable =>
          $$ProductModifierGroupsTableTableTableManager(
              _db, _db.productModifierGroupsTable);
  $$ProductBranchAvailabilityTableTableTableManager
      get productBranchAvailabilityTable =>
          $$ProductBranchAvailabilityTableTableTableManager(
              _db, _db.productBranchAvailabilityTable);
  $$OrdersTableTableTableManager get ordersTable =>
      $$OrdersTableTableTableManager(_db, _db.ordersTable);
  $$OrderItemsTableTableTableManager get orderItemsTable =>
      $$OrderItemsTableTableTableManager(_db, _db.orderItemsTable);
  $$OrderItemModifiersTableTableTableManager get orderItemModifiersTable =>
      $$OrderItemModifiersTableTableTableManager(
          _db, _db.orderItemModifiersTable);
  $$InvoicesTableTableTableManager get invoicesTable =>
      $$InvoicesTableTableTableManager(_db, _db.invoicesTable);
  $$PaymentsTableTableTableManager get paymentsTable =>
      $$PaymentsTableTableTableManager(_db, _db.paymentsTable);
  $$RefundsTableTableTableManager get refundsTable =>
      $$RefundsTableTableTableManager(_db, _db.refundsTable);
  $$CashSessionsTableTableTableManager get cashSessionsTable =>
      $$CashSessionsTableTableTableManager(_db, _db.cashSessionsTable);
  $$CashMovementsTableTableTableManager get cashMovementsTable =>
      $$CashMovementsTableTableTableManager(_db, _db.cashMovementsTable);
  $$CartHoldTableTableTableManager get cartHoldTable =>
      $$CartHoldTableTableTableManager(_db, _db.cartHoldTable);
}
