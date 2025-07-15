class Budget {
  final int budgetId;
  final int userId;
  final int categoryId;
  final String categoryName;
  final double amount;
  final double spentAmount;
  final int month;
  final int year;

  Budget({
    required this.budgetId,
    required this.userId,
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    required this.spentAmount,
    required this.month,
    required this.year,
  });
}
