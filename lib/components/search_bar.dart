import 'package:flutter/material.dart';
import 'app_styles.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const CustomSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Kotak Input Search Bar
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyles.jakartaRegular.copyWith(
                fontSize: 14,
                color: AppColors.darkCharcoal,
              ),
              decoration: InputDecoration(
                hintText: 'Cari resep, bahan (cth: tempe), atau bu...',
                hintStyle: AppTextStyles.jakartaRegular.copyWith(
                  fontSize: 13,
                  color: Colors.grey.shade400,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 18,
                  ),
                  onPressed: () {
                    // Tombol X untuk menghapus teks
                    controller?.clear();
                  },
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Tombol Filter di sebelah kanan search bar
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.tune, // Ikon filter sesuai desain Figma
              color: AppColors.redPrimary,
              size: 20,
            ),
            onPressed: onFilterTap ?? () {},
          ),
        ),
      ],
    );
  }
}