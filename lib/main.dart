import 'package:flutter/material.dart';
import 'package:final_project/BudgetPlanning.dart';
import 'package:final_project/EditScreen.dart';
import 'screens/auth_screen.dart';
import 'screens/category_management_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App',

      // Chọn màn hình muốn chạy ở đây:
      //home: const AuthScreen(),
      home: BudgetPlanning(),
      //home: Editscreen(),
      //home: CategoryManagementScreen(),
    ),
  );
}
