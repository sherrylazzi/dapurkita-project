import 'package:flutter/material.dart';
import 'app_styles.dart';

class InspirationCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String title;
  final String description;
  final String author;
  final bool isVerified;
  final String rating;
  final String reviewCount;
  final String duration;
  final String ingredientsCount;
  final String portions;
  final bool isBookmarked;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;

  const InspirationCard({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.description,
    required this.author,
    this.isVerified = true,
    required this.rating,
    required this.reviewCount,
    required this.duration,
    required this.ingredientsCount,
    required this.portions,
    this.isBookmarked = false,
    this.onTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. BAGIAN GAMBAR BESAR DI ATAS DENGAN ELEMEN MELAYANG
            SizedBox(
              height: 220,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Gambar Utama
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),

                    // Gradasi gelap tipis di bagian bawah gambar agar teks/badge lebih kontras
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                            Colors.black.withOpacity(0.4),
                          ],
                        ),
                      ),
                    ),

                    // Badge Kategori di Kiri Atas (mis: Tradisional)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.local_fire_department, size: 14, color: AppColors.redPrimary),
                            const SizedBox(width: 4),
                            Text(
                              category,
                              style: AppTextStyles.jakartaSemiBold.copyWith(
                                fontSize: 11,
                                color: AppColors.redPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Tombol Bookmark di Kanan Atas
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onBookmarkTap,
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                              size: 18,
                              color: isBookmarked ? AppColors.redPrimary : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Profil Author di Kiri Bawah Gambar
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100'),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              author,
                              style: AppTextStyles.jakartaSemiBold.copyWith(fontSize: 11, color: Colors.white),
                            ),
                            if (isVerified) ...[
                              const SizedBox(width: 4),
                              const Icon(Icons.verified, size: 12, color: Colors.greenAccent),
                            ],
                          ],
                        ),
                      ),
                    ),

                    // Rating di Kanan Bawah Gambar
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, size: 14, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              '$rating ($reviewCount)',
                              style: AppTextStyles.jakartaSemiBold.copyWith(fontSize: 11, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. BAGIAN TEKS DI BAWAH GAMBAR
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul Resep
                  Text(
                    title,
                    style: AppTextStyles.liberationBold.copyWith(
                      fontSize: 18,
                      color: AppColors.darkCharcoal,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Deskripsi Singkat Resep
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.jakartaRegular.copyWith(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Kotak Info Bawah (Waktu, Bahan, Porsi)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Waktu
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 14, color: AppColors.redPrimary),
                            const SizedBox(width: 6),
                            Text(duration, style: AppTextStyles.jakartaRegular.copyWith(fontSize: 12)),
                          ],
                        ),
                        Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                        // Bahan
                        Row(
                          children: [
                            const Icon(Icons.restaurant_menu, size: 14, color: AppColors.redPrimary),
                            const SizedBox(width: 6),
                            Text(ingredientsCount, style: AppTextStyles.jakartaRegular.copyWith(fontSize: 12)),
                          ],
                        ),
                        Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                        // Porsi
                        Row(
                          children: [
                            const Icon(Icons.room_service, size: 14, color: AppColors.redPrimary),
                            const SizedBox(width: 6),
                            Text(portions, style: AppTextStyles.jakartaRegular.copyWith(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}