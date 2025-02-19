import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecryptorDark extends StatefulWidget {
  const DecryptorDark({Key? key}) : super(key: key);

  @override
  _DecryptorDarkState createState() => _DecryptorDarkState();
}

class _DecryptorDarkState extends State<DecryptorDark> {
  TextEditingController _inputController = TextEditingController();
  TextEditingController _outputController = TextEditingController();

  String original = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String mapped = "tuvwxyzabcdefghijklmnopqrsTUVWXYZABCDEFGHIJKLMNOQPRS";

  String decrypt(String input) {
    if (input.length < 3) return "Invalid encrypted text";

    String cleaned = input.substring(1, input.indexOf('@')) + input.substring(input.indexOf('@') + 1);

    StringBuffer decrypted = StringBuffer();
    for (var ch in cleaned.split('')) {
      int index = mapped.indexOf(ch);
      decrypted.write(index != -1 ? original[index] : ch);
    }
    return decrypted.toString();
  }

  void _decryptText() {
    String inputText = _inputController.text;
    if (inputText.isNotEmpty) {
      setState(() {
        _outputController.text = decrypt(inputText);
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
        title: Text("Decryptor"),
        actions: [
          IconButton(
            icon: Icon(Icons.light_mode),
            onPressed: () {
              Navigator.pushNamed(context, '/decryptor_light');
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
              "Enter encrypted text:",
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
              onPressed: _decryptText,
              child: Text("Decrypt"),
            ),
            SizedBox(height: 20),
            Text(
              "Decrypted text:",
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