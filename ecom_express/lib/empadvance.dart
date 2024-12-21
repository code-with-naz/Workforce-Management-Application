import 'package:ecom_express/addadvance.dart';
import 'package:flutter/material.dart';

class EmployeeAdvance extends StatelessWidget {
  const EmployeeAdvance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: 
         Text('Advance',
         style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
         ),),
        ),
      ),

      body:Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
      
              child: 
            Image.asset('assets/advance.jpg' , height:200 , width: 300, ),
            ),

        SizedBox(
          height: 20,

        ),

        Container(
          padding:EdgeInsets.only(left: 50.0),
          child: 

        Text('Tap on Add Advance button to create employee advance records for your employees',
        
        style: TextStyle(
          fontFamily: 'Times new roman',
          fontSize: 15,
          color: Colors.grey,
          
          

        ),
        
        ),
        ),

         SizedBox(
          height: 20,

        ),
      

      ElevatedButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Addadvance()),);
      },

      child: Text('Add Advance',
      style: TextStyle(
        fontFamily :'Times new roman',
        fontSize : 15,
        color: Colors.white,
        
      ),),

      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 6, 75, 133), 
        minimumSize: Size(30, 40),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          
        ),
      ),
      
      ),
          ],
      ),
      ),
      
    );
  }
}


   