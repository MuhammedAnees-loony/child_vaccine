import 'package:flutter/material.dart';

// Define the dialog box widget
Future<Map<String, String>?> showLoginDialog(BuildContext context) {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  return showDialog<Map<String, String>>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Username and Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String username = usernameController.text;
              String password = passwordController.text;
              Navigator.of(context).pop({'username': username, 'password': password});
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
