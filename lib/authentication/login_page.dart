
import 'package:dapur_kita/components/app_logo.dart';
import 'package:dapur_kita/components/app_styles.dart';
import 'package:flutter/material.dart';
import 'components/app_logo.dart';
import 'components/app_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login berhasil diproses!'),
          backgroundColor: AppColors.greenDark,
        ),
      );

      // Hubungkan ke halaman Dashboard setelah autentikasi tersedia.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.hintWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 4,
          ),
          child: Column(
            children: [
              const SizedBox(height: 2),

              // =========================
              // LOGO DAPURKITA
              // =========================
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  const AppLogo(size: 58),

                  Positioned(
                    right: -3,
                    bottom: 0,
                    child: Container(
                      width: 21,
                      height: 21,
                      decoration: const BoxDecoration(
                        color: AppColors.greenMint,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.restaurant,
                        size: 12,
                        color: AppColors.greenDark,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // =========================
              // LABEL
              // =========================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEAE3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: AppColors.redPrimary,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Dapur Hangat & Inspiratif',
                      style: AppTextStyles.jakartaSemiBold.copyWith(
                        fontSize: 9,
                        color: AppColors.redPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 7),

              // =========================
              // JUDUL
              // =========================
              Text(
                'Selamat Datang di DapurKita',
                textAlign: TextAlign.center,
                style: AppTextStyles.liberationBold.copyWith(
                  fontSize: 20,
                  color: AppColors.darkCharcoal,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'Masuk untuk membuka catatan resep masakan\nAnda',
                textAlign: TextAlign.center,
                style: AppTextStyles.jakartaRegular.copyWith(
                  fontSize: 11,
                  height: 1.5,
                  color: AppColors.brownMuted,
                ),
              ),

              const SizedBox(height: 13),

              // =========================
              // FORM LOGIN
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // EMAIL
                      _buildLabel(
                        Icons.mail_outline,
                        'Email atau Username',
                      ),

                      const SizedBox(height: 5),

                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: AppTextStyles.jakartaRegular.copyWith(
                          fontSize: 11,
                        ),
                        decoration: _inputDecoration(
                          'ibu.anita@email.com',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email atau username wajib diisi';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      // PASSWORD
                      _buildLabel(
                        Icons.lock_outline,
                        'Kata Sandi',
                      ),

                      const SizedBox(height: 5),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: AppTextStyles.jakartaRegular.copyWith(
                          fontSize: 11,
                        ),
                        decoration: _inputDecoration(
                          'Masukkan kata sandi',
                        ).copyWith(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 17,
                              color: AppColors.brownMuted,
                            ),
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

                      const SizedBox(height: 9),

                      // INGAT SAYA & LUPA PASSWORD
                      Row(
                        children: [
                          SizedBox(
                            width: 19,
                            height: 24,
                            child: Checkbox(
                              value: _rememberMe,
                              activeColor: AppColors.redPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              side: const BorderSide(
                                color: Color(0xFFEEDBD2),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                            ),
                          ),

                          const SizedBox(width: 4),

                          Text(
                            'Ingat Saya',
                            style: AppTextStyles.jakartaRegular.copyWith(
                              fontSize: 9,
                              color: AppColors.brownMuted,
                            ),
                          ),

                          const Spacer(),

                          GestureDetector(
                            onTap: () {
                              _showMessage(
                                'Fitur lupa kata sandi',
                              );
                            },
                            child: Text(
                              'Lupa Kata Sandi?',
                              style: AppTextStyles.jakartaSemiBold.copyWith(
                                fontSize: 9,
                                color: AppColors.redPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // TOMBOL MASUK
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: _login,
                          icon: const Icon(
                            Icons.restaurant,
                            size: 15,
                          ),
                          label: Text(
                            'Masuk ke Dapur',
                            style: AppTextStyles.jakartaSemiBold.copyWith(
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redPrimary,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            shadowColor: AppColors.redPrimary.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // =========================
              // PEMBATAS
              // =========================
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: Color(0xFFEEDBD2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'ATAU MASUK DENGAN',
                      style: AppTextStyles.jakartaRegular.copyWith(
                        fontSize: 8,
                        color: AppColors.brownMuted,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Color(0xFFEEDBD2),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // =========================
              // GOOGLE LOGIN
              // =========================
              SizedBox(
                width: double.infinity,
                height: 38,
                child: OutlinedButton(
                  onPressed: () {
                    _showMessage(
                      'Login Google belum dihubungkan',
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'G',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Text(
                        'Akun Google',
                        style: AppTextStyles.jakartaMedium.copyWith(
                          fontSize: 10,
                          color: AppColors.darkCharcoal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 13),

              // =========================
              // QUOTE CARD
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEFE8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                        color: AppColors.greenMint,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.restaurant,
                        size: 14,
                        color: AppColors.greenDark,
                      ),
                    ),

                    const SizedBox(width: 9),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '"Memasak dengan cinta menghadirkan '
                            'ketenangan di setiap suapan rasa."',
                            style: AppTextStyles.jakartaRegular.copyWith(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                              color: AppColors.darkCharcoal,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Resep Warisan Nusantara',
                            style: AppTextStyles.jakartaSemiBold.copyWith(
                              fontSize: 8,
                              color: AppColors.goldBrown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 17),

              // =========================
              // DAFTAR AKUN
              // =========================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: AppTextStyles.jakartaRegular.copyWith(
                      fontSize: 10,
                      color: AppColors.brownMuted,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      _showMessage(
                        'Halaman daftar akun',
                      );
                    },
                    child: Text(
                      'Daftar Sekarang',
                      style: AppTextStyles.jakartaSemiBold.copyWith(
                        fontSize: 10,
                        color: AppColors.redPrimary,
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward,
                    size: 12,
                    color: AppColors.redPrimary,
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // LABEL INPUT
  Widget _buildLabel(IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          size: 13,
          color: AppColors.redPrimary,
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: AppTextStyles.jakartaSemiBold.copyWith(
            fontSize: 10,
            color: AppColors.darkCharcoal,
          ),
        ),
      ],
    );
  }

  // DESAIN TEXT FIELD
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.jakartaRegular.copyWith(
        fontSize: 10,
        color: const Color(0xFFB6A49B),
      ),
      filled: true,
      fillColor: const Color(0xFFFFF0EA),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.redPrimary,
          width: 1,
        ),
      ),
      errorStyle: const TextStyle(fontSize: 9),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.redPrimary,
      ),
    );
  }
}
