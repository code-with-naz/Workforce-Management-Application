import 'package:ecom_express/addovertime.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Overtime extends StatelessWidget {
  const Overtime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Center(
        child:  Text('Overtime',
        style: TextStyle(
          fontFamily: 'Times New Roman',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          
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
            Image.asset('assets/overtime.jpg' , height:200 , width: 300, ),
            ),

        SizedBox(
          height: 20,

        ),

        Container(
          padding:EdgeInsets.only(left: 50.0),
          child: 

        Text('Tap on overtime button to add overtime entries of your employees',
        
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddOvertime()),);
      },

      child: Text('Add Overtime',
      style: TextStyle(
        fontFamily :'Times new roman',
        fontSize : 12,
        color: Colors.white,
        
      ),),

      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 52, 35, 201), 
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

