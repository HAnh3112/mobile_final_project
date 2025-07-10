import 'package:flutter/material.dart';
import '../DoanAnhVu/models/transaction.dart';
import '../DoanAnhVu/widgets/empty_state_widget.dart';
import '../DoanAnhVu/widgets/transaction_list_widget.dart';
import '../DoanAnhVu/widgets/search_bar_widget.dart';
import '../DoanAnhVu/widgets/filter_modal.dart';

class TransactionHistoryScreen extends StatefulWidget {
  @override
  _TransactionHistoryScreenState createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _minAmountController = TextEditingController();
  final TextEditingController _maxAmountController = TextEditingController();

  String selectedType = 'All Types';
  String selectedCategory = 'All Categories';
  bool hasTransactions = false;

  final List<String> types = ['All Types', 'Income', 'Expense', 'Transfer'];
  final List<String> categories = ['All Categories', 'Food', 'Transport', 'Shopping', 'Bills'];

  final List<Transaction> transactions = [
    Transaction(date: '15-01-2025', description: 'Item', amount: -45.0, icon: Icons.shopping_cart),
    Transaction(date: '14-01-2025', description: 'Item', amount: -45.0, icon: Icons.restaurant),
    Transaction(date: '13-01-2025', description: 'Item', amount: -45.0, icon: Icons.local_gas_station),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Transaction History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black),
            onPressed: () => _showFilterModal(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            SearchBarWidget(controller: _searchController),

            // Content Area
            Expanded(
              child: hasTransactions
                  ? TransactionListWidget(transactions: transactions)
                  : EmptyStateWidget(),
            ),

            // Toggle button for demo purposes
            ElevatedButton(
              onPressed: () {
                setState(() {
                  hasTransactions = !hasTransactions;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8B7CF6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                hasTransactions ? 'Show Empty State' : 'Show Transactions',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FilterModal(
          selectedType: selectedType,
          selectedCategory: selectedCategory,
          startDateController: _startDateController,
          endDateController: _endDateController,
          minAmountController: _minAmountController,
          maxAmountController: _maxAmountController,
          types: types,
          categories: categories,
          onTypeChanged: (String newType) {
            setState(() {
              selectedType = newType;
            });
          },
          onCategoryChanged: (String newCategory) {
            setState(() {
              selectedCategory = newCategory;
            });
          },
          onClearAll: () {
            setState(() {
              selectedType = 'All Types';
              selectedCategory = 'All Categories';
              _startDateController.clear();
              _endDateController.clear();
              _minAmountController.clear();
              _maxAmountController.clear();
            });
          },
          onApply: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Filters applied successfully!')),
            );
          },
        );
      },
    );
  }
}