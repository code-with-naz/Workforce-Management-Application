import 'package:ecom_express/login.dart';
import 'package:flutter/material.dart';

class Forgot extends StatelessWidget {
  const Forgot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
      ),


      // ignore: avoid_unnecessary_containers
      body:Container(
        padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1,right: 35,left: 35),
        child: Column(
          children: [

            Text(
              'Change Your Password',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),

            ),

            const SizedBox(
            height: 10,
          ),

            TextField(
              decoration: InputDecoration(
                hintText:'Enter Your Email Id',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

              ),
              
            ),

             const SizedBox(
              height: 10,
            ),

            TextField(

              decoration:InputDecoration(
                hintText: 'Enter New Password',
               border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10)),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            TextField(
              decoration: InputDecoration(
               hintText: 'Confirm Password' ,
               border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
               ),
               
              ),
            ),

             const SizedBox(
              height: 10,
            ),

            ElevatedButton(onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=> const MyLogin()
              ),
              );

            },child: Text('Submit',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              
            ),
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              minimumSize: Size(250, 40),
            ),
            
            ),



            
          ],
        ),


      ),
    );
  }
}