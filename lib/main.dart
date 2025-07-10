import 'package:flutter/material.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/BudgetPlanning.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/EditScreen.dart';
import 'screens_Giap/auth_screen.dart';
import 'screens_Giap/category_management_screen.dart';
import 'screens_Giap/transaction_history_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App',

      // Chọn màn hình muốn chạy ở đây:
      home: const AuthScreen(),
      //home: BudgetPlanning(),
      //home: Editscreen(),
      //home: CategoryManagementScreen(),


      //home: TransactionHistoryScreen(), // Transaction History Screen
    ),
  );
}
