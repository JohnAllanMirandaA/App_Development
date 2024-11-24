import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BookingDetailsPage extends StatelessWidget {
  final String serviceType;
  final String option;
  final String userEmail;

  BookingDetailsPage({required this.serviceType, required this.option, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking for $option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Service: $serviceType\nOption: $option\nUser: $userEmail",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle booking logic here
              },
              child: Text("Book Now"),
            ),
          ],
        ),
      ),
    );
  }
}

