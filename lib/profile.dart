import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  // Removed unnecessary parameters
  static void handleLogin(String username, String password) {
    // Handle the login data as needed
    print('Received username: $username and password: $password');
    // You can store these in a state management solution if needed
  }

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Call fetchUserDetails inside the initState
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    final url = Uri.parse('http://localhost:5000/get-user-details'); // Change to your backend URL
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
    }, body: json.encode({
      'username': '', // You can pass the username here
      'password': '', // You can pass the password here
    }));

    if (response.statusCode == 200) {
      setState(() {
        userDetails = json.decode(response.body)['user'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Show an error message if user not found or invalid credentials
      final errorMessage = json.decode(response.body)['message'];
      _showErrorDialog(errorMessage);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Header with Back Button and Profile Picture
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage('D:/test2/assets/images/profile_pic.JPG'), // Replace with your image path
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Profile Information
            Text(
              userDetails?['first_name'] ?? 'N/A',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              userDetails?['email'] ?? 'N/A', // Assuming email is part of the user details
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 30),
            // Profile Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileDetail(
                    icon: Icons.phone,
                    detail: userDetails?['phone_number'] ?? 'N/A',
                  ),
                  ProfileDetail(
                    icon: Icons.email,
                    detail: userDetails?['email'] ?? 'N/A',
                  ),
                  ProfileDetail(
                    icon: Icons.cake,
                    detail: userDetails?['dob'] ?? 'N/A',
                  ),
                  ProfileDetail(
                    icon: Icons.card_membership,
                    detail: userDetails?['occupation'] ?? 'N/A',
                  ),
                  ProfileDetail(
                    icon: Icons.school,
                    detail: userDetails?['institution'] ?? 'N/A', // Assuming institution is part of the user details
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text(
                      'How to use the App (Video Tutorial)',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'App Version : 9',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final IconData icon;
  final String detail;

  ProfileDetail({required this.icon, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.black54),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              detail,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
