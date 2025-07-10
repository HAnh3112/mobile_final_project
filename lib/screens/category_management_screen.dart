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

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Category"),
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
                  return ChoiceChip(
                    label: Text(icon, style: const TextStyle(fontSize: 20)),
                    selected: _selectedIcon == icon,
                    onSelected: (_) => setState(() => _selectedIcon = icon),
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
                    onTap: () => setState(() => _selectedColor = color),
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
              if (_nameController.text.isNotEmpty && _selectedIcon != null) {
                final newCategory = Category(
                  id: const Uuid().v4(),
                  name: _nameController.text,
                  icon: _selectedIcon!,
                  color: _selectedColor,
                );
                setState(() => _categories.add(newCategory));
                _nameController.clear();
                _selectedIcon = null;
                _selectedColor = const Color(0xFFFF6B6B);
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _deleteCategory(String id) {
    setState(() {
      _categories.removeWhere((cat) => cat.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Categories"),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _showAddDialog),
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
                    onPressed: _showAddDialog,
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
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteCategory(category.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
