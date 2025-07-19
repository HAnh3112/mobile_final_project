import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Category {
  final String id;
  final String name;
  final String icon;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  Category copyWith({String? name, String? icon, Color? color}) {
    return Category(
      id: id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
}

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  final List<Category> _categories = [];
  final TextEditingController _nameController = TextEditingController();

  String? _selectedIcon;
  Color _selectedColor = const Color(0xFFFF6B6B);

  final List<String> commonIcons = [
    '🍔',
    '🚗',
    '🛍️',
    '💡',
    '🎬',
    '💰',
    '🏠',
    '📱',
    '⚕️',
    '🎓',
    '✈️',
    '🎮',
  ];

  final List<Color> commonColors = [
    Color(0xFFFF6B6B),
    Color(0xFF4ECDC4),
    Color(0xFF45B7D1),
    Color(0xFF96CEB4),
    Color(0xFFFFEAA7),
    Color(0xFFDDA0DD),
    Color(0xFFFFB6C1),
    Color(0xFF98D8C8),
  ];

  void _showCategoryDialog({Category? existing}) {
    _nameController.text = existing?.name ?? '';
    _selectedIcon = existing?.icon;
    _selectedColor = existing?.color ?? const Color(0xFFFF6B6B);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text(existing == null ? "Add New Category" : "Edit Category"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Category Name"),
                ),
                const SizedBox(height: 12),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Choose Icon"),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: commonIcons.map((icon) {
                    final isSelected = _selectedIcon == icon;

                    final isUsedByOther = _categories.any(
                      (cat) =>
                          cat.icon == icon &&
                          (existing == null || cat.id != existing.id),
                    );
                    final isDisabled = isUsedByOther;

                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ChoiceChip(
                          label: Text(
                            icon,
                            style: const TextStyle(fontSize: 20),
                          ),
                          selected: isSelected,
                          onSelected: isDisabled
                              ? null
                              : (_) =>
                                    setStateDialog(() => _selectedIcon = icon),
                          selectedColor: Colors.blue.shade100,
                          disabledColor: Colors.grey.shade200,
                        ),
                        if (isSelected)
                          const Positioned(
                            top: -4,
                            right: -4,
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Choose Color"),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: commonColors.map((color) {
                    return GestureDetector(
                      onTap: () => setStateDialog(() => _selectedColor = color),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedColor == color
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text.trim();
                if (name.isEmpty || _selectedIcon == null) return;

                final nameExists = _categories.any(
                  (cat) =>
                      cat.name.toLowerCase() == name.toLowerCase() &&
                      (existing == null || cat.id != existing.id),
                );

                final iconExists = _categories.any(
                  (cat) =>
                      cat.icon == _selectedIcon &&
                      (existing == null || cat.id != existing.id),
                );

                if (nameExists || iconExists) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Name or icon already exists'),
                    ),
                  );
                  return;
                }

                if (existing != null) {
                  final updated = existing.copyWith(
                    name: name,
                    icon: _selectedIcon!,
                    color: _selectedColor,
                  );
                  setState(() {
                    final index = _categories.indexWhere(
                      (c) => c.id == existing.id,
                    );
                    _categories[index] = updated;
                  });
                } else {
                  final newCategory = Category(
                    id: const Uuid().v4(),
                    name: name,
                    icon: _selectedIcon!,
                    color: _selectedColor,
                  );
                  setState(() => _categories.add(newCategory));
                }

                Navigator.pop(context);
              },
              child: Text(existing == null ? "Add" : "Save"),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteCategory(String id) {
    setState(() => _categories.removeWhere((cat) => cat.id == id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Categories"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCategoryDialog(),
          ),
        ],
      ),
      body: _categories.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("📂", style: TextStyle(fontSize: 48)),
                  const Text(
                    "No Categories Yet",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text("Add your first category to get started"),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => _showCategoryDialog(),
                    icon: const Icon(Icons.add),
                    label: const Text("Add Category"),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: category.color,
                      child: Text(category.icon),
                    ),
                    title: Text(category.name),
                    subtitle: const Text("Category"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              _showCategoryDialog(existing: category),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteCategory(category.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
