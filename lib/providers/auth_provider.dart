import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String? token;
  bool isLoading = false;

  bool get isLoggedIn => token != null && token!.isNotEmpty;

  Future<void> loadToken() async {
    token = await _authService.getToken();
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      return false;
    }

    try {
      isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));

      token = 'dummy_token';
      await _authService.saveToken(token!);

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    if (name.trim().isEmpty ||
        email.trim().isEmpty ||
        password.trim().isEmpty) {
      return false;
    }

    try {
      isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));

      token = 'dummy_token';
      await _authService.saveToken(token!);

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    token = null;
    await _authService.clearToken();
    notifyListeners();
  }
}