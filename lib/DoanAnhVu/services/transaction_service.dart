// // lib/services/transaction_service.dart
// import 'dart:convert';
// import 'package:final_project/DoanAnhVu/model/transaction.dart';
// import 'package:http/http.dart' as http;
// import 'package:final_project/DoanAnhVu/DTO/TransactionHistoryDTO.dart'; // Đảm bảo đường dẫn đúng
// import 'package:final_project/global_variable/ip_address.dart';

// class TransactionService {
//   final String baseUrl = 'http://$currentHost/api/transactions'; // Thay thế bằng IP và port của backend của bạn

//   Future<List<TransactionHistory>> getUserTransactionHistory(int userId) async {
//     try {
//        final response = await http.get(
//         Uri.parse('$baseUrl/transactionHistory?userID=$userId'),);

//       if (response.statusCode == 200) {
//         List<dynamic> body = json.decode(response.body);
//         List<TransactionHistory> transactions = body
//             .map((dynamic item) => TransactionHistory.fromJson(item))
//             .toList();
//         return transactions;
//       } else {
//         throw Exception('Failed to load transaction history: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to connect to the server: $e');
//     }
//   }
  
//   // Bạn có thể thêm các phương thức khác ở đây cho các API khác
//   // Future<TransactionHistory> createTransaction(TransactionHistory transaction) async { ... }
// }
// lib/services/transaction_service.dart (Cập nhật)
import 'dart:convert';
import 'package:final_project/DoanAnhVu/DTO/TransactionSummary.dart';
import 'package:final_project/DoanAnhVu/model/transaction.dart'; // Đảm bảo import đúng model Transaction
import 'package:http/http.dart' as http;
import 'package:final_project/DoanAnhVu/DTO/TransactionHistoryDTO.dart';
import 'package:final_project/global_variable/ip_address.dart';

class TransactionService {
  final String baseUrl = 'http://$currentHost/api/transactions'; // Thay thế bằng IP và port của backend của bạn

  Future<List<TransactionHistory>> getUserTransactionHistory(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/transactionHistory?userID=$userId'),
      );

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

  // Phương thức mới để tạo giao dịch
  Future<String> createTransaction(Transaction transaction) async {
    try {
      print("Sending JSON: ${jsonEncode(transaction.toJson())}");
      final response = await http.post(
        Uri.parse(baseUrl), // Endpoint POST không cần thêm path phụ
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(transaction.toJson()), // Chuyển đổi Transaction object thành JSON string
      );

      if (response.statusCode == 201) { // Mã 201 Created cho biết thành công
        print('Transaction created successfully: ${response.body}');
        // Tùy chọn: Nếu backend trả về đối tượng Transaction đã tạo, bạn có thể phân tích cú pháp ở đây
        // return Transaction.fromJson(jsonDecode(response.body));
        return 'Suceed to add transaction'; // Trả về null hoặc đối tượng Transaction đã tạo nếu bạn parse nó
      } else {
        print('Failed to create transaction. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        // Ném lỗi hoặc trả về null để xử lý ở UI
        return 'Failed to add transaction';
      }
    } catch (e) {
      print('Error creating transaction: $e');
      return 'Error adding transaction';
    }
  }
  Future<List<TransactionSummary>> getUserRecentHistory(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/recentTransaction?userID=$userId'),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<TransactionSummary> transactions = body
            .map((dynamic item) => TransactionSummary.fromJson(item))
            .toList();
        return transactions;
      } else {
        throw Exception('Failed to load recent transaction history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}