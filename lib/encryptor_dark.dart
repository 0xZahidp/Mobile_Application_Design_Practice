import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EncryptorDark extends StatefulWidget {
  const EncryptorDark({Key? key}) : super(key: key);

  @override
  _EncryptorDarkState createState() => _EncryptorDarkState();
}

class _EncryptorDarkState extends State<EncryptorDark> {
  TextEditingController _inputController = TextEditingController();
  TextEditingController _outputController = TextEditingController();

  String original = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String mapped = "tuvwxyzabcdefghijklmnopqrsTUVWXYZABCDEFGHIJKLMNOQPRS";

  String encrypt(String input) {
    StringBuffer encrypted = StringBuffer();
    for (var ch in input.split('')) {
      int index = original.indexOf(ch);
      encrypted.write(index != -1 ? mapped[index] : ch);
    }

    String special1 = "#";
    String special2 = "@";
    int mid = encrypted.length ~/ 2;
    return special1 + encrypted.toString().substring(0, mid) + special2 + encrypted.toString().substring(mid);
  }

  void _encryptText() {
    String inputText = _inputController.text;
    if (inputText.isNotEmpty) {
      setState(() {
        _outputController.text = encrypt(inputText);
      });
    }
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _outputController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Copied to clipboard!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5CBA5C),
        title: Text("Encryptor"),
        actions: [
          IconButton(
            icon: Icon(Icons.light_mode),
            onPressed: () {
              Navigator.pushNamed(context, '/encryptor_light');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF5CBA5C),
              ),
            ),
            ListTile(
              title: Text(
                'Encrypt',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/encryptor_dark');
              },
            ),
            ListTile(
              title: Text(
                'Decrypt',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/decryptor_dark');
              },
            ),
            ListTile(
              title: Text(
                'About',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/about_dark');
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[900],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your plain text:",
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: _inputController,
              maxLines: 3,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[800],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
              ),
              onPressed: _encryptText,
              child: Text("Encrypt"),
            ),
            SizedBox(height: 20),
            Text(
              "Here you go! This is your encrypted text:",
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: _outputController,
              maxLines: 3,
              readOnly: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[800],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
              ),
              onPressed: _copyToClipboard,
              child: Text("Copy"),
            ),
          ],
        ),
      ),
    );
  }
}