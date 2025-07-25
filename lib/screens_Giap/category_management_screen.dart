import 'package:final_project/ThemeChanging_HaiAnh/current_theme.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  Category copyWith({String? name, IconData? icon, Color? color}) {
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

  IconData? _selectedIcon;
  Color _selectedColor = const Color(0xFFFF6B6B);

  final List<IconData> commonIcons = [
    Icons.fastfood,        // Đồ ăn nhanh
    Icons.directions_car,  // Xe hơi
    Icons.shopping_bag,    // Mua sắm
    Icons.lightbulb,       // Điện / ý tưởng
    Icons.movie,           // Xem phim
    Icons.attach_money,    // Tiền bạc
    Icons.home,            // Nhà
    Icons.smartphone,      // Điện thoại
    Icons.medical_services, // Y tế
    Icons.school,          // Giáo dục
    Icons.flight,          // Du lịch
    Icons.sports_esports,  // Game
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
    final theme = currentTheme;

    _nameController.text = existing?.name ?? '';
    _selectedIcon = existing?.icon;
    _selectedColor = existing?.color ?? const Color(0xFFFF6B6B);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          backgroundColor: Colors.grey[100],
          title: Text(
            existing == null ? "Add New Category" : "Edit Category",
            style: TextStyle(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Category Name",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.main_button_color),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose Icon",
                    style: TextStyle(color: Colors.black),
                  ),
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

                    return RawChip(
                      label: Icon(
                        icon,
                        size: 20,
                        color: isSelected
                            ? Colors.white
                            : theme.main_text_color,
                      ),
                      selected: isSelected,
                      onSelected: isUsedByOther
                          ? null
                          : (_) {
                              setStateDialog(() => _selectedIcon = icon);
                            },
                      selectedColor: Colors.lightBlueAccent,
                      backgroundColor: theme.background_color,
                      disabledColor: Colors.grey[300],
                      showCheckmark: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose Color",
                    style: TextStyle(color: Colors.black),
                  ),
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
              child: Text(
                "Cancel",
                style: TextStyle(color: theme.main_button_color),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.main_button_color,
              ),
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
                    SnackBar(
                      content: Text(
                        'Name or icon already exists',
                        style: TextStyle(color: theme.main_text_color),
                      ),
                      backgroundColor: theme.background_color,
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
              child: Text(
                existing == null ? "Add" : "Save",
                style: TextStyle(color: theme.main_button_text_color),
              ),
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
    final theme = currentTheme;

    return Scaffold(
      backgroundColor: theme.background_color,
      appBar: AppBar(
        title: Text(
          "Category Management",
          style: TextStyle(color: theme.main_text_color),
        ),
        backgroundColor: theme.background_color,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: theme.main_button_color),
            onPressed: () => _showCategoryDialog(),
          ),
        ],
      ),
      body: _categories.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.folder_open,
                    size: 48,
                    color: theme.sub_text_color,
                  ),
                  Text(
                    "No Categories Yet",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.main_text_color,
                    ),
                  ),
                  Text(
                    "Add your first category to get started",
                    style: TextStyle(color: theme.sub_text_color),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Card(
                  color: theme.sub_button_color,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: category.color,
                      child: Icon(
                        category.icon,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      category.name,
                      style: TextStyle(color: theme.main_text_color),
                    ),
                    subtitle: Text(
                      "Category",
                      style: TextStyle(color: theme.sub_text_color),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: theme.main_button_color,
                          ),
                          onPressed: () =>
                              _showCategoryDialog(existing: category),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: theme.main_button_color.withOpacity(0.7),
                          ),
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