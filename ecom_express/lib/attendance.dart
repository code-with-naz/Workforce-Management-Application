import 'dart:convert';
import 'package:ecom_express/config.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  DateTime today = DateTime.now();
  List<dynamic> employees = [];
  bool isLoading = true;
  int? selectedEmployeeIndex;

  // Map to store attendance data for each employee
  Map<int, Map<DateTime, String>> employeeAttendance = {};

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  void _fetchEmployees() async {
    try {
      final response = await http.get(
        Uri.parse('$getemp'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> employeeList = data['data'];
        setState(() {
          employees = employeeList;
          isLoading = false;
          // Initialize the employeeAttendance map
          for (int i = 0; i < employees.length; i++) {
            employeeAttendance[i] = {}; // Each employee starts with an empty attendance map
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load employees')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _markAttendance(int employeeIndex, String status) async {
    if (selectedEmployeeIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select an employee first')),
      );
      return;
    }

    final employeeId = employees[employeeIndex]['_id']; // Assuming employee ID is stored in '_id'
    final employeeName = employees[employeeIndex]['name']; // Fetch employee name
    final date = today.toIso8601String().split('T')[0]; // Get date in YYYY-MM-DD format

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.132/api/markAttendance'), // Adjust with your backend API
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'employeeId': employeeId,
          'employeeName': employeeName, // Include employee name
          'date': date,
          'status': status,
        }),
      );

      if (response.statusCode == 200) {
        // Update attendance map
        setState(() {
          employeeAttendance.putIfAbsent(
            employeeIndex,
            () => <DateTime, String>{},
          );

          // Access the map for the selected employee
          final employeeMap = employeeAttendance[employeeIndex]!;
          employeeMap[today] = status; // Update the attendance status
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Attendance marked successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to mark attendance: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Method to determine color based on attendance type
  Color getColorForAttendance(String type) {
    switch (type) {
      case 'Present':
        return const Color.fromARGB(255, 150, 240, 153);
      case 'Halfday':
        return Colors.yellow;
      case 'Absent':
        return Colors.red;
      case 'Holiday':
        return Colors.purple;
      case 'Notset':
        return Colors.blue;
      default:
        return Colors.grey; // Default color if type is unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Mark Attendance',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        TableCalendar(
          selectedDayPredicate: (day) => isSameDay(day, today),
          focusedDay: today,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2025, 10, 16),
          onDaySelected: _onDaySelected,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          eventLoader: (day) {
            if (selectedEmployeeIndex == null || 
                !employeeAttendance.containsKey(selectedEmployeeIndex)) {
              return [];
            }
            // Load events for the selected employee on the specific day
            final attendanceType = employeeAttendance[selectedEmployeeIndex]![day];
            return attendanceType != null ? [attendanceType] : [];
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              if (events.isNotEmpty) {
                return Positioned(
                  bottom: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: events.map((event) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        width: 6.0,
                        height: 6.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getColorForAttendance(event as String), // Ensure event is String
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : employees.isEmpty
                  ? const Center(
                      child: Text(
                        'No employees found',
                        style: TextStyle(
                          fontFamily: 'Times New Roman',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: employees.length,
                      itemBuilder: (context, index) {
                        final employee = employees[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEmployeeIndex = index;
                                });
                              },
                              child: EmployeeCard(employee: employee),
                            ),
                            // Display attendance buttons for each employee by default
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 10.0, right: 10.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    buildAttendanceButton('Present', index),
                                    const SizedBox(width: 8),
                                    buildAttendanceButton('Halfday', index),
                                    const SizedBox(width: 8),
                                    buildAttendanceButton('Absent', index),
                                    const SizedBox(width: 8),
                                    buildAttendanceButton('Holiday', index),
                                    const SizedBox(width: 8),
                                    buildAttendanceButton('Notset', index),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
        ),
      ],
    );
  }

  Widget buildAttendanceButton(String label, int employeeIndex) {
    final buttonColor = getColorForAttendance(label);
    return ElevatedButton(
      onPressed: () {
        _markAttendance(employeeIndex, label); // Call the method to mark attendance
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4.0),
        child: Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: buttonColor,
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.employee});

  final Map<String, dynamic> employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 248, 245, 245),
            offset: Offset(0.0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 250, 243, 243),
            child: Icon(Icons.person),
          ),
          const SizedBox(width: 10),
          Text(
            employee['name'], // Assuming the employee name is stored here
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
