import 'dart:convert';
import 'Coordinator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoordinatorRegistrationPage extends StatefulWidget {
  @override
  _CoordinatorRegistrationPageState createState() =>
      _CoordinatorRegistrationPageState();
}

class _CoordinatorRegistrationPageState
    extends State<CoordinatorRegistrationPage> {
  final _companyNameController = TextEditingController();
  final _managerNameController = TextEditingController();
  final _contactNoController = TextEditingController();
  final _locationController = TextEditingController();
  final _aadharController = TextEditingController();

  String? _selectedServiceType;

  final List<String> _serviceTypes = [
    'Food',
    'Catering',
    'Cake',
    'Decorations',
    'Makeup',
    'Flowers',
    'Hall',
    'All Together'
  ];

  Future<void> _submitForm() async {
    if (_companyNameController.text.isEmpty ||
        _managerNameController.text.isEmpty ||
        _contactNoController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _aadharController.text.isEmpty ||
        _selectedServiceType == null) {
      _showDialog('Please fill in all fields.');
    } else {
      final prefs = await SharedPreferences.getInstance();
      final coordinator = Coordinator(
        companyName: _companyNameController.text,
        contactNumber: _contactNoController.text,
        serviceType: _selectedServiceType!,
      );

      final coordinatorJson = jsonEncode(coordinator.toJson());
      final existingData = prefs.getStringList(_selectedServiceType!) ?? [];
      existingData.add(coordinatorJson);
      await prefs.setStringList(_selectedServiceType!, existingData);

      _showDialog('Coordinator registration successful.');
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Notification'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color of Scaffold to black
      appBar: AppBar(
        title: Text('Coordinator Registration'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.black, // Set container background color to black
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Register as a Coordinator",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildTextField(_companyNameController, "Company Name"),
              SizedBox(height: 15),
              _buildTextField(_managerNameController, "Manager Name"),
              SizedBox(height: 15),
              _buildTextField(_contactNoController, "Contact Number"),
              SizedBox(height: 15),
              _buildTextField(_locationController, "Location"),
              SizedBox(height: 15),
              _buildTextField(_aadharController, "Aadhar Number"),
              SizedBox(height: 15),
              _buildDropdown(),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[900],
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white70),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.grey[900],
        value: _selectedServiceType,
        hint: Text("Select Service Type", style: TextStyle(color: Colors.white70)),
        iconEnabledColor: Colors.white70,
        isExpanded: true,
        underline: SizedBox(),
        items: _serviceTypes.map((String serviceType) {
          return DropdownMenuItem<String>(
            value: serviceType,
            child: Text(serviceType, style: TextStyle(color: Colors.white)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedServiceType = newValue;
          });
        },
      ),
    );
  }
}
// Assume Coordinator class is already defined with a `fromJson()` method
