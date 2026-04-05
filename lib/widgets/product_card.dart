import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: EGP ${product.price.toStringAsFixed(2)}'),
            Text(product.inStock ? 'In Stock' : 'OUT OF STOCK'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: product.inStock ? onAdd : null,
          child: const Text('Add'),
        ),
      ),
    );
  }
}