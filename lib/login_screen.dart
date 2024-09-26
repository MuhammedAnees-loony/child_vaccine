import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController(); // Phone number controller
  final TextEditingController _otpController = TextEditingController();   // OTP controller
  String? _generatedOtp; // To store the OTP received from the backend

  // Function to generate OTP by sending the phone number to the backend
  Future<void> _generateOtp() async {
    final String phoneNumber = _phoneController.text;
    if (phoneNumber.isEmpty) {
      _showDialog('Error', 'Please enter your phone number');
      return;
    }

    print('Sending request to backend for OTP generation with phone number: $phoneNumber');

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/generate-otp'), // Updated Flask backend URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone_number': phoneNumber}), // Updated JSON payload key
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Convert OTP to string if it's an integer
        setState(() {
          _generatedOtp = responseData['otp'].toString(); // Convert OTP to String
        });

        print('OTP received from backend: $_generatedOtp');
        _showDialog('Success', 'OTP generated. Please check your phone.');
      } else {
        print('Failed to generate OTP. Status code: ${response.statusCode}');
        _showDialog('Error', 'Failed to generate OTP.');
      }
    } catch (e) {
      print('Error occurred during OTP generation: $e');
      _showDialog('Error', 'An error occurred: $e');
    }
  }


  // Function to verify the OTP entered by the user
  Future<void> _checkOtp() async {
    final String otp = _otpController.text;
    if (otp.isEmpty || _generatedOtp == null) {
      _showDialog('Error', 'Please enter the OTP.');
      return;
    }

    print('Checking OTP. Entered OTP: $otp, Generated OTP: $_generatedOtp');

    // Verify OTP against stored OTP (if verification is done locally)
    if (otp == _generatedOtp) {
      print('OTP verification successful.');
      _showDialog('Success', 'OTP verified. You are logged in.');
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      print('OTP verification failed.');
      _showDialog('Error', 'Invalid OTP.');
    }
  }

  void _showDialog(String title, String message) {
    print('$title: $message');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('LoginScreen build method called.');
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Username TextField (from the old UI)
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        print('Username entered: $value');
                      },
                    ),
                    SizedBox(height: 12),
                    // Password TextField (from the old UI)
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        print('Password entered: $value');
                      },
                    ),
                    SizedBox(height: 20),
                    // Phone Number TextField (for OTP login)
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        print('Phone number entered: $value');
                      },
                    ),
                    SizedBox(height: 20),
                    // Generate OTP Button
                    ElevatedButton(
                      onPressed: _generateOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Generate OTP',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    // OTP TextField
                    TextField(
                      controller: _otpController,
                      decoration: InputDecoration(
                        labelText: 'Enter OTP',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        print('OTP entered: $value');
                      },
                    ),
                    SizedBox(height: 20),
                    // Check OTP Button
                    ElevatedButton(
                      onPressed: _checkOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Check OTP',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Register New User Button (from the old UI)
                    TextButton(
                      onPressed: () {
                        print('Navigating to Register screen.');
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('Register New User'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blueAccent,
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
