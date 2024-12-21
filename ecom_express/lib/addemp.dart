import 'dart:convert';
import 'package:ecom_express/config.dart';
import 'package:ecom_express/emp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddEmp extends StatefulWidget {
  const AddEmp({super.key});

  @override
  State<AddEmp> createState() => _AddEmpState();
}

class _AddEmpState extends State<AddEmp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _designController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _leaveController = TextEditingController();
  final TextEditingController _shiftController = TextEditingController();
  final TextEditingController _intimeController = TextEditingController();
  final TextEditingController _outtimeController = TextEditingController();

 TimeOfDay _timeofDay = TimeOfDay.now();
   String _dropdownValue = 'Select Employee Type';
  String _paymentType = 'Monthly'; // Default value for payment type
  final List<String> _items = ['Select Employee Type', 'Employee', 'Student', 'Manager', 'Driver', 'Others'];
  final List<String> _paymentTypes = ['Monthly', 'Daily', 'Hourly'];
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');


  void onSubmit() async {
    print("ENter in onsubmit function");
  if (_nameController.text.isNotEmpty) {
    final formattedDate = _dateController.text;
    final response = await http.post(
      Uri.parse("$employee"),     //('http://192.168.1.120:3000/api/employee/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
    // "name": "naz",
    // "mobile_no": 8989765036,
    // "dateOfJoining": "2024-08-21",
    // "select_emp_type": "employee",
    // "designation": "pune",
    // "salary": 16000,
    // "leave_month": "december",
    // "shift": "Morning",
    // "intime": "8:00pm",
    // "outtime": "5:00pm"
        'name': _nameController.text,
        'mobile_no': _mobileController.text,
        'dateOfJoining':formattedDate ,
        'select_emp_type': _dropdownValue,
        'designation': _designController.text,
        'salary':_salaryController.text,
        'leave_month': _leaveController.text,
        'shift': _shiftController.text,
        'intime': _intimeController.text,
        'outtime': _outtimeController.text,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Employee added successfully')));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Employee()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add employee')));
    }
  }
}


  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintText: 'Enter $label',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: _inputDecoration('Name'),
                style: _textStyle(),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _mobileController,
                decoration: _inputDecoration('Mobile Number'),
                style: _textStyle(),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: _inputDecoration('Joining Date').copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dateController.text = _dateFormat.format(pickedDate);
                        });
                      }
                    },
                  ),
                ),
                style: _textStyle(),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _dropdownValue,
                 decoration: _inputDecoration('Employee Type'),
                 items: _items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: _textStyle()),
                  );
                 }).toList(),
                 onChanged: (String? newValue) {
                  setState(() {
                     _dropdownValue = newValue!;
                   });
                 },
                style: _textStyle(),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _designController,
                decoration: _inputDecoration('Designation (Optional)'),
                style: _textStyle(),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Payment Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ..._paymentTypes.map((type) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 14.0), 
                    
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _paymentType = type;
                        });
                      },
                      child: Text(type),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _paymentType == type ? const Color.fromARGB(255, 174, 214, 247) : const Color.fromARGB(255, 243, 234, 234),
                        textStyle: const TextStyle(color: Colors.white),
                        
                      ),
                    ),
                    );
                  }).toList(),
                ],
              ),
          
      
              const SizedBox(height: 10),
              TextField(
                controller: _salaryController,
                decoration: _inputDecoration('Salary Amount'),
                keyboardType: TextInputType.number,
                style: _textStyle(),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _leaveController,
                decoration: _inputDecoration('Leaves in a month'),
                style: _textStyle(),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _shiftController,
                decoration: _inputDecoration('Shift'),
                style: _textStyle(),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _intimeController,
                      decoration: _inputDecoration('In Time').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.lock_clock_rounded),
                          onPressed: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: _timeofDay,
                              context: context,
                            );
                            if (pickedTime != null) {
                              setState(() {
                                _intimeController.text = pickedTime.format(context);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _outtimeController,
                      decoration: _inputDecoration('Out Time').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.lock_clock_rounded),
                          onPressed: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: _timeofDay,
                              context: context,
                            );
                            if (pickedTime != null) {
                              setState(() {
                                _outtimeController.text = pickedTime.format(context);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
              onPressed: () async {
    
              onSubmit();

    
              // Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => const Employee()),
              // );
              },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}
