import 'dart:convert';
import 'EventOptionsPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserDashboard extends StatelessWidget {
  final String email;

  UserDashboard({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black, // Set background color to black
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select the event",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              buildEventButton(context, "Marriage", 'Marriage'),
              SizedBox(height: 20),
              buildEventButton(context, "Birthday", 'Birthday'),
              SizedBox(height: 20),
              buildEventButton(context, "Other Events", 'Other Events'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEventButton(BuildContext context, String label, String serviceType) {
    return SizedBox(
      width: 200, // Set the width for all buttons
      height: 50,  // Set the height for all buttons
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Button color
          foregroundColor: Colors.white, // Text color
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventOptionsPage(serviceType: serviceType, userEmail: email),
            ),
          );
        },
        child: Text(label, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
