import 'package:flutter/material.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/BudgetPlanning.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/EditScreen.dart';
import 'screens_Giap/auth_screen.dart';
import 'screens_Giap/category_management_screen.dart';
<<<<<<< HEAD
import 'DoanAnhVu/transaction_history_screen.dart';
=======
import 'screens_Giap/transaction_history_screen.dart';
import 'QuynhAnh_screens/add_transaction_screen.dart';
import 'QuynhAnh_screens/dashboard.dart';
>>>>>>> ad3d1700f1c5c0be8f075f8ce7435d2a90aed04c

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App',

      // Chọn màn hình muốn chạy ở đây:
      //home: const AuthScreen(),
<<<<<<< HEAD
=======
      //home: const AddTransactionScreen(),
      home: const DashboardScreen(),
>>>>>>> ad3d1700f1c5c0be8f075f8ce7435d2a90aed04c
      //home: BudgetPlanning(),
      //home: Editscreen(),
      //home: CategoryManagementScreen(),

<<<<<<< HEAD

      home: TransactionHistoryScreen(), // Transaction History Screen
=======
      //home: TransactionHistoryScreen(), // Transaction History Screen
>>>>>>> ad3d1700f1c5c0be8f075f8ce7435d2a90aed04c
    ),
  );
}
