import 'package:flutter/material.dart';
import 'app_styles.dart';

class RecipeCard extends StatelessWidget {
  final String imageUrl;         // Foto makanan
  final String category;         // Label kategori (mis: "Porsi Keluarga", "Favorit")
  final String title;            // Nama resep
  final String author;           // Pembuat resep
  final bool isVerified;         // Status centang hijau koki
  final String rating;           // Rating (mis: "4.9")
  final String duration;         // Waktu masak (mis: "3.5 jam")
  final String ingredientsCount; // Jumlah bahan (mis: "14 bahan")
  final bool isBookmarked;       // Status tombol bookmark
  final VoidCallback? onTap;     // Aksi saat card diklik
  final VoidCallback? onBookmarkTap; // Aksi saat tombol bookmark diklik

  const RecipeCard({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.author,
    this.isVerified = true,
    required this.rating,
    required this.duration,
    required this.ingredientsCount,
    this.isBookmarked = false,
    this.onTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Gambar Resep di Kiri
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                // Penanganan jika gambar gagal dimuat / loading
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // 2. Konten Teks di Kanan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Baris Kategori & Bookmark
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Badge Kategori (mis: Porsi Keluarga)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.greenDark.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          category,
                          style: AppTextStyles.jakartaSemiBold.copyWith(
                            fontSize: 10,
                            color: AppColors.greenDark,
                          ),
                        ),
                      ),
                      // Tombol Bookmark
                      GestureDetector(
                        onTap: onBookmarkTap,
                        child: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          size: 20,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Judul Resep
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.liberationBold.copyWith(
                      fontSize: 14,
                      color: AppColors.darkCharcoal,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Pembuat Resep & Centang Hijau
                  Row(
                    children: [
                      Text(
                        'Oleh $author',
                        style: AppTextStyles.jakartaRegular.copyWith(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      if (isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, size: 12, color: Colors.green),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Info Bawah (Rating, Durasi, Jumlah Bahan)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8F6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rating
                        Row(
                          children: [
                            const Icon(Icons.star, size: 12, color: Colors.amber),
                            const SizedBox(width: 2),
                            Text(
                              rating,
                              style: AppTextStyles.jakartaSemiBold.copyWith(fontSize: 11),
                            ),
                          ],
                        ),
                        // Durasi Waktu
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 12, color: Colors.grey),
                            const SizedBox(width: 2),
                            Text(
                              duration,
                              style: AppTextStyles.jakartaRegular.copyWith(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                        // Jumlah Bahan
                        Row(
                          children: [
                            const Icon(Icons.restaurant_menu, size: 12, color: Colors.grey),
                            const SizedBox(width: 2),
                            Text(
                              ingredientsCount,
                              style: AppTextStyles.jakartaRegular.copyWith(fontSize: 11, color: Colors.grey),
                            ),
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