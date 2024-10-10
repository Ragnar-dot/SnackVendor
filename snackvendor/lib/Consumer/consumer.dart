
import 'package:snackvendor/Product/product.dart';




class Consumer {
  double insertedAmount = 0.0; // Der Geldbetrag, den der Benutzer eingeworfen hat
  Product? selectedProduct; // Das ausgewählte Produkt des Benutzers

  // Methode zum Einwerfen von Münzen
  void insertCoin(double value) {
    insertedAmount += value;
  }

  // Methode zum Auswählen eines Produkts
  void selectProduct(Product product) {
    selectedProduct = product;
  }

  // Methode, um zu überprüfen, ob genug Geld eingeworfen wurde
  bool canPurchase() {
    if (selectedProduct != null) {
      return insertedAmount >= selectedProduct!.price;
    }
    return false;
  }

  // Methode, um den Kauf abzuschließen
  void completePurchase() {
    if (canPurchase()) {
      // Verringere die Produktmenge
      selectedProduct!.quantity--;

      // Berechne Wechselgeld
      double change = insertedAmount - selectedProduct!.price;
      ('Wechselgeld: $change DodgeCoin');

      // Rücksetzen nach dem Kauf
      insertedAmount = 0.0;
      selectedProduct = null;
    } else {
      ('Nicht genügend Geld eingeworfen');
    }
  }

  // Transaktion abbrechen
  void cancelTransaction() {
    insertedAmount = 0.0;
    selectedProduct = null;
  }
}


