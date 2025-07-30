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
  final FilterData? initialFilter; // Add initial filter parameter

  const TransactionFilterWidget({
    super.key,
    required this.onApplyFilters,
    this.initialFilter,
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
  void initState() {
    super.initState();
    
    // Initialize with existing filter data if provided
    if (widget.initialFilter != null) {
      _selectedFilterType = widget.initialFilter!.selectedType;
      _selectedFilterCategory = widget.initialFilter!.selectedCategory;
      _startDate = widget.initialFilter!.startDate;
      _endDate = widget.initialFilter!.endDate;
      _minAmount = widget.initialFilter!.minAmount;
      _maxAmount = widget.initialFilter!.maxAmount;
      
      if (_minAmount != null) {
        _minAmountController.text = _minAmount!.toString();
      }
      if (_maxAmount != null) {
        _maxAmountController.text = _maxAmount!.toString();
      }
    }
  }

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
    // Validate amount inputs
    if (_minAmountController.text.isNotEmpty) {
      _minAmount = double.tryParse(_minAmountController.text);
      if (_minAmount == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid minimum amount'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    } else {
      _minAmount = null;
    }

    if (_maxAmountController.text.isNotEmpty) {
      _maxAmount = double.tryParse(_maxAmountController.text);
      if (_maxAmount == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid maximum amount'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    } else {
      _maxAmount = null;
    }

    // Validate date range
    if (_startDate != null && _endDate != null && _startDate!.isAfter(_endDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Start date cannot be after end date'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate amount range
    if (_minAmount != null && _maxAmount != null && _minAmount! > _maxAmount!) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Minimum amount cannot be greater than maximum amount'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

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
      height: MediaQuery.of(context).size.height * 0.8,
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
            // Header with title and clear all button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Transactions',
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
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type and Category filters
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
                                  color: currentTheme.sub_button_color,
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
                                  color: currentTheme.sub_button_color,
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
                    
                    // Date Range filter
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
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: currentTheme.main_button_color,
                                        onPrimary: currentTheme.main_button_text_color,
                                        surface: currentTheme.background_color,
                                        onSurface: currentTheme.main_text_color,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
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
                                color: currentTheme.sub_button_color,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: currentTheme.sub_text_color),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _startDate != null
                                          ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                                          : 'Start Date',
                                      style: TextStyle(
                                        color: _startDate != null ? currentTheme.main_text_color : currentTheme.sub_text_color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('to', style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _endDate ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: currentTheme.main_button_color,
                                        onPrimary: currentTheme.main_button_text_color,
                                        surface: currentTheme.background_color,
                                        onSurface: currentTheme.main_text_color,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
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
                                color: currentTheme.sub_button_color,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: currentTheme.sub_text_color),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _endDate != null
                                          ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                                          : 'End Date',
                                      style: TextStyle(
                                        color: _endDate != null ? currentTheme.main_text_color : currentTheme.sub_text_color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Amount Range filter
                    Text('Amount Range', style: TextStyle(fontWeight: FontWeight.w500, color: currentTheme.main_text_color)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Min Amount', style: TextStyle(fontSize: 12, color: currentTheme.sub_text_color)),
                              const SizedBox(height: 4),
                              TextField(
                                controller: _minAmountController,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                ],
                                style: TextStyle(color: currentTheme.main_text_color),
                                decoration: InputDecoration(
                                  hintText: '0.00',
                                  hintStyle: TextStyle(color: currentTheme.sub_text_color),
                                  prefixText: '\$',
                                  prefixStyle: TextStyle(color: currentTheme.main_text_color),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: currentTheme.sub_text_color.withOpacity(0.2)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: currentTheme.sub_text_color.withOpacity(0.2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: currentTheme.main_button_color),
                                  ),
                                  filled: true,
                                  fillColor: currentTheme.sub_button_color,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                              Text('Max Amount', style: TextStyle(fontSize: 12, color: currentTheme.sub_text_color)),
                              const SizedBox(height: 4),
                              TextField(
                                controller: _maxAmountController,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                ],
                                style: TextStyle(color: currentTheme.main_text_color),
                                decoration: InputDecoration(
                                  hintText: '0.00',
                                  hintStyle: TextStyle(color: currentTheme.sub_text_color),
                                  prefixText: '\$',
                                  prefixStyle: TextStyle(color: currentTheme.main_text_color),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: currentTheme.sub_text_color.withOpacity(0.2)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: currentTheme.sub_text_color.withOpacity(0.2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: currentTheme.main_button_color),
                                  ),
                                  filled: true,
                                  fillColor: currentTheme.sub_button_color,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Quick date filters
                    Text('Quick Date Filters', style: TextStyle(fontWeight: FontWeight.w500, color: currentTheme.main_text_color)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildQuickDateChip('Today', () {
                          final now = DateTime.now();
                          setState(() {
                            _startDate = DateTime(now.year, now.month, now.day);
                            _endDate = DateTime(now.year, now.month, now.day);
                          });
                        }),
                        _buildQuickDateChip('This Week', () {
                          final now = DateTime.now();
                          final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
                          setState(() {
                            _startDate = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
                            _endDate = DateTime(now.year, now.month, now.day);
                          });
                        }),
                        _buildQuickDateChip('This Month', () {
                          final now = DateTime.now();
                          setState(() {
                            _startDate = DateTime(now.year, now.month, 1);
                            _endDate = DateTime(now.year, now.month, now.day);
                          });
                        }),
                        _buildQuickDateChip('Last 30 Days', () {
                          final now = DateTime.now();
                          setState(() {
                            _startDate = now.subtract(const Duration(days: 30));
                            _endDate = DateTime(now.year, now.month, now.day);
                          });
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: currentTheme.sub_text_color.withOpacity(0.3)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: currentTheme.sub_text_color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentTheme.main_button_color,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Apply Filters',
                      style: TextStyle(
                        color: currentTheme.main_button_text_color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickDateChip(String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: currentTheme.main_button_color.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(16),
          color: currentTheme.main_button_color.withOpacity(0.1),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: currentTheme.main_button_color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}