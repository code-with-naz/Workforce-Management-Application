import 'dart:convert';
import 'package:ecom_express/config.dart';
import 'package:ecom_express/employees.dart';
import 'package:ecom_express/remarks.dart'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Addremark extends StatefulWidget {
  final Map<String, dynamic>? employee; // Accept employee as parameter

  const Addremark({super.key, this.employee});

  @override
  State<Addremark> createState() => _AddremarkState();
}

class _AddremarkState extends State<Addremark> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _nameController.text = widget.employee!['name'] ?? ''; // Pre-fill name if available
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
    return const TextStyle(
      color: Colors.black,
      fontSize: 16,
    );
  }

  Future<void> _submitRemark() async {
    if (_nameController.text.isEmpty || _dateController.text.isEmpty || _remarkController.text.isEmpty) {
      _showMessage('Please fill in all fields.');
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      final response = await http.post(
        Uri.parse("$remark"), // Replace with the correct endpoint URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': _nameController.text,
          'dateOfJoining': _dateController.text,
          'remarks': _remarkController.text,
        }),
      );

      if (response.statusCode == 200) {
        final submittedRemark = {
          'name': _nameController.text,
          'dateOfJoining': _dateController.text,
          'remarks': _remarkController.text,
        };
        _showMessage('Remark added successfully!', success: true);
        _clearFields();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Remarks(submittedRemark: submittedRemark), // Pass remark data to Remarks page
          ),
        );
      } else {
        _showMessage('Failed to add remark. Please try again.');
      }
    } catch (e) {
      _showMessage('Error: $e');
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  void _showMessage(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  void _clearFields() {
    _dateController.clear();
    _remarkController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Remark',
            style: TextStyle(
              fontFamily: 'Times new roman',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Employee: ${widget.employee != null ? widget.employee!['name'] : 'No Employee Selected'}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 34, 1, 1),
                ),
              ),
              const SizedBox(height: 20),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Employees()),
                  );
                },
                child: const Icon(Icons.add),
                backgroundColor: Colors.blue,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 12.0),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Date',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: _inputDecoration('Select Date').copyWith(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dateController.text =
                              "${pickedDate.toLocal()}".split(' ')[0];
                        });
                      }
                    },
                  ),
                ),
                style: _textStyle(),
              ),
              const SizedBox(height: 10),
              const Text(
                'Remarks',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _remarkController,
                decoration: InputDecoration(
                  hintText: 'Enter remarks',
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
              ),
              const SizedBox(height: 180),
              Center(
                child: ElevatedButton(
                  onPressed: isSubmitting ? null : _submitRemark,
                  
                  child: Text(
                    isSubmitting ? 'Submitting...' : 'Submit',
                    style: const TextStyle(
                      color: Colors.white,
                      
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 7, 87, 156),
                    minimumSize: const Size(350, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
