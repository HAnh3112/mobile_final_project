import 'package:final_project/BudgetPlanningScreen_HaiAnh/model/Budget.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/model/TestDataBudget.dart';
import 'package:final_project/ThemeChanging_HaiAnh/current_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'AddBudgetScreen.dart';

class BudgetPlanning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentTheme.background_color,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); //Navigate back to dashboard
          },

          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text(
          "Budget Planning",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: currentTheme.tab_bar_color,
      ),
      body: BudgetPlanningBody(),
    );
  }
}

class screenIfNoBudgetExist extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _screenIfNoBudgetExistState();
}

class _screenIfNoBudgetExistState extends State<screenIfNoBudgetExist> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.radio_button_checked, size: 200, color: Colors.deepPurple),

          SizedBox(height: 5),

          Text(
            "No Budgets Set",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: currentTheme.main_text_color),
          ),

          Text("Create your first budget to track spending!", style: TextStyle(color: currentTheme.main_text_color),),

          SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => AddBudgetScreen())
                ).then((result){
                  if(result == true){
                    setState(() {
                      
                    });
                  }
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: currentTheme.main_button_color),
              child: Text("Set New Budget +", style: TextStyle(color: currentTheme.main_button_text_color)),
            ),
          )
        ],
      ),
    );
  }
}



class BudgetPlanningBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BudgetPlannignBodyState();
}



class _BudgetPlannignBodyState extends State<BudgetPlanningBody> {
  int? editingIndex;
  TextEditingController editingController = TextEditingController();
  List<Budget>? allBudgets = mockBudgetBlank;

  DateFormat dateFormat = DateFormat("MM/yyyy");
  DateTime currentDate = DateTime.now();
  DateTime pickedDate = DateTime.now();

  bool isEditable(DateTime date) {
    final now = currentDate;
    final lastMonth = DateTime(now.year, now.month - 1);
    return (date.year == now.year && date.month == now.month) ||
        (date.year == lastMonth.year && date.month == lastMonth.month);
  }

  void _showMonthPicker() async {
    final selected = await showMonthPicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(currentDate.year - 1,currentDate.month),
      lastDate: currentDate,
    );
    if (selected != null) {
      setState(() {
        pickedDate = selected;
        allBudgets = mockBudgetsJuly; // replace with actual function that fetch data in database;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //If no budget found will return a blank page
    if (allBudgets == null || allBudgets!.isEmpty) {
      return screenIfNoBudgetExist();
    }

    double totalBudget = allBudgets!.fold(0.0, (total, budget) => total + budget.amount);
    double totalSpent = allBudgets!.fold(0.0, (total, budget) => total + budget.spentAmount);
    double remaining = totalBudget - totalSpent;

    return Column(
      children: [
        

        //Monthly Overview
        Container(
          width: 400,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.fromLTRB(20,20,20,10),
          decoration: BoxDecoration(
              gradient: currentTheme.elevated_background_color,
              boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 2, blurRadius: 6)],
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with month picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Monthly Overview", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 20,
                      color: Colors.white70
                    )
                  ),
                  TextButton.icon(
                    onPressed: _showMonthPicker,
                    icon: Icon(Icons.calendar_today, color: Colors.white),
                    label: Text(
                      dateFormat.format(pickedDate),
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Total budget:", style: TextStyle(color: Colors.white70),),
                Text("$totalBudget đ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ]),
              SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Total spent:", style: TextStyle(color: Colors.white70)),
                Text("$totalSpent đ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ]),
              SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Remaining:", style: TextStyle(color: Colors.white70)),
                Text("$remaining đ", style: TextStyle(fontWeight: FontWeight.bold,color: (remaining<0)? Colors.redAccent:Colors.greenAccent)),
              ]),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple.shade700),
                ),
                child: LinearProgressIndicator(
                  value: totalBudget == 0 ? 0 : totalSpent / totalBudget,
                  backgroundColor: Colors.deepPurple.shade100,
                  color: Colors.deepPurple,
                ),
              )
            ],
          ),
        ),

        //Navigate to adding budget screen
        Container(
          width: 400,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => AddBudgetScreen())
              ).then((result){
                if(result == true){
                  setState(() {
                    
                  });
                }
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: currentTheme.main_button_color),
            child: Text("Set new budget +",style: TextStyle(color: currentTheme.main_button_text_color, fontWeight: FontWeight.bold),),
          ),
        ),

        SizedBox(height: 10,),


        Divider(height: 10, thickness: 2, color: Colors.grey, indent: 22, endIndent: 22),


        //Budget List
        Expanded(
          child: ListView.builder(
            itemCount: allBudgets!.length,
            itemBuilder: (context, index) {
              bool isEditing = editingIndex == index;
              var budget = allBudgets![index];

              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: currentTheme.sub_button_text_color, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: currentTheme.sub_button_color
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 2, child: Text(budget.categoryName, 
                          style: TextStyle(color: currentTheme.sub_button_text_color),)
                        ),

                        Spacer(),

                        Expanded(
                          flex: 2,
                          child: isEditing
                              ? TextField(
                                  controller: editingController,
                                  style: TextStyle(color: currentTheme.sub_button_text_color),
                                  decoration: InputDecoration(hintText: "Enter new amount"),
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                )
                              : Text("${budget.spentAmount}/${budget.amount} đ",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: (budget.spentAmount > budget.amount)? Colors.red:Colors.green
                                ),),
                        ),

                        if (isEditable(pickedDate))
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (isEditing) {
                                    // UPDATE DATA FUNCTION HERE
                                    editingIndex = null;
                                  } else {
                                    editingIndex = index;
                                    editingController.text = budget.amount.toString();
                                  }
                                });
                              },
                              icon: Icon(isEditing ? Icons.save : Icons.edit, color: currentTheme.sub_button_text_color,),
                            ),
                          ),
                      ],
                    ),
                    if (isEditing)
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            children: [
                              Text("Editing ${budget.categoryName} budget", style: TextStyle(color: Colors.grey)),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    // DELETE FUNCTION BASE ON ID HERE
                                  });
                                },
                                style: IconButton.styleFrom(backgroundColor: Colors.deepPurple),
                                icon: Icon(Icons.delete, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple.shade700),
                      ),
                      child: LinearProgressIndicator(
                        value: (budget.amount == 0)?   0 : budget.spentAmount / budget.amount,
                        backgroundColor: Colors.deepPurple.shade100,
                        color: Colors.deepPurple,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
