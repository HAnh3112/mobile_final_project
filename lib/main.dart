import 'package:flutter/material.dart';
import 'package:final_project/BudgetPlanning.dart';
import 'package:final_project/EditScreen.dart';

// void main() {
//   runApp(MaterialApp(home: BudgetPlanning()));
// }

import 'screens/auth_screen.dart';
import 'screens/category_management_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App',

      //  Đổi giữa 2 màn hình tại đây:
      //home: const AuthScreen(), // màn hình đăng nhập
      home: CategoryManagementScreen(), // màn hình danh mục
    );
  }
}
