import 'package:serverpod_auth_idp_server/core.dart';

/// Exposes serverpod_auth_core's JWT refresh flow to the client. The
/// business logic lives entirely in the module (`RefreshJwtTokensEndpoint`)
/// -- this class only needs to exist so the endpoint is registered and
/// reachable, per the module's own "subclass this" contract. Required for
/// `FlutterAuthSessionManager`'s JWT auth key provider to find a refresh
/// endpoint at all (`client.getEndpointOfType<EndpointRefreshJwtTokens>()`).
class JwtTokensEndpoint extends RefreshJwtTokensEndpoint {}
