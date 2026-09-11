import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartLine {
  const CartLine({required this.menuItem, required this.quantity});

  final MenuItemRecord menuItem;
  final int quantity;

  int get lineTotalMillimes => menuItem.priceMillimes * quantity;

  CartLine copyWith({int? quantity}) =>
      CartLine(menuItem: menuItem, quantity: quantity ?? this.quantity);
}

/// The staff member's in-progress order. Purely client-local state until
/// [OrderSubmissionController.submit] confirms it -- there's no server
/// concept of a "draft" order.
class CartController extends Notifier<List<CartLine>> {
  @override
  List<CartLine> build() => [];

  void addItem(MenuItemRecord menuItem) {
    final index = state.indexWhere((line) => line.menuItem.id == menuItem.id);
    if (index == -1) {
      state = [...state, CartLine(menuItem: menuItem, quantity: 1)];
      return;
    }
    state = [
      for (final line in state)
        if (line.menuItem.id == menuItem.id)
          line.copyWith(quantity: line.quantity + 1)
        else
          line,
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

  void clear() => state = [];

  int get totalMillimes =>
      state.fold(0, (sum, line) => sum + line.lineTotalMillimes);
}

final cartControllerProvider = NotifierProvider<CartController, List<CartLine>>(
  CartController.new,
);
