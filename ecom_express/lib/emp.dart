// import 'dart:convert';
// import 'package:ecom_express/cashbook.dart';
// import 'package:ecom_express/config.dart';
// import 'package:ecom_express/home.dart';
// import 'package:ecom_express/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'addemp.dart';
// import 'employee_detail.dart';

// class Employee extends StatefulWidget {
//   const Employee({super.key});

//   @override
//   _EmployeeState createState() => _EmployeeState();
// }

// class _EmployeeState extends State<Employee> {
//   TextEditingController firstnamecontroller = TextEditingController();
//   TextEditingController lastnamecontroller = TextEditingController();
//   TextEditingController emailcontroller = TextEditingController();

//   int _selectedIndex = 1;
//   List<dynamic> employees = [];
//   List<dynamic> filteredEmployees = [];
//   bool showSearch = false;

//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchEmployees();
//     _searchController.addListener(_filterEmployees);
//   }

//   void _fetchEmployees() async {
//   try {
//     final response = await http.get(
//       Uri.parse('$getemp'), // Ensure this is the correct endpoint
//       headers: {'Content-Type': 'application/json; charset=UTF-8'},
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       final List<dynamic> employeeList = data['data']; // Access the 'data' field
//       setState(() {
//         employees = employeeList;
//         filteredEmployees = employees;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to load employees')),
//       );
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error: $e')),
//     );
//   }
// }

//   void _filterEmployees() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       filteredEmployees = employees.where((employee) {
//         final name = employee['name'].toLowerCase();
//         return name.contains(query);
//       }).toList();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text('Employees', style: TextStyle(color: Colors.black)),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               setState(() {
//                 showSearch = !showSearch;
//               });
//             },
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Employee',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.cases),
//             label: 'Cashbook',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//       ),
//       body: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Column(
//           children: [
//             if (showSearch)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.search),
//                     hintText: 'Search Employees',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                 ),
//               ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredEmployees.length,
//                 itemBuilder: (context, index) {
//                   final employee = filteredEmployees[index];
//                   return ListTile(
//                     title: Text(employee['name']),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => EmployeeDetail(
//                             employee: employee,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddEmp()),
//           );
//           _fetchEmployees(); // Refresh employee list after adding a new one
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: Colors.blue,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     if (index == 0) {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
//     } else if (index == 1) {
//       // Do nothing as we are already on the Employees screen
//     } else if (index == 2) {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => const Cashbook()));
//     } else if (index == 3) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Profile(
//             firstname: firstnamecontroller.text,
//             lastname: lastnamecontroller.text,
//             email: emailcontroller.text,
//           ),
//         ),
//       );
//     }
//   }
// }
import 'dart:convert';
import 'package:ecom_express/cashbook.dart';
import 'package:ecom_express/config.dart';
import 'package:ecom_express/home.dart';
import 'package:ecom_express/profile.dart';
import 'package:ecom_express/viewProfile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'addemp.dart';
//import 'employee_detail.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  _EmployeeState createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  int _selectedIndex = 1;
  List<dynamic> employees = [];
  List<dynamic> filteredEmployees = [];
  bool showSearch = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
    _searchController.addListener(_filterEmployees);
  }

  void _fetchEmployees() async {
    try {
      final response = await http.get(
        Uri.parse('$getemp'), // Ensure this is the correct endpoint
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> employeeList = data['data']; // Access the 'data' field
        setState(() {
          employees = employeeList;
          filteredEmployees = employees;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load employees')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _filterEmployees() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredEmployees = employees.where((employee) {
        final name = employee['name'].toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Employees', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                showSearch = !showSearch;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Employee',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cases),
            label: 'Cashbook',
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
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            if (showSearch)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search Employees',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
            Expanded(
  child: ListView.builder(
    itemCount: filteredEmployees.length,
    itemBuilder: (context, index) {
      final employee = filteredEmployees[index];
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewProfile(employee: employee),
                ),
              );
            },
            
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    employee['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            
          ),
          if (index != filteredEmployees.length - 1) // Don't add a divider after the last item
            const Divider(
              color: Color.fromARGB(255, 248, 239, 239), // Set the color of the divider
              thickness: 1.0, // Set the thickness of the line
            ),
        ],
      );
    },
  ),
),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEmp()),
          );
          _fetchEmployees(); // Refresh employee list after adding a new one
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
    } else if (index == 1) {
      // Do nothing as we are already on the Employees screen
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Cashbook()));
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(
            firstname: firstnamecontroller.text,
            lastname: lastnamecontroller.text,
            email: emailcontroller.text,
          ),
        ),
      );
    }
  }
}
