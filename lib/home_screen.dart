import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Profile Area (Top)
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Good morning!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'User',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Local Body',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // House Hold Survey Section
                const Text(
                  'Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _buildChildDetailsCard(
                    context, 'Child1', Colors.grey, 'These are Child1 details'),
                const SizedBox(height: 10),
                _buildChildDetailsCard(
                    context, 'Child2', Colors.grey, 'These are Child2 details'),
                const SizedBox(height: 10),
                _buildChildDetailsCard(
                    context, 'Child3', Colors.grey, 'These are Child3 details'),
                const SizedBox(height: 20),
                // Assigned Wards Section
                const Text(
                  'Assigned Asha Worker',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.people, color: Colors.black54),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Name here',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Active',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        '84%',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/qr-scanner');
              },
            ),
            IconButton(
              icon: const Icon(Icons.child_care, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/register-child');
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/notifications');
              },
            ),
            IconButton(
              icon: const Icon(Icons.home, color: Colors.blueAccent),
              onPressed: () {
                // Already on the Home page
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildDetailsCard(
      BuildContext context, String childName, Color color, String childDetails) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChildDetailsPage(childName: childName, childDetails: childDetails),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              childName,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}

class ChildDetailsPage extends StatelessWidget {
  final String childName;
  final String childDetails;

  const ChildDetailsPage({required this.childName, required this.childDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(childName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details for $childName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              childDetails,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
