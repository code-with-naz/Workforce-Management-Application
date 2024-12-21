import 'dart:convert';

import 'package:ecom_express/login.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart'; // Ensure this file correctly contains the `registration` URL

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller =  TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _isNotValid = false;

  void registerUser() async{
    print('Enter in api');
    if(emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty){

      var regBody= {
        "firstname":firstnamecontroller.text,
        "lastname":lastnamecontroller.text,
        "email":emailcontroller.text,
        "password":passwordcontroller.text

      };
      print("naziya");
      print(regBody);
      try {
        var response = await http.post(
          Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );
         print(response.statusCode);
        if (response.statusCode == 200) {
          print(response.statusCode);
          print(response.body);

         
          showDialog(context: context, builder: (context){
              // ignore: avoid_unnecessary_containers
              return Container(
                child: AlertDialog(
                  title: const Text('You have successfully registered!!Please Login',
                  style: TextStyle(fontSize: 15),
                  
                  ),
                  
                  actions: [
                    TextButton(onPressed:(){
                      
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context)=> MyLogin()),
                      
                      );

                    }, child: const Text("OK")),

                    TextButton(onPressed: (){
                    Navigator.pop(context);

                    },
                    child: Text("Cancel"),
                    ),
                  ],
                ),

              );

            });
          // Assuming 200 OK means success, handle success
          //  Navigator.push(
          //    context,
          //    MaterialPageRoute(
          //    builder: (context) => MyLogin()
          // //       firstname: firstnamecontroller.text,
          // //       lastname: lastnamecontroller.text,
          // //       email: emailcontroller.text,
          //      ),
             
          //  );
        } else {
          // Handle different HTTP response status codes
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Registration Failed'),
                content: Text('Error: ${response.statusCode}\n${response.body}'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        // Handle any exceptions that occur during the request
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('An error occurred: $e'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      setState(() {
        _isNotValid = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Register here!'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, right: 35, left: 35),
        child:SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Create Your Account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: firstnamecontroller,
              decoration: InputDecoration(
                hintText: 'Enter Your First Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lastnamecontroller,
              decoration: InputDecoration(
                hintText: 'Enter Your Last Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: 'Enter Email Id',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                errorText: _isNotValid && emailcontroller.text.isEmpty ? 'Email cannot be empty' : null,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                hintText: 'Enter your Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                errorText: _isNotValid && passwordcontroller.text.isEmpty ? 'Password cannot be empty' : null,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    registerUser();

                    //  Navigator.push(context, 
                    //  MaterialPageRoute(builder: (context)=> MyLogin()
                    // // Profile(firstname: firstnamecontroller.text,
                    // //         lastname: lastnamecontroller.text,
                    // //          email: emailcontroller.text),
                    //  ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    minimumSize: Size(130, 40),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyLogin()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    minimumSize: Size(130, 40),
                  ),
                  child: const Text(
                    'SignIn',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
