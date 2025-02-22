import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecryptorPage extends StatefulWidget {
  const DecryptorPage({Key? key}) : super(key: key);

  @override
  _DecryptorPageState createState() => _DecryptorPageState();
}

class _DecryptorPageState extends State<DecryptorPage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  String _decryptText(String input) {
    if (input.length < 5 || !input.startsWith('#') || !input.endsWith('\$')) {
      return "Invalid encrypted text";
    }

    // Remove wrapping special characters
    input = input.substring(1, input.length - 1);

    // Remove marker characters (., ,) before extracting special characters
    input = input.replaceAll(".,", "").replaceAll(",#,", "#").replaceAll(".@.", "@").replaceAll(".\$.", "\$");

    int middleIndex = input.indexOf('@');
    if (middleIndex == -1 || middleIndex == 0 || middleIndex == input.length - 1) {
      return "Invalid encrypted text";
    }

    String firstHalf = input.substring(0, middleIndex);
    String secondHalf = input.substring(middleIndex + 1);
    input = firstHalf + secondHalf;

    final Map<String, String> charMapping = {
      'y': 'a', 'x': 'b', 'w': 'c', 'v': 'd', 'u': 'e', 't': 'f', 's': 'g',
      'r': 'h', 'q': 'i', 'p': 'j', 'o': 'k', 'n': 'l', 'm': 'm', 'l': 'n',
      'k': 'o', 'j': 'p', 'i': 'q', 'h': 'r', 'g': 's', 'f': 't', 'e': 'u',
      'd': 'v', 'c': 'w', 'b': 'x', 'a': 'y', 'z': 'z',
      '8': '0', '7': '1', '6': '2', '5': '3', '4': '4', '3': '5', '2': '6', '1': '7', '0': '8', '9': '9',
      'M': 'A', 'N': 'B', 'O': 'C', 'P': 'D', 'Q': 'E', 'R': 'F', 'S': 'G',
      'T': 'H', 'U': 'I', 'V': 'J', 'W': 'K', 'X': 'L', 'Y': 'M', 'Z': 'N',
      'A': 'O', 'B': 'P', 'C': 'Q', 'D': 'R', 'E': 'S', 'F': 'T', 'G': 'U',
      'H': 'V', 'I': 'W', 'J': 'X', 'K': 'Y', 'L': 'Z'
    };

    // Decrypt text
    String decrypted = input.split('').map((char) => charMapping[char] ?? char).join();

    // Restore the original @ position
    decrypted = decrypted.replaceAll('@', '');

    return decrypted;
  }

  void _decrypt() {
    String inputText = _inputController.text.trim();
    if (inputText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter text to decrypt!")));
      return;
    }
    setState(() {
      _outputController.text = _decryptText(inputText);
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
      appBar: AppBar(title: const Text("Decryptor"), backgroundColor: Theme.of(context).primaryColor),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter encrypted text:"),
            const SizedBox(height: 5),
            TextField(controller: _inputController, maxLines: 3, decoration: const InputDecoration(border: OutlineInputBorder())),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _decrypt, child: const Text("Decrypt")),
            const SizedBox(height: 20),
            const Text("Decrypted Text:"),
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
          _buildDrawerItem(context, "Encrypt", '/encryptor'),
          //_buildDrawerItem(context, "Decrypt", '/decryptor'),
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
