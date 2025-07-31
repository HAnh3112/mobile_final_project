class Transaction {
  final String id;
  final String type;
  final String category;
  final double amount;
  final DateTime date;
  final int icon;
  final String iconColor;
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