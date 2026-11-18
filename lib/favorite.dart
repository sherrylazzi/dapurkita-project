
import 'package:flutter/material.dart';

import 'components/top_navbar.dart';
import 'components/bottom_navbar.dart';
import 'components/search_bar.dart';
import 'components/category_chips.dart';
import 'components/recipe_card.dart';
import 'components/app_styles.dart';
import 'data/recipe_data.dart';
import 'models/recipe_models.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedIndex = 1;
  int _selectedCategoryIndex = 0;

  final TextEditingController _searchController =
      TextEditingController();

  // Hanya mengambil dua resep yang dibutuhkan
  late final List<Recipe> _favoriteRecipes;

  // Status bookmark
  final Set<String> _bookmarkedRecipes = {};

  final List<String> _categories = [
    'Semua (2)',
    'Lauk Pauk',
    'Kuah & Sup',
  ];

  @override
  void initState() {
    super.initState();

    _favoriteRecipes = RecipeData.dummyRecipes.where((recipe) {
      final title = recipe.title.toLowerCase();

      return title.contains('ayam goreng lengkuas') ||
          title.contains('soto betawi');
    }).toList();

    // Mengambil status bookmark awal dari data
    for (final recipe in _favoriteRecipes) {
      if (recipe.isBookmarked) {
        _bookmarkedRecipes.add(recipe.title);
      }
    }

    // Memperbarui tampilan ketika search dihapus
    _searchController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Menentukan kategori resep
  String _getCategory(Recipe recipe) {
    if (recipe.title.toLowerCase().contains('ayam')) {
      return 'Lauk Pauk';
    }

    return 'Kuah & Sup';
  }

  // Filter resep berdasarkan pencarian dan kategori
  List<Recipe> get _filteredRecipes {
    final keyword = _searchController.text.toLowerCase();

    return _favoriteRecipes.where((recipe) {
      final matchesSearch =
          recipe.title.toLowerCase().contains(keyword) ||
          recipe.author.toLowerCase().contains(keyword);

      final matchesCategory =
          _selectedCategoryIndex == 0 ||
          _getCategory(recipe) ==
              _categories[_selectedCategoryIndex];

      final isBookmarked =
          _bookmarkedRecipes.contains(recipe.title);

      return matchesSearch && matchesCategory && isBookmarked;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
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
                      '${_bookmarkedRecipes.length} Resep Aktif',
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
              '2 koleksi resep pilihan yang Anda simpan untuk '
              'dimasak di dapur rumah.',
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
                // Tombol filter
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Filter resep favorit'),
                  ),
                );
              },
            ),

            const SizedBox(height: 14),

            // CATEGORY
            CategoryChips(
              categories: _categories,
              selectedIndex: _selectedCategoryIndex,
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
                    category: _getCategory(recipe),
                    title: recipe.title,
                    author: recipe.author,
                    isVerified: recipe.isVerified,
                    rating: recipe.rating,
                    duration: recipe.duration,
                    ingredientsCount: recipe.ingredientsCount,
                    isBookmarked: _bookmarkedRecipes.contains(
                      recipe.title,
                    ),

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
                        _bookmarkedRecipes.remove(recipe.title);
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
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
