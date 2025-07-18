import 'package:flutter/material.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/BudgetPlanning.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/AddBudgetScreen.dart';
import 'screens_Giap/auth_screen.dart';
import 'screens_Giap/category_management_screen.dart';

import 'DoanAnhVu/transaction_history_screen.dart';
import 'QuynhAnh_screens/add_transaction_screen.dart';
import 'QuynhAnh_screens/dashboard.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App 2',
      home: const AuthScreen(),
    ),
  );
}
