import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'about_page.dart';
import 'decryptor_page.dart';
import 'encryptor_page.dart';
import 'settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ThemeMode savedThemeMode = await _loadThemePreference();
  runApp(MyApp(themeMode: savedThemeMode));
}

Future<ThemeMode> _loadThemePreference() async {
  final prefs = await SharedPreferences.getInstance();
  bool? systemPreference = prefs.getBool('system_preference');
  bool? isDarkMode = prefs.getBool('is_dark_mode');

  if (systemPreference == null || isDarkMode == null) {
    return ThemeMode.light; // Default to Light Mode if values are missing
  }

  if (systemPreference) {
    return ThemeMode.system;
  }
  return isDarkMode ? ThemeMode.dark : ThemeMode.light;
}

class MyApp extends StatefulWidget {
  final ThemeMode themeMode;
  const MyApp({super.key, required this.themeMode});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.themeMode;
  }

  void _updateTheme(ThemeMode mode) async {
    setState(() {
      _themeMode = mode;
    });
    final prefs = await SharedPreferences.getInstance();
    if (mode == ThemeMode.system) {
      await prefs.setBool('system_preference', true);
    } else {
      await prefs.setBool('system_preference', false);
      await prefs.setBool('is_dark_mode', mode == ThemeMode.dark);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Encryptor App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/decryptor': (context) => const DecryptorPage(),
        '/encryptor': (context) => const EncryptorPage(),
        '/settings': (context) => SettingsPage(onThemeChanged: _updateTheme),
      },
    );
  }
}
