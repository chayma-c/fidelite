import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

const _fcmScopes = ['https://www.googleapis.com/auth/firebase.messaging'];

/// Sends push notifications via FCM's HTTP v1 API, authenticated with a
/// Firebase service-account key -- FCM's current API needs a full OAuth2
/// service-account exchange (not a simple API key like Resend's), which is
/// exactly what `googleapis_auth` exists to handle rather than hand-rolling
/// JWT signing for security-sensitive code like this.
class FcmNotificationSender {
  const FcmNotificationSender();

  /// Sends [title]/[body] to every currently-registered staff device.
  /// Deliberately doesn't throw on an individual device's send failing
  /// (an expired/rotated token on one device shouldn't stop the others
  /// from being notified) -- callers should still wrap the call itself so
  /// a total failure here (e.g. missing/bad credentials) never fails
  /// whatever actually mattered, like placing an order.
  Future<void> sendToAllStaffDevices(
    Session session, {
    required String title,
    required String body,
    Map<String, String> data = const {},
  }) async {
    final serviceAccountJson = session.passwords['fcmServiceAccountJson'];
    if (serviceAccountJson == null || serviceAccountJson.isEmpty) {
      throw StateError(
        'Missing "fcmServiceAccountJson" in config/passwords.yaml.',
      );
    }

    final projectId =
        (jsonDecode(serviceAccountJson) as Map<String, dynamic>)['project_id']
            as String;
    final credentials = auth.ServiceAccountCredentials.fromJson(
      serviceAccountJson,
    );

    final tokens = await DeviceTokenRecord.db.find(session);
    if (tokens.isEmpty) return;

    final authClient = await auth.clientViaServiceAccount(
      credentials,
      _fcmScopes,
    );
    try {
      for (final token in tokens) {
        try {
          final response = await authClient.post(
            Uri.parse(
              'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
            ),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'message': {
                'token': token.fcmToken,
                'notification': {'title': title, 'body': body},
                'data': data,
              },
            }),
          );
          if (response.statusCode >= 400) {
            session.log(
              'FCM send failed for device token id=${token.id} '
              '(${response.statusCode}): ${response.body}',
              level: LogLevel.warning,
            );
          }
        } catch (e) {
          session.log(
            'FCM send threw for device token id=${token.id}: $e',
            level: LogLevel.warning,
          );
        }
      }
    } finally {
      authClient.close();
    }
  }
}
