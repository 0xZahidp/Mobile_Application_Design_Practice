import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecryptorLight extends StatefulWidget {
  const DecryptorLight({Key? key}) : super(key: key);

  @override
  _DecryptorLightState createState() => _DecryptorLightState();
}

class _DecryptorLightState extends State<DecryptorLight> {
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
            icon: Icon(Icons.dark_mode),
            onPressed: () {
              Navigator.pushNamed(context, '/decryptor_dark');
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
            Text("Enter encrypted text:"),
            TextField(
              controller: _inputController,
              maxLines: 3,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF28905D)),
              onPressed: _decryptText,
              child: Text("Decrypt"),
            ),
            SizedBox(height: 20),
            Text("Decrypted text:"),
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