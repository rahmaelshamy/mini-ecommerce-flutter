class Product {
  final int id;
  final String name;
  final double price;
  final bool inStock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.inStock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['title'] ?? '',
      price: (json['price'] as num).toDouble(),
      inStock: (json['stock'] ?? 0) > 0,
    );
  }
}