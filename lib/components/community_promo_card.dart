import 'package:flutter/material.dart';
import 'app_styles.dart';

class CommunityPromoCard extends StatelessWidget {
  final VoidCallback? onTap;

  const CommunityPromoCard({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7EFE9), // Warna krem lembut sesuai Figma
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Dekorasi ikon samar di pojok kanan bawah card
          Positioned(
            bottom: -10,
            right: -10,
            child: Icon(
              Icons.menu_book_rounded,
              size: 110,
              color: Colors.brown.withOpacity(0.04),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge Komunitas DapurKita
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.redPrimary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit_note,
                        size: 14,
                        color: AppColors.redPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'KOMUNITAS DAPURKITA',
                      style: AppTextStyles.jakartaSemiBold.copyWith(
                        fontSize: 11,
                        color: AppColors.redPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Judul Utama
                Text(
                  'Punya Resep Masakan Andalan?',
                  style: AppTextStyles.liberationBold.copyWith(
                    fontSize: 18,
                    color: AppColors.darkCharcoal,
                  ),
                ),
                const SizedBox(height: 8),

                // Deskripsi
                Text(
                  'Tulis resep buatanmu lengkap dengan takaran sendok dan foto langkah demi langkah. Dapatkan lencana koki dan bagikan kelezatan ke ribuan dapur lainnya!',
                  style: AppTextStyles.jakartaRegular.copyWith(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),

                // Tombol Aksi "Baca Panduan Resep"
                ElevatedButton(
                  onPressed: onTap ?? () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Baca Panduan Resep',
                        style: AppTextStyles.jakartaSemiBold.copyWith(fontSize: 13),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}