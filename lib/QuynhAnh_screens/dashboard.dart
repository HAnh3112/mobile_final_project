// lib/dashboard_screen.dart
import 'package:final_project/BudgetPlanningScreen_HaiAnh/BudgetPlanning.dart';
import 'package:final_project/DoanAnhVu/transaction_history_screen.dart';
import 'package:final_project/QuynhAnh_screens/ExpenseBreakdownScreen.dart';
import 'package:final_project/QuynhAnh_screens/add_transaction_screen.dart';
import 'package:final_project/screens_Giap/category_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/ThemeChanging_HaiAnh/theme.dart';
import 'package:final_project/ThemeChanging_HaiAnh/current_theme.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentTheme.background_color,
      appBar: AppBar(
        backgroundColor: currentTheme.background_color,
        elevation: 0,
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: currentTheme.main_text_color,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              (currentTheme == lightTheme) ? Icons.light_mode : Icons.dark_mode,
              color: currentTheme.sub_text_color,
              size: 28,
            ),
            onPressed: () {
              setState(() {
                currentTheme = (currentTheme == lightTheme)
                    ? darkTheme
                    : lightTheme;
              });
            },
          ),
          _buildSettingsMenu(),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 20),
            _buildExpenseOverviewCard(),
            const SizedBox(height: 15),
            _buildRecentTransactions(), // THÊM MỚI
            const SizedBox(height: 15),
            _buildMonthlySummaryRow(),
            const SizedBox(height: 20),
            _buildFeatureRow(context),
          ],
        ),
      ),
    );
  }

  /// Settings Menu
  Widget _buildSettingsMenu() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.settings, color: currentTheme.sub_text_color, size: 28),
      onSelected: (value) {
        if (value == 'signout') {
          Navigator.pop(context);
        }
      },
      color: currentTheme.sub_button_color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 'signout',
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 8),
              Text("Sign Out"),
            ],
          ),
        ),
      ],
    );
  }

  /// Balance Card
  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: currentTheme.elevated_background_color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Balance',
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
          const SizedBox(height: 5),
          Text(
            '\$0',
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBalanceDetail('Income', '\$0'),
              _buildBalanceDetail('Expense', '\$0'),
              _buildBalanceDetail('Saved', '0%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Expense Overview
  Widget _buildExpenseOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: currentTheme.sub_button_color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expense Overview',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: currentTheme.main_text_color,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExpenseBreakdownScreen(),
                    ),
                  );
                },
                child: Text(
                  'View',
                  style: TextStyle(color: currentTheme.main_button_color),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 65, height: 65, color: Colors.grey[300]),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    _buildExpenseItem('Food', '100\$'),
                    _buildExpenseItem('Transport', '100\$'),
                    _buildExpenseItem('Shopping', '100\$'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(String name, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.circle, size: 7, color: Colors.blue),
              const SizedBox(width: 5),
              Text(name, style: TextStyle(color: currentTheme.main_text_color)),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              color: currentTheme.main_text_color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Recent Transactions
  Widget _buildRecentTransactions() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: currentTheme.sub_button_color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: currentTheme.main_text_color,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionHistoryScreen(),
                    ),
                  );
                },
                child: Text(
                  'View All',
                  style: TextStyle(color: currentTheme.main_button_color),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildTransactionItem('Food', '2025-07-21', '-\$20', false),
          _buildTransactionItem('Salary', '2025-07-20', '+\$500', true),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    String title,
    String date,
    String amount,
    bool isIncome,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.receipt_long,
            size: 20,
            color: isIncome ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: currentTheme.main_text_color),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: currentTheme.sub_text_color,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isIncome ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Monthly Summary Row
  Widget _buildMonthlySummaryRow() {
    return Row(
      children: [
        Expanded(
          child: _buildMonthlySummaryCard(
            icon: Icons.add_circle_outline,
            color: Colors.green,
            amount: '+\$0',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildMonthlySummaryCard(
            icon: Icons.remove_circle_outline,
            color: Colors.red,
            amount: '-\$0',
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlySummaryCard({
    required IconData icon,
    required Color color,
    required String amount,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: currentTheme.sub_button_color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 7),
          Text(
            amount,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Feature Row
  Widget _buildFeatureRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildFeatureCard(context, Icons.history, 'History', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransactionHistoryScreen()),
          );
        }),
        _buildFeatureCard(context, Icons.pie_chart_outline, 'Budget', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BudgetPlanning()),
          );
        }),
        _buildFeatureCard(context, Icons.category_outlined, 'Category', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryManagementScreen()),
          );
        }),
        _buildFeatureCard(context, Icons.add, 'Add', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransactionScreen()),
          );
        }),
      ],
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.black, size: 28),
          const SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
