import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ServicePage extends StatelessWidget {
  final String serviceType;
  final String userEmail;

  ServicePage({required this.serviceType, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceType),
      ),
      body: Center(
        child: Text("Booking service for: $serviceType\nUser: $userEmail"),
      ),
    );
  }
}
