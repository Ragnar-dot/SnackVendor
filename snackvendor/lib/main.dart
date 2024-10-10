import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackvendor/Coin/coin_screen.dart';
import 'package:snackvendor/Owner/owner_Screen.dart';
import 'package:snackvendor/VendorMachine/vendingMachineScreen.dart';



// Importiere Provider für Transaktionen, Produkte und Münzen

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
    body: const Stack(
      children: [
        // Hauptbildschirm: ProductScreen als Hintergrund
        Positioned.fill(
          child: ProductScreen(),
        ),





        // Owner-Zugang ebenfalls anpassbar
        Positioned(
          top: 400, // Am oberen Rand positioniert
          right: 100,
          width: 200, // Breite kann angepasst werden
          height: 100, // Höhe kann angepasst werden
          child: OwnerScreen(),

        ),






        // Münzverwaltung und Transaktionen in einem anpassbaren Bereich
        Positioned(
          
          bottom: 0, // Am unteren Rand positioniert
          left: 10,
          right: 800,
          height: 800, // Höhe kann angepasst werden
          child: CoinScreen(),
        ),



      ],
    ),
  );
}
}

