import 'package:dapur_kita/models/recipe_models.dart';
import 'package:flutter/material.dart';
import 'components/top_navbar.dart';
import 'components/bottom_navbar.dart';
import 'components/search_bar.dart';
import 'components/category_chips.dart';
import 'components/recipe_card.dart';
import 'components/inspiration_card.dart';
import 'components/community_promo_card.dart';
import 'components/recipe_filter_sheet.dart';
import 'data/recipe_data.dart';
import 'add_recipe_screen.dart';
import 'favorite.dart';
import 'my_recipe.dart';
import 'profile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController =
      TextEditingController();

  List<Recipe> get _exploreRecipes =>
      RecipeData.getExploreRecipes();

  List<String> get _categoryList => [
        'Semua',
        ..._exploreRecipes
            .map((recipe) => recipe.category)
            .toSet(),
      ];

  int _selectedCategoryIndex = 0;
  bool _showAllRecipes = false;
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

  List<Recipe> get _filteredRecipes {
    final keyword =
        _searchController.text.trim().toLowerCase();

    final baseList = _selectedCategoryIndex == 0
        ? _exploreRecipes
        : _exploreRecipes
            .where((recipe) =>
                recipe.category ==
                _categoryList[_selectedCategoryIndex])
            .toList();

    final matched = baseList.where((recipe) {
      return keyword.isEmpty ||
          recipe.title.toLowerCase().contains(keyword) ||
          recipe.author.toLowerCase().contains(keyword) ||
          recipe.category.toLowerCase().contains(keyword) ||
          recipe.description.toLowerCase().contains(keyword) ||
          recipe.duration.toLowerCase().contains(keyword) ||
          recipe.ingredientsCount.toLowerCase().contains(keyword);
    }).toList();

    return sortRecipes(matched, _sortOption);
  }

  @override
  Widget build(BuildContext context) {
    final safeCategoryIndex =
        _selectedCategoryIndex >= _categoryList.length
            ? 0
            : _selectedCategoryIndex;

    final allFiltered = _filteredRecipes;

    final displayRecipes = _showAllRecipes
        ? allFiltered
        : allFiltered.take(5).toList();

    final Recipe? heroRecipe =
        RecipeData.recipes.cast<Recipe?>().firstWhere(
              (r) =>
                  r != null &&
                  r.title.toLowerCase().contains('soto betawi'),
              orElse: () => _exploreRecipes.isNotEmpty
                  ? _exploreRecipes.first
                  : null,
            );

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: const TopNavBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            CustomSearchBar(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              onFilterTap: () async {
                final selected =
                    await RecipeFilterSheet.show(
                  context,
                  selected: _sortOption,
                );

                if (selected != null && mounted) {
                  setState(() {
                    _sortOption = selected;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            CategoryChips(
              categories: _categoryList,
              selectedIndex: safeCategoryIndex,
              onSelected: (index) {
                setState(() {
                  _selectedCategoryIndex = index;
                  _showAllRecipes = false;
                });
              },
            ),

            const SizedBox(height: 24),

            if (heroRecipe != null)
              InspirationCard(
                imageUrl: heroRecipe.imageUrl.isNotEmpty
                    ? heroRecipe.imageUrl
                    : 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500',
                category: heroRecipe.category,
                title: heroRecipe.title,
                description: heroRecipe.description.isNotEmpty
                    ? heroRecipe.description
                    : 'Kelezatan kuah kaldu sapi berpadu susu murni lembut dan rempah cengkeh kapulaga wangi...',
                author: heroRecipe.author,
                isVerified: heroRecipe.isVerified,
                rating: heroRecipe.rating,
                reviewCount: '184',
                duration: heroRecipe.duration,
                ingredientsCount: heroRecipe.ingredientsCount,
                portions: heroRecipe.portions,
                isBookmarked: heroRecipe.isBookmarked,
                onTap: () {
                  print("Inspiration Card diklik!");
                },
                onBookmarkTap: () {
                  setState(() {
                    RecipeData.toggleBookmark(heroRecipe.id);
                  });
                },
              ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Inspirasi Hari Ini',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF372F2A),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showAllRecipes = !_showAllRecipes;
                    });
                  },
                  child: Text(
                    _showAllRecipes
                        ? 'Sembunyikan'
                        : 'Semua',
                    style: const TextStyle(
                      color: Color(0xFFA83211),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            displayRecipes.isEmpty
                ? const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(
                      child: Text(
                        'Tidak ada resep dalam kategori ini.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount: displayRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = displayRecipes[index];

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
                          print(
                              "Membuka resep: ${recipe.title}");
                        },
                        onBookmarkTap: () {
                          setState(() {
                            RecipeData.toggleBookmark(
                                recipe.id);
                          });
                        },
                      );
                    },
                  ),

            const SizedBox(height: 8),

            CommunityPromoCard(
              onTap: () {
                print(
                    "Tombol Baca Panduan Resep diklik!");
              },
            ),
          ],
        ),
      ),

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

      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == _selectedIndex) return;

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
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  onLogout: () async {
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}