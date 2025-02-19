import 'package:flutter/material.dart';
import 'homepage.dart';
import 'about_dark.dart';
import 'about_light.dart';
import 'decryptor_dark.dart';
import 'decryptor_light.dart';
import 'encryptor_dark.dart';
import 'encryptor_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Encryptor App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/about_dark': (context) => AboutDark(),
        '/about_light': (context) => AboutLight(),
        '/decryptor_dark': (context) => DecryptorDark(),
        '/decryptor_light': (context) => DecryptorLight(),
        '/encryptor_dark': (context) => EncryptorDark(),
        '/encryptor_light': (context) => EncryptorLight(),
      },
    );
  }
}
