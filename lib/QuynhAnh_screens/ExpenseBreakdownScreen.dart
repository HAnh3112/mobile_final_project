import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpenseBreakdownScreen extends StatelessWidget {
  const ExpenseBreakdownScreen({super.key});

  final List<Map<String, dynamic>> transactions = const [
    {"category": "Food", "amount": 120.0, "color": Colors.blue},
    {"category": "Transport", "amount": 80.0, "color": Colors.orange},
    {"category": "Shopping", "amount": 150.0, "color": Colors.green},
    {"category": "Other", "amount": 50.0, "color": Colors.purple},
  ];

  double get totalAmount =>
      transactions.fold(0.0, (sum, item) => sum + item["amount"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Expense Breakdown",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSummaryRow(),
            const SizedBox(height: 20),
            _buildPieChartSection(),
            const SizedBox(height: 20),

            _buildExportButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSummaryCard(
          icon: Icons.arrow_upward,
          color: Colors.green,
          title: "This month",
          amount: "+ \$3.500",
        ),
        _buildSummaryCard(
          icon: Icons.arrow_downward,
          color: Colors.red,
          title: "This month",
          amount: "- \$2.700",
        ),
      ],
    );
  }

  Widget _buildPieChartSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Expense by category",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: transactions.map((item) {
                  final percent = (item["amount"] / totalAmount) * 100;
                  return PieChartSectionData(
                    color: item["color"],
                    value: item["amount"],
                    title: "${percent.toStringAsFixed(1)}%",
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
                centerSpaceRadius: 30,
                sectionsSpace: 2,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: transactions.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle, size: 12, color: item["color"]),
                        const SizedBox(width: 8),
                        Text(item["category"]),
                      ],
                    ),
                    Text("${item["amount"].toStringAsFixed(0)}\$"),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExportButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildExportButton(Icons.file_download, "Export CSV"),
        _buildExportButton(Icons.file_download, "Export Excel"),
      ],
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required Color color,
    required String title,
    required String amount,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton(IconData icon, String text) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
