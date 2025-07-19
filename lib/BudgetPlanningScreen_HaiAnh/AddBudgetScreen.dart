import 'package:final_project/BudgetPlanningScreen_HaiAnh/model/Budget.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/model/TestDataBudget.dart';
import 'package:final_project/ThemeChanging_HaiAnh/current_theme.dart';
import 'package:flutter/material.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/model/Category.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/model/TestDataCategory.dart';
import 'package:flutter/services.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';

class AddBudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentTheme.background_color,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text(
          "New Budget",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: currentTheme.tab_bar_color,
        elevation: 2,
      ),
      body: AddBudgetScreenBody(),
    );
  }
}

class AddBudgetScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBudgetScreenBodyState();
}

class _AddBudgetScreenBodyState extends State<AddBudgetScreenBody> {
  List<Category> categoryList = mockCategory;
  Category? selectedValue;
  final TextEditingController _amountController = TextEditingController();

  DateTime selectedMonth = DateTime.now();
  DateFormat monthFormat = DateFormat('MM/yyyy');

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [


          //  Month picker 
          Text("Select Month", style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.w500,
            color: currentTheme.main_text_color
            )
          ),

          const SizedBox(height: 10),

          TextButton.icon(
            icon: Icon(Icons.calendar_today, color: Colors.deepPurple),
            label: Text(monthFormat.format(selectedMonth),
                style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold,fontSize: 20)),
            onPressed: () async {
              final picked = await showMonthPicker(
                context: context,
                initialDate: selectedMonth,
                firstDate: DateTime(DateTime.now().year - 1, DateTime.now().month),
                lastDate: DateTime.now(),
              );
              if (picked != null) setState(() => selectedMonth = picked);
            },
          ),

          const SizedBox(height: 30),
          

          // Input amount
          Text("Set Budget Amount", style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.w500,
            color: currentTheme.main_text_color
            )
          ),

          const SizedBox(height: 10),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: currentTheme.sub_button_color,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '0.00',
                hintStyle: TextStyle(color: currentTheme.sub_button_text_color),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    'VND',
                    style: TextStyle(fontWeight: FontWeight.bold, color: currentTheme.main_button_text_color),
                  ),
                ),
                suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              ),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: currentTheme.sub_button_text_color),
            ),
          ),

          const SizedBox(height: 30),


          // Category
          Text("Select Category", style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.w500,
            color: currentTheme.main_text_color
            )
          ),

          const SizedBox(height: 10),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: currentTheme.sub_button_color,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Category>(
                value: selectedValue,
                dropdownColor: currentTheme.sub_button_color,
                hint: Text("Choose a category",style: TextStyle(color: currentTheme.sub_button_text_color),),
                isExpanded: true,
                items: categoryList.map((category) {
                  return DropdownMenuItem(
                    value: category, 
                    child: Text(category.categoryName, style: TextStyle(color: currentTheme.sub_button_text_color),));
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    selectedValue = newVal;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 40),


          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final amt = double.tryParse(_amountController.text.trim());
                    if (selectedValue == null || amt == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter a valid amount and category.")),
                      );
                      return;
                    }

                    //Call API here
                    mockBudgetsJuly.add(
                      Budget(
                        budgetId: mockBudgetsJuly.length, 
                        userId: 101, 
                        categoryId: selectedValue!.categoryId, 
                        categoryName: selectedValue!.categoryName, 
                        amount: amt, 
                        spentAmount: 100, 
                        month: selectedMonth.month, 
                        year: selectedMonth.year
                      )
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Budget saved!")),
                    );
                    Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentTheme.main_button_color,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("CONFIRM", style: TextStyle(fontSize: 16, color: currentTheme.main_button_text_color)),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: currentTheme.sub_button_text_color),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("CANCEL", style: TextStyle(fontSize: 16, color: currentTheme.sub_button_text_color)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
