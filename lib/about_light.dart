import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Ensure this import is correct

class AboutLight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Light'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.dark_mode),
            onPressed: () {
              Navigator.pushNamed(context, '/about_dark');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Encrypt'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/encryptor_light');
              },
            ),
            ListTile(
              title: Text('Decrypt'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/decryptor_light');
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/about_light');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/images/my.png'), // Replace with actual asset
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Md Zahid Hasan Patwary',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Image.asset(
                              'assets/images/dev.png', // Replace with actual asset
                              height: 120,
                            ),
                            SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'App Name: Encryptor',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'A simple text conversation app to protect your secret words.',
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: 16),
                                  _buildInfoRow('App Version:', '1.0.0'),
                                  _buildInfoRow('Release Date:', '15 Feb, 2025'),
                                  _buildInfoRow('Developed by:', 'Patwary Software Limited'),
                                  _buildInfoRow('Author:', 'Md Zahid Hasan Patwary'),
                                  _buildInfoRow('Designer:', 'Md Zahid Hasan Patwary'),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () async {
                                const url = 'https://github.com/0xZahidp';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Could not launch $url')),
                                  );
                                }
                              },
                              child: Text('GitHub'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Patwary Software © Copyright 2025',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}