import 'package:flutter/material.dart';

class RegisterChildPage extends StatefulWidget {
  @override
  _RegisterChildPageState createState() => _RegisterChildPageState();
}

class _RegisterChildPageState extends State<RegisterChildPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  DateTime? _dob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Child'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the child\'s name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the child\'s age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _dob == null
                          ? 'Date of Birth: Not selected'
                          : 'Date of Birth: ${_dob!.toLocal().toShortDateString()}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _selectDate,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text(
                    'Register Child',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dob)
      setState(() {
        _dob = picked;
      });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Process the form data
      final name = _nameController.text;
      final age = _ageController.text;
      final dob = _dob;

      // Display the entered data
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Child Registered'),
            content: Text('Name: $name\nAge: $age\nDate of Birth: ${dob?.toLocal().toShortDateString() ?? 'Not selected'}'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      // Clear the form
      _nameController.clear();
      _ageController.clear();
      setState(() {
        _dob = null;
      });
    }
  }
}

extension DateTimeExtension on DateTime {
  String toShortDateString() {
    return '${this.day}/${this.month}/${this.year}';
  }
}
