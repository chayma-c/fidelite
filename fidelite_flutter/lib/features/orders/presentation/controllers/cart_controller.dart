import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartLine {
  const CartLine({
    required this.menuItem,
    required this.quantity,
    this.removedIngredients = const [],
    this.addedSauces = const [],
    this.specialRequest,
  });

  final MenuItemRecord menuItem;
  final int quantity;

  /// Base ingredients left out ("menghir") -- always empty for a
  /// non-customizable item (see [MenuItemRecord.isCustomizable]) or the
  /// staff counter-order flow, which doesn't offer customization.
  final List<String> removedIngredients;

  /// Optional sauces added -- same customizable-only restriction as
  /// [removedIngredients].
  final List<String> addedSauces;

  final String? specialRequest;

  bool get isCustomized =>
      removedIngredients.isNotEmpty ||
      addedSauces.isNotEmpty ||
      (specialRequest?.isNotEmpty ?? false);

  int get lineTotalMillimes => menuItem.priceMillimes * quantity;

  CartLine copyWith({int? quantity}) => CartLine(
    menuItem: menuItem,
    quantity: quantity ?? this.quantity,
    removedIngredients: removedIngredients,
    addedSauces: addedSauces,
    specialRequest: specialRequest,
  );

  /// Whether [other] represents the exact same customization choice as
  /// this line -- used to decide whether adding [other]'s menu item again
  /// should bump this line's quantity or start a new line (see
  /// CartController.addCustomizedItem).
  bool hasSameCustomizationAs(CartLine other) =>
      menuItem.id == other.menuItem.id &&
      specialRequest == other.specialRequest &&
      listEquals(removedIngredients, other.removedIngredients) &&
      listEquals(addedSauces, other.addedSauces);
}

/// The in-progress order -- staff's counter order and the customer's
/// self-order both build one of these, purely as client-local state until
/// submission confirms it (there's no server concept of a "draft" order).
/// Shared between the two flows since a signed-in user is always exactly
/// one role or the other (see app_router.dart's redirect guard), so there's
/// never a session where both are in use at once -- it's code reuse, not a
/// runtime conflict.
///
/// [setQuantity]/[removeItem] (menu-item-id keyed) are what the staff cart
/// uses, unchanged from before customization existed -- a counter order
/// never produces two lines for the same menu item with different
/// customization, so an id is all it ever needed. [setLineQuantity]/
/// [removeLine]/[replaceLine] (line-instance keyed) are what the
/// customer's customizable cart uses instead, since two of its lines *can*
/// share a menu item with different customization and an id alone can't
/// tell them apart.
class CartController extends Notifier<List<CartLine>> {
  @override
  List<CartLine> build() => [];

  void addItem(MenuItemRecord menuItem) => addCustomizedItem(menuItem);

  /// Adds [menuItem] with the given customization, merging into an
  /// existing line with the exact same menu item and customization
  /// (bumping its quantity) instead of creating a duplicate -- the same
  /// merge-by-identity behavior [addItem] always had, just no longer keyed
  /// on menu item id alone.
  void addCustomizedItem(
    MenuItemRecord menuItem, {
    List<String> removedIngredients = const [],
    List<String> addedSauces = const [],
    String? specialRequest,
  }) {
    final candidate = CartLine(
      menuItem: menuItem,
      quantity: 1,
      removedIngredients: removedIngredients,
      addedSauces: addedSauces,
      specialRequest: specialRequest,
    );
    final index = state.indexWhere(candidate.hasSameCustomizationAs);
    if (index == -1) {
      state = [...state, candidate];
      return;
    }
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) state[i].copyWith(quantity: state[i].quantity + 1) else state[i],
    ];
  }

  void setQuantity(int menuItemId, int quantity) {
    if (quantity <= 0) {
      state = state.where((line) => line.menuItem.id != menuItemId).toList();
      return;
    }
    state = [
      for (final line in state)
        if (line.menuItem.id == menuItemId)
          line.copyWith(quantity: quantity)
        else
          line,
    ];
  }

  void removeItem(int menuItemId) {
    state = state.where((line) => line.menuItem.id != menuItemId).toList();
  }

  /// Line-instance-keyed quantity change -- [target] must be an object
  /// currently in [state] (the exact instance read off it, e.g. via the
  /// `for (final line in cart)` the cart panel already iterates with).
  void setLineQuantity(CartLine target, int quantity) {
    final index = state.indexOf(target);
    if (index == -1) return;
    if (quantity <= 0) {
      state = [...state]..removeAt(index);
      return;
    }
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) state[i].copyWith(quantity: quantity) else state[i],
    ];
  }

  void removeLine(CartLine target) {
    final index = state.indexOf(target);
    if (index == -1) return;
    state = [...state]..removeAt(index);
  }

  /// Replaces [target] in place with [replacement] -- used when editing an
  /// existing line's customization, so the line keeps its position instead
  /// of being removed and re-added at the end.
  void replaceLine(CartLine target, CartLine replacement) {
    final index = state.indexOf(target);
    if (index == -1) return;
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) replacement else state[i],
    ];
  }

  void clear() => state = [];

  int get totalMillimes =>
      state.fold(0, (sum, line) => sum + line.lineTotalMillimes);
}

final cartControllerProvider = NotifierProvider<CartController, List<CartLine>>(
  CartController.new,
);

/// Short, staff-readable summary of a line's customization, e.g.
/// "Without: Harissa, Onion · + Ketchup · "Spicy"" -- empty if nothing was
/// customized. Shared by the cart panel, the order confirmation screen,
/// and the customization sheet's own live preview, so the exact same
/// wording shows up everywhere a customer sees what they chose.
String describeCartLineCustomization(CartLine line) {
  final parts = <String>[];
  if (line.removedIngredients.isNotEmpty) {
    parts.add('Without: ${line.removedIngredients.join(', ')}');
  }
  if (line.addedSauces.isNotEmpty) {
    parts.add('+ ${line.addedSauces.join(', ')}');
  }
  final note = line.specialRequest;
  if (note != null && note.isNotEmpty) {
    parts.add('"$note"');
  }
  return parts.join(' · ');
}
