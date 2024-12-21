import 'package:flutter/material.dart';

class EmployeeDetail extends StatelessWidget {
  final Map<String, dynamic> employee;

  const EmployeeDetail({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${employee['name']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Mobile Number: ${employee['mobile_no']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Date of Joining: ${employee['dateOfJoining']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Employee Type: ${employee['select_emp_type']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Designation: ${employee['designation']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Salary: \$${employee['salary']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Leave Month: ${employee['leave_month']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Shift: ${employee['shift']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("In Time: ${employee['intime']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Out Time: ${employee['outtime']}", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
