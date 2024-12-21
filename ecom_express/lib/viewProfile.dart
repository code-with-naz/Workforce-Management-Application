import 'package:ecom_express/addadvance.dart';
import 'package:ecom_express/addovertime.dart';
import 'package:ecom_express/addremark.dart';
import 'package:ecom_express/attendance.dart';
import 'package:ecom_express/employee_detail.dart';
import 'package:ecom_express/payroll.dart';
import 'package:flutter/material.dart';

class ViewProfile extends StatelessWidget {
  final Map<String, dynamic> employee;

  const ViewProfile({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String initials = getInitials(employee['name'] ?? '');

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0, // Adjust the height of the AppBar if needed
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Color of the text and icons
        title: Center(
          child: Text(
            'View Profile',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0, // Removes shadow if not needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card with employee details
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: double.infinity, // Set the width of the card
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue, // Background color of the circle
                      child: Text(
                        initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      radius: 30, // Radius of the circle
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: InkWell(
                            onTap: (){
                              Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => EmployeeDetail(employee: employee))
                              );
                            },
                          
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Text(
                            '${employee['name']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          
                          Text(
                            '${employee['select_emp_type']}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          
                        ],
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // New section for Attendance and Advance
            ListTile(
              leading: Icon(Icons.calendar_month, size: 30), // Attendance logo
              title: Text('Attendance'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Attendance page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Attendance()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.schedule, size: 30), 
              title: Text('Overtime'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddOvertime()),
                );
              },
            ),


            ListTile(
              leading: Icon(Icons.av_timer_rounded, size: 30), 
              title: Text('Advance'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Addadvance()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.book, size: 30), 
              title: Text('Remarks'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Addremark(employee: employee)),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.paypal, size: 30), 
              title: Text('Payroll'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Payrolls()),
                );
              },
            ),


          ],
        ),
      ),
    );
  }

  // Function to get initials from the name
  String getInitials(String name) {
    List<String> parts = name.split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else {
      return '${name[0]}'.toUpperCase();
    }
  }
}

