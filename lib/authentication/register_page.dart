import 'package:dapur_kita/components/app_logo.dart';
import 'package:dapur_kita/components/app_styles.dart';
import 'package:flutter/material.dart';
// Sesuaikan import di bawah ini dengan lokasi file Anda
import '../components/app_logo.dart';
import '../components/app_styles.dart';// File yang berisi AppColors dan AppTextStyles

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil input pengguna
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // State untuk visibilitas password dan loading
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulasi proses registrasi (ganti dengan API / Firebase Auth Anda)
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Akun berhasil dibuat! Selamat datang di DapurKita.',
            style: AppTextStyles.jakartaMedium.copyWith(color: AppColors.darkCharcoal),
          ),
          backgroundColor: AppColors.greenMint,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Navigasi ke halaman Login atau Home
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.hintWhite, // Latar belakang krem hangat (#FFF8F6)
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Tombol Kembali (Opsional, jika dibuka dari halaman Login)
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    color: AppColors.brownMuted,
                  ),
                ),

                // 1. Logo Aplikasi
                const AppLogo(size: 95),
                const SizedBox(height: 16),

                // 2. Judul & Subjudul
                Text(
                  'Buat Akun Baru',
                  style: AppTextStyles.titleDapurKita.copyWith(fontSize: 28),
                ),
                const SizedBox(height: 6),
                Text(
                  'Mulai simpan dan bagikan resep andalanmu',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.descriptionBody.copyWith(
                    color: AppColors.brownMuted,
                  ),
                ),
                const SizedBox(height: 28),

                // 3. Form Input Nama Lengkap
                _buildInputLabel('Nama Lengkap'),
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  style: AppTextStyles.jakartaRegular.copyWith(color: AppColors.darkCharcoal),
                  decoration: _buildInputDecoration(
                    hint: 'Contoh: Budi Santoso',
                    icon: Icons.person_outline_rounded,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama lengkap wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 4. Form Input Email
                _buildInputLabel('Alamat Email'),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: AppTextStyles.jakartaRegular.copyWith(color: AppColors.darkCharcoal),
                  decoration: _buildInputDecoration(
                    hint: 'nama@email.com',
                    icon: Icons.email_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email wajib diisi';
                    }
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 5. Form Input Kata Sandi
                _buildInputLabel('Kata Sandi'),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.next,
                  style: AppTextStyles.jakartaRegular.copyWith(color: AppColors.darkCharcoal),
                  decoration: _buildInputDecoration(
                    hint: 'Minimal 6 karakter',
                    icon: Icons.lock_outline_rounded,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: AppColors.brownMuted,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kata sandi wajib diisi';
                    }
                    if (value.length < 6) {
                      return 'Kata sandi minimal 6 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 6. Form Konfirmasi Kata Sandi
                _buildInputLabel('Konfirmasi Kata Sandi'),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  style: AppTextStyles.jakartaRegular.copyWith(color: AppColors.darkCharcoal),
                  decoration: _buildInputDecoration(
                    hint: 'Ulangi kata sandi',
                    icon: Icons.lock_reset_rounded,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: AppColors.brownMuted,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi kata sandi wajib diisi';
                    }
                    if (value != _passwordController.text) {
                      return 'Kata sandi tidak cocok';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),

                // 7. Tombol Daftar
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redPrimary,
                      foregroundColor: AppColors.pureWhite,
                      disabledBackgroundColor: AppColors.redPrimary.withOpacity(0.6),
                      elevation: 2,
                      shadowColor: AppColors.redPrimary.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              color: AppColors.pureWhite,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            'Daftar Sekarang',
                            style: AppTextStyles.jakartaBold.copyWith(fontSize: 16),
                          ),
                  ),
                ),
                const SizedBox(height: 24),

                // 8. Kotak Kutipan Khas (Sesuai Gambar Referensi)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.peachLight.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    '“Masakan rumahan, rasa penuh cerita.”',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.jakartaRegular.copyWith(
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                      color: AppColors.brownMuted,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 9. Tautan ke Halaman Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun? ',
                      style: AppTextStyles.jakartaRegular.copyWith(
                        color: AppColors.brownMuted,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Kembali ke halaman Login
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Masuk sekarang',
                        style: AppTextStyles.jakartaBold.copyWith(
                          color: AppColors.redPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper untuk Label di atas TextField
  Widget _buildInputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6.0, left: 2.0),
        child: Text(
          text,
          style: AppTextStyles.jakartaSemiBold.copyWith(
            fontSize: 13,
            color: AppColors.darkCharcoal,
          ),
        ),
      ),
    );
  }

  // Helper untuk Styling TextFormField yang Konsisten
  InputDecoration _buildInputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.jakartaRegular.copyWith(
        color: AppColors.brownMuted.withOpacity(0.5),
        fontSize: 14,
      ),
      prefixIcon: Icon(icon, color: AppColors.brownMuted, size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.pureWhite,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.peachLight, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.redPrimary, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.redDark, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.redDark, width: 1.8),
      ),
      errorStyle: AppTextStyles.jakartaRegular.copyWith(
        color: AppColors.redDark,
        fontSize: 12,
      ),
    );
  }
}