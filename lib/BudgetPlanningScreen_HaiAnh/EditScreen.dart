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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              // Thay đổi từ const InputDecoration sang InputDecoration
              border: InputBorder.none,
              hintText: '0.00',
              // --- THÊM DÒNG NÀY ĐỂ HIỂN THỊ ĐƠN VỊ TIỀN TỆ ---
              suffixIcon: Padding(
                // Sử dụng suffixIcon để đặt widget bên trong
                padding: const EdgeInsets.only(
                  right: 8.0,
                ), // Để tạo khoảng cách
                child: Text(
                  'VND', // Hoặc biểu tượng "₫" nếu có font hỗ trợ
                  style: TextStyle(
                    fontSize: 18, // Kích thước font phù hợp
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700], // Màu sắc của đơn vị
                  ),
                ),
              ),
              suffixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ), // Giúp suffixIcon không chiếm quá nhiều không gian
            ),
          ),
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