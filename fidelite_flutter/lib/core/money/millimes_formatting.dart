/// Formats an integer amount of millimes (1 Tunisian Dinar = 1000 millimes)
/// as e.g. `8.600 DT`, matching the 3-decimal pricing on the physical menu.
/// Kept as a single small extension rather than a general `Money` type --
/// this app only ever prices in TND.
extension MillimesFormatting on int {
  String get asDinars {
    // Dart's `%` returns a non-negative result even for a negative
    // receiver, so working from `abs()` and re-applying the sign is what
    // keeps a negative amount (e.g. a future redemption) from silently
    // losing its minus sign here.
    final isNegative = this < 0;
    final wholeDinars = abs() ~/ 1000;
    final millimesRemainder = (abs() % 1000).toString().padLeft(3, '0');
    return '${isNegative ? '-' : ''}$wholeDinars.$millimesRemainder DT';
  }
}
