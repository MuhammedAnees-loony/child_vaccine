import 'package:flutter/material.dart';

class VaccineSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccine Schedule'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upcoming Vaccinations',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildVaccineCard('Polio', 'Due: 12 Sep 2024'),
            const SizedBox(height: 10),
            _buildVaccineCard('Hepatitis B', 'Due: 15 Oct 2024'),
            // Add more vaccine details as needed
          ],
        ),
      ),
    );
  }

  Widget _buildVaccineCard(String vaccineName, String dueDate) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vaccineName,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            dueDate,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
