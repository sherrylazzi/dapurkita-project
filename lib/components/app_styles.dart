import 'package:flutter/material.dart';

class AppColors {
  // Palet Warna DapurKita
  static const Color redPrimary = Color(0xFFA83211);
  static const Color greenDark = Color(0xFF3A6848);
  static const Color brownMuted = Color(0xFF59413B);
  static const Color darkCharcoal = Color(0xFF211A16);
  static const Color goldBrown = Color(0xFF7F5300);
  static const Color peachLight = Color(0xFFFFDDB4);
  static const Color redDark = Color(0xFF93000A);
  static const Color redSoft = Color(0xFFFFDAD6);
  static const Color greenMint = Color(0xFFBBEFC6);
  static const Color greenSage = Color(0xFF406E4D);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color hintWhite = Color(0xFFFFF8F6);
  static const Color darkWithOpacity80 = Color(0xCC372F2A);
}

class AppTextStyles {
  // ==================== LIBERATION SERIF ====================
  static const TextStyle liberationBold = TextStyle(
    fontFamily: 'LiberationSerif',
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle liberationSemiBold = TextStyle(
    fontFamily: 'LiberationSerif',
    fontWeight: FontWeight.w600,
  );

  static const TextStyle liberationMedium = TextStyle(
    fontFamily: 'LiberationSerif',
    fontWeight: FontWeight.w500,
  );

  static const TextStyle liberationRegular = TextStyle(
    fontFamily: 'LiberationSerif',
    fontWeight: FontWeight.normal,
  );

  // ==================== PLUS JAKARTA SANS ====================
  static const TextStyle jakartaBold = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.bold,
  );

  static const TextStyle jakartaSemiBold = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w600,
  );

  static const TextStyle jakartaMedium = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500,
  );

  static const TextStyle jakartaRegular = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.normal,
  );

  // ==================== MERRIWEATHER ====================
  static const TextStyle merriweatherBold = TextStyle(
    fontFamily: 'Merriweather',
    fontWeight: FontWeight.bold,
  );

  static const TextStyle merriweatherSemiBold = TextStyle(
    fontFamily: 'Merriweather',
    fontWeight: FontWeight.w600,
  );

  static const TextStyle merriweatherMedium = TextStyle(
    fontFamily: 'Merriweather',
    fontWeight: FontWeight.w500,
  );

  static const TextStyle merriweatherRegular = TextStyle(
    fontFamily: 'Merriweather',
    fontWeight: FontWeight.normal,
  );

  // ==================== GAYA SIAP PAKAI KHUSUS DAPURKITA ====================
  // 1. Judul Utama (Liberation Serif Bold, 32, #A83211)
  static TextStyle titleDapurKita = liberationBold.copyWith(
    fontSize: 32,
    color: AppColors.redPrimary,
  );

  // 2. Subtitle / Label Kecil (Plus Jakarta Sans SemiBold, 14, #3A6848)
  static TextStyle subtitleRecipeBook = jakartaSemiBold.copyWith(
    fontSize: 14,
    letterSpacing: 1.5,
    color: AppColors.greenDark,
  );

  // 3. Deskripsi Biasa (Plus Jakarta Sans Regular, 14, #211A16)
  static TextStyle descriptionBody = jakartaRegular.copyWith(
    fontSize: 14,
    color: AppColors.darkCharcoal,
    height: 1.4,
  );
}