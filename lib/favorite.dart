import 'package:flutter/material.dart';

import 'components/top_navbar.dart';
import 'components/bottom_navbar.dart';
import 'components/search_bar.dart';
import 'components/category_chips.dart';
import 'components/recipe_card.dart';
import 'components/app_styles.dart';
import 'components/recipe_filter_sheet.dart';
import 'data/recipe_data.dart';
import 'models/recipe_models.dart';
import 'my_recipe.dart';
import 'dashboard.dart';
import 'add_recipe_screen.dart';

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

  String _sortOption = 'default';

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Kategori resep favorit
  List<String> get _categories {
    final bookmarkedCategories =
        RecipeData.getBookmarkedRecipes()
            .map((recipe) => recipe.category)
            .toSet()
            .toList();

    return ['Semua', ...bookmarkedCategories];
  }

  // Search dan filter resep favorit
  List<Recipe> get _filteredRecipes {
    final keyword =
        _searchController.text.trim().toLowerCase();

    final bookmarkedRecipes =
        RecipeData.getBookmarkedRecipes();

    final safeIndex =
        _selectedCategoryIndex >= _categories.length
            ? 0
            : _selectedCategoryIndex;

    final currentCategory = _categories[safeIndex];

    final filtered = bookmarkedRecipes.where((recipe) {
      final matchesSearch =
          recipe.title.toLowerCase().contains(keyword) ||
          recipe.author.toLowerCase().contains(keyword) ||
          recipe.category.toLowerCase().contains(keyword) ||
          recipe.description.toLowerCase().contains(keyword) ||
          recipe.duration.toLowerCase().contains(keyword) ||
          recipe.ingredientsCount.toLowerCase().contains(keyword);

      final matchesCategory =
          safeIndex == 0 ||
          recipe.category == currentCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return sortRecipes(filtered, _sortOption);
  }

  // Menampilkan pilihan filter
  Future<void> _openFilter() async {
    final selected = await RecipeFilterSheet.show(
      context,
      selected: _sortOption,
    );

    if (selected != null && mounted) {
      setState(() {
        _sortOption = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalBookmarked =
        RecipeData.getBookmarkedRecipes().length;

    final recipes = _filteredRecipes;

    final safeCategoryIndex =
        _selectedCategoryIndex >= _categories.length
            ? 0
            : _selectedCategoryIndex;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      appBar: const TopNavBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // HEADER BUKU RESEP
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
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

            // JUDUL
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

            // SEARCH BAR DAN FILTER
            CustomSearchBar(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              onFilterTap: _openFilter,
            ),

            const SizedBox(height: 14),

            // CATEGORY CHIPS
            CategoryChips(
              categories: _categories,
              selectedIndex: safeCategoryIndex,
              onSelected: (index) {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
            ),

            const SizedBox(height: 14),

            // JUDUL DAFTAR
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
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
                physics:
                    const NeverScrollableScrollPhysics(),
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
                    ingredientsCount:
                        recipe.ingredientsCount,
                    isBookmarked: recipe.isBookmarked,

                    onTap: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            'Membuka ${recipe.title}',
                          ),
                        ),
                      );
                    },

                    onBookmarkTap: () {
                      setState(() {
                        RecipeData.toggleBookmark(
                          recipe.id,
                        );
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
              builder: (context) =>
                  const AddRecipeScreen(),
            ),
          );

          if (result == true && mounted) {
            setState(() {});
          }
        },
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
              MaterialPageRoute(
                builder: (context) =>
                    const DashboardScreen(),
              ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const FavoriteScreen(),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const ResepSayaScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}