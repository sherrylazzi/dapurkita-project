import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size; // Ukuran bisa diatur fleksibel nanti

  const AppLogo({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      // 1. Lingkaran Putih Luar + Shadow Lembut
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.18), // Shadow kecokelatan yang lembut
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      // 2. Lingkaran Dalam (Warna krem tipis sesuai desain Figma)
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Jarak antara lingkaran luar putih dan lingkaran dalam
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFDFBF7), // Warna latar dalam lingkaran (krem sangat muda)
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 4,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.restaurant_menu,
              size: 60,
              color: Color(0xFF8B4513), // Warna cokelat khas DapurKita
            ),
          ),
        ),
      ),
    );
  }
}