import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../menu/data/ingredients_providers.dart';
import '../controllers/cart_controller.dart';

/// What [showItemCustomizationSheet] hands back -- [Navigator.pop]'s
/// result type can't be a bare record across the generic `showModalBottomSheet<T>`
/// call as cleanly as a named class, and this reads better at the call site.
class ItemCustomization {
  const ItemCustomization({
    required this.removedIngredients,
    required this.addedSauces,
    required this.specialRequest,
  });

  final List<String> removedIngredients;
  final List<String> addedSauces;
  final String? specialRequest;
}

/// Opens the "leave out a base ingredient / add a sauce / special request"
/// sheet for [menuItem] (only ever called for one where
/// [MenuItemRecord.isCustomizable] is true -- see CustomerOrderPage).
/// Pass [initial] to pre-fill it with an existing cart line's choices when
/// editing instead of adding fresh. Returns null if the sheet was
/// dismissed without confirming.
Future<ItemCustomization?> showItemCustomizationSheet(
  BuildContext context, {
  required MenuItemRecord menuItem,
  CartLine? initial,
}) {
  return showModalBottomSheet<ItemCustomization>(
    context: context,
    isScrollControlled: true,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      builder: (context, scrollController) => _ItemCustomizationSheet(
        menuItem: menuItem,
        initial: initial,
        scrollController: scrollController,
      ),
    ),
  );
}

class _ItemCustomizationSheet extends ConsumerStatefulWidget {
  const _ItemCustomizationSheet({
    required this.menuItem,
    required this.initial,
    required this.scrollController,
  });

  final MenuItemRecord menuItem;
  final CartLine? initial;
  final ScrollController scrollController;

  @override
  ConsumerState<_ItemCustomizationSheet> createState() =>
      _ItemCustomizationSheetState();
}

class _ItemCustomizationSheetState
    extends ConsumerState<_ItemCustomizationSheet> {
  late final _removed = {...widget.initial?.removedIngredients ?? const []};
  late final _addedSauces = {...widget.initial?.addedSauces ?? const []};
  late final _noteController = TextEditingController(
    text: widget.initial?.specialRequest,
  );

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ingredientsAsync = ref.watch(ingredientsProvider);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ListView(
        controller: widget.scrollController,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.menuItem.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Text(
                widget.menuItem.priceMillimes.asDinars,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ingredientsAsync.when(
            data: (ingredients) => _Options(
              ingredients: ingredients,
              removed: _removed,
              addedSauces: _addedSauces,
              onToggleRemoved: (name) => setState(
                () => _removed.contains(name)
                    ? _removed.remove(name)
                    : _removed.add(name),
              ),
              onToggleSauce: (name) => setState(
                () => _addedSauces.contains(name)
                    ? _addedSauces.remove(name)
                    : _addedSauces.add(name),
              ),
              onKolChay: () => setState(_removed.clear),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Text(
                    'Could not load customization options:\n$error',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => ref.invalidate(ingredientsProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Special request (optional)',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _noteController,
            decoration: const InputDecoration(
              hintText: 'e.g. spicy',
              isDense: true,
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.done,
            maxLength: 80,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 8),
          _SummaryPreview(
            menuItemName: widget.menuItem.name,
            removed: _removed,
            addedSauces: _addedSauces,
            note: _noteController.text,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _confirm,
            child: Text(widget.initial == null ? 'Add to order' : 'Save changes'),
          ),
        ],
      ),
    );
  }

  void _confirm() {
    final ingredients = ref.read(ingredientsProvider).valueOrNull ?? const [];
    // Canonical catalog order rather than Set iteration order, so two
    // identical selections always produce identically-ordered lists --
    // CartController.addCustomizedItem merges lines by comparing these
    // lists with listEquals, which is order-sensitive.
    final orderedRemoved = [
      for (final ingredient in ingredients)
        if (ingredient.kind == IngredientKind.base &&
            _removed.contains(ingredient.name))
          ingredient.name,
    ];
    final orderedSauces = [
      for (final ingredient in ingredients)
        if (ingredient.kind == IngredientKind.sauce &&
            _addedSauces.contains(ingredient.name))
          ingredient.name,
    ];
    final note = _noteController.text.trim();

    Navigator.of(context).pop(
      ItemCustomization(
        removedIngredients: orderedRemoved,
        addedSauces: orderedSauces,
        specialRequest: note.isEmpty ? null : note,
      ),
    );
  }
}

class _Options extends StatelessWidget {
  const _Options({
    required this.ingredients,
    required this.removed,
    required this.addedSauces,
    required this.onToggleRemoved,
    required this.onToggleSauce,
    required this.onKolChay,
  });

  final List<IngredientRecord> ingredients;
  final Set<String> removed;
  final Set<String> addedSauces;
  final ValueChanged<String> onToggleRemoved;
  final ValueChanged<String> onToggleSauce;
  final VoidCallback onKolChay;

  @override
  Widget build(BuildContext context) {
    final base = ingredients.where((i) => i.kind == IngredientKind.base);
    final sauces = ingredients.where((i) => i.kind == IngredientKind.sauce);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Don't want something? (menghir)",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            TextButton(
              onPressed: removed.isEmpty ? null : onKolChay,
              child: const Text('Kol chay (skip)'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final ingredient in base)
              FilterChip(
                label: Text(ingredient.name),
                selected: removed.contains(ingredient.name),
                onSelected: (_) => onToggleRemoved(ingredient.name),
                avatar: removed.contains(ingredient.name)
                    ? const Icon(Icons.remove_circle, size: 18)
                    : null,
                selectedColor: colorScheme.errorContainer,
                checkmarkColor: colorScheme.onErrorContainer,
                labelStyle: removed.contains(ingredient.name)
                    ? TextStyle(
                        color: colorScheme.onErrorContainer,
                        decoration: TextDecoration.lineThrough,
                      )
                    : null,
              ),
          ],
        ),
        if (sauces.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Add a sauce', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (final ingredient in sauces)
                FilterChip(
                  label: Text(ingredient.name),
                  selected: addedSauces.contains(ingredient.name),
                  onSelected: (_) => onToggleSauce(ingredient.name),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _SummaryPreview extends StatelessWidget {
  const _SummaryPreview({
    required this.menuItemName,
    required this.removed,
    required this.addedSauces,
    required this.note,
  });

  final String menuItemName;
  final Set<String> removed;
  final Set<String> addedSauces;
  final String note;

  @override
  Widget build(BuildContext context) {
    final parts = <String>[
      if (removed.isNotEmpty) 'Without: ${removed.join(', ')}',
      if (addedSauces.isNotEmpty) '+ ${addedSauces.join(', ')}',
      if (note.trim().isNotEmpty) '"${note.trim()}"',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(menuItemName, style: Theme.of(context).textTheme.titleSmall),
          if (parts.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Everything as usual',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                parts.join(' · '),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
        ],
      ),
    );
  }
}
