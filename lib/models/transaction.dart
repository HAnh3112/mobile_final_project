import 'package:flutter/material.dart';

class Transaction {
  final String date;
  final String description;
  final double amount;
  final IconData icon;

  Transaction({
    required this.date,
    required this.description,
    required this.amount,
    required this.icon,
  });
}