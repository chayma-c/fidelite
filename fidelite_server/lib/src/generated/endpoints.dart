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
import '../menu/menu_endpoint.dart' as _i2;
import '../menu/menu_management_endpoint.dart' as _i3;
import '../notifications/device_token_endpoint.dart' as _i4;
import '../orders/online_order_endpoint.dart' as _i5;
import '../orders/online_order_management_endpoint.dart' as _i6;
import '../orders/order_endpoint.dart' as _i7;
import '../points/points_claim_endpoint.dart' as _i8;
import '../points/wallet_endpoint.dart' as _i9;
import '../redemption/redemption_endpoint.dart' as _i10;
import '../rewards/rewards_endpoint.dart' as _i11;
import '../shop/online_order_settings_endpoint.dart' as _i12;
import '../shop/shop_status_endpoint.dart' as _i13;
import '../shop/shop_status_management_endpoint.dart' as _i14;
import '../users/email_auth_endpoint.dart' as _i15;
import '../users/jwt_tokens_endpoint.dart' as _i16;
import '../users/user_endpoint.dart' as _i17;
import 'package:fidelite_server/src/generated/orders/order_item_input.dart'
    as _i18;
import 'package:fidelite_server/src/generated/shop/shop_open_status.dart'
    as _i19;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i20;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i21;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'menu': _i2.MenuEndpoint()
        ..initialize(
          server,
          'menu',
          null,
        ),
      'menuManagement': _i3.MenuManagementEndpoint()
        ..initialize(
          server,
          'menuManagement',
          null,
        ),
      'deviceToken': _i4.DeviceTokenEndpoint()
        ..initialize(
          server,
          'deviceToken',
          null,
        ),
      'onlineOrder': _i5.OnlineOrderEndpoint()
        ..initialize(
          server,
          'onlineOrder',
          null,
        ),
      'onlineOrderManagement': _i6.OnlineOrderManagementEndpoint()
        ..initialize(
          server,
          'onlineOrderManagement',
          null,
        ),
      'order': _i7.OrderEndpoint()
        ..initialize(
          server,
          'order',
          null,
        ),
      'pointsClaim': _i8.PointsClaimEndpoint()
        ..initialize(
          server,
          'pointsClaim',
          null,
        ),
      'wallet': _i9.WalletEndpoint()
        ..initialize(
          server,
          'wallet',
          null,
        ),
      'redemption': _i10.RedemptionEndpoint()
        ..initialize(
          server,
          'redemption',
          null,
        ),
      'rewards': _i11.RewardsEndpoint()
        ..initialize(
          server,
          'rewards',
          null,
        ),
      'onlineOrderSettings': _i12.OnlineOrderSettingsEndpoint()
        ..initialize(
          server,
          'onlineOrderSettings',
          null,
        ),
      'shopStatus': _i13.ShopStatusEndpoint()
        ..initialize(
          server,
          'shopStatus',
          null,
        ),
      'shopStatusManagement': _i14.ShopStatusManagementEndpoint()
        ..initialize(
          server,
          'shopStatusManagement',
          null,
        ),
      'emailAuth': _i15.EmailAuthEndpoint()
        ..initialize(
          server,
          'emailAuth',
          null,
        ),
      'jwtTokens': _i16.JwtTokensEndpoint()
        ..initialize(
          server,
          'jwtTokens',
          null,
        ),
      'user': _i17.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['menu'] = _i1.EndpointConnector(
      name: 'menu',
      endpoint: endpoints['menu']!,
      methodConnectors: {
        'getMenu': _i1.MethodConnector(
          name: 'getMenu',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['menu'] as _i2.MenuEndpoint).getMenu(session),
        ),
      },
    );
    connectors['menuManagement'] = _i1.EndpointConnector(
      name: 'menuManagement',
      endpoint: endpoints['menuManagement']!,
      methodConnectors: {
        'listAllMenuItems': _i1.MethodConnector(
          name: 'listAllMenuItems',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['menuManagement'] as _i3.MenuManagementEndpoint)
                      .listAllMenuItems(session),
        ),
        'getCategories': _i1.MethodConnector(
          name: 'getCategories',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['menuManagement'] as _i3.MenuManagementEndpoint)
                      .getCategories(session),
        ),
        'createMenuItem': _i1.MethodConnector(
          name: 'createMenuItem',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'priceMillimes': _i1.ParameterDescription(
              name: 'priceMillimes',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['menuManagement'] as _i3.MenuManagementEndpoint)
                      .createMenuItem(
                        session,
                        name: params['name'],
                        description: params['description'],
                        category: params['category'],
                        priceMillimes: params['priceMillimes'],
                      ),
        ),
        'updateMenuItem': _i1.MethodConnector(
          name: 'updateMenuItem',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'priceMillimes': _i1.ParameterDescription(
              name: 'priceMillimes',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['menuManagement'] as _i3.MenuManagementEndpoint)
                      .updateMenuItem(
                        session,
                        id: params['id'],
                        name: params['name'],
                        description: params['description'],
                        category: params['category'],
                        priceMillimes: params['priceMillimes'],
                      ),
        ),
        'setMenuItemActive': _i1.MethodConnector(
          name: 'setMenuItemActive',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['menuManagement'] as _i3.MenuManagementEndpoint)
                      .setMenuItemActive(
                        session,
                        id: params['id'],
                        isActive: params['isActive'],
                      ),
        ),
      },
    );
    connectors['deviceToken'] = _i1.EndpointConnector(
      name: 'deviceToken',
      endpoint: endpoints['deviceToken']!,
      methodConnectors: {
        'registerToken': _i1.MethodConnector(
          name: 'registerToken',
          params: {
            'fcmToken': _i1.ParameterDescription(
              name: 'fcmToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['deviceToken'] as _i4.DeviceTokenEndpoint)
                  .registerToken(
                    session,
                    params['fcmToken'],
                  ),
        ),
      },
    );
    connectors['onlineOrder'] = _i1.EndpointConnector(
      name: 'onlineOrder',
      endpoint: endpoints['onlineOrder']!,
      methodConnectors: {
        'placeOrder': _i1.MethodConnector(
          name: 'placeOrder',
          params: {
            'items': _i1.ParameterDescription(
              name: 'items',
              type: _i1.getType<List<_i18.OrderItemInput>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['onlineOrder'] as _i5.OnlineOrderEndpoint)
                  .placeOrder(
                    session,
                    params['items'],
                  ),
        ),
      },
    );
    connectors['onlineOrderManagement'] = _i1.EndpointConnector(
      name: 'onlineOrderManagement',
      endpoint: endpoints['onlineOrderManagement']!,
      methodConnectors: {
        'listUnhandled': _i1.MethodConnector(
          name: 'listUnhandled',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onlineOrderManagement']
                          as _i6.OnlineOrderManagementEndpoint)
                      .listUnhandled(session),
        ),
        'getItemsForOrder': _i1.MethodConnector(
          name: 'getItemsForOrder',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onlineOrderManagement']
                          as _i6.OnlineOrderManagementEndpoint)
                      .getItemsForOrder(
                        session,
                        params['orderId'],
                      ),
        ),
        'markHandled': _i1.MethodConnector(
          name: 'markHandled',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onlineOrderManagement']
                          as _i6.OnlineOrderManagementEndpoint)
                      .markHandled(
                        session,
                        params['orderId'],
                      ),
        ),
      },
    );
    connectors['order'] = _i1.EndpointConnector(
      name: 'order',
      endpoint: endpoints['order']!,
      methodConnectors: {
        'submitOrder': _i1.MethodConnector(
          name: 'submitOrder',
          params: {
            'items': _i1.ParameterDescription(
              name: 'items',
              type: _i1.getType<List<_i18.OrderItemInput>>(),
              nullable: false,
            ),
            'requestedTicketNumber': _i1.ParameterDescription(
              name: 'requestedTicketNumber',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'placedAt': _i1.ParameterDescription(
              name: 'placedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i7.OrderEndpoint).submitOrder(
                session,
                params['items'],
                requestedTicketNumber: params['requestedTicketNumber'],
                placedAt: params['placedAt'],
              ),
        ),
        'getOrderHistory': _i1.MethodConnector(
          name: 'getOrderHistory',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i7.OrderEndpoint).getOrderHistory(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'getOrdersInRange': _i1.MethodConnector(
          name: 'getOrdersInRange',
          params: {
            'start': _i1.ParameterDescription(
              name: 'start',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'end': _i1.ParameterDescription(
              name: 'end',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i7.OrderEndpoint).getOrdersInRange(
                    session,
                    start: params['start'],
                    end: params['end'],
                  ),
        ),
      },
    );
    connectors['pointsClaim'] = _i1.EndpointConnector(
      name: 'pointsClaim',
      endpoint: endpoints['pointsClaim']!,
      methodConnectors: {
        'claimOrderPoints': _i1.MethodConnector(
          name: 'claimOrderPoints',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['pointsClaim'] as _i8.PointsClaimEndpoint)
                  .claimOrderPoints(
                    session,
                    params['orderId'],
                    params['token'],
                  ),
        ),
      },
    );
    connectors['wallet'] = _i1.EndpointConnector(
      name: 'wallet',
      endpoint: endpoints['wallet']!,
      methodConnectors: {
        'getBalance': _i1.MethodConnector(
          name: 'getBalance',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['wallet'] as _i9.WalletEndpoint).getBalance(
                session,
              ),
        ),
        'getWalletToken': _i1.MethodConnector(
          name: 'getWalletToken',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['wallet'] as _i9.WalletEndpoint)
                  .getWalletToken(session),
        ),
        'getPointsHistory': _i1.MethodConnector(
          name: 'getPointsHistory',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['wallet'] as _i9.WalletEndpoint).getPointsHistory(
                    session,
                    limit: params['limit'],
                  ),
        ),
      },
    );
    connectors['redemption'] = _i1.EndpointConnector(
      name: 'redemption',
      endpoint: endpoints['redemption']!,
      methodConnectors: {
        'redeemReward': _i1.MethodConnector(
          name: 'redeemReward',
          params: {
            'walletUserId': _i1.ParameterDescription(
              name: 'walletUserId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'walletToken': _i1.ParameterDescription(
              name: 'walletToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'rewardItemId': _i1.ParameterDescription(
              name: 'rewardItemId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['redemption'] as _i10.RedemptionEndpoint)
                  .redeemReward(
                    session,
                    params['walletUserId'],
                    params['walletToken'],
                    params['rewardItemId'],
                  ),
        ),
      },
    );
    connectors['rewards'] = _i1.EndpointConnector(
      name: 'rewards',
      endpoint: endpoints['rewards']!,
      methodConnectors: {
        'getCatalog': _i1.MethodConnector(
          name: 'getCatalog',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rewards'] as _i11.RewardsEndpoint)
                  .getCatalog(session),
        ),
      },
    );
    connectors['onlineOrderSettings'] = _i1.EndpointConnector(
      name: 'onlineOrderSettings',
      endpoint: endpoints['onlineOrderSettings']!,
      methodConnectors: {
        'getSettings': _i1.MethodConnector(
          name: 'getSettings',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onlineOrderSettings']
                          as _i12.OnlineOrderSettingsEndpoint)
                      .getSettings(session),
        ),
        'setAutoPrint': _i1.MethodConnector(
          name: 'setAutoPrint',
          params: {
            'enabled': _i1.ParameterDescription(
              name: 'enabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onlineOrderSettings']
                          as _i12.OnlineOrderSettingsEndpoint)
                      .setAutoPrint(
                        session,
                        params['enabled'],
                      ),
        ),
      },
    );
    connectors['shopStatus'] = _i1.EndpointConnector(
      name: 'shopStatus',
      endpoint: endpoints['shopStatus']!,
      methodConnectors: {
        'getStatus': _i1.MethodConnector(
          name: 'getStatus',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['shopStatus'] as _i13.ShopStatusEndpoint)
                  .getStatus(session),
        ),
      },
    );
    connectors['shopStatusManagement'] = _i1.EndpointConnector(
      name: 'shopStatusManagement',
      endpoint: endpoints['shopStatusManagement']!,
      methodConnectors: {
        'setStatus': _i1.MethodConnector(
          name: 'setStatus',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i19.ShopOpenStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['shopStatusManagement']
                          as _i14.ShopStatusManagementEndpoint)
                      .setStatus(
                        session,
                        params['status'],
                      ),
        ),
      },
    );
    connectors['emailAuth'] = _i1.EndpointConnector(
      name: 'emailAuth',
      endpoint: endpoints['emailAuth']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailAuth'] as _i15.EmailAuthEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailAuth'] as _i15.EmailAuthEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailAuth'] as _i15.EmailAuthEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailAuth'] as _i15.EmailAuthEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailAuth'] as _i15.EmailAuthEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailAuth'] as _i15.EmailAuthEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailAuth'] as _i15.EmailAuthEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailAuth'] as _i15.EmailAuthEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtTokens'] = _i1.EndpointConnector(
      name: 'jwtTokens',
      endpoint: endpoints['jwtTokens']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtTokens'] as _i16.JwtTokensEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'getMe': _i1.MethodConnector(
          name: 'getMe',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i17.UserEndpoint).getMe(session),
        ),
      },
    );
    modules['serverpod_auth_core'] = _i20.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i21.Endpoints()
      ..initializeEndpoints(server);
  }
}
