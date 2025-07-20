// lib/dashboard_screen.dart
import 'package:final_project/BudgetPlanningScreen_HaiAnh/BudgetPlanning.dart';
import 'package:final_project/DoanAnhVu/transaction_history_screen.dart';
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.logout, color: Colors.red),
        ),
        backgroundColor: currentTheme.background_color,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(
                color: currentTheme.main_text_color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Welcome back!', //USER'S USERNAME HERE
              style: TextStyle(color: currentTheme.sub_text_color, fontSize: 16),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon((currentTheme == lightTheme)? Icons.light_mode:Icons.dark_mode, color: currentTheme.sub_text_color),
            onPressed: () {setState(() {
              if(currentTheme == lightTheme){
                currentTheme = darkTheme;
              }else{
                currentTheme = lightTheme;
              }
            });},
          ),
          IconButton(
            icon: Icon(Icons.notifications_none, color: currentTheme.sub_text_color),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings, color: currentTheme.sub_text_color),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(context),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddTransactionScreen()),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Transaction'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentTheme.main_button_color,
                      foregroundColor: currentTheme.main_button_text_color,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.bar_chart, color: currentTheme.main_text_color),
                    label: Text(
                      'View Charts',
                      style: TextStyle(color: currentTheme.main_text_color),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: currentTheme.sub_text_color),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: currentTheme.main_text_color,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'No transactions yet',
                  style: TextStyle(color: currentTheme.sub_text_color, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: _buildMonthlySummaryCard(
                    icon: Icons.add_circle_outline,
                    color: Colors.green[400]!,
                    label: 'This Month',
                    amount: '+\$0',
                    iconBgColor: Colors.green[100]!,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMonthlySummaryCard(
                    icon: Icons.remove_circle_outline,
                    color: Colors.red[400]!,
                    label: 'This Month',
                    amount: '-\$0',
                    iconBgColor: Colors.red[100]!,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _buildFeatureCard(
                  context,
                  icon: Icons.history,
                  label: 'History',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionHistoryScreen()));
                  },
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.pie_chart_outline,
                  label: 'Budget',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetPlanning()));
                  },
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.category_outlined,
                  label: 'Categories',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryManagementScreen()));
                  },
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.notifications_active_outlined,
                  label: 'Reminders',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: currentTheme.elevated_background_color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current Balance',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '\$0',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBalanceDetail('Income', '\$0'),
              _buildBalanceDetail('Expenses', '\$0'),
              _buildBalanceDetail('Saved', '0.0%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlySummaryCard({
    required IconData icon,
    required Color color,
    required String label,
    required String amount,
    required Color iconBgColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      color: currentTheme.sub_button_color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: iconBgColor,
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(color: currentTheme.sub_button_text_color, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              amount,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        color: currentTheme.sub_button_color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[200],
              child: Icon(
                icon,
                color: Colors.black54,
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: currentTheme.sub_button_text_color,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}