import 'package:flutter/material.dart';

class Budget {
  final int budgetId;
  final int userId;
  final int categoryId;
  final String categoryName;
  final double amount;
  final int month;
  final int year;

  Budget({
    required this.budgetId,
    required this.userId,
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    required this.month,
    required this.year,
  });
}
