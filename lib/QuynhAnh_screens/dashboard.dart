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
  int _selectedIndex = 0; // To keep track of the selected tab

  // List of screens to navigate to
  List<Widget> _widgetOptions() => [
    _DashboardContent(),
    TransactionHistoryScreen(),
    AddTransactionScreen(),
    BudgetPlanning(),
    CategoryManagementScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String titleName(index){
    switch(index){
      case 0: return "Dashboard";
      case 1: return "Transaction History";
      case 2: return "Add Transaction";
      case 3: return "Budget Planning";
      case 4: return "Categories";
      default: return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentTheme.background_color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: currentTheme.background_color,
        elevation: 0,
        title: Text(
          titleName(_selectedIndex),
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
      body: _widgetOptions()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: currentTheme.background_color,
        selectedItemColor: currentTheme.main_button_color,
        unselectedItemColor: currentTheme.sub_text_color,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures all labels are shown
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: currentTheme.main_button_color,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white, size: 30),
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Category',
          ),
        ],
      ),
    );
  }

  /// Settings Menu
  Widget _buildSettingsMenu() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.settings, color: currentTheme.sub_text_color, size: 28),
      onSelected: (value) {
        if (value == 'signout') {
          // You might want to navigate to a login screen or perform actual sign-out logic here
          Navigator.pop(
            context,
          ); // This will pop the current route (DashboardScreen)
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
}

// Extract your original dashboard body into a separate widget
class _DashboardContent extends StatelessWidget {
  const _DashboardContent({Key? key})
    : super(key: key); // Add a constructor for best practice

  @override
  Widget build(BuildContext context) {
    // context is available here
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          _buildBalanceCard(),
          const SizedBox(height: 20),
          _buildExpenseOverviewCard(context), // Pass context here
          const SizedBox(height: 15),
          _buildRecentTransactions(context), // Pass context here
          const SizedBox(height: 15),
          _buildMonthlySummaryRow(),
        ],
      ),
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
  Widget _buildExpenseOverviewCard(BuildContext context) {
    // Accept context
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
              // Placeholder for the chart/graph
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8), // Add some rounding
                ),
                child: Center(
                  child: Icon(
                    Icons.bar_chart,
                    size: 40,
                    color: Colors.grey[600],
                  ), // Example icon
                ),
              ),
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
  Widget _buildRecentTransactions(BuildContext context) {
    // Accept context
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
}
