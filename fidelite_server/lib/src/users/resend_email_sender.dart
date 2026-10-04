import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

/// Sends transactional emails via the [Resend](https://resend.com) API.
///
/// `mail.sansalearning.com` is verified in Resend (SPF + DKIM), so this
/// sends for real to any recipient -- no more sandbox restriction to just
/// the account owner's own address.
class ResendEmailSender {
  const ResendEmailSender();

  static const _fromAddress = 'Fidélité <noreply@mail.sansalearning.com>';
  static const _endpoint = 'https://api.resend.com/emails';

  Future<void> send(
    Session session, {
    required String to,
    required String subject,
    required String html,
  }) async {
    final apiKey = session.passwords['resendApiKey'];
    if (apiKey == null || apiKey.isEmpty) {
      throw StateError('Missing "resendApiKey" in config/passwords.yaml.');
    }

    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'from': _fromAddress,
        'to': [to],
        'subject': subject,
        'html': html,
      }),
    );

    if (response.statusCode >= 400) {
      throw StateError(
        'Resend request failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
