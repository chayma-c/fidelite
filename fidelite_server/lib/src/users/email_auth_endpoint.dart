import 'package:serverpod_auth_idp_server/providers/email.dart';

/// Exposes serverpod_auth_idp's email/password login, registration, and
/// password-reset flow to the client. All business logic lives in the
/// module (`EmailIdpBaseEndpoint`) -- this class only needs to exist so the
/// endpoint is registered and reachable, per the module's own
/// "subclass this in your own application" contract.
class EmailAuthEndpoint extends EmailIdpBaseEndpoint {}
