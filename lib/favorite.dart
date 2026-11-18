import 'package:flutter/material.dart';

import 'components/top_navbar.dart';
import 'components/bottom_navbar.dart';
import 'components/search_bar.dart';
import 'components/category_chips.dart';
import 'components/recipe_card.dart';
import 'components/app_styles.dart';
import 'data/recipe_data.dart';
import 'models/recipe_models.dart';
import 'my_recipe.dart';
import 'dashboard.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedIndex = 1;
  int _selectedCategoryIndex = 0;

  final TextEditingController _searchController = TextEditingController();

  // Membuat kategori secara dinamis dari resep yang berstatus bookmarked
  List<String> get _categories {
    final bookmarkedCategories = RecipeData.dummyRecipes
        .where((recipe) => recipe.isBookmarked)
        .map((recipe) => recipe.category)
        .toSet();

    return ['Semua', ...bookmarkedCategories];
  }

  @override
  void initState() {
    super.initState();
    // Memperbarui tampilan ketika pencarian diketik
    _searchController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter resep berdasarkan pencarian, kategori, dan isBookmarked == true
  List<Recipe> get _filteredRecipes {
    final keyword = _searchController.text.toLowerCase();

    // Mengambil langsung resep dari sumber global RecipeData yang di-bookmark
    final bookmarkedRecipes =
        RecipeData.dummyRecipes.where((recipe) => recipe.isBookmarked).toList();

    return bookmarkedRecipes.where((recipe) {
      final matchesSearch =
          recipe.title.toLowerCase().contains(keyword) ||
          recipe.author.toLowerCase().contains(keyword);

      final currentCategory = _categories[_selectedCategoryIndex];
      final matchesCategory =
          _selectedCategoryIndex == 0 || recipe.category == currentCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final totalBookmarked =
        RecipeData.dummyRecipes.where((r) => r.isBookmarked).length;
    final recipes = _filteredRecipes;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),

      // TOP NAVBAR
      appBar: const TopNavBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER BUKU RESEP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 9,
                      color: Color(0xFF3A6848),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$totalBookmarked Resep Aktif',
                      style: AppTextStyles.jakartaSemiBold.copyWith(
                        fontSize: 10,
                        color: AppColors.greenDark,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBBEFC6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '♥ Koleksi Tersimpan',
                    style: AppTextStyles.jakartaSemiBold.copyWith(
                      fontSize: 9,
                      color: AppColors.greenDark,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              'Buku Resep Favorit',
              style: AppTextStyles.liberationBold.copyWith(
                fontSize: 25,
                color: AppColors.darkCharcoal,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'Koleksi resep pilihan yang Anda simpan untuk dimasak di dapur rumah.',
              style: AppTextStyles.jakartaRegular.copyWith(
                fontSize: 12,
                color: Colors.brown.shade400,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 16),

            // SEARCH BAR
            CustomSearchBar(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              onFilterTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Filter resep favorit'),
                  ),
                );
              },
            ),

            const SizedBox(height: 14),

            // CATEGORY CHIPS
            CategoryChips(
              categories: _categories,
              selectedIndex: _selectedCategoryIndex > _categories.length - 1
                  ? 0
                  : _selectedCategoryIndex,
              onSelected: (index) {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
            ),

            const SizedBox(height: 14),

            // JUDUL DAFTAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Resep Tersimpan',
                  style: AppTextStyles.liberationBold.copyWith(
                    fontSize: 19,
                    color: AppColors.darkCharcoal,
                  ),
                ),
                Text(
                  '${recipes.length} resep',
                  style: AppTextStyles.jakartaRegular.copyWith(
                    fontSize: 11,
                    color: Colors.brown.shade400,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // DAFTAR RESEP
            if (recipes.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 45,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.bookmark_border,
                        size: 55,
                        color: Colors.brown.shade200,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Resep tidak ditemukan',
                        style: AppTextStyles.jakartaSemiBold.copyWith(
                          color: AppColors.darkCharcoal,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Coba cari resep lainnya.',
                        style: AppTextStyles.jakartaRegular.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];

                  return RecipeCard(
                    imageUrl: recipe.imageUrl,
                    category: recipe.category,
                    title: recipe.title,
                    author: recipe.author,
                    isVerified: recipe.isVerified,
                    rating: recipe.rating,
                    duration: recipe.duration,
                    ingredientsCount: recipe.ingredientsCount,
                    isBookmarked: recipe.isBookmarked,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Membuka ${recipe.title}',
                          ),
                        ),
                      );
                    },
                    onBookmarkTap: () {
                      setState(() {
                        // Mengubah status menjadi false agar otomatis hilang dari halaman favorite
                        recipe.isBookmarked = false;
                      });
                    },
                  );
                },
              ),

            const SizedBox(height: 15),
          ],
        ),
      ),

      // TOMBOL TAMBAH
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.redPrimary,
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      // BOTTOM NAVBAR
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == _selectedIndex) return;

          setState(() {
            _selectedIndex = index;
          });

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FavoriteScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ResepSayaScreen()),
            );
          }
        },
      ),
    );
  }
}