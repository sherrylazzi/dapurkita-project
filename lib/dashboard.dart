import 'package:flutter/material.dart';
import 'components/top_navbar.dart';
import 'components/bottom_navbar.dart';
import 'components/search_bar.dart';
import 'components/category_chips.dart';
import 'components/recipe_card.dart';
import 'components/inspiration_card.dart';
import 'components/community_promo_card.dart'; // 1. Impor komponen CommunityPromoCard
import 'data/recipe_data.dart'; 
import 'add_recipe_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // Kategori dinamis
  final List<String> _categoryList = [
    'Semua',
    ...RecipeData.dummyRecipes.map((recipe) => recipe.category).toSet(),
  ];
  int _selectedCategoryIndex = 0;

  // State untuk mengontrol apakah semua resep ditampilkan atau dibatasi 5 saja
  bool _showAllRecipes = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Logika filter resep berdasarkan kategori
  List get _filteredRecipes {
    if (_selectedCategoryIndex == 0) {
      return RecipeData.dummyRecipes;
    }
    final selectedCategory = _categoryList[_selectedCategoryIndex];
    return RecipeData.dummyRecipes.where((recipe) => recipe.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Ambil resep hasil filter, lalu batasi maksimal 5 jika _showAllRecipes bernilai false
    final allFiltered = _filteredRecipes;
    final displayRecipes = _showAllRecipes ? allFiltered : allFiltered.take(5).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: const TopNavBar(),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            
            // Search Bar
            CustomSearchBar(
              controller: _searchController,
              onChanged: (value) {},
              onFilterTap: () {
                print("Tombol filter diklik!");
              },
            ),
            
            const SizedBox(height: 20),

            // Category Chips
            CategoryChips(
              categories: _categoryList,
              selectedIndex: _selectedCategoryIndex,
              onSelected: (index) {
                setState(() {
                  _selectedCategoryIndex = index;
                  _showAllRecipes = false; // Reset tampilan list saat kategori diganti
                });
              },
            ),

            const SizedBox(height: 24),

            // Inspiration Card (Hero Banner di atas)
            InspirationCard(
              imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500',
              category: 'Tradisional',
              title: 'Soto Betawi Kuah Susu Gurih',
              description: 'Kelezatan kuah kaldu sapi berpadu susu murni lembut dan rempah cengkeh kapulaga wangi...',
              author: 'Bu Anita',
              isVerified: true,
              rating: '4.9',
              reviewCount: '184',
              duration: '45 mnt',
              ingredientsCount: '6 bahan utama',
              portions: '4 Porsi',
              isBookmarked: false,
              onTap: () {
                print("Inspiration Card diklik!");
              },
              onBookmarkTap: () {
                print("Bookmark diklik!");
              },
            ),

            const SizedBox(height: 16),

            // Judul Section & Tombol "Semua"
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
                      // Toggle untuk melihat semua atau kembali dibatasi 5
                      _showAllRecipes = !_showAllRecipes;
                    });
                  },
                  child: Text(
                    _showAllRecipes ? 'Sembunyikan' : 'Semua',
                    style: const TextStyle(color: Color(0xFFA83211), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Daftar Card Resep (Maksimal 5 item atau semua jika tombol 'Semua' diklik)
            displayRecipes.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(
                      child: Text(
                        'Tidak ada resep dalam kategori ini.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                        ingredientsCount: recipe.ingredientsCount,
                        isBookmarked: recipe.isBookmarked,
                        onTap: () {
                          print("Membuka resep: ${recipe.title}");
                        },
                        onBookmarkTap: () {
                          print("Bookmark diklik untuk: ${recipe.title}");
                        },
                      );
                    },
                  ),

            const SizedBox(height: 8),

            // COMMUNITY PROMO CARD DI PALING BAWAH (SETELAH MENU)
            CommunityPromoCard(
              onTap: () {
                print("Tombol Baca Panduan Resep diklik!");
              },
            ),
          ],
        ),
      ),

      // Tombol Tambah Resep di tengah bawah
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB94A23),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRecipeScreen()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // BottomNavBar
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