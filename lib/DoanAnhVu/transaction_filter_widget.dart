import 'package:final_project/ThemeChanging_HaiAnh/current_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Filter data class to hold all filter selections
class FilterData {
  final String selectedType;
  final String selectedCategory;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minAmount;
  final double? maxAmount;

  FilterData({
    required this.selectedType,
    required this.selectedCategory,
    this.startDate,
    this.endDate,
    this.minAmount,
    this.maxAmount,
  });

  @override
  String toString() {
    return 'FilterData(type: $selectedType, category: $selectedCategory, startDate: $startDate, endDate: $endDate, minAmount: $minAmount, maxAmount: $maxAmount)';
  }
}

// Filter widget - handles all filter UI and selections
class TransactionFilterWidget extends StatefulWidget {
  final Function(FilterData) onApplyFilters; // Callback when filters are applied

  const TransactionFilterWidget({
    super.key,
    required this.onApplyFilters,
  });

  @override
  State<TransactionFilterWidget> createState() => _TransactionFilterWidgetState();
}

class _TransactionFilterWidgetState extends State<TransactionFilterWidget> {
  String _selectedFilterType = 'All types';
  String _selectedFilterCategory = 'All Categories';
  DateTime? _startDate;
  DateTime? _endDate;
  double? _minAmount;
  double? _maxAmount;

  final TextEditingController _minAmountController = TextEditingController();
  final TextEditingController _maxAmountController = TextEditingController();

  @override
  void dispose() {
    _minAmountController.dispose();
    _maxAmountController.dispose();
    super.dispose();
  }

  void _clearAllFilters() {
    setState(() {
      _selectedFilterType = 'All types';
      _selectedFilterCategory = 'All Categories';
      _startDate = null;
      _endDate = null;
      _minAmount = null;
      _maxAmount = null;
      _minAmountController.clear();
      _maxAmountController.clear();
    });
  }

  void _applyFilters() {
    final filterData = FilterData(
      selectedType: _selectedFilterType,
      selectedCategory: _selectedFilterCategory,
      startDate: _startDate,
      endDate: _endDate,
      minAmount: _minAmount,
      maxAmount: _maxAmount,
    );

    widget.onApplyFilters(filterData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: currentTheme.background_color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: currentTheme.main_text_color,
                  ),
                ),
                TextButton(
                  onPressed: _clearAllFilters,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: currentTheme.sub_text_color.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Clear All',
                      style: TextStyle(color: currentTheme.sub_text_color),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Types', style: TextStyle(fontWeight: FontWeight.w500, color: currentTheme.main_text_color)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: currentTheme.sub_text_color.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedFilterType,
                            isExpanded: true,
                            dropdownColor: currentTheme.background_color,
                            iconEnabledColor: currentTheme.sub_text_color,
                            style: TextStyle(color: currentTheme.main_text_color),
                            items: ['All types', 'Income', 'Expense'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(color: currentTheme.main_text_color)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedFilterType = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Categories', style: TextStyle(fontWeight: FontWeight.w500, color: currentTheme.main_text_color)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: currentTheme.sub_text_color.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedFilterCategory,
                            isExpanded: true,
                            dropdownColor: currentTheme.background_color,
                            iconEnabledColor: currentTheme.sub_text_color,
                            style: TextStyle(color: currentTheme.main_text_color),
                            items: ['All Categories', 'Lunch', 'Transport', 'Salary', 'Food', 'Entertainment', 'Shopping', 'Bills']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(color: currentTheme.main_text_color)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedFilterCategory = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Date Range', style: TextStyle(fontWeight: FontWeight.w500, color: currentTheme.main_text_color)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _startDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          _startDate = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: currentTheme.sub_text_color.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _startDate != null
                            ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                            : 'Start Date',
                        style: TextStyle(
                          color: _startDate != null ? currentTheme.main_text_color : currentTheme.sub_text_color,
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('---'),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _endDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          _endDate = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: currentTheme.sub_text_color.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _endDate != null
                            ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                            : 'End Date',
                        style: TextStyle(
                          color: _endDate != null ? currentTheme.main_text_color : currentTheme.sub_text_color,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Amount Range', style: TextStyle(fontWeight: FontWeight.w500, color: currentTheme.main_text_color)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minAmountController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(color: currentTheme.main_text_color),
                    decoration: InputDecoration(
                      hintText: 'Min Amount',
                      hintStyle: TextStyle(color: currentTheme.sub_text_color),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: currentTheme.sub_text_color.withOpacity(0.2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: currentTheme.sub_text_color.withOpacity(0.2)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _minAmount = double.tryParse(value);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _maxAmountController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(color: currentTheme.main_text_color),
                    decoration: InputDecoration(
                      hintText: 'Max Amount',
                      hintStyle: TextStyle(color: currentTheme.sub_text_color),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: currentTheme.sub_text_color.withOpacity(0.2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: currentTheme.sub_text_color.withOpacity(0.2)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _maxAmount = double.tryParse(value);
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentTheme.main_button_color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Apply',
                  style: TextStyle(
                    color: currentTheme.main_button_text_color,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
