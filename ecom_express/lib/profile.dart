import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
 

  final String firstname;
  final String lastname;
  final String email;

   const Profile({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.email,
}) : super (key : key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile',
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Times new roman',
          fontWeight: FontWeight.bold,
        ),
        
        ),
        backgroundColor: Colors.white,
      ),
      body:  Padding(
      padding:  EdgeInsets.all(16.0),
      child:
       Column(
        children: [
          Text(
              'firstname : ${widget.firstname}',
          ),
           Text(
            'lastname : ${widget.lastname}',
            
           ),

           Text(
            'email : ${widget.email}',
           )

        ],
      ),
      ),
    );
  }
}