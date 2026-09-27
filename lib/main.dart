import 'package:flutter/material.dart';

import 'core/di/injection.dart';
import 'features/products/presentation/pages/products_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const ElevateTaskApp());
}

class ElevateTaskApp extends StatelessWidget {
  const ElevateTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route — Products',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF004087),
        ),
      ),
      home: const ProductsPage(),
    );
  }
}
