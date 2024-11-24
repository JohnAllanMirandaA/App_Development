import 'dart:convert';
import 'Coordinator.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CoordinatorDetailsPage extends StatefulWidget {
  final Coordinator coordinator;

  CoordinatorDetailsPage({required this.coordinator});

  @override
  _CoordinatorDetailsPageState createState() => _CoordinatorDetailsPageState();
}

class _CoordinatorDetailsPageState extends State<CoordinatorDetailsPage> {
  final _feedbackController = TextEditingController();
  double _rating = 3.0; // Initial rating value

  Future<void> _submitFeedback() async {
    final prefs = await SharedPreferences.getInstance();
    final feedbackData = {
      'rating': _rating,
      'feedback': _feedbackController.text,
      'companyName': widget.coordinator.companyName,
    };
    final feedbackList = prefs.getStringList('feedback_${widget.coordinator.companyName}') ?? [];
    feedbackList.add(jsonEncode(feedbackData));
    await prefs.setStringList('feedback_${widget.coordinator.companyName}', feedbackList);

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Thank you!"),
        content: Text("Your feedback has been submitted."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Return to CoordinatorListPage
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coordinator.companyName),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Number: ${widget.coordinator.contactNumber}",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            Text(
              "Service Type: ${widget.coordinator.serviceType}",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            Divider(color: Colors.white38, thickness: 1.5, height: 30),
            Text("Rate this Coordinator:", style: TextStyle(fontSize: 18, color: Colors.white)),
            Slider(
              value: _rating,
              min: 1.0,
              max: 5.0,
              divisions: 4,
              label: _rating.toString(),
              activeColor: Colors.deepPurple,
              inactiveColor: Colors.grey[800],
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            Text("Rating: ${_rating.toStringAsFixed(1)}", style: TextStyle(color: Colors.white70)),
            SizedBox(height: 20),
            TextField(
              controller: _feedbackController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Feedback",
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 3,
            ),
           SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitFeedback,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                ),
                child: Text(
                  "Submit Feedback",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
