import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackvendor/Coin/coin.dart';
import 'package:snackvendor/Product/product.dart';
import 'package:snackvendor/StackManager/manager.dart';


// Transaction Provider zur Verwaltung der Transaktionen (eingeworfenes Geld)
final transactionProvider = StateNotifierProvider<TransactionNotifier, double>((ref) {
  return TransactionNotifier();
});

class TransactionNotifier extends StateNotifier<double> {
  TransactionNotifier() : super(0.0);

  // Methode zum Hinzufügen von Münzen
  void addCoin(double value) {
    state += value;
  }

  // Methode zum Rücksetzen der Transaktion
  void resetTransaction() {
    state = 0.0;
  }
}

// Coin List Provider für die Verwaltung der Münzen und deren Bilder
final coinListProvider = Provider<List<Coin>>((ref) {
  return [
    Coin(value: 0.20, imageUrl: 'assets/coins/coin_20.png'),
    Coin(value: 0.50, imageUrl: 'assets/coins/coin_50.png'),
    Coin(value: 1.00, imageUrl: 'assets/coins/coin_100.png'),
    Coin(value: 2.00, imageUrl: 'assets/coins/coin_200.png'),
  ];
});

// Product List Provider für die Verwaltung der Produkte und deren Bilder
final productListProvider = Provider<List<Product>>((ref) {
  return [
      Product(id: 1, name: 'Lays KFC Chips', price: 1.50, quantity: 10, imageUrl: 'assets/products/Lays KFC Chips.jpg'),
      Product(id: 2, name: 'Snickers', price: 1.50, quantity: 10, imageUrl: 'assets/products/Snickers.jpg'),
      Product(id: 3, name: 'Pea Snacks', price: 1.50, quantity: 10, imageUrl: 'assets/products/Pea Snacks.jpg'),
      Product(id: 4, name: 'NISSIN Soba Bag Japanese Curry', price: 2.00, quantity: 10, imageUrl: 'assets/products/NISSIN Soba Bag Japanese Curry.jpg'),
      Product(id: 5, name: 'Mandeln', price: 2.50, quantity: 10, imageUrl: 'assets/products/Mandeln.jpg'),
      Product(id: 6, name: 'Kortoffel Sticks', price: 1.50, quantity: 10, imageUrl: 'assets/products/Kortoffel Sticks.jpg'),
      Product(id: 7, name: 'Knusprige Krabbencracker', price: 1.70, quantity: 10, imageUrl: 'assets/products/Knusprige Krabbencracker.jpg'),
      Product(id: 8, name: 'Knorr Pasta Pot XXL', price: 2.20, quantity: 10, imageUrl: 'assets/products/Knorr Pasta Pot XXL.jpg'),
      Product(id: 9, name: 'Knoppers', price: 1.70, quantity: 20, imageUrl: 'assets/products/Knoppers.jpg'),
      Product(id: 10, name: 'Kichererbsen Chips', price: 1.70, quantity: 10, imageUrl: 'assets/products/Kichererbsen Chips.jpg'),
      Product(id: 11, name: 'Elephant Prezels', price: 2.20, quantity: 10, imageUrl: 'assets/products/Elephant Prezels.jpg'),
      Product(id: 12, name: 'Crunchy Nuts Spicy', price: 1.20, quantity: 10, imageUrl: 'assets/products/Crunchy Nuts Spicy.jpg'),
      Product(id: 13, name: 'Celebrations Pop Geschenkbox', price: 2.70, quantity: 10, imageUrl: 'assets/products/Celebrations Pop Geschenkbox.jpg'),
      Product(id: 14, name: 'BeefJerky', price: 3.20, quantity: 10, imageUrl: 'assets/products/BeefJerky.jpg'),
      Product(id: 15, name: 'Adelholzener Naturell 0,5 l', price: 1.20, quantity: 10, imageUrl: 'assets/products/Adelholzener Naturell 0,5 l.jpg'),
      Product(id: 16, name: 'Ball und Ovidias belgische Schokolade', price: 2.20, quantity: 10, imageUrl: 'assets/products/Ball und Ovidias belgische Schokolade.jpg'),
      Product(id: 17, name: 'Coca Cola Dose 0,33 l', price: 1.20, quantity: 10, imageUrl: 'assets/products/Coca Cola Dose 0,33 l.jpg'),
      Product(id: 18, name: 'Fanta Dose 0,33 l', price: 1.20, quantity: 10, imageUrl: 'assets/products/Fanta Dose 0,33 l.jpg'),
      Product(id: 19, name: 'Iso Sport Drink light 0,25 l', price: 1.50, quantity: 10, imageUrl: 'assets/products/Iso Sport Drink light 0,25 l.jpg'),
      Product(id: 20, name: 'Lavazza Cappuccino 0,25 l', price: 2.50, quantity: 10, imageUrl: 'assets/products/Lavazza Cappuccino 0,25 l.jpg'),
      Product(id: 21, name: 'Mr.Brown Caramel Latte 0,25 l', price: 2.50, quantity: 10, imageUrl: 'assets/products/Mr.Brown Caramel Latte 0,25 l.jpg'),
  ];
});

