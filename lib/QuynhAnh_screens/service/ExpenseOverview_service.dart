import 'dart:convert';
import 'package:final_project/QuynhAnh_screens/model/ExpenseOverview.dart';
import 'package:final_project/global_variable/ip_address.dart';
import 'package:final_project/model/AvailableCategory.dart';
import 'package:final_project/model/Budget.dart';
import 'package:http/http.dart' as http;

class ExpenseOverview_service{

  Future<List<ExpenseOverview>> showtop3ExOverview(int id, int month, int year) async {
    final url = Uri.http(currentHost, "/api/monthlyreport/top3MonthlyExpense",
      {
        'userID': id.toString(),
        'month': month.toString(),
        'year': year.toString(),
      },
    );
    
    print("Data is being fetch...");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print("Success!");
      return data.map((json) => ExpenseOverview.fromJson(json)).toList();
    } else {
      print("Failed");
      throw Exception('Failed to fetch budgets');
    }
  }

}