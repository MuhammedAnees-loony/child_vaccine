import 'package:flutter/material.dart';

class ChildDetailsPage extends StatelessWidget {
  final List<Map<String, String>> children = [
    {
      'name': 'Child 1',
      'age': '5 years',
      'gender': 'Male',
      'school': 'ABC Primary School',
    },
    {
      'name': 'Child 2',
      'age': '7 years',
      'gender': 'Female',
      'school': 'XYZ Elementary School',
    },
    // Add more children as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Children Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: children.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChildDetailScreen(child: children[index]),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
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
                      children[index]['name']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Age: ${children[index]['age']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Gender: ${children[index]['gender']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'School: ${children[index]['school']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChildDetailScreen extends StatelessWidget {
  final Map<String, String> child;

  const ChildDetailScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${child['name']} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${child['name']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Age: ${child['age']}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'Gender: ${child['gender']}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'School: ${child['school']}',
              style: const TextStyle(fontSize: 20),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
