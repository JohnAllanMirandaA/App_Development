import 'dart:convert';
import 'Coordinator.dart';
import 'CoordinatorDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CoordinatorListPage extends StatelessWidget {
  final String serviceType;
  final String option;
  final String userEmail;

  CoordinatorListPage({required this.serviceType, required this.option, required this.userEmail});

  Future<List<Coordinator>> _fetchCoordinators() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(option);
    if (data == null) return [];
    return data.map((item) => Coordinator.fromJson(jsonDecode(item))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$option Coordinators'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<Coordinator>>(
        future: _fetchCoordinators(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No coordinators available.', style: TextStyle(color: Colors.white70)));
          } else {
            final coordinators = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: coordinators.length,
              itemBuilder: (context, index) {
                final coordinator = coordinators[index];
                return Card(
                  color: Colors.grey[850],
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: ListTile(
                    title: Text(coordinator.companyName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'Contact: ${coordinator.contactNumber}',
                      style: TextStyle(color: Colors.white70),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurpleAccent),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoordinatorDetailsPage(coordinator: coordinator),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}
