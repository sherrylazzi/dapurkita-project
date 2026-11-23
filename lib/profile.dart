
import 'package:flutter/material.dart';
import 'package:dapur_kita/components/app_styles.dart';
import 'package:dapur_kita/authentication/login_page.dart';

class ProfilePage extends StatelessWidget {
  final Future<void> Function() onLogout;

  const ProfilePage({
    super.key,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.hintWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // HEADER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.redPrimary,
                        size: 20,
                      ),
                    ),

                    Expanded(
                      child: Text(
                        'Profil Saya',
                        style: AppTextStyles.liberationBold.copyWith(
                          fontSize: 23,
                          color: AppColors.redPrimary,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: AppColors.brownMuted,
                      ),
                    ),
                  ],
                ),
              ),

              // PROFILE CARD
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.brownMuted.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 38,
                          backgroundColor: Color(0xFFE8DAD3),
                          child: Icon(
                            Icons.person,
                            size: 45,
                            color: AppColors.brownMuted,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Anita Kusum',
                                style: AppTextStyles.jakartaBold.copyWith(
                                  fontSize: 17,
                                  color: AppColors.brownMuted,
                                ),
                              ),

                              const SizedBox(height: 3),

                              Text(
                                '@dapurAnita',
                                style: AppTextStyles.jakartaRegular.copyWith(
                                  fontSize: 12,
                                  color: Colors.brown,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.verified,
                                    size: 13,
                                    color: AppColors.greenDark,
                                  ),

                                  const SizedBox(width: 5),

                                  Text(
                                    'Koki Rumahan',
                                    style: AppTextStyles.jakartaSemiBold.copyWith(
                                      fontSize: 11,
                                      color: AppColors.greenDark,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 43,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 17,
                        ),
                        label: Text(
                          'Edit Profil',
                          style: AppTextStyles.jakartaSemiBold.copyWith(
                            fontSize: 13,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.redPrimary,
                          side: const BorderSide(
                            color: AppColors.redPrimary,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // STATISTIK
              _sectionTitle('Aktivitas Saya'),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _statCard(
                      Icons.menu_book_rounded,
                      '8',
                      'Resep',
                      AppColors.greenDark,
                    ),

                    const SizedBox(width: 10),

                    _statCard(
                      Icons.favorite_rounded,
                      '142',
                      'Disukai',
                      AppColors.redPrimary,
                    ),

                    const SizedBox(width: 10),

                    _statCard(
                      Icons.edit_note_rounded,
                      '4',
                      'Draf',
                      AppColors.goldBrown,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // MENU AKUN
              _sectionTitle('Akun Saya'),

              const SizedBox(height: 10),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    _menuItem(
                      Icons.person_outline,
                      'Informasi Pribadi',
                      'Kelola informasi akun kamu',
                      () {},
                    ),

                    _divider(),

                    _menuItem(
                      Icons.lock_outline,
                      'Keamanan Akun',
                      'Ubah password dan keamanan',
                      () {},
                    ),

                    _divider(),

                    _menuItem(
                      Icons.notifications_none,
                      'Notifikasi',
                      'Atur pemberitahuan aplikasi',
                      () {},
                    ),

                    _divider(),

                    _menuItem(
                      Icons.help_outline,
                      'Pusat Bantuan',
                      'Bantuan penggunaan DapurKita',
                      () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // LOGOUT
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _showLogoutDialog(context),
                  child: Padding(
                    padding: const EdgeInsets.all(17),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout_rounded,
                          color: AppColors.redPrimary,
                        ),

                        const SizedBox(width: 13),

                        Expanded(
                          child: Text(
                            'Keluar dari Akun',
                            style: AppTextStyles.jakartaSemiBold.copyWith(
                              fontSize: 13,
                              color: AppColors.redPrimary,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: AppColors.redPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // FOOTER
              Center(
                child: Text(
                  'DapurKita v1.0.0',
                  style: AppTextStyles.jakartaRegular.copyWith(
                    fontSize: 11,
                    color: AppColors.brownMuted.withOpacity(0.6),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  // JUDUL SECTION
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: AppTextStyles.jakartaBold.copyWith(
          fontSize: 17,
          color: AppColors.brownMuted,
        ),
      ),
    );
  }

  // STATISTIK CARD
  Widget _statCard(
    IconData icon,
    String number,
    String label,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: AppColors.brownMuted.withOpacity(0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 25),

            const SizedBox(height: 8),

            Text(
              number,
              style: AppTextStyles.jakartaBold.copyWith(
                fontSize: 20,
                color: AppColors.brownMuted,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              label,
              style: AppTextStyles.jakartaRegular.copyWith(
                fontSize: 11,
                color: AppColors.brownMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MENU ITEM
  Widget _menuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 3,
      ),
      leading: Icon(
        icon,
        color: AppColors.redPrimary,
        size: 24,
      ),
      title: Text(
        title,
        style: AppTextStyles.jakartaSemiBold.copyWith(
          fontSize: 13,
          color: AppColors.brownMuted,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.jakartaRegular.copyWith(
          fontSize: 11,
          color: AppColors.brownMuted.withOpacity(0.7),
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: AppColors.brownMuted,
      ),
      onTap: onTap,
    );
  }

  // DIVIDER
  Widget _divider() {
    return Divider(
      color: AppColors.brownMuted.withOpacity(0.10),
      height: 1,
    );
  }

  // LOGOUT DIALOG
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.hintWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: Text(
            'Keluar dari Akun?',
            style: AppTextStyles.jakartaBold.copyWith(
              color: AppColors.brownMuted,
              fontSize: 18,
            ),
          ),

          content: Text(
            'Apakah kamu yakin ingin keluar dari akun DapurKita?',
            style: AppTextStyles.jakartaRegular.copyWith(
              color: AppColors.brownMuted,
              fontSize: 13,
            ),
          ),

          actions: [
            // BATAL
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Batal',
                style: AppTextStyles.jakartaSemiBold.copyWith(
                  color: AppColors.brownMuted,
                ),
              ),
            ),

            // YA, KELUAR
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redPrimary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              onPressed: () async {
                // Tutup dialog
                Navigator.pop(dialogContext);

                // Jalankan proses logout
                await onLogout();

                if (!context.mounted) return;

                // Kembali ke halaman LoginScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },

              child: Text(
                'Ya, Keluar',
                style: AppTextStyles.jakartaSemiBold.copyWith(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
