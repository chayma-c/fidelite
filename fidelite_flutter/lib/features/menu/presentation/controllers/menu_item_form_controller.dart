import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/menu_providers.dart';

sealed class MenuItemFormState {
  const MenuItemFormState();
}

class MenuItemFormIdle extends MenuItemFormState {
  const MenuItemFormIdle();
}

class MenuItemFormInProgress extends MenuItemFormState {
  const MenuItemFormInProgress();
}

class MenuItemFormSuccess extends MenuItemFormState {
  const MenuItemFormSuccess(this.item);

  final MenuItemRecord item;
}

class MenuItemFormFailure extends MenuItemFormState {
  const MenuItemFormFailure(this.message);

  final String message;
}

/// Drives both the "add item" and "edit item" forms -- the only difference
/// between the two is whether [update] is called with an id or [create]
/// without one.
class MenuItemFormController extends Notifier<MenuItemFormState> {
  @override
  MenuItemFormState build() => const MenuItemFormIdle();

  Future<void> create({
    required String name,
    required String? description,
    required String category,
    required int priceMillimes,
  }) => _submit(
    () => ref
        .read(serverpodClientProvider)
        .menuManagement
        .createMenuItem(
          name: name,
          description: description,
          category: category,
          priceMillimes: priceMillimes,
        ),
  );

  Future<void> update({
    required int id,
    required String name,
    required String? description,
    required String category,
    required int priceMillimes,
  }) => _submit(
    () => ref
        .read(serverpodClientProvider)
        .menuManagement
        .updateMenuItem(
          id: id,
          name: name,
          description: description,
          category: category,
          priceMillimes: priceMillimes,
        ),
  );

  Future<void> _submit(Future<MenuItemRecord> Function() call) async {
    state = const MenuItemFormInProgress();
    try {
      final item = await call();
      state = MenuItemFormSuccess(item);
      ref.invalidate(menuManagementProvider);
      ref.invalidate(menuCategoriesProvider);
      ref.read(menuProvider.notifier).refreshNow();
    } on MenuItemValidationException catch (e) {
      state = MenuItemFormFailure(_messageFor(e.reason));
    } catch (_) {
      state = const MenuItemFormFailure(
        'Could not save the item. Check your connection and try again.',
      );
    }
  }

  void reset() => state = const MenuItemFormIdle();

  String _messageFor(MenuItemValidationExceptionReason reason) =>
      switch (reason) {
        MenuItemValidationExceptionReason.nameRequired => 'Enter a name.',
        MenuItemValidationExceptionReason.categoryRequired =>
          'Enter a category.',
        MenuItemValidationExceptionReason.invalidPrice =>
          'Enter a price greater than 0.',
        MenuItemValidationExceptionReason.duplicateName =>
          'An item with this name already exists in this category.',
        MenuItemValidationExceptionReason.notFound =>
          'This item no longer exists.',
        MenuItemValidationExceptionReason.unknown =>
          'Something went wrong saving the item.',
      };
}

final menuItemFormControllerProvider =
    NotifierProvider<MenuItemFormController, MenuItemFormState>(
      MenuItemFormController.new,
    );
