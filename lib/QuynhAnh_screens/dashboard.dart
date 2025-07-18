// lib/dashboard_screen.dart
import 'package:final_project/BudgetPlanningScreen_HaiAnh/BudgetPlanning.dart';
import 'package:final_project/DoanAnhVu/transaction_history_screen.dart';
import 'package:final_project/QuynhAnh_screens/add_transaction_screen.dart';
import 'package:final_project/screens_Giap/category_management_screen.dart';
import 'package:flutter/material.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Màu nền tổng thể
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, 
        icon: Icon(Icons.logout,color: Colors.red,)
        ),
        backgroundColor: Colors.grey[100], // Match scaffold background
        elevation: 0, // Bỏ đường kẻ dưới AppBar
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Welcome back!',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette_outlined, color: Colors.black54),
            onPressed: () {
              // Handle icon press
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black54),
            onPressed: () {
              // Handle icon press
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black54),
            onPressed: () {
              // Handle icon press
            },
          ),
          const SizedBox(width: 8), // Khoảng trống cuối cùng
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Balance Card
            _buildBalanceCard(context),
            const SizedBox(height: 20),

            // Action Buttons (Add Transaction, View Charts)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to Add Transaction screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransactionScreen()));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Transaction'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600], // Màu nền xanh
                      foregroundColor: Colors.white, // Màu chữ và icon
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
                    onPressed: () {
                      // Navigate to View Charts screen
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const ChartsScreen()));
                    },
                    icon: const Icon(Icons.bar_chart, color: Colors.black87),
                    label: const Text(
                      'View Charts',
                      style: TextStyle(color: Colors.black87),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.grey[400]!), // Viền
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Recent Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            // Placeholder for transactions if empty
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'No transactions yet',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ),
            ),

            // Nếu có dữ liệu giao dịch, bạn sẽ dùng ListView.builder ở đây
            // Ví dụ:
            // ListView.builder(
            //   shrinkWrap: true, // Quan trọng khi dùng trong SingleChildScrollView
            //   physics: NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn riêng của ListView
            //   itemCount: transactions.length,
            //   itemBuilder: (context, index) {
            //     return TransactionItem(transaction: transactions[index]);
            //   },
            // ),
            const SizedBox(height: 30),

            // Monthly Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildMonthlySummaryCard(
                    icon: Icons.add_circle_outline,
                    color: Colors.green[400]!, // Màu xanh nhạt
                    label: 'This Month',
                    amount: '+\$0',
                    iconBgColor: Colors.green[100]!, // Nền icon xanh nhạt
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMonthlySummaryCard(
                    icon: Icons.remove_circle_outline,
                    color: Colors.red[400]!, // Màu đỏ nhạt
                    label: 'This Month',
                    amount: '-\$0',
                    iconBgColor: Colors.red[100]!, // Nền icon đỏ nhạt
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Grid of Feature Cards
            GridView.count(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn riêng của GridView
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5, // Tỷ lệ chiều rộng/chiều cao của mỗi item
              children: [
                _buildFeatureCard(
                  context,
                  icon: Icons.history,
                  label: 'History',
                  onTap: () {
                    // Navigate to History Screen
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => TransactionHistoryScreen())
                    );
                  },
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.pie_chart_outline,
                  label: 'Budget',
                  onTap: () {
                    // Navigate to Budget Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BudgetPlanning())
                    );
                  },
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.category_outlined,
                  label: 'Categories',
                  onTap: () {
                    // Navigate to Categories Screen
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => CategoryManagementScreen())
                    );
                  },
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.notifications_active_outlined,
                  label: 'Reminders',
                  onTap: () {
                    // Navigate to Reminders Screen
                  },
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
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple[400]!, // Tím đậm
            Colors.deepPurple[200]!, // Tím nhạt hơn
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
          style: const TextStyle(color: Colors.white54, fontSize: 14),
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
      elevation: 0, // Bỏ đổ bóng
      color: Colors.white, // Màu nền thẻ
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
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
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
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[200],
              child: Icon(
                icon,
                color: Colors.grey[700], // Màu icon
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[800],
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
