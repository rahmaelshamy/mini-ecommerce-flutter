import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'products_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleRegister() async {
  final name = nameController.text.trim();
  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  if (name.isEmpty || email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill all fields')),
    );
    return;
  }

  if (name.length < 2) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Name must be at least 2 characters')),
    );
    return;
  }

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  if (!emailRegex.hasMatch(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enter a valid email address')),
    );
    return;
  }

  if (password.length < 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password must be at least 6 characters')),
    );
    return;
  }

  final authProvider = Provider.of<AuthProvider>(context, listen: false);

  final success = await authProvider.register(name, email, password);

  if (!mounted) return;

  if (success) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProductsScreen()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Register failed')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            authProvider.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: handleRegister,
                    child: const Text('Register'),
                  ),
          ],
        ),
      ),
    );
  }
}