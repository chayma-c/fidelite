import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../data/menu_providers.dart';
import '../controllers/menu_item_form_controller.dart';

/// Add/edit form for a single menu item. Editing an existing item is
/// signalled by passing [item]; omit it to add a new one.
class MenuItemFormPage extends ConsumerStatefulWidget {
  const MenuItemFormPage({super.key, this.item});

  final MenuItemRecord? item;

  @override
  ConsumerState<MenuItemFormPage> createState() => _MenuItemFormPageState();
}

class _MenuItemFormPageState extends ConsumerState<MenuItemFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.item?.name);
  late final _descriptionController = TextEditingController(
    text: widget.item?.description,
  );
  late final _categoryController = TextEditingController(
    text: widget.item?.category,
  );
  late final _priceController = TextEditingController(
    text: widget.item == null
        ? null
        : (widget.item!.priceMillimes / 1000).toStringAsFixed(3),
  );

  bool get _isEditing => widget.item != null;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<MenuItemFormState>(menuItemFormControllerProvider, (
      previous,
      next,
    ) {
      if (next is MenuItemFormFailure) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.message)));
        ref.read(menuItemFormControllerProvider.notifier).reset();
      } else if (next is MenuItemFormSuccess) {
        Navigator.of(context).pop();
      }
    });

    final formState = ref.watch(menuItemFormControllerProvider);
    final isSubmitting = formState is MenuItemFormInProgress;
    final categoriesAsync = ref.watch(menuCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit item' : 'Add item')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      (value == null || value.trim().isEmpty)
                      ? 'Enter a name'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (optional)',
                  ),
                  textInputAction: TextInputAction.next,
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                categoriesAsync.when(
                  data: (categories) => Autocomplete<String>(
                    initialValue: TextEditingValue(
                      text: _categoryController.text,
                    ),
                    optionsBuilder: (textEditingValue) {
                      if (textEditingValue.text.isEmpty) return categories;
                      return categories.where(
                        (category) => category.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        ),
                      );
                    },
                    onSelected: (selection) =>
                        _categoryController.text = selection,
                    fieldViewBuilder:
                        (context, controller, focusNode, onSubmitted) {
                          // Keeps the Autocomplete's own internal controller
                          // in sync with ours, so a category typed without
                          // picking a suggestion is still captured on
                          // submit.
                          controller.text = _categoryController.text;
                          controller.addListener(
                            () => _categoryController.text = controller.text,
                          );
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                              labelText: 'Category',
                              helperText:
                                  'Pick an existing one, or type a new category',
                            ),
                            validator: (value) =>
                                (value == null || value.trim().isEmpty)
                                ? 'Enter a category'
                                : null,
                          );
                        },
                  ),
                  loading: () => TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(labelText: 'Category'),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Enter a category'
                        : null,
                  ),
                  error: (error, _) => TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(labelText: 'Category'),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Enter a category'
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    suffixText: 'DT',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    final millimes = value?.toMillimesOrNull();
                    if (millimes == null || millimes <= 0) {
                      return 'Enter a valid price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: isSubmitting ? null : _submit,
                  child: isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(_isEditing ? 'Save changes' : 'Add item'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _nameController.text;
    final description = _descriptionController.text;
    final category = _categoryController.text;
    final priceMillimes = _priceController.text.toMillimesOrNull()!;
    final controller = ref.read(menuItemFormControllerProvider.notifier);

    if (_isEditing) {
      controller.update(
        id: widget.item!.id!,
        name: name,
        description: description,
        category: category,
        priceMillimes: priceMillimes,
      );
    } else {
      controller.create(
        name: name,
        description: description,
        category: category,
        priceMillimes: priceMillimes,
      );
    }
  }
}
