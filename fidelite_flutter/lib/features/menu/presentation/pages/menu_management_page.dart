import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/menu_providers.dart';
import 'menu_item_form_page.dart';

/// Staff-only: add/edit menu items and toggle their availability. Reached
/// from the staff order screen's app bar; access itself is enforced
/// server-side (`MenuManagementEndpoint` requires `role:staff`) since only
/// staff can ever reach the order screen in the first place.
class MenuManagementPage extends ConsumerStatefulWidget {
  const MenuManagementPage({super.key});

  @override
  ConsumerState<MenuManagementPage> createState() =>
      _MenuManagementPageState();
}

class _MenuManagementPageState extends ConsumerState<MenuManagementPage> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(menuManagementProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Manage menu')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search items',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _query = value.trim()),
            ),
          ),
          Expanded(
            child: itemsAsync.when(
              data: (items) => _ItemList(items: items, query: _query),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Text(
                  'Could not load the menu:\n$error',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const MenuItemFormPage(),
          ),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add item'),
      ),
    );
  }
}

class _ItemList extends StatelessWidget {
  const _ItemList({required this.items, required this.query});

  final List<MenuItemRecord> items;
  final String query;

  @override
  Widget build(BuildContext context) {
    final filtered = query.isEmpty
        ? items
        : items
              .where(
                (item) =>
                    item.name.toLowerCase().contains(query.toLowerCase()) ||
                    item.category.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

    if (filtered.isEmpty) {
      return const Center(child: Text('No items match your search.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 88),
      itemCount: filtered.length,
      itemBuilder: (context, index) => _MenuItemTile(item: filtered[index]),
    );
  }
}

class _MenuItemTile extends ConsumerStatefulWidget {
  const _MenuItemTile({required this.item});

  final MenuItemRecord item;

  @override
  ConsumerState<_MenuItemTile> createState() => _MenuItemTileState();
}

class _MenuItemTileState extends ConsumerState<_MenuItemTile> {
  bool _isUpdating = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final isActive = item.isActive;

    return ListTile(
      enabled: !_isUpdating,
      title: Text(
        item.name,
        style: isActive
            ? null
            : const TextStyle(decoration: TextDecoration.lineThrough),
      ),
      subtitle: Text('${item.category} · ${item.priceMillimes.asDinars}'),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => MenuItemFormPage(item: item),
        ),
      ),
      trailing: _isUpdating
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : IconButton(
              icon: Icon(isActive ? Icons.delete_outline : Icons.restore),
              tooltip: isActive ? 'Remove from menu' : 'Restore to menu',
              onPressed: () => isActive
                  ? _confirmDeactivate(context)
                  : _setActive(true),
            ),
    );
  }

  Future<void> _confirmDeactivate(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove this item?'),
        content: Text(
          'This hides "${widget.item.name}" from the menu. Past orders that '
          'included it are not affected, and it can be restored later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await _setActive(false);
  }

  Future<void> _setActive(bool isActive) async {
    setState(() => _isUpdating = true);
    try {
      await ref
          .read(serverpodClientProvider)
          .menuManagement
          .setMenuItemActive(id: widget.item.id!, isActive: isActive);
      ref.invalidate(menuManagementProvider);
      ref.read(menuProvider.notifier).refreshNow();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not update the item. Try again.'),
        ),
      );
      setState(() => _isUpdating = false);
    }
  }
}
