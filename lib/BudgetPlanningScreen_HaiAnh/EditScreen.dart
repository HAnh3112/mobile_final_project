import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Editscreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back),color: Colors.black,),// FUNCTION TO NAVIGATE BACK,
        title: Text("Edit",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        backgroundColor: Colors.deepPurple,
      ),
      body: EditScreenBody(),
    );
  }
}

class EditScreenBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _EditScreenBodyState();
}

class _EditScreenBodyState extends State<EditScreenBody>{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(15),
          width: 200,
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: "Budget",
              border: OutlineInputBorder(),
              suffixText: "đ"
            ),
          )
        ),

        SizedBox(height: 20,),

        Text("This will show categories!"),

        SizedBox(height: 20,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple), 
            child: Text("CONFIRM",style: TextStyle(color: Colors.black),)),

            VerticalDivider(
              thickness: 10,
              color: Colors.grey
            ),

            ElevatedButton(onPressed: (){}, child: Text("CANCEL"))
          ],
        )
      ],
    );
  }
}