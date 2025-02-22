import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Pushes content apart
            children: [
              const SizedBox(height: 50), // Added space at the top
              const Text(
                "Encryptor",
                style: TextStyle(
                  fontSize: 49,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                  fontFamily: 'Condensed',
                  color: Color(0xFF28905D),
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                'assets/images/EncryptorLogo.png',
                height: 280,
                width: 280,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome to Encryptor!",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Let’s secure your text in a simple way",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(
                    context,
                    "Encrypt",
                    '/encryptor',
                    Colors.green, // Custom color for Encrypt button
                  ),
                  const SizedBox(width: 20),
                  _buildButton(
                    context,
                    "Decrypt",
                    '/decryptor',
                    Colors.red, // Custom color for Decrypt button
                  ),
                ],
              ),

              // Spacer pushes the text to the bottom
              const SizedBox(height: 150),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Patwary Software © Copyright 2025',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String route, Color color) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        backgroundColor: color, // Set button color
        foregroundColor: Colors.white, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
