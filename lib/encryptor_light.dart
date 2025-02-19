import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EncryptorLight extends StatefulWidget {
  const EncryptorLight({Key? key}) : super(key: key);

  @override
  _EncryptorLightState createState() => _EncryptorLightState();
}

class _EncryptorLightState extends State<EncryptorLight> {
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
        title: Text("Encryptor Light"),
        actions: [
          IconButton(
            icon: Icon(Icons.dark_mode),
            onPressed: () {
              Navigator.pushNamed(context, '/encryptor_dark');
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
                color: Color(0xFF5CBA5C),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter your plain text:"),
            TextField(
              controller: _inputController,
              maxLines: 3,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF28905D)),
              onPressed: _encryptText,
              child: Text("Encrypt"),
            ),
            SizedBox(height: 20),
            Text("Here you go! This is your encrypted text:"),
            TextField(
              controller: _outputController,
              maxLines: 3,
              readOnly: true,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF28905D)),
              onPressed: _copyToClipboard,
              child: Text("Copy"),
            ),
          ],
        ),
      ),
    );
  }
}