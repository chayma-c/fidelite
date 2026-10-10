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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i3;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i4;
import 'menu/exceptions/menu_item_validation_exception.dart' as _i5;
import 'menu/exceptions/menu_item_validation_exception_reason.dart' as _i6;
import 'menu/menu_item.dart' as _i7;
import 'notifications/device_token.dart' as _i8;
import 'orders/exceptions/invalid_order_exception.dart' as _i9;
import 'orders/exceptions/invalid_order_exception_reason.dart' as _i10;
import 'orders/online_order_confirmation.dart' as _i11;
import 'orders/order.dart' as _i12;
import 'orders/order_confirmation.dart' as _i13;
import 'orders/order_fulfillment_method.dart' as _i14;
import 'orders/order_item.dart' as _i15;
import 'orders/order_item_input.dart' as _i16;
import 'orders/order_payment_method.dart' as _i17;
import 'orders/order_status.dart' as _i18;
import 'points/claim_result.dart' as _i19;
import 'points/claim_token_status.dart' as _i20;
import 'points/exceptions/order_claim_exception.dart' as _i21;
import 'points/exceptions/order_claim_exception_reason.dart' as _i22;
import 'points/order_claim_token.dart' as _i23;
import 'points/points_ledger_entry.dart' as _i24;
import 'points/points_ledger_reason.dart' as _i25;
import 'points/wallet_token.dart' as _i26;
import 'points/wallet_token_response.dart' as _i27;
import 'redemption/exceptions/redemption_exception.dart' as _i28;
import 'redemption/exceptions/redemption_exception_reason.dart' as _i29;
import 'redemption/redemption.dart' as _i30;
import 'redemption/redemption_result.dart' as _i31;
import 'redemption/redemption_status.dart' as _i32;
import 'rewards/reward_item.dart' as _i33;
import 'shop/online_order_settings.dart' as _i34;
import 'shop/shop_open_status.dart' as _i35;
import 'shop/shop_status.dart' as _i36;
import 'users/app_user.dart' as _i37;
import 'package:fidelite_server/src/generated/menu/menu_item.dart' as _i38;
import 'package:fidelite_server/src/generated/orders/order_item_input.dart'
    as _i39;
import 'package:fidelite_server/src/generated/orders/order.dart' as _i40;
import 'package:fidelite_server/src/generated/orders/order_item.dart' as _i41;
import 'package:fidelite_server/src/generated/points/points_ledger_entry.dart'
    as _i42;
