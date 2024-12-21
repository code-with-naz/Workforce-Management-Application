import 'package:ecom_express/business.dart';

import 'package:flutter/material.dart';

class Addholiday extends StatefulWidget {
  const Addholiday({super.key});

  @override
  State<Addholiday> createState() => _AddholidayState();
}

class _AddholidayState extends State<Addholiday> {
  final TextEditingController _dateController = TextEditingController();
      

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
        title: Center(
          child: Text(
            'Add New Holiday',
            style: TextStyle(
              fontFamily: 'Times new roman',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      body: Container(
        padding: EdgeInsets.all(10.0),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
             
              Text(
                ' Date',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 10),

              
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: _inputDecoration('Select Date').copyWith(
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
                          _dateController.text =
                              "${pickedDate.toLocal()}".split(' ')[0];
                        });
                      }
                    },
                  ),
                ),
                style: _textStyle(),
              ),
              SizedBox(height: 10),
              
              
              const SizedBox(height: 10),
              Text(
                'Holiday Name',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter holiday name',
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
              ),
              const SizedBox(height: 320),
              Container(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Business()),
                      );
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 143, 152, 160),
                      minimumSize: Size(350, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
          ],
          ),
    ),
    );
        
      
    
  }
}

   
