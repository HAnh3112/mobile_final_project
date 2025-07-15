import 'package:final_project/BudgetPlanningScreen_HaiAnh/model/Budget.dart';
import 'package:final_project/BudgetPlanningScreen_HaiAnh/model/TestDataBudget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class BudgetPlanning extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back),color: Colors.white,),// FUNCTION TO NAVIGATE BACK,
        title: Text("Budget Planning",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_circle),color: Colors.white,)
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: BudgetPlanningBody(),
    );
  }
}

class screenIfNoBudgetExist extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.radio_button_checked, size: 200, color: Colors.deepPurple),
          SizedBox(height: 5,),
          Text("No Budgets Set",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          Text("Create your first budget to track spending!"),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
             onPressed: (){}, //Navigation to add budget page
             style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
             child: Text("+ Set New Budget",style: TextStyle(color: Colors.white),)
             ),
          )
        ],
      ),
    );
  }
}

class BudgetPlanningBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _BudgetPlannignBodyState();
}

class _BudgetPlannignBodyState extends State<BudgetPlanningBody>{
  int? editingIndex; // Track which index is being edited
  TextEditingController editingController = TextEditingController();
  List<Budget>? mockData = mockBudgetsJuly;

  DateFormat dateformat = DateFormat("MM/yyyy");
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    if(mockData!.isEmpty) {return screenIfNoBudgetExist();}

    double totalBudget = mockData!.fold(0.0, (total,budget) => total + budget.amount);
    double totalSpent = mockData!.fold(0.0, (total,budget) => total + budget.spentAmount);
    double remaining = totalBudget - totalSpent;

    String presentDate = dateformat.format(currentDate);
    String minDate = dateformat.format(DateTime(currentDate.year - 1, currentDate.month, currentDate.day));


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 400,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 6,
              ),
            ],
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Monthly Overview",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Text(presentDate, style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),

              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total budget:"),
                  Text("$totalBudget đ", style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),

              SizedBox(height: 15),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total spent:"),
                    Text("$totalSpent đ", style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
              ),

              SizedBox(height: 15),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Remaining:"),
                    Text("$remaining đ", style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
              ),
              
              SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:Colors.deepPurple.shade700,
                  )
                ),
                child: LinearProgressIndicator(
                  value: totalSpent / totalBudget,
                  backgroundColor: Colors.deepPurple.shade100,
                  color: Colors.deepPurple,
                ),
              )
            ],
          ),
        ),

        Divider(
          height: 10,
          thickness: 2,
          color: Colors.grey,
          indent: 10,
          endIndent: 10,
        ),


        Expanded(
          child: ListView.builder(
                  itemCount: mockData!.length,
                  itemBuilder: (context, index) {
                    bool isEditing = editingIndex == index;

                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(flex: 2, child: Text(mockData![index].categoryName)),

                              Spacer(),
                              
                              Expanded(
                                flex: 2,
                                child: isEditing
                                    ? TextField(
                                        controller: editingController,
                                        decoration: InputDecoration(
                                          hintText: "Enter new amount",
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      )
                                    : Text("${mockData![index].spentAmount}/${mockData![index].amount} đ"), //REPLACE WITH REAL DATA LATER
                              ),

                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isEditing) {
                                        // UPDATE DATA FUNCTION HERE
                                        editingIndex = null; // close editor
                                      } else {
                                        editingIndex = index;
                                        editingController.text = mockData![index].amount.toString(); // CURRENT VALUE WHEN CANCEL
                                      }
                                    });
                                  },
                                  icon: Icon(isEditing? Icons.save:Icons.edit),
                                ),
                              ),
                            ],
                          ),

                          // Optional extra row if you want to animate or show more
                          if (isEditing)
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Editing ${mockData![index].categoryName} budget",
                                      style: TextStyle(color: Colors.grey),
                                    ),

                                    SizedBox(width: 10,),

                                    Spacer(),

                                    IconButton(onPressed: (){
                                      setState(() {
                                        // DELETE FUNCTION BASE ON ID HERE
                                      });
                                    },
                                    style: IconButton.styleFrom(backgroundColor: Colors.deepPurple),
                                    icon: Icon(Icons.delete,color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                          

                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:Colors.deepPurple.shade700,
                              )
                            ),
                            child: LinearProgressIndicator(
                              value: mockData![index].spentAmount / mockData![index].amount,
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