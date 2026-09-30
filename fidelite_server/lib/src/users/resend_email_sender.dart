import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

/// Sends transactional emails via the [Resend](https://resend.com) API.
///
/// Without a verified sending domain, Resend runs in sandbox mode: it only
/// accepts sends *to* the address the Resend account itself was created
/// with, from the shared `onboarding@resend.dev` address. Once A&A has a
/// domain, verify it in Resend (Domains -> Add Domain, add the DNS records
/// it gives you) and update [_fromAddress] to something on that domain --
/// no other code changes needed.
class ResendEmailSender {
  const ResendEmailSender();

  static const _fromAddress = 'Fidélité <onboarding@resend.dev>';
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
