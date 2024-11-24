import 'dart:convert';
import 'Coordinator.dart';
import 'CoordinatorListPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventOptionsPage extends StatelessWidget {
  final String serviceType;
  final String userEmail;

  EventOptionsPage({required this.serviceType, required this.userEmail});

  final List<String> options = [
    'Food', 'Catering', 'Flowers', 'Decorations', 'Hall', 'Cake', 'Makeup', 'All Together'
  ];

  Future<List<Coordinator>> getCoordinatorsForService(String serviceType) async {
    final prefs = await SharedPreferences.getInstance();
    final coordinatorData = prefs.getStringList(serviceType);
    if (coordinatorData == null) {
      return [];
    }
    return coordinatorData.map((coordinatorJson) {
      return Coordinator.fromJson(jsonDecode(coordinatorJson));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select the Service'),
      ),
      body: Container(
        color: Colors.black, // Set background color to black
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: List.generate((options.length / 2).ceil(), (rowIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0), // Vertical spacing between rows
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: _buildServiceButton(context, options[rowIndex * 2])),
                    SizedBox(width: 10), // Horizontal spacing between buttons
                    if (rowIndex * 2 + 1 < options.length)
                      Expanded(child: _buildServiceButton(context, options[rowIndex * 2 + 1])),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceButton(BuildContext context, String option) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoordinatorListPage(
              serviceType: serviceType,
              option: option,
              userEmail: userEmail,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners for buttons
        ),
      ),
      child: Text(
        option,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

