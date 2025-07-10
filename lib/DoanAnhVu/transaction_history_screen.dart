import 'package:flutter/material.dart';
import 'transaction_filter_widget.dart'; // Import the filter widget

// Transaction model class to represent each transaction
class Transaction {
  final String id;
  final String type;        // Category like Food, Transport, Salary
  final String category;    // Subcategory like Lunch, Transport, Salary
  final double amount;      // Transaction amount
  final DateTime date;      // Transaction date
  final IconData icon;      // Icon to display
  final Color iconColor;    // Icon background color
  final bool isIncome;      // true = Income, false = Expense

  Transaction({
    required this.id,
    required this.type,
    required this.category,
    required this.amount,
    required this.date,
    required this.icon,
    required this.iconColor,
    required this.isIncome,
  });
}

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  // Search controller for the search bar
  final TextEditingController _searchController = TextEditingController();

  // Sample transaction data - replace with real data from database
  final List<Transaction> _allTransactions = [
    Transaction(
      id: '1',
      type: 'Food',
      category: 'Lunch',
      amount: 45.5,
      date: DateTime(2024, 1, 15),
      icon: Icons.restaurant,
      iconColor: Colors.red,
      isIncome: false, // This is an expense
    ),
    Transaction(
      id: '2',
      type: 'Transport',
      category: 'Transport',
      amount: 25.0,
      date: DateTime(2024, 1, 14),
      icon: Icons.directions_car,
      iconColor: Colors.teal,
      isIncome: false, // This is an expense
    ),
    Transaction(
      id: '3',
      type: 'Salary',
      category: 'Salary',
      amount: 3500.0,
      date: DateTime(2024, 1, 1),
      icon: Icons.attach_money,
      iconColor: Colors.purple,
      isIncome: true, // This is income
    ),
  ];

  // Working copy of transactions (can be modified by delete operations)
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    // Initialize transactions with sample data
    transactions = List.from(_allTransactions);

    // Listen to search text changes for real-time filtering
    _searchController.addListener(() {
      setState(() {}); // Rebuild UI when search text changes
    });
  }

  @override
  void dispose() {
    // Clean up the controller when widget is disposed
    _searchController.dispose();
    super.dispose();
  }

  // Show the filter modal using the separate filter widget
  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow full height control
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return TransactionFilterWidget(
          onApplyFilters: (filterData) {
            // Handle filter application here
            // For now, we just close the modal without applying filters
            print('Filter applied: $filterData'); // Debug print
            Navigator.pop(context);
          },
        );
      },
    );
  }

  // Return all transactions without filtering (filter functionality removed)
  List<Transaction> get displayedTransactions {
    // NOTE: Filter functionality has been removed
    // This now just returns all transactions regardless of filter selections
    return transactions;

    // REMOVED: All filtering logic has been commented out
    // The search and filter selections still work in the UI but don't affect the data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // App bar with back button and filter icon
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Transaction History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Filter icon button - opens filter modal
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterModal(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar section (UI only - doesn't filter data)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search transactions...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Transaction list section - shows all transactions
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: groupedTransactions.keys.length,
              itemBuilder: (context, index) {
                String dateKey = groupedTransactions.keys.elementAt(index);
                List<Transaction> dayTransactions = groupedTransactions[dateKey]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date header for each group
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            dateKey,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // List of transactions for this date
                    ...dayTransactions.map((transaction) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          // Transaction icon with colored background
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: transaction.iconColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              transaction.icon,
                              color: transaction.iconColor,
                              size: 24,
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Transaction details (type and category)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction.type, // Main category
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  transaction.category, // Subcategory
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Amount with + or - prefix and color coding
                          Text(
                            '${transaction.isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(transaction.amount == transaction.amount.toInt() ? 0 : 1)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: transaction.isIncome ? Colors.green : Colors.red, // Green for income, red for expense
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Delete button - DISABLED (for display only)
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.grey), // Grey to show it's disabled
                            onPressed: () {
                              // Show message that delete is disabled
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete Disabled'),
                                    content: const Text('Delete functionality is currently disabled.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    )).toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Group transactions by date for display (no filtering applied)
  Map<String, List<Transaction>> get groupedTransactions {
    Map<String, List<Transaction>> grouped = {};

    // Group all transactions by date string (no filtering)
    for (var transaction in displayedTransactions) {
      String dateKey = '${transaction.date.month}/${transaction.date.day}/${transaction.date.year}';
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(transaction);
    }
    return grouped;
  }
}
