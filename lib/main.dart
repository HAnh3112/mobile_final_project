import 'package:flutter/material.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/BudgetPlanning.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/EditScreen.dart';
import 'screens_Giap/auth_screen.dart';
import 'screens_Giap/category_management_screen.dart';

import 'DoanAnhVu/transaction_history_screen.dart';
import 'QuynhAnh_screens/add_transaction_screen.dart';
import 'QuynhAnh_screens/dashboard.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App',

      // Chọn màn hình muốn chạy ở đây:
      //home: const AuthScreen(),

      //home: const AddTransactionScreen(),
      //home: const DashboardScreen(),

      //home: BudgetPlanning(),
      //home: Editscreen(),
      home: CategoryManagementScreen(),

      //home: TransactionHistoryScreen(), // Transaction History Screen
    ),
  );
}
