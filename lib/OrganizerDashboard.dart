import 'dart:convert';
import 'CoordinatorRegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OrganizerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organizer Dashboard"),
        backgroundColor: Colors.deepPurple, // Optional: Make AppBar a distinct color
      ),
      body: Container(
        color: Colors.black, // Set background color to black
        padding: EdgeInsets.all(16.0), // Add padding around content
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to the Organizer Dashboard",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text color
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30), // Space between text and button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoordinatorRegistrationPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  backgroundColor: Colors.deepPurple, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  ),
                  elevation: 5, // Add a shadow for depth
                ),
                child: Text(
                  "Register as Coordinator",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text color for readability
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

