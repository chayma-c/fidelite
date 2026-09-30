import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/local_cache.dart';

const _ticketNumberCacheKey = 'ticketNumber.lastKnown';

/// Tracks the last known ticket number on-device so an order placed with no
/// connection still gets a real, printable number immediately instead of a
/// "pending" placeholder -- staff need to hand a customer a ticket number
/// the moment an order is taken, connection or not.
///
/// This assumes one order-taking device active at a time. If two devices
/// somehow went offline simultaneously, they could independently reserve
/// the same number for different orders; [OrderEndpoint.submitOrder]'s
/// `requestedTicketNumber` handles that at sync time by falling back to a
/// fresh atomic number instead of ever recording two orders under the same
/// one -- so it degrades safely rather than corrupting anything, it just
/// means that, in that rare case, the number already on the paper ticket
/// and the number the server ends up recording could differ.
class LocalTicketNumberTracker {
  const LocalTicketNumberTracker(this._cache);

  final LocalCache _cache;

  /// The next number to use for an order being placed *right now*, purely
  /// from local state -- for the offline path, where there's no server to
  /// ask. Also records it as the new "last known" so a second offline
  /// order placed right after correctly continues from it.
  Future<int> reserveNext() async {
    final last = await _readLastKnown();
    final today = _dayKey(DateTime.now());
    final base = (last != null && last.day == today) ? last.ticketNumber : 0;
    final next = (base % 100) + 1;
    await _writeLastKnown(next, today);
    return next;
  }

  /// Learned a real, server-assigned number -- from an online submission,
  /// or a since-synced queued one. Keeps local state from ever falling
  /// behind what the server actually has, including for orders this
  /// device didn't assign a number to itself.
  Future<void> recordKnown(int ticketNumber, DateTime createdAt) async {
    final day = _dayKey(createdAt.toLocal());
    final last = await _readLastKnown();
    if (last != null && last.day == day && last.ticketNumber >= ticketNumber) {
      return;
    }
    await _writeLastKnown(ticketNumber, day);
  }

  Future<_LastKnownTicket?> _readLastKnown() async {
    final raw = await _cache.readValue<Map<String, dynamic>>(
      _ticketNumberCacheKey,
      (json) => json as Map<String, dynamic>,
    );
    if (raw == null) return null;
    return _LastKnownTicket(
      day: raw['day'] as String,
      ticketNumber: raw['ticketNumber'] as int,
    );
  }

  Future<void> _writeLastKnown(int ticketNumber, String day) async {
    await _cache.writeValue(_ticketNumberCacheKey, {
      'day': day,
      'ticketNumber': ticketNumber,
    });
  }

  String _dayKey(DateTime dt) =>
      '${dt.year.toString().padLeft(4, '0')}-'
      '${dt.month.toString().padLeft(2, '0')}-'
      '${dt.day.toString().padLeft(2, '0')}';
}

class _LastKnownTicket {
  const _LastKnownTicket({required this.day, required this.ticketNumber});

  final String day;
  final int ticketNumber;
}

final localTicketNumberTrackerProvider = Provider<LocalTicketNumberTracker>((
  ref,
) {
  return LocalTicketNumberTracker(ref.watch(localCacheProvider));
});