// Stack Manager Provider für Coins und Produkte
final stackManagerProvider = StateProvider<StackManager>((ref) {
  return StackManager(
    initialProducts: ref.read(productListProvider),
    initialCoins: ref.read(coinListProvider),
  );
});

// // Stack Manager für die Verwaltung von Coins und Produkten
// class StackManager {
//   final List<Product> _products;
//   final Map<double, int> _coinInventory;

//   StackManager({
//     required List<Product> initialProducts,
//     required List<Coin> initialCoins,
//   })  : _products = initialProducts,
//         _coinInventory = {
//           for (var coin in initialCoins) coin.value: 10, // Anfangsbestand für Münzen
//         };

//   // Produkte verwalten
//   List<Product> get products => _products;

//   // Münzbestand abfragen
//   Map<double, int> get coinInventory => _coinInventory;

//   // Produkt nach ID finden
// Product getProductById(int productId) {
//   if (productId < 1 || productId > 21) {
//     print('Die ID $productId ist ungültig. Es gibt nur Produkte mit IDs von 1 bis 21.');
//     throw Exception('Ungültige Produkt-ID');
//   }

//   return _products.firstWhere(
//     (product) => product.id == productId,
//     orElse: () => throw Exception('Kein Produkt mit der ID $productId gefunden.'),
//   );
// }


//   // Produkt auffüllen
//   void restockProduct(int productId, int amount) {
//     final product = getProductById(productId);
//     product.quantity += amount;
//     }

//   // Münzen auffüllen
//   void restockCoin(double coinValue, int amount) {
//     if (_coinInventory.containsKey(coinValue)) {
//       _coinInventory[coinValue] = (_coinInventory[coinValue] ?? 0) + amount;
//     }
//   }

//   // Produktbestand verringern (bei Kauf)
//   void reduceProductStock(int productId) {
//     final product = getProductById(productId);
//     if (product.quantity > 0) {
//       product.quantity--;
//     }
//   }

//   // Münzenbestand verringern (bei Wechselgeld-Ausgabe)
//   void reduceCoinStock(double coinValue) {
//     if (_coinInventory.containsKey(coinValue) && _coinInventory[coinValue]! > 0) {
//       _coinInventory[coinValue] = _coinInventory[coinValue]! - 1;
//     }
//   }

//   // Prüfen, ob genug Münzen für das Wechselgeld vorhanden sind
//   bool canProvideChange(double changeAmount) {
//     double remainingAmount = changeAmount;
//     List<double> availableCoins = _coinInventory.keys.toList()..sort((a, b) => b.compareTo(a));

//     for (var coinValue in availableCoins) {
//       int coinCount = _coinInventory[coinValue]!;
//       while (remainingAmount >= coinValue && coinCount > 0) {
//         remainingAmount -= coinValue;
//         coinCount--;
//       }
//       if (remainingAmount == 0) break;
//     }

//     return remainingAmount == 0;
//   }
// }
