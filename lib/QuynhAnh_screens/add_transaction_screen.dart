// lib/add_transaction_screen.dart
import 'package:final_project/ThemeChanging_HaiAnh/current_theme.dart';
import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool _isIncome = true; // true for Income, false for Expense
  TextEditingController _amountController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  final List<String> _categories = [
    'Food',
    'Transport',
    'Shopping',
    'Utilities',
    'Salary',
    'Gift',
    'Investment',
    'Other',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _amountController.text = '0.00';
    _selectedDate = DateTime(2025, 6, 25);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentTheme.background_color,
      appBar: AppBar(
        backgroundColor: currentTheme.tab_bar_color,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: currentTheme.main_button_text_color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add Transaction', style: TextStyle(color: currentTheme.main_button_text_color)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: currentTheme.main_text_color),
              ),
              const SizedBox(height: 20),
              Text('Transaction Type', style: TextStyle(fontSize: 16, color: currentTheme.sub_text_color)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: currentTheme.sub_button_color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isIncome = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !_isIncome ? currentTheme.main_button_color : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '- Expense',
                            style: TextStyle(
                              color: !_isIncome ? currentTheme.main_button_text_color : currentTheme.main_text_color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isIncome = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _isIncome ? currentTheme.main_button_color : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '+ Income',
                            style: TextStyle(
                              color: _isIncome ? currentTheme.main_button_text_color : currentTheme.main_text_color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('Amount', style: TextStyle(fontSize: 16, color: currentTheme.sub_text_color)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: currentTheme.sub_button_color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: currentTheme.main_text_color,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: TextStyle(color: currentTheme.sub_text_color),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'VND',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: currentTheme.sub_text_color,
                        ),
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Category', style: TextStyle(fontSize: 16, color: currentTheme.sub_text_color)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: currentTheme.sub_button_color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedCategory,
                    hint: Text('Select a category', style: TextStyle(color: currentTheme.sub_text_color)),
                    icon: Icon(Icons.arrow_drop_down, color: currentTheme.sub_text_color),
                    onChanged: (String? newValue) => setState(() => _selectedCategory = newValue),
                    style: TextStyle(color: currentTheme.main_text_color),
                    dropdownColor: currentTheme.sub_button_color,
                    items: _categories.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: currentTheme.main_text_color)),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Date', style: TextStyle(fontSize: 16, color: currentTheme.sub_text_color)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: currentTheme.sub_button_color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.year}',
                        style: TextStyle(fontSize: 16, color: currentTheme.main_text_color),
                      ),
                      Icon(Icons.calendar_today, color: currentTheme.sub_text_color),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Notes (Optional)', style: TextStyle(fontSize: 16, color: currentTheme.sub_text_color)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: currentTheme.sub_button_color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _notesController,
                  maxLines: 3,
                  style: TextStyle(color: currentTheme.main_text_color),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add a note...',
                    hintStyle: TextStyle(color: currentTheme.sub_text_color),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('Transaction Type: ${_isIncome ? "Income" : "Expense"}');
                    print('Amount: ${_amountController.text}');
                    print('Category: ${_selectedCategory ?? "N/A"}');
                    print('Date: ${_selectedDate.toLocal()}');
                    print('Notes: ${_notesController.text}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentTheme.main_button_color,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    _isIncome ? 'Add Income' : 'Add Expense',
                    style: TextStyle(
                      fontSize: 18,
                      color: currentTheme.main_button_text_color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
