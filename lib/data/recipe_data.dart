import '../models/recipe_models.dart';

class RecipeData {
  static const String defaultRecipeImage =
      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c';

  static final List<Recipe> recipes = [
    // --- RESEP SAYA: DIPUBLIKASIKAN ---
    Recipe(
      id: 'my-pub-1',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
      category: 'Sayuran',
      title: 'Pepes Tahu Kemangi Wangi',
      author: 'Anita Kusum',
      isVerified: true,
      rating: '4.9',
      duration: '35 mnt',
      ingredientsCount: '8 Bahan',
      portions: '4 Porsi',
      description: 'Harum kemangi dengan bumbu ulek medok.',
      isMine: true,
      isPublished: true,
      isBookmarked: true,
      likesCount: 48,
      savesCount: 32,
    ),
    Recipe(
      id: 'my-pub-2',
      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      category: 'Tradisional',
      title: 'Gulai Cumi Isi Tahu Telur',
      author: 'Anita Kusum',
      isVerified: true,
      rating: '4.8',
      duration: '60 mnt',
      ingredientsCount: '12 Bahan',
      portions: '4 Porsi',
      description: 'Kuah kental gurih khas Minang otentik.',
      isMine: true,
      isPublished: true,
      isBookmarked: false,
      likesCount: 64,
      savesCount: 58,
    ),

    // --- RESEP SAYA: DRAF & PRIBADI ---
    Recipe(
      id: 'my-draft-1',
      imageUrl: 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6',
      category: 'Porsi Keluarga',
      title: 'Resep Ayam Bakar Madu',
      author: 'Anita Kusum',
      isVerified: true,
      rating: '0.0',
      duration: '50 mnt',
      ingredientsCount: '9 Bahan',
      portions: '4 Porsi',
      description: 'Resep ayam bakar dengan madu spesial.',
      isMine: true,
      isPublished: false,
      isBookmarked: false,
      likesCount: 0,
      savesCount: 0,
    ),
    Recipe(
      id: 'my-draft-2',
      imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd',
      category: 'Pemula Ramah',
      title: 'Sup Ayam Sayuran',
      author: 'Anita Kusum',
      isVerified: true,
      rating: '0.0',
      duration: '30 mnt',
      ingredientsCount: '7 Bahan',
      portions: '3 Porsi',
      description: 'Sup hangat dengan sayuran pilihan.',
      isMine: true,
      isPublished: false,
      isBookmarked: false,
      likesCount: 0,
      savesCount: 0,
    ),

    // --- RESEP PENGGUNA LAIN (JELAJAH) ---
    Recipe(
      id: 'other-1',
      imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1',
      category: 'Tradisional',
      title: 'Rendang Sapi Minang',
      author: 'Chef Hendra',
      isVerified: true,
      rating: '4.9',
      duration: '120 mnt',
      ingredientsCount: '15 Bahan',
      portions: '6 Porsi',
      description: 'Daging sapi empuk dengan rempah kaya rasa.',
      isMine: false,
      isPublished: true,
      isBookmarked: true,
      likesCount: 120,
      savesCount: 95,
    ),
  ];

  // Resep Saya -> Dipublikasikan
  static List<Recipe> getMyPublishedRecipes() {
    return recipes.where((r) => r.isMine && r.isPublished).toList();
  }

  // Resep Saya -> Draf & Pribadi
  static List<Recipe> getMyDraftRecipes() {
    return recipes.where((r) => r.isMine && !r.isPublished).toList();
  }

  // Halaman Jelajah (resep pengguna lain yang dipublikasikan)
  static List<Recipe> getExploreRecipes() {
    return recipes.where((r) => !r.isMine && r.isPublished).toList();
  }

  // Halaman Favorit (semua resep yang di-bookmark)
  static List<Recipe> getBookmarkedRecipes() {
    return recipes.where((r) => r.isBookmarked).toList();
  }

  // Tambah resep baru (bisa langsung publikasi atau simpan sebagai draf)
  static void addRecipe(Recipe recipe) {
    recipes.insert(0, recipe);
  }

  // Toggle bookmark / favorit
  static void toggleBookmark(String id) {
    final index = recipes.indexWhere((r) => r.id == id);
    if (index != -1) {
      final nextState = !recipes[index].isBookmarked;
      recipes[index].isBookmarked = nextState;
      recipes[index].savesCount += nextState ? 1 : -1;
      if (recipes[index].savesCount < 0) recipes[index].savesCount = 0;
    }
  }
}