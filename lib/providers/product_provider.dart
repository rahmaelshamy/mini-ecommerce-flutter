import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> products = [];
  bool isLoading = false;

  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _apiService.dio.get('/products');
      final List data = response.data['products'];

      products = data.map((item) => Product.fromJson(item)).toList();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }
}