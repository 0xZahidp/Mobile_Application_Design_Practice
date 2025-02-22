import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EncryptorPage extends StatefulWidget {
  const EncryptorPage({Key? key}) : super(key: key);

  @override
  _EncryptorPageState createState() => _EncryptorPageState();
}

class _EncryptorPageState extends State<EncryptorPage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  String _encryptText(String input) {
    final Map<String, String> charMapping = {
      'a': 'y', 'b': 'x', 'c': 'w', 'd': 'v', 'e': 'u', 'f': 't', 'g': 's',
      'h': 'r', 'i': 'q', 'j': 'p', 'k': 'o', 'l': 'n', 'm': 'm', 'n': 'l',
      'o': 'k', 'p': 'j', 'q': 'i', 'r': 'h', 's': 'g', 't': 'f', 'u': 'e',
      'v': 'd', 'w': 'c', 'x': 'b', 'y': 'a', 'z': 'z',
      '0': '8', '1': '7', '2': '6', '3': '5', '4': '4', '5': '3', '6': '2', '7': '1', '8': '0', '9': '9',
      'A': 'M', 'B': 'N', 'C': 'O', 'D': 'P', 'E': 'Q', 'F': 'R', 'G': 'S',
      'H': 'T', 'I': 'U', 'J': 'V', 'K': 'W', 'L': 'X', 'M': 'Y', 'N': 'Z',
      'O': 'A', 'P': 'B', 'Q': 'C', 'R': 'D', 'S': 'E', 'T': 'F', 'U': 'G',
      'V': 'H', 'W': 'I', 'X': 'J', 'Y': 'K', 'Z': 'L'
    };

    // Encrypt text using mapping
    String transformed = input.split('').map((char) => charMapping[char] ?? char).join();

    // Insert marker characters before adding special characters
    transformed = transformed.replaceAll("@", ".@.").replaceAll("#", ",#,").replaceAll("\$", ".\$.");

    // Insert special characters
    String specialStart = "#";
    String specialMiddle = "@";
    String specialEnd = "\$";

    int middleIndex = (transformed.length / 2).floor();
    String encrypted = specialStart + transformed.substring(0, middleIndex) + specialMiddle + transformed.substring(middleIndex) + specialEnd;

    return encrypted;
  }

  void _encrypt() {
    String inputText = _inputController.text.trim();
    if (inputText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter text to encrypt!")));
      return;
    }
    setState(() {
      _outputController.text = _encryptText(inputText);
    });
  }

  void _copyToClipboard() {
    if (_outputController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No text to copy!")));
      return;
    }
    Clipboard.setData(ClipboardData(text: _outputController.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Copied to clipboard!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Encryptor"), backgroundColor: Theme.of(context).primaryColor),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter your plain text:"),
            const SizedBox(height: 5),
            TextField(controller: _inputController, maxLines: 3, decoration: const InputDecoration(border: OutlineInputBorder())),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _encrypt, child: const Text("Encrypt")),
            const SizedBox(height: 20),
            const Text("Encrypted Text:"),
            const SizedBox(height: 5),
            TextField(controller: _outputController, maxLines: 3, readOnly: true, decoration: const InputDecoration(border: OutlineInputBorder())),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _copyToClipboard, child: const Text("Copy")),
          ],
        ),
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
            child: const Text('Menu', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          //_buildDrawerItem(context, "Encrypt", '/encryptor'),
          _buildDrawerItem(context, "Decrypt", '/decryptor'),
          _buildDrawerItem(context, "About", '/about'),
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
}
