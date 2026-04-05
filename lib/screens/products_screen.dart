import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'login_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, _) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Center(
                  child: Text(
                    'Total: EGP ${cartProvider.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              );
            },
          ),
          Consumer<CartProvider>(
            builder: (context, cartProvider, _) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                  ),
                  if (cartProvider.items.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '${cartProvider.items.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          Tooltip(
            message: 'Logout',
            child: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                 await authProvider.logout();
                 if (!mounted) return;
                 Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    },
  ),
),
        ],
      ),
      body: productProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productProvider.products.isEmpty
              ? const Center(child: Text('No products available'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: productProvider.products.length,
                  itemBuilder: (context, index) {
                    final product = productProvider.products[index];
                    return ProductCard(
                      product: product,
                      onAdd: () {
                        cartProvider.addToCart(product);
                        final messenger = ScaffoldMessenger.of(context);

                        messenger.clearSnackBars(); //clear previous ones

                        messenger.showSnackBar(
                            SnackBar(
                                content: Text('${product.name} added to cart'),
                                duration: const Duration(seconds: 1),
                            ),
                            );
                      },
                    );
                  },
                ),
    );
  }
}