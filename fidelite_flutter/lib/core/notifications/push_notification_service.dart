import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../serverpod/serverpod_client_provider.dart';

/// Registers this device for FCM push notifications once staff signs in --
/// Android only. firebase_core has no Windows desktop support, and there's
/// no Firebase web app registered (this whole app's web target is for local
/// Chrome testing, not something Firebase needs to know about); the only
/// real need for a push is a staff tablet catching a new online order while
/// the app is closed, which is Android hardware.
///
/// Deliberately doesn't register a foreground message handler: when the app
/// is actually open, OnlineOrdersController's 15s poll + the app bar badge
/// already surfaces a new order -- the push here exists purely to wake up a
/// closed/backgrounded app, which Android's FCM SDK handles automatically
/// for a "notification"-type payload (see FcmNotificationSender) without
/// any Dart code needing to run.
class PushNotificationService {
  const PushNotificationService(this._ref);

  final Ref _ref;

  static bool get isSupported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  Future<void> registerForStaffDevice() async {
    if (!isSupported) return;

    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) return;

    final token = await messaging.getToken();
    if (token != null) {
      await _registerWithServer(token);
    }

    // FCM can rotate the token at any time (reinstall, token expiry, ...);
    // re-send it so the server's copy never goes stale.
    messaging.onTokenRefresh.listen(_registerWithServer);
  }

  Future<void> _registerWithServer(String token) =>
      _ref.read(serverpodClientProvider).deviceToken.registerToken(token);
}

final pushNotificationServiceProvider = Provider<PushNotificationService>(
  (ref) => PushNotificationService(ref),
);
