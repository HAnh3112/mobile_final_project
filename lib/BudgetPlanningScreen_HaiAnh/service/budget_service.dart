import 'dart:convert';
import 'package:final_project/API%20IP/ip_address.dart';
import 'package:final_project/model/Budget.dart';
import 'package:http/http.dart' as http;

class budget_service{

  Future<List<Budget>> getbudgetList(int id, int month, int year) async {
    final url = Uri.http(currentHost, "/api/budget/showByMonth",
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
      return data.map((json) => Budget.fromJson(json)).toList();
    } else {
      print("Failed");
      throw Exception('Failed to fetch budgets');
    }
  }

  Future<String> editBudget(int id, double amount) async {
    final url = Uri.http(currentHost, "/api/budget/update", 
      {
        'id': id.toString(),
        'amount': amount.toString()
      }
    );

    final response = await http.put(url);

    if (response.statusCode == 200) {
      print("Success!");
      return ("Success!");
    } else {
      print("Failed");
      throw Exception('Failed to update budget');
    }
  }

  Future<String> deleteBudget(int id) async{
    final url = Uri.http(currentHost, "/api/budget/delete", {'id': id.toString()});

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print("Success!");
      return ("Success!");
    } else {
      print("Failed");
      throw Exception('Failed to delete budget');
    }
  }
}