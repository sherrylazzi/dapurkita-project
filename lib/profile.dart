import 'package:flutter/material.dart';
import 'package:dapur_kita/authentication/login_page.dart';
import 'package:dapur_kita/components/app_styles.dart';
import 'package:dapur_kita/components/bottom_navbar.dart';
import 'package:dapur_kita/components/top_navbar.dart';
import 'package:dapur_kita/add_recipe_screen.dart';
import 'package:dapur_kita/dashboard.dart';
import 'package:dapur_kita/favorite.dart';
import 'package:dapur_kita/my_recipe.dart';

class ProfilePage extends StatefulWidget {
  final Future<void> Function()? onLogout;

  const ProfilePage({
    super.key,
    this.onLogout,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int _selectedIndex = 3;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.redPrimary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),

      // TOP NAVBAR
      appBar: const TopNavBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PROFILE CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 34,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Anita Kusum',
                              style: AppTextStyles.liberationBold.copyWith(
                                fontSize: 18,
                                color: AppColors.darkCharcoal,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '@dapuranita',
                              style: AppTextStyles.jakartaRegular.copyWith(
                                fontSize: 12,
                                color: Colors.brown.shade400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFBBEFC6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.verified,
                                    size: 12,
                                    color: AppColors.greenDark,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Koki Rumahan',
                                    style: AppTextStyles.jakartaSemiBold.copyWith(
                                      fontSize: 10,
                                      color: AppColors.greenDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showMessage('Fitur Edit Profil');
                      },
                      icon: const Icon(Icons.edit_outlined, size: 16),
                      label: Text(
                        'Edit Profil',
                        style: AppTextStyles.jakartaSemiBold.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.redPrimary,
                        side: const BorderSide(color: AppColors.redPrimary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // STATISTIK AKTIVITAS
            Text(
              'Aktivitas Saya',
              style: AppTextStyles.liberationBold.copyWith(
                fontSize: 17,
                color: AppColors.darkCharcoal,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _statCard(
                  icon: Icons.menu_book_rounded,
                  number: '8',
                  label: 'Resep',
                  color: AppColors.greenDark,
                  onTap: () => _navigateTo(const ResepSayaScreen()),
                ),
                const SizedBox(width: 10),
                _statCard(
                  icon: Icons.favorite_rounded,
                  number: '142',
                  label: 'Disukai',
                  color: AppColors.redPrimary,
                  onTap: () => _showMessage('142 total suka resep'),
                ),
                const SizedBox(width: 10),
                _statCard(
                  icon: Icons.bookmark_rounded,
                  number: '2',
                  label: 'Tersimpan',
                  color: AppColors.goldBrown,
                  onTap: () => _navigateTo(const FavoriteScreen()),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // NAVIGASI & AKUN
            Text(
              'Menu & Akun',
              style: AppTextStyles.liberationBold.copyWith(
                fontSize: 17,
                color: AppColors.darkCharcoal,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: _cardDecoration(),
              child: Column(
                children: [
                  _menuItem(
                    icon: Icons.explore_outlined,
                    title: 'Jelajah Resep',
                    subtitle: 'Temukan inspirasi masakan harian',
                    onTap: () => _navigateTo(const DashboardScreen()),
                  ),
                  _divider(),
                  _menuItem(
                    icon: Icons.bookmark_outline,
                    title: 'Buku Resep Favorit',
                    subtitle: 'Lihat resep yang sudah kamu simpan',
                    onTap: () => _navigateTo(const FavoriteScreen()),
                  ),
                  _divider(),
                  _menuItem(
                    icon: Icons.menu_book_outlined,
                    title: 'Kelola Resep Saya',
                    subtitle: 'Atur resep publikasi dan draf',
                    onTap: () => _navigateTo(const ResepSayaScreen()),
                  ),
                  _divider(),
                  _menuItem(
                    icon: Icons.add_circle_outline,
                    title: 'Tulis Resep Baru',
                    subtitle: 'Buat dan bagikan resep baru',
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddRecipeScreen(),
                        ),
                      );
                      if (result == true && mounted) {
                        setState(() {});
                      }
                    },
                  ),
                  _divider(),
                  _menuItem(
                    icon: Icons.notifications_none,
                    title: 'Notifikasi',
                    subtitle: 'Atur pemberitahuan aplikasi',
                    onTap: () => _showMessage('Pengaturan Notifikasi'),
                  ),
                  _divider(),
                  _menuItem(
                    icon: Icons.lock_outline,
                    title: 'Keamanan Akun',
                    subtitle: 'Ubah password dan keamanan',
                    onTap: () => _showMessage('Pengaturan Keamanan'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // LOGOUT
            Container(
              decoration: _cardDecoration(),
              child: ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.redPrimary,
                ),
                title: Text(
                  'Keluar dari Akun',
                  style: AppTextStyles.jakartaSemiBold.copyWith(
                    fontSize: 13,
                    color: AppColors.redPrimary,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.redPrimary,
                ),
                onTap: () => _showLogoutDialog(context),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                'DapurKita v1.0.0',
                style: AppTextStyles.jakartaRegular.copyWith(
                  fontSize: 11,
                  color: Colors.brown.shade400,
                ),
              ),
            ),
          ],
        ),
      ),

      // FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB94A23),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRecipeScreen(),
            ),
          );
          if (result == true && mounted) {
            setState(() {});
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // BOTTOM NAVBAR
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == _selectedIndex) return;

          if (index == 0) {
            _navigateTo(const DashboardScreen());
          } else if (index == 1) {
            _navigateTo(const FavoriteScreen());
          } else if (index == 2) {
            _navigateTo(const ResepSayaScreen());
          }
        },
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.brown.withOpacity(0.06),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String number,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: _cardDecoration(),
          child: Column(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 6),
              Text(
                number,
                style: AppTextStyles.jakartaBold.copyWith(
                  fontSize: 18,
                  color: AppColors.darkCharcoal,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTextStyles.jakartaRegular.copyWith(
                  fontSize: 11,
                  color: Colors.brown.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.redPrimary,
        size: 22,
      ),
      title: Text(
        title,
        style: AppTextStyles.jakartaSemiBold.copyWith(
          fontSize: 13,
          color: AppColors.darkCharcoal,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.jakartaRegular.copyWith(
          fontSize: 11,
          color: Colors.brown.shade400,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.brown,
      ),
      onTap: onTap,
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade100,
      indent: 16,
      endIndent: 16,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFF8F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Keluar dari Akun?',
            style: AppTextStyles.jakartaBold.copyWith(
              color: AppColors.darkCharcoal,
              fontSize: 18,
            ),
          ),
          content: Text(
            'Apakah kamu yakin ingin keluar dari akun DapurKita?',
            style: AppTextStyles.jakartaRegular.copyWith(
              color: Colors.brown.shade500,
              fontSize: 13,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Batal',
                style: AppTextStyles.jakartaSemiBold.copyWith(
                  color: Colors.brown.shade500,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redPrimary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                Navigator.pop(dialogContext);
                if (widget.onLogout != null) {
                  await widget.onLogout!();
                }
                if (!context.mounted) return;
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