import 'package:fidelite_server/src/generated/rewards/reward_item.dart' as _i43;
export 'menu/exceptions/menu_item_validation_exception.dart';
export 'menu/exceptions/menu_item_validation_exception_reason.dart';
export 'menu/menu_item.dart';
export 'notifications/device_token.dart';
export 'orders/exceptions/invalid_order_exception.dart';
export 'orders/exceptions/invalid_order_exception_reason.dart';
export 'orders/online_order_confirmation.dart';
export 'orders/order.dart';
export 'orders/order_confirmation.dart';
export 'orders/order_fulfillment_method.dart';
export 'orders/order_item.dart';
export 'orders/order_item_input.dart';
export 'orders/order_payment_method.dart';
export 'orders/order_status.dart';
export 'points/claim_result.dart';
export 'points/claim_token_status.dart';
export 'points/exceptions/order_claim_exception.dart';
export 'points/exceptions/order_claim_exception_reason.dart';
export 'points/order_claim_token.dart';
export 'points/points_ledger_entry.dart';
export 'points/points_ledger_reason.dart';
export 'points/wallet_token.dart';
export 'points/wallet_token_response.dart';
export 'redemption/exceptions/redemption_exception.dart';
export 'redemption/exceptions/redemption_exception_reason.dart';
export 'redemption/redemption.dart';
export 'redemption/redemption_result.dart';
export 'redemption/redemption_status.dart';
export 'rewards/reward_item.dart';
export 'shop/online_order_settings.dart';
export 'shop/shop_open_status.dart';
export 'shop/shop_status.dart';
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
      name: 'device_token',
      dartName: 'DeviceTokenRecord',
      schema: 'public',
      module: 'fidelite',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'device_token_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'fcmToken',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'device_token_fk_0',
          columns: ['userId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'device_token_pkey',
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
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _i2.ColumnDefinition(
          name: 'customerUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _i2.ColumnDefinition(
          name: 'handledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OrderStatus',
          columnDefault: '\'confirmed\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'ticketNumber',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
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
          name: 'fulfillmentMethod',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:OrderFulfillmentMethod?',
        ),
        _i2.ColumnDefinition(
          name: 'paymentMethod',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:OrderPaymentMethod?',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryFeeMillimes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryPhone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
        _i2.ForeignKeyDefinition(
          constraintName: 'fidelite_order_fk_1',
          columns: ['customerUserId'],
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
      name: 'online_order_settings',
      dartName: 'OnlineOrderSettingsRecord',
      schema: 'public',
      module: 'fidelite',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'online_order_settings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'autoPrintEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
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
          indexName: 'online_order_settings_pkey',
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
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'relatedRedemptionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
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
          columns: ['relatedRedemptionId'],
          referenceTable: 'redemption',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'points_ledger_entry_fk_3',
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
    _i2.TableDefinition(
      name: 'redemption',
      dartName: 'RedemptionRecord',
      schema: 'public',
      module: 'fidelite',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'redemption_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'customerUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'staffUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'rewardItemId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'rewardNameSnapshot',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'pointsCostSnapshot',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RedemptionStatus',
          columnDefault: '\'completed\'::text',
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
          constraintName: 'redemption_fk_0',
          columns: ['customerUserId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'redemption_fk_1',
          columns: ['staffUserId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'redemption_fk_2',
          columns: ['rewardItemId'],
          referenceTable: 'reward_item',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'redemption_pkey',
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
      name: 'reward_item',
      dartName: 'RewardItemRecord',
      schema: 'public',
      module: 'fidelite',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'reward_item_id_seq\'::regclass)',
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
          name: 'pointsCost',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'stock',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
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
          indexName: 'reward_item_pkey',
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
      name: 'shop_status',
      dartName: 'ShopStatusRecord',
      schema: 'public',
      module: 'fidelite',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'shop_status_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ShopOpenStatus',
          columnDefault: '\'open\'::text',
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
          indexName: 'shop_status_pkey',
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
      name: 'wallet_token',
      dartName: 'WalletTokenRecord',
      schema: 'public',
      module: 'fidelite',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'wallet_token_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'tokenHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
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
          name: 'consumedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'consumedByRedemptionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'wallet_token_fk_0',
          columns: ['userId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'wallet_token_fk_1',
          columns: ['consumedByRedemptionId'],
          referenceTable: 'redemption',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'wallet_token_pkey',
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
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
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

    if (t == _i5.MenuItemValidationException) {
      return _i5.MenuItemValidationException.fromJson(data) as T;
    }
    if (t == _i6.MenuItemValidationExceptionReason) {
      return _i6.MenuItemValidationExceptionReason.fromJson(data) as T;
    }
    if (t == _i7.MenuItemRecord) {
      return _i7.MenuItemRecord.fromJson(data) as T;
    }
    if (t == _i8.DeviceTokenRecord) {
      return _i8.DeviceTokenRecord.fromJson(data) as T;
    }
    if (t == _i9.InvalidOrderException) {
      return _i9.InvalidOrderException.fromJson(data) as T;
    }
    if (t == _i10.InvalidOrderExceptionReason) {
      return _i10.InvalidOrderExceptionReason.fromJson(data) as T;
    }
    if (t == _i11.OnlineOrderConfirmation) {
      return _i11.OnlineOrderConfirmation.fromJson(data) as T;
    }
    if (t == _i12.OrderRecord) {
      return _i12.OrderRecord.fromJson(data) as T;
    }
    if (t == _i13.OrderConfirmation) {
      return _i13.OrderConfirmation.fromJson(data) as T;
    }
    if (t == _i14.OrderFulfillmentMethod) {
      return _i14.OrderFulfillmentMethod.fromJson(data) as T;
    }
    if (t == _i15.OrderItemRecord) {
      return _i15.OrderItemRecord.fromJson(data) as T;
    }
    if (t == _i16.OrderItemInput) {
      return _i16.OrderItemInput.fromJson(data) as T;
    }
    if (t == _i17.OrderPaymentMethod) {
      return _i17.OrderPaymentMethod.fromJson(data) as T;
    }
    if (t == _i18.OrderStatus) {
      return _i18.OrderStatus.fromJson(data) as T;
    }
    if (t == _i19.ClaimResult) {
      return _i19.ClaimResult.fromJson(data) as T;
    }
    if (t == _i20.ClaimTokenStatus) {
      return _i20.ClaimTokenStatus.fromJson(data) as T;
    }
    if (t == _i21.OrderClaimException) {
      return _i21.OrderClaimException.fromJson(data) as T;
    }
    if (t == _i22.OrderClaimExceptionReason) {
      return _i22.OrderClaimExceptionReason.fromJson(data) as T;
    }
    if (t == _i23.OrderClaimTokenRecord) {
      return _i23.OrderClaimTokenRecord.fromJson(data) as T;
    }
    if (t == _i24.PointsLedgerEntryRecord) {
      return _i24.PointsLedgerEntryRecord.fromJson(data) as T;
    }
    if (t == _i25.PointsLedgerReason) {
      return _i25.PointsLedgerReason.fromJson(data) as T;
    }
    if (t == _i26.WalletTokenRecord) {
      return _i26.WalletTokenRecord.fromJson(data) as T;
    }
    if (t == _i27.WalletTokenResponse) {
      return _i27.WalletTokenResponse.fromJson(data) as T;
    }
    if (t == _i28.RedemptionException) {
      return _i28.RedemptionException.fromJson(data) as T;
    }
    if (t == _i29.RedemptionExceptionReason) {
      return _i29.RedemptionExceptionReason.fromJson(data) as T;
    }
    if (t == _i30.RedemptionRecord) {
      return _i30.RedemptionRecord.fromJson(data) as T;
    }
    if (t == _i31.RedemptionResult) {
      return _i31.RedemptionResult.fromJson(data) as T;
    }
    if (t == _i32.RedemptionStatus) {
      return _i32.RedemptionStatus.fromJson(data) as T;
    }
    if (t == _i33.RewardItemRecord) {
      return _i33.RewardItemRecord.fromJson(data) as T;
    }
    if (t == _i34.OnlineOrderSettingsRecord) {
      return _i34.OnlineOrderSettingsRecord.fromJson(data) as T;
    }
    if (t == _i35.ShopOpenStatus) {
      return _i35.ShopOpenStatus.fromJson(data) as T;
    }
    if (t == _i36.ShopStatusRecord) {
      return _i36.ShopStatusRecord.fromJson(data) as T;
    }
    if (t == _i37.AppUserRecord) {
      return _i37.AppUserRecord.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.MenuItemValidationException?>()) {
      return (data != null
              ? _i5.MenuItemValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i6.MenuItemValidationExceptionReason?>()) {
      return (data != null
              ? _i6.MenuItemValidationExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i7.MenuItemRecord?>()) {
      return (data != null ? _i7.MenuItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.DeviceTokenRecord?>()) {
      return (data != null ? _i8.DeviceTokenRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.InvalidOrderException?>()) {
      return (data != null ? _i9.InvalidOrderException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.InvalidOrderExceptionReason?>()) {
      return (data != null
              ? _i10.InvalidOrderExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i11.OnlineOrderConfirmation?>()) {
      return (data != null ? _i11.OnlineOrderConfirmation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.OrderRecord?>()) {
      return (data != null ? _i12.OrderRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.OrderConfirmation?>()) {
      return (data != null ? _i13.OrderConfirmation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.OrderFulfillmentMethod?>()) {
      return (data != null ? _i14.OrderFulfillmentMethod.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.OrderItemRecord?>()) {
      return (data != null ? _i15.OrderItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.OrderItemInput?>()) {
      return (data != null ? _i16.OrderItemInput.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.OrderPaymentMethod?>()) {
      return (data != null ? _i17.OrderPaymentMethod.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.OrderStatus?>()) {
      return (data != null ? _i18.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.ClaimResult?>()) {
      return (data != null ? _i19.ClaimResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.ClaimTokenStatus?>()) {
      return (data != null ? _i20.ClaimTokenStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.OrderClaimException?>()) {
      return (data != null ? _i21.OrderClaimException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.OrderClaimExceptionReason?>()) {
      return (data != null
              ? _i22.OrderClaimExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i23.OrderClaimTokenRecord?>()) {
      return (data != null ? _i23.OrderClaimTokenRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.PointsLedgerEntryRecord?>()) {
      return (data != null ? _i24.PointsLedgerEntryRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.PointsLedgerReason?>()) {
      return (data != null ? _i25.PointsLedgerReason.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.WalletTokenRecord?>()) {
      return (data != null ? _i26.WalletTokenRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.WalletTokenResponse?>()) {
      return (data != null ? _i27.WalletTokenResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.RedemptionException?>()) {
      return (data != null ? _i28.RedemptionException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.RedemptionExceptionReason?>()) {
      return (data != null
              ? _i29.RedemptionExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i30.RedemptionRecord?>()) {
      return (data != null ? _i30.RedemptionRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.RedemptionResult?>()) {
      return (data != null ? _i31.RedemptionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.RedemptionStatus?>()) {
      return (data != null ? _i32.RedemptionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.RewardItemRecord?>()) {
      return (data != null ? _i33.RewardItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.OnlineOrderSettingsRecord?>()) {
      return (data != null
              ? _i34.OnlineOrderSettingsRecord.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i35.ShopOpenStatus?>()) {
      return (data != null ? _i35.ShopOpenStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.ShopStatusRecord?>()) {
      return (data != null ? _i36.ShopStatusRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.AppUserRecord?>()) {
      return (data != null ? _i37.AppUserRecord.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i38.MenuItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i38.MenuItemRecord>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i39.OrderItemInput>) {
      return (data as List)
              .map((e) => deserialize<_i39.OrderItemInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i40.OrderRecord>) {
      return (data as List)
              .map((e) => deserialize<_i40.OrderRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i41.OrderItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i41.OrderItemRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i42.PointsLedgerEntryRecord>) {
      return (data as List)
              .map((e) => deserialize<_i42.PointsLedgerEntryRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i43.RewardItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i43.RewardItemRecord>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.MenuItemValidationException => 'MenuItemValidationException',
      _i6.MenuItemValidationExceptionReason =>
        'MenuItemValidationExceptionReason',
      _i7.MenuItemRecord => 'MenuItemRecord',
      _i8.DeviceTokenRecord => 'DeviceTokenRecord',
      _i9.InvalidOrderException => 'InvalidOrderException',
      _i10.InvalidOrderExceptionReason => 'InvalidOrderExceptionReason',
      _i11.OnlineOrderConfirmation => 'OnlineOrderConfirmation',
      _i12.OrderRecord => 'OrderRecord',
      _i13.OrderConfirmation => 'OrderConfirmation',
      _i14.OrderFulfillmentMethod => 'OrderFulfillmentMethod',
      _i15.OrderItemRecord => 'OrderItemRecord',
      _i16.OrderItemInput => 'OrderItemInput',
      _i17.OrderPaymentMethod => 'OrderPaymentMethod',
      _i18.OrderStatus => 'OrderStatus',
      _i19.ClaimResult => 'ClaimResult',
      _i20.ClaimTokenStatus => 'ClaimTokenStatus',
      _i21.OrderClaimException => 'OrderClaimException',
      _i22.OrderClaimExceptionReason => 'OrderClaimExceptionReason',
      _i23.OrderClaimTokenRecord => 'OrderClaimTokenRecord',
      _i24.PointsLedgerEntryRecord => 'PointsLedgerEntryRecord',
      _i25.PointsLedgerReason => 'PointsLedgerReason',
      _i26.WalletTokenRecord => 'WalletTokenRecord',
      _i27.WalletTokenResponse => 'WalletTokenResponse',
      _i28.RedemptionException => 'RedemptionException',
      _i29.RedemptionExceptionReason => 'RedemptionExceptionReason',
      _i30.RedemptionRecord => 'RedemptionRecord',
      _i31.RedemptionResult => 'RedemptionResult',
      _i32.RedemptionStatus => 'RedemptionStatus',
      _i33.RewardItemRecord => 'RewardItemRecord',
      _i34.OnlineOrderSettingsRecord => 'OnlineOrderSettingsRecord',
      _i35.ShopOpenStatus => 'ShopOpenStatus',
      _i36.ShopStatusRecord => 'ShopStatusRecord',
      _i37.AppUserRecord => 'AppUserRecord',
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
      case _i5.MenuItemValidationException():
        return 'MenuItemValidationException';
      case _i6.MenuItemValidationExceptionReason():
        return 'MenuItemValidationExceptionReason';
      case _i7.MenuItemRecord():
        return 'MenuItemRecord';
      case _i8.DeviceTokenRecord():
        return 'DeviceTokenRecord';
      case _i9.InvalidOrderException():
        return 'InvalidOrderException';
      case _i10.InvalidOrderExceptionReason():
        return 'InvalidOrderExceptionReason';
      case _i11.OnlineOrderConfirmation():
        return 'OnlineOrderConfirmation';
      case _i12.OrderRecord():
        return 'OrderRecord';
      case _i13.OrderConfirmation():
        return 'OrderConfirmation';
      case _i14.OrderFulfillmentMethod():
        return 'OrderFulfillmentMethod';
      case _i15.OrderItemRecord():
        return 'OrderItemRecord';
      case _i16.OrderItemInput():
        return 'OrderItemInput';
      case _i17.OrderPaymentMethod():
        return 'OrderPaymentMethod';
      case _i18.OrderStatus():
        return 'OrderStatus';
      case _i19.ClaimResult():
        return 'ClaimResult';
      case _i20.ClaimTokenStatus():
        return 'ClaimTokenStatus';
      case _i21.OrderClaimException():
        return 'OrderClaimException';
      case _i22.OrderClaimExceptionReason():
        return 'OrderClaimExceptionReason';
      case _i23.OrderClaimTokenRecord():
        return 'OrderClaimTokenRecord';
      case _i24.PointsLedgerEntryRecord():
        return 'PointsLedgerEntryRecord';
      case _i25.PointsLedgerReason():
        return 'PointsLedgerReason';
      case _i26.WalletTokenRecord():
        return 'WalletTokenRecord';
      case _i27.WalletTokenResponse():
        return 'WalletTokenResponse';
      case _i28.RedemptionException():
        return 'RedemptionException';
      case _i29.RedemptionExceptionReason():
        return 'RedemptionExceptionReason';
      case _i30.RedemptionRecord():
        return 'RedemptionRecord';
      case _i31.RedemptionResult():
        return 'RedemptionResult';
      case _i32.RedemptionStatus():
        return 'RedemptionStatus';
      case _i33.RewardItemRecord():
        return 'RewardItemRecord';
      case _i34.OnlineOrderSettingsRecord():
        return 'OnlineOrderSettingsRecord';
      case _i35.ShopOpenStatus():
        return 'ShopOpenStatus';
      case _i36.ShopStatusRecord():
        return 'ShopStatusRecord';
      case _i37.AppUserRecord():
        return 'AppUserRecord';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'MenuItemValidationException') {
      return deserialize<_i5.MenuItemValidationException>(data['data']);
    }
    if (dataClassName == 'MenuItemValidationExceptionReason') {
      return deserialize<_i6.MenuItemValidationExceptionReason>(data['data']);
    }
    if (dataClassName == 'MenuItemRecord') {
      return deserialize<_i7.MenuItemRecord>(data['data']);
    }
    if (dataClassName == 'DeviceTokenRecord') {
      return deserialize<_i8.DeviceTokenRecord>(data['data']);
    }
    if (dataClassName == 'InvalidOrderException') {
      return deserialize<_i9.InvalidOrderException>(data['data']);
    }
    if (dataClassName == 'InvalidOrderExceptionReason') {
      return deserialize<_i10.InvalidOrderExceptionReason>(data['data']);
    }
    if (dataClassName == 'OnlineOrderConfirmation') {
      return deserialize<_i11.OnlineOrderConfirmation>(data['data']);
    }
    if (dataClassName == 'OrderRecord') {
      return deserialize<_i12.OrderRecord>(data['data']);
    }
    if (dataClassName == 'OrderConfirmation') {
      return deserialize<_i13.OrderConfirmation>(data['data']);
    }
    if (dataClassName == 'OrderFulfillmentMethod') {
      return deserialize<_i14.OrderFulfillmentMethod>(data['data']);
    }
    if (dataClassName == 'OrderItemRecord') {
      return deserialize<_i15.OrderItemRecord>(data['data']);
    }
    if (dataClassName == 'OrderItemInput') {
      return deserialize<_i16.OrderItemInput>(data['data']);
    }
    if (dataClassName == 'OrderPaymentMethod') {
      return deserialize<_i17.OrderPaymentMethod>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i18.OrderStatus>(data['data']);
    }
    if (dataClassName == 'ClaimResult') {
      return deserialize<_i19.ClaimResult>(data['data']);
    }
    if (dataClassName == 'ClaimTokenStatus') {
      return deserialize<_i20.ClaimTokenStatus>(data['data']);
    }
    if (dataClassName == 'OrderClaimException') {
      return deserialize<_i21.OrderClaimException>(data['data']);
    }
    if (dataClassName == 'OrderClaimExceptionReason') {
      return deserialize<_i22.OrderClaimExceptionReason>(data['data']);
    }
    if (dataClassName == 'OrderClaimTokenRecord') {
      return deserialize<_i23.OrderClaimTokenRecord>(data['data']);
    }
    if (dataClassName == 'PointsLedgerEntryRecord') {
      return deserialize<_i24.PointsLedgerEntryRecord>(data['data']);
    }
    if (dataClassName == 'PointsLedgerReason') {
      return deserialize<_i25.PointsLedgerReason>(data['data']);
    }
    if (dataClassName == 'WalletTokenRecord') {
      return deserialize<_i26.WalletTokenRecord>(data['data']);
    }
    if (dataClassName == 'WalletTokenResponse') {
      return deserialize<_i27.WalletTokenResponse>(data['data']);
    }
    if (dataClassName == 'RedemptionException') {
      return deserialize<_i28.RedemptionException>(data['data']);
    }
    if (dataClassName == 'RedemptionExceptionReason') {
      return deserialize<_i29.RedemptionExceptionReason>(data['data']);
    }
    if (dataClassName == 'RedemptionRecord') {
      return deserialize<_i30.RedemptionRecord>(data['data']);
    }
    if (dataClassName == 'RedemptionResult') {
      return deserialize<_i31.RedemptionResult>(data['data']);
    }
    if (dataClassName == 'RedemptionStatus') {
      return deserialize<_i32.RedemptionStatus>(data['data']);
    }
    if (dataClassName == 'RewardItemRecord') {
      return deserialize<_i33.RewardItemRecord>(data['data']);
    }
    if (dataClassName == 'OnlineOrderSettingsRecord') {
      return deserialize<_i34.OnlineOrderSettingsRecord>(data['data']);
    }
    if (dataClassName == 'ShopOpenStatus') {
      return deserialize<_i35.ShopOpenStatus>(data['data']);
    }
    if (dataClassName == 'ShopStatusRecord') {
      return deserialize<_i36.ShopStatusRecord>(data['data']);
    }
    if (dataClassName == 'AppUserRecord') {
      return deserialize<_i37.AppUserRecord>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i7.MenuItemRecord:
        return _i7.MenuItemRecord.t;
      case _i8.DeviceTokenRecord:
        return _i8.DeviceTokenRecord.t;
      case _i12.OrderRecord:
        return _i12.OrderRecord.t;
      case _i15.OrderItemRecord:
        return _i15.OrderItemRecord.t;
      case _i23.OrderClaimTokenRecord:
        return _i23.OrderClaimTokenRecord.t;
      case _i24.PointsLedgerEntryRecord:
        return _i24.PointsLedgerEntryRecord.t;
      case _i26.WalletTokenRecord:
        return _i26.WalletTokenRecord.t;
      case _i30.RedemptionRecord:
        return _i30.RedemptionRecord.t;
      case _i33.RewardItemRecord:
        return _i33.RewardItemRecord.t;
      case _i34.OnlineOrderSettingsRecord:
        return _i34.OnlineOrderSettingsRecord.t;
      case _i36.ShopStatusRecord:
        return _i36.ShopStatusRecord.t;
      case _i37.AppUserRecord:
        return _i37.AppUserRecord.t;
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
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
