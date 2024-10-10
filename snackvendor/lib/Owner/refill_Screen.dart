import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackvendor/provider.dart';

class RefillScreen extends ConsumerWidget {
  const RefillScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stackManager = ref.watch(stackManagerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Auffüllen')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gesamt Coins: ${stackManager.coinInventory.values.reduce((a, b) => a + b)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Produkt Übersicht:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: stackManager.products.length,
                itemBuilder: (context, index) {
                  final product = stackManager.products[index];
                  return ListTile(
                    title: Text(product.name, style: const TextStyle(fontSize: 16)),
                    subtitle: Text('Menge: ${product.quantity}', style: const TextStyle(fontSize: 14)),
                    trailing: ElevatedButton(
                      onPressed: () {
                        ref.read(stackManagerProvider).restockProduct(product.id, 10);
                      },
                      child: const Text('Auffüllen', style: TextStyle(fontSize: 12)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Coins Auffüllen:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: stackManager.coinInventory.keys.length,
                itemBuilder: (context, index) {
                  final coinValue = stackManager.coinInventory.keys.elementAt(index);
                  return ListTile(
                    title: Text('Coin: ${coinValue.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
                    subtitle: Text('Anzahl: ${stackManager.coinInventory[coinValue]}', style: const TextStyle(fontSize: 14)),
                    trailing: ElevatedButton(
                      onPressed: () {
                        ref.read(stackManagerProvider).restockCoin(coinValue, 10);
                      },
                      child: const Text('Auffüllen', style: TextStyle(fontSize: 12)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
