import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;

  const SettingsPage({super.key, required this.onThemeChanged});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLightMode = false;
  bool isDarkMode = false;
  bool isSystemDefault = true; // Default to system mode

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLightMode = prefs.getBool('is_light_mode') ?? false;
      isDarkMode = prefs.getBool('is_dark_mode') ?? false;
      isSystemDefault = prefs.getBool('is_system_default') ?? true;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_light_mode', isLightMode);
    await prefs.setBool('is_dark_mode', isDarkMode);
    await prefs.setBool('is_system_default', isSystemDefault);
  }

  void _updateTheme(ThemeMode mode) {
    setState(() {
      if (mode == ThemeMode.light) {
        isLightMode = true;
        isDarkMode = false;
        isSystemDefault = false;
      } else if (mode == ThemeMode.dark) {
        isLightMode = false;
        isDarkMode = true;
        isSystemDefault = false;
      } else {
        isLightMode = false;
        isDarkMode = false;
        isSystemDefault = true;
      }
    });

    _savePreferences();
    widget.onThemeChanged(mode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: _buildDrawer(context), // Added Navigation Drawer
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Theme",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  _buildThemeToggle(
                    icon: Icons.light_mode,
                    title: "Light Mode",
                    value: isLightMode,
                    onChanged: (bool value) {
                      if (value) _updateTheme(ThemeMode.light);
                    },
                  ),
                  const Divider(),
                  _buildThemeToggle(
                    icon: Icons.dark_mode,
                    title: "Dark Mode",
                    value: isDarkMode,
                    onChanged: (bool value) {
                      if (value) _updateTheme(ThemeMode.dark);
                    },
                  ),
                  const Divider(),
                  _buildThemeToggle(
                    icon: Icons.brightness_auto,
                    title: "System Default",
                    value: isSystemDefault,
                    onChanged: (bool value) {
                      if (value) _updateTheme(ThemeMode.system);
                    },
                  ),
                ],
              ),
            ),

            const Spacer(), // Pushes copyright text to the bottom
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Patwary Software © Copyright 2025',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Navigation Drawer
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
          _buildDrawerItem(context, "About", '/about'),
          //_buildDrawerItem(context, "Settings", '/settings'),
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

  // Toggle Switch for Theme Selection
  Widget _buildThemeToggle({required IconData icon, required String title, required bool value, required Function(bool) onChanged}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
