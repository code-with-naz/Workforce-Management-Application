import 'package:ecom_express/attendance.dart';
import 'package:ecom_express/business.dart';
import 'package:ecom_express/cashbook.dart';
import 'package:ecom_express/emp.dart';
import 'package:ecom_express/empadvance.dart';
import 'package:ecom_express/inactiveemp.dart';
import 'package:ecom_express/overtime.dart';
import 'package:ecom_express/payroll.dart';
import 'package:ecom_express/remarks.dart';
import 'package:ecom_express/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController(); 

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) { // Employees tab index
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Employee()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Cashbook()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Profile(
          firstname: firstnamecontroller.text,
          lastname: lastnamecontroller.text,
          email: emailcontroller.text,
        )),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    // Determine if the app is running on a mobile device
    final isMobile = screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Naziya Patel',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Employees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cases),
            label: 'Cashbooks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: isMobile ? 2 : 4, // Change number of columns based on device type
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          children: [
            buildGridItem(
              icon: Icons.person,
              title: "Employees",
              subtitle: "Manage your employees",
              color: const Color.fromARGB(255, 245, 219, 211),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Employee()),
                );
              },
            ),
            buildGridItem(
              icon: FontAwesomeIcons.calendar,
              title: "Attendance",
              subtitle: "Manage your Attendance",
              color: const Color.fromARGB(255, 245, 238, 160),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Attendance()),
                );
              },
            ),
            buildGridItem(
              icon: Icons.schedule,
              title: "Overtime",
              subtitle: "Manage employee overtime",
              color: const Color.fromARGB(255, 235, 206, 240),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Overtime()),
                );
              },
            ),
            buildGridItem(
              icon: FontAwesomeIcons.adversal,
              title: "Employee Advance",
              subtitle: "Manage employee Advance",
              color: const Color.fromARGB(255, 188, 247, 189),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmployeeAdvance()),
                );
              },
            ),
            buildGridItem(
              icon: FontAwesomeIcons.book,
              title: "Remarks",
              subtitle: "Manage employee remarks",
              color: const Color.fromARGB(255, 184, 211, 233),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Remarks(submittedRemark: {},)),
                );
              },
            ),
            buildGridItem(
              icon: FontAwesomeIcons.paypal,
              title: "Payrolls",
              subtitle: "View Employee Payroll",
              color: const Color.fromARGB(255, 248, 204, 187),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Payrolls()),
                );
              },
            ),
            buildGridItem(
              icon: Icons.holiday_village,
              title: "Business Holidays",
              subtitle: "Manage your business holidays",
              color: const Color.fromARGB(255, 181, 243, 183),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Business()),
                );
              },
            ),
            buildGridItem(
              icon: FontAwesomeIcons.personArrowDownToLine,
              title: "Inactive employees",
              subtitle: "Manage Inactive employees",
              color: const Color.fromARGB(255, 204, 220, 233),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InactiveEmp()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: Icon(icon, size: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
