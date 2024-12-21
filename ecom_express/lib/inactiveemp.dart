import 'package:flutter/material.dart';

class InactiveEmp extends StatelessWidget {
  const InactiveEmp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Inactive Employees',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
      body:Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
      
              child: 
            Image.asset('assets/inactive.png' , height:200 , width: 300, ),
            ),

        SizedBox(
          height: 20,

        ),

        Container(
         
          child: 

        Text('No Inactive Employees',
        
        style: TextStyle(
          fontFamily: 'Times new roman',
          fontSize: 15,
          color: Colors.black,
          
          

        ),
        
        ),
        ),
          ],
        ),
      ),

    );
  }
}