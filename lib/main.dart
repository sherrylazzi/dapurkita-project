
import 'package:dapur_kita/authentication/login_page.dart';
import 'package:flutter/material.dart';
import 'load_screen.dart';
import 'my_recipe.dart';
// import 'dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DapurKita',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFA83211),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F6),
        useMaterial3: true,
      ),

      // HALAMAN PERTAMA
      home: const LoginScreen(),
    );
  }
}
