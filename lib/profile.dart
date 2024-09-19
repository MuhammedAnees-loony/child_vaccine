import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                      backgroundImage: AssetImage('D:\test2\assets\images\profile_pic.JPG'), // Replace with your image path
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Profile Information
            Text(
              'Kuriakose Philip',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'kp.csb2226@saintgits.org',
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
                    detail: '9567956975',
                  ),
                  ProfileDetail(
                    icon: Icons.email,
                    detail: 'kp.csb2226@saintgits.org',
                  ),
                  ProfileDetail(
                    icon: Icons.cake,
                    detail: '2003-01-12',
                  ),
                  ProfileDetail(
                    icon: Icons.card_membership,
                    detail: 'VXW3894',
                  ),
                  ProfileDetail(
                    icon: Icons.school,
                    detail: 'SAINTGITS COLLEGE OF ENGINEERING-MGP',
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
