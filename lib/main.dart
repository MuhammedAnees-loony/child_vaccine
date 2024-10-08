import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'qr_scanner_screen.dart';
import 'profile.dart'; // Ensure the ProfilePage import is correct
import 'notification.dart';
import 'register_child.dart';
import 'vaccine_schedule.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Care App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterScreen(),
        '/qr-scanner': (context) => QRScannerScreen(),
        // Updated profile route to accept username and password directly
        '/profile': (context) => ProfilePage(),

        '/register-child': (context) => RegisterChildPage(),
        '/notifications': (context) => NotificationScreen(),
        '/vaccine-schedule': (context) => VaccineSchedulePage(),
      },
    );
  }
}
