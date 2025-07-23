import 'package:final_project/ThemeChanging_HaiAnh/current_theme.dart';
import 'package:flutter/material.dart';
import 'package:final_project/QuynhAnh_screens/add_transaction_screen.dart';

class Transaction {
  final String id;
  final String type;
  final String category;
  final double amount;
  final DateTime date;
  final IconData icon;
  final Color iconColor;
  final bool isIncome;

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
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Transaction> transactions = [
    Transaction(
      id: '1',
      type: 'Food',
      category: 'Lunch',
      amount: 45.5,
      date: DateTime(2024, 1, 15),
      icon: Icons.restaurant,
      iconColor: Colors.red,
      isIncome: false,
    ),
    Transaction(
      id: '2',
      type: 'Transport',
      category: 'Transport',
      amount: 25.0,
      date: DateTime(2024, 1, 14),
      icon: Icons.directions_car,
      iconColor: Colors.teal,
      isIncome: false,
    ),
    Transaction(
      id: '3',
      type: 'Salary',
      category: 'Salary',
      amount: 3500.0,
      date: DateTime(2024, 1, 1),
      icon: Icons.attach_money,
      iconColor: Colors.purple,
      isIncome: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Map<String, List<Transaction>> get groupedTransactions {
    Map<String, List<Transaction>> grouped = {};
    for (var transaction in transactions) {
      String dateKey =
          '${transaction.date.month}/${transaction.date.day}/${transaction.date.year}';
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(transaction);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final theme = currentTheme;

    return Scaffold(
      backgroundColor: theme.background_color,
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.main_button_color,
        child: const Icon(Icons.add),
        onPressed: () async {
          final newTransaction = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
          );

          if (newTransaction != null && newTransaction is Transaction) {
            setState(() {
              transactions.add(newTransaction);
            });
          }
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: theme.main_text_color),
              decoration: InputDecoration(
                hintText: 'Search transactions...',
                hintStyle: TextStyle(color: theme.sub_text_color),
                prefixIcon: Icon(Icons.search, color: theme.sub_text_color),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.sub_text_color.withOpacity(0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.sub_text_color.withOpacity(0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.main_button_color),
                ),
                filled: true,
                fillColor: theme.sub_button_color,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: groupedTransactions.keys.length,
              itemBuilder: (context, index) {
                String dateKey = groupedTransactions.keys.elementAt(index);
                List<Transaction> dayTransactions =
                    groupedTransactions[dateKey]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: theme.main_text_color,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            dateKey,
                            style: TextStyle(
                              color: theme.main_text_color,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...dayTransactions.map(
                      (transaction) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.sub_button_color,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.sub_text_color.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          children: [
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaction.type,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: theme.main_text_color,
                                    ),
                                  ),
                                  Text(
                                    transaction.category,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: theme.sub_text_color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${transaction.isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: transaction.isIncome
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
