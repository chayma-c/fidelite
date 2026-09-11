/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'menu/menu_item.dart' as _i3;
import 'orders/exceptions/invalid_order_exception.dart' as _i4;
import 'orders/exceptions/invalid_order_exception_reason.dart' as _i5;
import 'orders/order.dart' as _i6;
import 'orders/order_confirmation.dart' as _i7;
import 'orders/order_item.dart' as _i8;
import 'orders/order_item_input.dart' as _i9;
import 'orders/order_status.dart' as _i10;
import 'points/claim_result.dart' as _i11;
import 'points/claim_token_status.dart' as _i12;
import 'points/exceptions/order_claim_exception.dart' as _i13;
import 'points/exceptions/order_claim_exception_reason.dart' as _i14;
import 'points/order_claim_token.dart' as _i15;
import 'points/points_ledger_entry.dart' as _i16;
import 'points/points_ledger_reason.dart' as _i17;
import 'users/app_user.dart' as _i18;
import 'package:fidelite_server/src/generated/menu/menu_item.dart' as _i19;
import 'package:fidelite_server/src/generated/orders/order_item_input.dart'
    as _i20;
import 'package:fidelite_server/src/generated/orders/order.dart' as _i21;
import 'package:fidelite_server/src/generated/points/points_ledger_entry.dart'
    as _i22;
