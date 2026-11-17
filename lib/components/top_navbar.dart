import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Menggunakan dekorasi agar kita bisa mengatur bayangan (shadow) di bawah secara kustom
      decoration: BoxDecoration(
        color: const Color(0xFFF9F6F0),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.06), // Warna bayangan kecokelatan lembut
            blurRadius: 10,
            offset: const Offset(0, 4), // Arah bayangan ke bawah (sumbu Y positif)
          ),
        ],
      ),
      child: SafeArea(
        child: AppBar(
          backgroundColor: Colors.transparent, // Transparan karena warna sudah diatur di Container luar
          elevation: 0, // Matikan elevation bawaan AppBar agar tidak memunculkan garis abu-abu
          centerTitle: true,
          title: const Text(
            'DapurKita',
            style: TextStyle(
              color: Color(0xFF8B4513),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.brown),
              onPressed: () {},
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}