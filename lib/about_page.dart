import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool isDarkMode = false;
  bool systemPreference = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      systemPreference = prefs.getBool('system_preference') ?? false;
      if (systemPreference) {
        isDarkMode = Theme.of(context).brightness == Brightness.dark;
      } else {
        isDarkMode = prefs.getBool('is_dark_mode') ?? false;
      }
    });
  }

  Future<void> _launchGitHub() async {
    final Uri url = Uri.parse('https://github.com/0xZahidp');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      elevation: 4,
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/images/my.png'),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Md Zahid Hasan Patwary',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Image.asset(
                              'assets/images/dev.png',
                              height: 120,
                            ),
                            const SizedBox(height: 16),
                            _buildInfoSection(),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _launchGitHub,
                              child: const Text('GitHub'),
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
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          _buildDrawerItem(context, "Encrypt", '/encryptor'),
          _buildDrawerItem(context, "Decrypt", '/decryptor'),
          //_buildDrawerItem(context, "About", '/about'),
          _buildDrawerItem(context, "Settings", '/settings'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pushNamed(context, route);
        });
      },
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('App Name:', 'Encryptor'),
        _buildInfoRow('Description:', 'A simple text encryption app to protect your secret words.'),
        _buildInfoRow('App Version:', '1.0.0'),
        _buildInfoRow('Release Date:', '15 Feb, 2025'),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 4),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
