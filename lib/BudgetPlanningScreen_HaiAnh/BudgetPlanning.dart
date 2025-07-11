import 'package:flutter/material.dart';

class BudgetPlanning extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back),color: Colors.black,),// FUNCTION TO NAVIGATE BACK,
        title: Text("Budget Planning",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_circle),color: Colors.black,)
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
    return Column(
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
    );
  }
}

class BudgetPlanningBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _BudgetPlannignBodyState();
}

class _BudgetPlannignBodyState extends State<BudgetPlanningBody>{
  List<String> mockData = ["Item1","Item2","Item3","Item4","Item5","Item6","Item7","Item8","Item9","Item10"];
  //List<String> mockData = [];
  int? editingIndex; // Track which index is being edited
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 400,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
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
              Text("Monthly Oveview",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 10,),
              Text("Total budget: "),
              SizedBox(height: 10,),
              Text("Total spent: "),
              SizedBox(height: 10,),
              Text("Remaining: "),
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


        (mockData.isEmpty)? screenIfNoBudgetExist():
        Expanded(
          child: ListView.builder(
                  itemCount: mockData.length,
                  itemBuilder: (context, index) {
                    bool isEditing = editingIndex == index;

                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(flex: 1, child: Text(mockData[index])),
                              Expanded(
                                flex: 2,
                                child: isEditing
                                    ? TextField(
                                        controller: editingController,
                                        decoration: InputDecoration(
                                          hintText: "Enter new amount",
                                        ),
                                      )
                                    : Text("200\$"), //REPLACE WITH REAL DATA LATER
                              ),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isEditing) {
                                        // UPDATE DATA FUNCTION HERE
                                        editingIndex = null; // close editor
                                      } else {
                                        editingIndex = index;
                                        editingController.text = "200"; // CURRENT VALUE WHEN CANCEL
                                      }
                                    });
                                  },
                                  child: Text(isEditing ? "Save" : "Edit"),
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
                                      "Editing ${mockData[index]} budget",
                                      style: TextStyle(color: Colors.grey),
                                    ),

                                    SizedBox(width: 10,),

                                    Spacer(),

                                    ElevatedButton(onPressed: (){
                                      setState(() {
                                        // DELETE FUNCTION BASE ON ID HERE
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                                    child: Text("Delete",style: TextStyle(color: Colors.white),))
                                  ],
                                ),
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