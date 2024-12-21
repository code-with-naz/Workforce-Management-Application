import 'package:ecom_express/addholiday.dart';
import 'package:flutter/material.dart';

class Business extends StatelessWidget {
  const Business({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Business Holidays',
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
            Image.asset('assets/business.png' , height:200 , width: 300, ),
            ),

        SizedBox(
          height: 25,

        ),

        Container(
          padding:EdgeInsets.only(left: 50.0),
          child: 

        Text('Tap on  Add holidays to create holiday calendar for your business.',
        
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Addholiday()),);
      },

      child: Text('Add Holiday',
      style: TextStyle(
        fontFamily :'Times new roman',
        fontSize : 15,
        color: Colors.white,
        
      ),),

      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 32, 96, 148), 
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
