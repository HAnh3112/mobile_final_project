import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionListWidget({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 8),

              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      transaction.icon,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      transaction.description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  Text(
                    '${transaction.amount.toStringAsFixed(0)} \$',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: transaction.amount < 0 ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}