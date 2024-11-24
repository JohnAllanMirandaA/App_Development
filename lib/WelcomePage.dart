import 'dart:convert';
import 'UserLoginPage.dart';
import 'OrganizerLoginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paradise Planner"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Black background color
          Container(
            color: Colors.black, // Set the background color to black
          ),
          // Background image
          Positioned.fill(
            child: Center(
              child: Image.asset(
                'assets/Home2.png', // Ensure your image path is correct
                fit: BoxFit.cover, // Ensure the image covers the entire screen
              ),
            ),
          ),
          // Centered content (buttons)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align items to the top
              children: [
                SizedBox(height: 520), // Add vertical space before the first button
                SizedBox(
                  width: 300, // Set a fixed width for both buttons
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserLoginPage()),
                      );
                    },
                    child: Text("User Login"),
                  ),
                ),
                SizedBox(height: 20), // Space between buttons
                SizedBox(
                  width: 300, // Same width for both buttons
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrganizerLoginPage()),
                      );
                    },
                    child: Text("Organizer Login"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
