import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/custom_widgets.dart'; // Make sure this points to your custom widgets

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _villageController = TextEditingController();
  final _occupationController = TextEditingController();
  final _marriedController = TextEditingController();
  final _phoneController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedDistrict;
  String? _selectedSex;

  // Country, state, district options
  final Map<String, List<String>> _states = {
    'USA': ['California', 'New York', 'Texas'],
    'India': ['Delhi', 'Karnataka', 'Maharashtra', 'Kerala'],
  };

  final Map<String, List<String>> _districts = {
    'California': ['Los Angeles', 'San Francisco'],
    'New York': ['Manhattan', 'Brooklyn'],
    'Texas': ['Houston', 'Dallas'],
    'Delhi': ['North Delhi', 'South Delhi'],
    'Karnataka': ['Bengaluru', 'Mysuru'],
    'Maharashtra': ['Mumbai', 'Pune'],
    'Kerala': ['Thiruvananthapuram', 'Kochi', 'Kollam', 'Palakkad'],
  };

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      print('Selected date: $_selectedDate');
    }
  }

  Future<void> _registerUser() async {
    print('Attempting to register user...');
    final url = Uri.parse('http://127.0.0.1:5000/register'); // Replace with your Flask backend URL

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'address': _addressController.text,
        'pincode': _pincodeController.text,
        'village': _villageController.text,
        'occupation': _occupationController.text,
        'married': _marriedController.text,
        'phone_number': _phoneController.text,
        'dob': _selectedDate?.toIso8601String(),
        'country': _selectedCountry,
        'state': _selectedState,
        'district': _selectedDistrict,
        'sex': _selectedSex,
      }),
    );

    if (response.statusCode == 200) {
      print('Registration successful');
      Navigator.pop(context);
    } else {
      print('Registration failed. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Handle error here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'User Registration',
                style: AppStyles.headingTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: _firstNameController,
                labelText: 'First Name',
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print('First name is empty');
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: _lastNameController,
                labelText: 'Last Name',
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print('Last name is empty');
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomDropdownButtonFormField(
                value: _selectedCountry,
                hint: 'Select Country',
                items: _states.keys.map((country) {
                  return DropdownMenuItem<String>(
                    child: Text(country),
                    value: country,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                    _selectedState = null;
                    _selectedDistrict = null;
                  });
                  print('Selected country: $_selectedCountry');
                },
              ),
              SizedBox(height: 16),
              CustomDropdownButtonFormField(
                value: _selectedState,
                hint: 'Select State',
                items: (_selectedCountry == null ? [] : _states[_selectedCountry] ?? [])
                    .map((state) {
                  return DropdownMenuItem<String>(
                    child: Text(state),
                    value: state,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedState = value;
                    _selectedDistrict = null;
                  });
                  print('Selected state: $_selectedState');
                },
              ),
              SizedBox(height: 16),
              CustomDropdownButtonFormField(
                value: _selectedDistrict,
                hint: 'Select District',
                items: (_selectedState == null ? [] : _districts[_selectedState] ?? [])
                    .map((district) {
                  return DropdownMenuItem<String>(
                    child: Text(district),
                    value: district,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDistrict = value;
                  });
                  print('Selected district: $_selectedDistrict');
                },
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: _addressController,
                labelText: 'Address',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: _pincodeController,
                labelText: 'Pincode',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print('Pincode is empty');
                    return 'Please enter your pincode';
                  }
                  if (int.tryParse(value) == null) {
                    print('Invalid pincode');
                    return 'Pincode must be a number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: _villageController,
                labelText: 'Village',
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    labelText: 'Date of Birth',
                    suffixIcon: Icon(Icons.calendar_today),
                    controller: TextEditingController(
                      text: _selectedDate == null
                          ? ''
                          : '${_selectedDate!.toLocal()}'.split(' ')[0],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        print('DOB is empty');
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              CustomDropdownButtonFormField(
                value: _selectedSex,
                hint: 'Select Sex',
                items: ['Male', 'Female', 'Other']
                    .map((sex) {
                  return DropdownMenuItem<String>(
                    child: Text(sex),
                    value: sex,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSex = value;
                  });
                  print('Selected sex: $_selectedSex');
                },
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: _occupationController,
                labelText: 'Occupation',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: _marriedController,
                labelText: 'Married (Yes/No)',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: _phoneController,
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print('Phone number is empty');
                    return 'Please enter your phone number';
                  }
                  if (int.tryParse(value) == null) {
                    print('Invalid phone number');
                    return 'Phone number must be a number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    print('Form is valid');
                    _registerUser();
                  } else {
                    print('Form is invalid');
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
