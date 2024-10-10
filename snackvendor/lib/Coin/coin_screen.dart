import 'package:flutter/material.dart';
import 'package:snackvendor/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinScreen extends ConsumerWidget {
  const CoinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = ref.watch(transactionProvider);
    final coins = ref.watch(coinListProvider);

    return Column(
      children: [
        // Zeigt den aktuellen Transaktionsstand an
        Text('Eingeworfene Münzen: ${transaction.toStringAsFixed(2)} DodgeCoin'),
        
        // Die Münzen werden jetzt vertikal angeordnet
        Column(
          children: coins.map((coin) {
            return SizedBox(
              width: 90,
              height: 90,
              child: IconButton(
                icon: Image.asset(coin.imageUrl),
                onPressed: () {
                  ref.read(transactionProvider.notifier).addCoin(coin.value);
                },
              ),
            );
          }).toList(),
        ),
        
        // Transaktionsabbruch
        ElevatedButton(
          onPressed: () {
            ref.read(transactionProvider.notifier).resetTransaction();
          },
          child: const Text('Cancel Transaction'),
        ),
      ],
    );
  }
}
