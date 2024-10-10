import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:snackvendor/provider.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stackManager = ref.watch(stackManagerProvider);

    ('Produkte geladen: ${stackManager.products.length}');

    return Container(
      // Verwende MediaQuery, um die Containergröße dynamisch anzupassen
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Vendor/Vendor.png'), // Bild aus den Assets
          fit: BoxFit.cover, // Bildgröße anpassen
        ),
      ),
      // Füge einen Scrollbalken hinzu
      child: SingleChildScrollView(
       

        
        child: Padding(
          padding: const EdgeInsets.all(250.0), // Padding für den gesamten Inhalt
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true, // Verhindert, dass das GridView unendlich viel Platz beansprucht
                
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Anzahl der Spalten im Raster
                  crossAxisSpacing: 16.0, // Abstand zwischen den Spalten
                  mainAxisSpacing: 16.0, // Abstand zwischen den Reihen
                  childAspectRatio: 0.8, // Verhältnis der Breite zur Höhe der Zellen
                ),
                itemCount: stackManager.products.length,
                itemBuilder: (context, index) {
                  final product = stackManager.products[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(1), // Hintergrund für Produkt-Container
                      borderRadius: BorderRadius.circular(16),
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
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
    );
  }
}