export 'menu/menu_item.dart';
export 'orders/exceptions/invalid_order_exception.dart';
export 'orders/exceptions/invalid_order_exception_reason.dart';
export 'orders/order.dart';
export 'orders/order_confirmation.dart';
export 'orders/order_item.dart';
export 'orders/order_item_input.dart';
export 'orders/order_status.dart';
export 'points/claim_result.dart';
export 'points/claim_token_status.dart';
export 'points/exceptions/order_claim_exception.dart';
export 'points/exceptions/order_claim_exception_reason.dart';
export 'points/order_claim_token.dart';
export 'points/points_ledger_entry.dart';
export 'points/points_ledger_reason.dart';
export 'users/app_user.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'app_user',
      dartName: 'AppUserRecord',
      schema: 'public',
      module: 'fidelite',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'username',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'fullName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'roles',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'app_user_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'fidelite_order',
      dartName: 'OrderRecord',
      schema: 'public',
      module: 'fidelite',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'fidelite_order_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'staffUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OrderStatus',
          columnDefault: '\'confirmed\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'subtotalMillimes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'totalMillimes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'fidelite_order_fk_0',
          columns: ['staffUserId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'fidelite_order_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'menu_item',
      dartName: 'MenuItemRecord',
      schema: 'public',
      module: 'fidelite',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'menu_item_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'priceMillimes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'sortOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'menu_item_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'order_claim_token',
      dartName: 'OrderClaimTokenRecord',
      schema: 'public',
      module: 'fidelite',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'order_claim_token_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'orderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'tokenHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ClaimTokenStatus',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'issuedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'claimedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'claimedByUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'order_claim_token_fk_0',
          columns: ['orderId'],
          referenceTable: 'fidelite_order',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'order_claim_token_fk_1',
          columns: ['claimedByUserId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'order_claim_token_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'order_item',
      dartName: 'OrderItemRecord',
      schema: 'public',
      module: 'fidelite',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'order_item_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'orderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'menuItemId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'menuItemNameSnapshot',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'unitPriceMillimesSnapshot',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'lineTotalMillimes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'order_item_fk_0',
          columns: ['orderId'],
          referenceTable: 'fidelite_order',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'order_item_fk_1',
          columns: ['menuItemId'],
          referenceTable: 'menu_item',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'order_item_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'points_ledger_entry',
      dartName: 'PointsLedgerEntryRecord',
      schema: 'public',
      module: 'fidelite',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'points_ledger_entry_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'deltaMillimes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PointsLedgerReason',
        ),
        _i2.ColumnDefinition(
          name: 'relatedOrderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'balanceAfterMillimes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdByUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'points_ledger_entry_fk_0',
          columns: ['userId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'points_ledger_entry_fk_1',
          columns: ['relatedOrderId'],
          referenceTable: 'fidelite_order',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'points_ledger_entry_fk_2',
          columns: ['createdByUserId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'points_ledger_entry_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i3.MenuItemRecord) {
      return _i3.MenuItemRecord.fromJson(data) as T;
    }
    if (t == _i4.InvalidOrderException) {
      return _i4.InvalidOrderException.fromJson(data) as T;
    }
    if (t == _i5.InvalidOrderExceptionReason) {
      return _i5.InvalidOrderExceptionReason.fromJson(data) as T;
    }
    if (t == _i6.OrderRecord) {
      return _i6.OrderRecord.fromJson(data) as T;
    }
    if (t == _i7.OrderConfirmation) {
      return _i7.OrderConfirmation.fromJson(data) as T;
    }
    if (t == _i8.OrderItemRecord) {
      return _i8.OrderItemRecord.fromJson(data) as T;
    }
    if (t == _i9.OrderItemInput) {
      return _i9.OrderItemInput.fromJson(data) as T;
    }
    if (t == _i10.OrderStatus) {
      return _i10.OrderStatus.fromJson(data) as T;
    }
    if (t == _i11.ClaimResult) {
      return _i11.ClaimResult.fromJson(data) as T;
    }
    if (t == _i12.ClaimTokenStatus) {
      return _i12.ClaimTokenStatus.fromJson(data) as T;
    }
    if (t == _i13.OrderClaimException) {
      return _i13.OrderClaimException.fromJson(data) as T;
    }
    if (t == _i14.OrderClaimExceptionReason) {
      return _i14.OrderClaimExceptionReason.fromJson(data) as T;
    }
    if (t == _i15.OrderClaimTokenRecord) {
      return _i15.OrderClaimTokenRecord.fromJson(data) as T;
    }
    if (t == _i16.PointsLedgerEntryRecord) {
      return _i16.PointsLedgerEntryRecord.fromJson(data) as T;
    }
    if (t == _i17.PointsLedgerReason) {
      return _i17.PointsLedgerReason.fromJson(data) as T;
    }
    if (t == _i18.AppUserRecord) {
      return _i18.AppUserRecord.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.MenuItemRecord?>()) {
      return (data != null ? _i3.MenuItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.InvalidOrderException?>()) {
      return (data != null ? _i4.InvalidOrderException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.InvalidOrderExceptionReason?>()) {
      return (data != null
              ? _i5.InvalidOrderExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i6.OrderRecord?>()) {
      return (data != null ? _i6.OrderRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.OrderConfirmation?>()) {
      return (data != null ? _i7.OrderConfirmation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.OrderItemRecord?>()) {
      return (data != null ? _i8.OrderItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.OrderItemInput?>()) {
      return (data != null ? _i9.OrderItemInput.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.OrderStatus?>()) {
      return (data != null ? _i10.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ClaimResult?>()) {
      return (data != null ? _i11.ClaimResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ClaimTokenStatus?>()) {
      return (data != null ? _i12.ClaimTokenStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.OrderClaimException?>()) {
      return (data != null ? _i13.OrderClaimException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.OrderClaimExceptionReason?>()) {
      return (data != null
              ? _i14.OrderClaimExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i15.OrderClaimTokenRecord?>()) {
      return (data != null ? _i15.OrderClaimTokenRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.PointsLedgerEntryRecord?>()) {
      return (data != null ? _i16.PointsLedgerEntryRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.PointsLedgerReason?>()) {
      return (data != null ? _i17.PointsLedgerReason.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.AppUserRecord?>()) {
      return (data != null ? _i18.AppUserRecord.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i19.MenuItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i19.MenuItemRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.OrderItemInput>) {
      return (data as List)
              .map((e) => deserialize<_i20.OrderItemInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.OrderRecord>) {
      return (data as List)
              .map((e) => deserialize<_i21.OrderRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.PointsLedgerEntryRecord>) {
      return (data as List)
              .map((e) => deserialize<_i22.PointsLedgerEntryRecord>(e))
              .toList()
          as T;
    }
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i3.MenuItemRecord => 'MenuItemRecord',
      _i4.InvalidOrderException => 'InvalidOrderException',
      _i5.InvalidOrderExceptionReason => 'InvalidOrderExceptionReason',
      _i6.OrderRecord => 'OrderRecord',
      _i7.OrderConfirmation => 'OrderConfirmation',
      _i8.OrderItemRecord => 'OrderItemRecord',
      _i9.OrderItemInput => 'OrderItemInput',
      _i10.OrderStatus => 'OrderStatus',
      _i11.ClaimResult => 'ClaimResult',
      _i12.ClaimTokenStatus => 'ClaimTokenStatus',
      _i13.OrderClaimException => 'OrderClaimException',
      _i14.OrderClaimExceptionReason => 'OrderClaimExceptionReason',
      _i15.OrderClaimTokenRecord => 'OrderClaimTokenRecord',
      _i16.PointsLedgerEntryRecord => 'PointsLedgerEntryRecord',
      _i17.PointsLedgerReason => 'PointsLedgerReason',
      _i18.AppUserRecord => 'AppUserRecord',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('fidelite.', '');
    }

    switch (data) {
      case _i3.MenuItemRecord():
        return 'MenuItemRecord';
      case _i4.InvalidOrderException():
        return 'InvalidOrderException';
      case _i5.InvalidOrderExceptionReason():
        return 'InvalidOrderExceptionReason';
      case _i6.OrderRecord():
        return 'OrderRecord';
      case _i7.OrderConfirmation():
        return 'OrderConfirmation';
      case _i8.OrderItemRecord():
        return 'OrderItemRecord';
      case _i9.OrderItemInput():
        return 'OrderItemInput';
      case _i10.OrderStatus():
        return 'OrderStatus';
      case _i11.ClaimResult():
        return 'ClaimResult';
      case _i12.ClaimTokenStatus():
        return 'ClaimTokenStatus';
      case _i13.OrderClaimException():
        return 'OrderClaimException';
      case _i14.OrderClaimExceptionReason():
        return 'OrderClaimExceptionReason';
      case _i15.OrderClaimTokenRecord():
        return 'OrderClaimTokenRecord';
      case _i16.PointsLedgerEntryRecord():
        return 'PointsLedgerEntryRecord';
      case _i17.PointsLedgerReason():
        return 'PointsLedgerReason';
      case _i18.AppUserRecord():
        return 'AppUserRecord';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'MenuItemRecord') {
      return deserialize<_i3.MenuItemRecord>(data['data']);
    }
    if (dataClassName == 'InvalidOrderException') {
      return deserialize<_i4.InvalidOrderException>(data['data']);
    }
    if (dataClassName == 'InvalidOrderExceptionReason') {
      return deserialize<_i5.InvalidOrderExceptionReason>(data['data']);
    }
    if (dataClassName == 'OrderRecord') {
      return deserialize<_i6.OrderRecord>(data['data']);
    }
    if (dataClassName == 'OrderConfirmation') {
      return deserialize<_i7.OrderConfirmation>(data['data']);
    }
    if (dataClassName == 'OrderItemRecord') {
      return deserialize<_i8.OrderItemRecord>(data['data']);
    }
    if (dataClassName == 'OrderItemInput') {
      return deserialize<_i9.OrderItemInput>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i10.OrderStatus>(data['data']);
    }
    if (dataClassName == 'ClaimResult') {
      return deserialize<_i11.ClaimResult>(data['data']);
    }
    if (dataClassName == 'ClaimTokenStatus') {
      return deserialize<_i12.ClaimTokenStatus>(data['data']);
    }
    if (dataClassName == 'OrderClaimException') {
      return deserialize<_i13.OrderClaimException>(data['data']);
    }
    if (dataClassName == 'OrderClaimExceptionReason') {
      return deserialize<_i14.OrderClaimExceptionReason>(data['data']);
    }
    if (dataClassName == 'OrderClaimTokenRecord') {
      return deserialize<_i15.OrderClaimTokenRecord>(data['data']);
    }
    if (dataClassName == 'PointsLedgerEntryRecord') {
      return deserialize<_i16.PointsLedgerEntryRecord>(data['data']);
    }
    if (dataClassName == 'PointsLedgerReason') {
      return deserialize<_i17.PointsLedgerReason>(data['data']);
    }
    if (dataClassName == 'AppUserRecord') {
      return deserialize<_i18.AppUserRecord>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i3.MenuItemRecord:
        return _i3.MenuItemRecord.t;
      case _i6.OrderRecord:
        return _i6.OrderRecord.t;
      case _i8.OrderItemRecord:
        return _i8.OrderItemRecord.t;
      case _i15.OrderClaimTokenRecord:
        return _i15.OrderClaimTokenRecord.t;
      case _i16.PointsLedgerEntryRecord:
        return _i16.PointsLedgerEntryRecord.t;
      case _i18.AppUserRecord:
        return _i18.AppUserRecord.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'fidelite';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i2.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
