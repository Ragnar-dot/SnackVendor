
import 'package:snackvendor/Coin/coin.dart';
import 'package:snackvendor/Product/product.dart';



// Manager für die Verwaltung von Produkten, Münzen und Transaktionen
class StackManager {
  final List<Product> _products;  // Interne Liste der Produkte
  final Map<double, int> _coinInventory;  // Münzbestand (Wert -> Anzahl)

  StackManager({
    required List<Product> initialProducts,
    required List<Coin> initialCoins,
  })  : _products = initialProducts,
        _coinInventory = {
          for (var coin in initialCoins) coin.value: 10,  // Anfangsbestand für jede Münze
        };

  // Produkte verwalten
  List<Product> get products => _products;

  // Münzbestand anzeigen
  Map<double, int> get coinInventory => _coinInventory;

  // Produkt nach ID suchen
Product getProductById(int productId) {
  if (productId < 1 || productId > 21) {
    ('Die ID $productId ist ungültig. Es gibt nur Produkte mit IDs von 1 bis 21.');
    throw Exception('Ungültige Produkt-ID');
  }

  return _products.firstWhere(
    (product) => product.id == productId,
    orElse: () => throw Exception('Kein Produkt mit der ID $productId gefunden.'),
  );
}



  // Produktauffüllung
  void restockProduct(int productId, int amount) {
    final product = getProductById(productId);
    product.quantity += amount;
    ('${product.name} wurde um $amount Einheiten aufgefüllt.');
    }

  // Münzen auffüllen
  void restockCoin(double coinValue, int amount) {
    if (_coinInventory.containsKey(coinValue)) {
      _coinInventory[coinValue] = (_coinInventory[coinValue] ?? 0) + amount;
      ('$amount Münzen mit Wert $coinValue DodgeCoin hinzugefügt.');
    } else {
      ('Münze mit Wert $coinValue nicht gefunden.');
    }
  }

  // Produktbestand verringern (bei Kauf)
  void reduceProductStock(int productId) {
    final product = getProductById(productId);
    if (product.quantity > 0) {
      product.quantity--;
      ('Produkt ${product.name} wurde um 1 reduziert.');
    } else {
      ('Produkt ausverkauft oder nicht vorhanden.');
    }
  }

  // Münzbestand verringern (bei Wechselgeld)
  void reduceCoinStock(double coinValue) {
    if (_coinInventory.containsKey(coinValue) && _coinInventory[coinValue]! > 0) {
      _coinInventory[coinValue] = _coinInventory[coinValue]! - 1;
      ('Münze mit Wert $coinValue DodgeCoin wurde ausgegeben.');
    } else {
      ('Nicht genügend Münzen im Wert von $coinValue vorhanden.');
    }
  }

  // Prüfen, ob genug Münzen für Wechselgeld vorhanden sind
  bool canProvideChange(double changeAmount) {
    double remainingAmount = changeAmount;
    List<double> availableCoins = _coinInventory.keys.toList()..sort((a, b) => b.compareTo(a));

    for (var coinValue in availableCoins) {
      int coinCount = _coinInventory[coinValue]!;
      while (remainingAmount >= coinValue && coinCount > 0) {
        remainingAmount -= coinValue;
        coinCount--;
      }
      if (remainingAmount == 0) break;
    }

    return remainingAmount == 0;
  }

  // Wechselgeld berechnen
  List<double> calculateChange(double changeAmount) {
    List<double> change = [];
    if (canProvideChange(changeAmount)) {
      double remainingAmount = changeAmount;
      List<double> availableCoins = _coinInventory.keys.toList()..sort((a, b) => b.compareTo(a));

      for (var coinValue in availableCoins) {
        while (remainingAmount >= coinValue && _coinInventory[coinValue]! > 0) {
          remainingAmount -= coinValue;
          _coinInventory[coinValue] = _coinInventory[coinValue]! - 1;
          change.add(coinValue);
        }
      }
    } else {
      ('Nicht genug Münzen für das Wechselgeld.');
    }
    return change;
  }

  // Gesamtbetrag der verfügbaren Münzen berechnen
  double totalCoinsAvailable() {
    double total = 0.0;
    _coinInventory.forEach((coinValue, count) {
      total += coinValue * count;
    });
    return total;
  }
}

