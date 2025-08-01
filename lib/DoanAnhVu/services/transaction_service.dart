// lib/services/transaction_service.dart
import 'dart:convert';
import 'package:final_project/DoanAnhVu/model/transaction.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/DoanAnhVu/DTO/TransactionHistoryDTO.dart'; // Đảm bảo đường dẫn đúng
import 'package:final_project/global_variable/ip_address.dart';

class TransactionService {
  final String baseUrl = 'http://$currentHost/api/transactions'; // Thay thế bằng IP và port của backend của bạn

  Future<List<TransactionHistory>> getUserTransactionHistory(int userId) async {
    try {
       final response = await http.get(
        Uri.parse('$baseUrl/transactionHistory?userID=$userId'),);

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<TransactionHistory> transactions = body
            .map((dynamic item) => TransactionHistory.fromJson(item))
            .toList();
        return transactions;
      } else {
        throw Exception('Failed to load transaction history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  // Bạn có thể thêm các phương thức khác ở đây cho các API khác
  // Future<TransactionHistory> createTransaction(TransactionHistory transaction) async { ... }
}