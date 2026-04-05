import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'order_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cartProvider.items.isEmpty
    ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
            const SizedBox(height: 12),
            const Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16), // 👈 HERE
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Start Shopping'),
            ),
          ],
        ),
      )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.items.length,
                      itemBuilder: (context, index) {
                        final product = cartProvider.items[index];
                        return Card(
                          child: ListTile(
                            title: Text(product.name),
                            subtitle: Text(
                              'Price: EGP ${product.price.toStringAsFixed(2)}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                cartProvider.removeFromCart(product);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Total: EGP ${cartProvider.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderScreen(),
                        ),
                      );
                    },
                    child: const Text('Proceed to Order'),
                  ),
                ],
              ),
            ),
    );
  }
}