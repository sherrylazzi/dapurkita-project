import 'package:flutter/material.dart';
import '../components/app_logo.dart';
import '../components/app_styles.dart';
import '../dashboard.dart';
import 'register_page.dart'; // Sesuaikan path file RegisterPage Anda

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Fungsi Login
  void login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String username = emailController.text.trim();
    String password = passwordController.text;

    if (username == 'admin' && password == 'admin123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau password salah!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 24,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 450,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    // LOGO
                    Center(
                      child: AppLogo(size: 82),
                    ),

                    const SizedBox(height: 18),

                    // NAMA APLIKASI
                    Text(
                      'DAPUR HANGAT & INSPIRATIF',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.jakartaBold.copyWith(
                        color: AppColors.redPrimary,
                        fontSize: 11,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // JUDUL
                    Text(
                      'Selamat Datang di\nDapurKita',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleDapurKita.copyWith(
                        color: AppColors.darkCharcoal,
                        fontSize: 29,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Masuk dan temukan inspirasi resep\nlezat untuk setiap harimu.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.descriptionBody.copyWith(
                        color: Colors.brown.shade400,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // LABEL USERNAME
                    Text(
                      'Email atau Username',
                      style: AppTextStyles.jakartaSemiBold.copyWith(
                        color: AppColors.darkCharcoal,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 9),

                    // INPUT USERNAME
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Masukkan username',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 13,
                        ),
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: AppColors.redPrimary,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Colors.brown.shade100,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Colors.brown.shade100,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: AppColors.redPrimary,
                            width: 1.5,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Username tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // LABEL PASSWORD
                    Text(
                      'Password',
                      style: AppTextStyles.jakartaSemiBold.copyWith(
                        color: AppColors.darkCharcoal,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 9),

                    // INPUT PASSWORD
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Masukkan password',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 13,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: AppColors.redPrimary,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Colors.brown.shade100,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Colors.brown.shade100,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: AppColors.redPrimary,
                            width: 1.5,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    // INGAT SAYA DAN LUPA PASSWORD
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _rememberMe,
                            activeColor: AppColors.redPrimary,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 7),

                        Text(
                          'Ingat saya',
                          style: AppTextStyles.jakartaRegular.copyWith(
                            fontSize: 12,
                            color: AppColors.brownMuted,
                          ),
                        ),

                        const Spacer(),

                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Fitur lupa password belum tersedia.',
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Lupa password?',
                            style: AppTextStyles.jakartaSemiBold.copyWith(
                              fontSize: 12,
                              color: AppColors.redPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // TOMBOL LOGIN
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.redPrimary,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Masuk',
                          style: AppTextStyles.jakartaBold.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // PEMBATAS
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.brown.shade200,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Text(
                            'atau masuk dengan',
                            style: TextStyle(
                              color: Colors.brown.shade400,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.brown.shade200,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // TOMBOL GOOGLE
                    SizedBox(
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Login Google belum tersedia.',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.g_mobiledata,
                          size: 28,
                          color: AppColors.redPrimary,
                        ),
                        label: Text(
                          'Google',
                          style: AppTextStyles.jakartaSemiBold.copyWith(
                            color: AppColors.darkCharcoal,
                            fontSize: 13,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.brown.shade200,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // KUTIPAN
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.peachLight.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.restaurant_menu,
                            color: AppColors.redPrimary,
                            size: 23,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '"Masakan rumahan, rasa penuh cerita."',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.jakartaMedium.copyWith(
                              color: AppColors.brownMuted,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // DAFTAR AKUN
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun? ',
                          style: AppTextStyles.jakartaRegular.copyWith(
                            color: AppColors.brownMuted,
                            fontSize: 12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Daftar sekarang',
                            style: AppTextStyles.jakartaBold.copyWith(
                              color: AppColors.redPrimary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}