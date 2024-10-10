


class Product {
  final int id; // Eindeutige ID des Produkts
  final String name; // Name des Produkts
  final double price; // Preis des Produkts
  int quantity; // Verfügbare Menge
  final String imageUrl; // Der Pfad zum Bild des Produkts

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}
