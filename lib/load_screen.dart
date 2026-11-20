import 'package:flutter/material.dart';
import 'components/app_logo.dart'; 
import 'components/app_styles.dart'; 
// import 'dashboard.dart'; 
import 'authentication/login_page.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.hintWhite, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(size: 100),
            const SizedBox(height: 24),
            
            // 3. Teks DapurKita (Warna Merah / redPrimary)
            Text(
              'DapurKita',
              style: AppTextStyles.liberationBold.copyWith(
                fontSize: 32,
                color: AppColors.redPrimary, // Warna merah ditaruh di sini
              ),
            ),
            const SizedBox(height: 8),
            
            // 4. Teks DIGITAL RECIPE BOOK (Warna Hijau / greenDark)
            Text(
              'DIGITAL RECIPE BOOK',
              style: AppTextStyles.jakartaSemiBold.copyWith(
                fontSize: 14,
                letterSpacing: 1.5,
                color: AppColors.greenDark, // Warna hijau ditaruh di sini
              ),
            ),

            // 5. Teks Digitalisasi Buku Resep Masakan untuk <br> Menyimpan & Berbagi Inspirasi Rasa
            Text(
              '\n Digitalisasi Buku Resep Masakan untuk \n Menyimpan & Berbagi Inspirasi Rasa',
              textAlign: TextAlign.center, // <--- 1. Agar teksnya rata tengah secara rapi
              style: AppTextStyles.jakartaRegular.copyWith(
                fontSize: 14,
                color: AppColors.brownMuted,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // 5. Loading Indicator
            const CircularProgressIndicator(
              color: AppColors.greenDark, 
            ),
          ],
        ),
      ),
    );
  }
}