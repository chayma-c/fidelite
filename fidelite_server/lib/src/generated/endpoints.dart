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
import '../orders/order_endpoint.dart' as _i3;
import '../points/points_claim_endpoint.dart' as _i4;
import '../points/wallet_endpoint.dart' as _i5;
import '../users/user_endpoint.dart' as _i6;
import 'package:fidelite_server/src/generated/orders/order_item_input.dart'
    as _i7;

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
      'order': _i3.OrderEndpoint()
        ..initialize(
          server,
          'order',
          null,
        ),
      'pointsClaim': _i4.PointsClaimEndpoint()
        ..initialize(
          server,
          'pointsClaim',
          null,
        ),
      'wallet': _i5.WalletEndpoint()
        ..initialize(
          server,
          'wallet',
          null,
        ),
      'user': _i6.UserEndpoint()
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
    connectors['order'] = _i1.EndpointConnector(
      name: 'order',
      endpoint: endpoints['order']!,
      methodConnectors: {
        'submitOrder': _i1.MethodConnector(
          name: 'submitOrder',
          params: {
            'items': _i1.ParameterDescription(
              name: 'items',
              type: _i1.getType<List<_i7.OrderItemInput>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i3.OrderEndpoint).submitOrder(
                session,
                params['items'],
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
                  (endpoints['order'] as _i3.OrderEndpoint).getOrderHistory(
                    session,
                    limit: params['limit'],
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
              ) async => (endpoints['pointsClaim'] as _i4.PointsClaimEndpoint)
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
              ) async => (endpoints['wallet'] as _i5.WalletEndpoint).getBalance(
                session,
              ),
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
                  (endpoints['wallet'] as _i5.WalletEndpoint).getPointsHistory(
                    session,
                    limit: params['limit'],
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
              ) async => (endpoints['user'] as _i6.UserEndpoint).getMe(session),
        ),
      },
    );
  }
}
