import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isEncryptHovered = false;
  bool _isDecryptHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Encryptor Title
            const Text(
              "Encryptor",
              style: TextStyle(
                fontSize: 49, // Font size
                fontStyle: FontStyle.italic, // Italic
                fontWeight: FontWeight.w600, // Semibold (600 weight)
                height: 28 / 49, // Line height adjustment
                fontFamily: 'Condensed', // Custom Font (make sure it's added in pubspec.yaml)
                  color: Color(0xFF28905D),
              ),
            ),
            const SizedBox(height: 10), // Space between title and logo

            // Logo
            Image.asset(
              'assets/images/EncryptorLogo.png', // Path to your image
              height: 349,
              width: 349,
            ),
            const SizedBox(height: 20),

            // Welcome Text
            const Text(
              "Welcome to Encryptor!",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            const Text(
              "Let’s secure your text in a simple way",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, color: Colors.grey),
            ),
            const SizedBox(height: 15),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Encrypt Button with Hover Effect
                MouseRegion(
                  onEnter: (_) => setState(() => _isEncryptHovered = true),
                  onExit: (_) => setState(() => _isEncryptHovered = false),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/encryptor_light');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isEncryptHovered ? Color(0xFF1E7A4E) : Color(0xFF28905D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: const Text(
                      "Encrypt",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // Decrypt Button with Hover Effect
                MouseRegion(
                  onEnter: (_) => setState(() => _isDecryptHovered = true),
                  onExit: (_) => setState(() => _isDecryptHovered = false),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/decryptor_light');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isDecryptHovered ? Color(0xFF1E7A4E) : Color(0xFF28905D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: const Text(
                      "Decrypt",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
