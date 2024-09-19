// lib/screens/registerscreen.dart

import 'package:flutter/material.dart';
import 'widgets/custom_widgets.dart'; // Import the unified file

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
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
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomDropdownButtonFormField(
                value: _selectedCountry,
                hint: 'Select Country',
                items: _states.keys.map((country) => DropdownMenuItem<String>(
                  child: Text(country),
                  value: country,
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                    _selectedState = null;
                    _selectedDistrict = null;
                  });
                },
              ),
              SizedBox(height: 16),
              CustomDropdownButtonFormField(
                value: _selectedState,
                hint: 'Select State',
                items: (_selectedCountry == null ? [] : _states[_selectedCountry] ?? [])
                    .map((state) => DropdownMenuItem<String>(
                  child: Text(state),
                  value: state,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedState = value;
                    _selectedDistrict = null;
                  });
                },
              ),
              SizedBox(height: 16),
              CustomDropdownButtonFormField(
                value: _selectedDistrict,
                hint: 'Select District',
                items: (_selectedState == null ? [] : _districts[_selectedState] ?? [])
                    .map((district) => DropdownMenuItem<String>(
                  child: Text(district),
                  value: district,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDistrict = value;
                  });
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
                    return 'Please enter your pincode';
                  }
                  if (int.tryParse(value) == null) {
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
                    .map((sex) => DropdownMenuItem<String>(
                  child: Text(sex),
                  value: sex,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSex = value;
                  });
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
                    return 'Please enter your phone number';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Phone number must be a number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Handle registration logic here
                    Navigator.pop(context);
                  }
                },
                child: Text('Register'),
                style: AppStyles.buttonStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
