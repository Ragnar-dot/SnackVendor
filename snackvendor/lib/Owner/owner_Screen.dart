import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'refill_Screen.dart'; // Import the new screen

class OwnerScreen extends ConsumerStatefulWidget {
  const OwnerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OwnerScreenState createState() => _OwnerScreenState();
}

class _OwnerScreenState extends ConsumerState<OwnerScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool _isPinCorrect = false;
  final String _correctPin = '1234'; 

  void _checkPin() {
    if (_pinController.text == _correctPin) {
      setState(() {
        _isPinCorrect = true;
      });
      // Navigate to the RefillScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RefillScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falscher PIN. Bitte versuchen Sie es erneut.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: TextField(
                controller: _pinController,
                obscureText: true, 
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'PIN',
                  labelStyle: TextStyle(fontSize: 16),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 14, 251, 2), // Hintergrundfarbe des Buttons
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Runde Ecken
                ),
              ),
              onPressed: _checkPin,
              child: const Text('Bestätigen', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

