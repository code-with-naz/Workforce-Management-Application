
import 'package:ecom_express/addadvance.dart';
import 'package:ecom_express/addemp.dart';
import 'package:ecom_express/addholiday.dart';
import 'package:ecom_express/addovertime.dart';
import 'package:ecom_express/addremark.dart';
import 'package:ecom_express/attendance.dart';
import 'package:ecom_express/business.dart';
import 'package:ecom_express/cashbook.dart';
//import 'package:ecom_express/config.dart';
import 'package:ecom_express/emp.dart';
import 'package:ecom_express/empadvance.dart';
import 'package:ecom_express/forgot.dart';
import 'package:ecom_express/home.dart';
import 'package:ecom_express/inactiveemp.dart';
import 'package:ecom_express/login.dart';
import 'package:ecom_express/overtime.dart';
import 'package:ecom_express/payroll.dart';
import 'package:ecom_express/remarks.dart';
import 'package:ecom_express/profile.dart';
import 'package:ecom_express/signup.dart';
import 'package:flutter/material.dart';


void main(){

  
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,

    initialRoute: 'login',
    routes: {
      'login': (context)=>const MyLogin(),
      'signup' : (context)=> const SignUp(),
      'home': (context) =>  const Home(),
      'forgot':(cotext)=> const Forgot(),
      'employee':(context)=> const Employee(),
      'cashbook' : (context)=> const Cashbook(),
      'profile' : (context)=> const Profile(firstname: 'naziya', lastname: 'patel', email: 'nazp@gmail.com',),
      'addemp' : (context)=> const AddEmp(),
      'attendance': (context)=> const Attendance(),
      'overtime': (context)=> const Overtime(),
      'empadvance':(context)=> const EmployeeAdvance(),
      'remarks': (context)=>  const Remarks(submittedRemark: {},),
      'payrolls' : (context)=> const Payrolls(),
      'business': (context)=> const Business(),
      'inactiveemp': (context)=> const InactiveEmp(),
      'addovertime' :(context)=>  AddOvertime(),
      'addadvance' : (context)=> const Addadvance(),
      'addremark' : (context)=> Addremark(),
      'addholiday': (context)=> Addholiday(),
    },

  ),
  );
}

