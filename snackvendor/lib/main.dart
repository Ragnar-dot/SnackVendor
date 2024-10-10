import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackvendor/Coin/coin_screen.dart';
import 'package:snackvendor/Owner/owner_screen.dart';
import 'package:snackvendor/VendorMachine/vending_machine_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snackautomat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Der beste Snackautomat'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(
        children: [
          // ProductScreen als Hauptbildschirm-Hintergrund
          Positioned(
            top: 200,
            left: 150,
            right: 150,
            bottom: 200,
            
            child: Container(
              child: const ProductScreen(),
            ),
          ),
      

          // OwnerScreen: Frei positionierbar
          Positioned(
            top: 100,  // Y-Position (oben)
            right: 200, // X-Position (rechts)
            child: Container(
              width: 190,  // Breite des OwnerScreen
              height: 100, // Höhe des OwnerScreen
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(183, 255, 0, 0)),
                color: const Color.fromARGB(2, 255, 255, 255).withOpacity(0.2),
              ),
              child: const OwnerScreen(),
            ),
          ),

          // CoinScreen: Frei positionierbar
          Positioned(
            bottom: 500,  // Y-Position (unten)
            left: 10,    // X-Position (links)
            child: Container(
              width: 150,  // Breite des CoinScreen
              height: 500, // Höhe des CoinScreen
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                color: const Color.fromARGB(255, 234, 234, 234).withOpacity(0.9),
              ),
              child: const CoinScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
