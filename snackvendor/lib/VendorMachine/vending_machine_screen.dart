import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:snackvendor/provider.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stackManager = ref.watch(stackManagerProvider);

    ('Produkte geladen: ${stackManager.products.length}');

    return Stack(
      children: [
        // Hintergrundbild-Container
        Positioned.fill(
          child: Container(
            width: 800,
            height: 800,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Vendor/Vendor.png'), // Hintergrundbild aus den Assets
                fit: BoxFit.cover,
              
                 // Bild an die Größe anpassen
              ),
            ),
          ),
        ),
        // GridView in einem anpassbaren Container
        Positioned(
          top: 70, // Positionierung des GridView von oben
          left: 130, // Positionierung des GridView von links
          right: 240, // Positionierung des GridView von rechts
          bottom: 270, // Positionierung des GridView von unten
          child: Container(
            padding: const EdgeInsets.all(16.0), // Padding innerhalb des Containers
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(), // Scroll-Verhalten
              
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true, // Verhindert, dass das GridView unendlich viel Platz beansprucht
                    padding: const EdgeInsets.all(20.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Anzahl der Spalten im Raster
                      crossAxisSpacing: 5.0, // Abstand zwischen den Spalten
                      mainAxisSpacing: 5.0, // Abstand zwischen den Reihen
                      childAspectRatio: 0.8, // Verhältnis der Breite zur Höhe der Zellen
                    ),
                    itemCount: stackManager.products.length,
                    itemBuilder: (context, index) {
                      final product = stackManager.products[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1), // Hintergrund für Produkt-Container
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Produktbild
                            Expanded(
                              child: Image.asset(
                                product.imageUrl,
                                fit: BoxFit.contain, // Bildgröße anpassen
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Produktname
                            Text(
                              product.name,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            // Preis und Menge
                            Column(
                              children: [
                                Text(
                                  '${product.price.toStringAsFixed(2)} DodgeCoin',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'Verfügbare Menge: ${product.quantity}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Kaufen-Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 14, 251, 2), // Hintergrundfarbe des Buttons
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // Runde Ecken
                                ),
                              ),
                              onPressed: () {
                                if (product.quantity > 0) {
                                  ref.read(stackManagerProvider).reduceProductStock(product.id);
                                }
                              },
                              child: const Text('Kaufen'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
