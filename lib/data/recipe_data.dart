import '../models/recipe_models.dart';

class RecipeData {
  static const String defaultRecipeImage =
      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c';

  static final List<Recipe> recipes = [
    // --- RESEP SAYA: DIPUBLIKASIKAN ---
    Recipe(
      id: 'my-pub-1',
      imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c',
      category: 'Tradisional',
      title: 'Tumis Oncom Leunca Pedas',
      author: 'Anita Kusum',
      isVerified: true,
      rating: '4.8',
      duration: '20 mnt',
      ingredientsCount: '7 Bahan',
      portions: '3 Porsi',
      description: 'Perpaduan gurih oncom bakar dengan renyah leunca dan kemangi.',
      isMine: true,
      isPublished: true,
      isBookmarked: false,
      likesCount: 41,
      savesCount: 29,
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
      isBookmarked: true,
      likesCount: 64,
      savesCount: 58,
    ),
    Recipe(
      id: 'my-pub-3',
      imageUrl: 'https://images.unsplash.com/photo-1574484284002-952d92456975',
      category: 'Sayuran',
      title: 'Sayur Asem Segar Khas Sunda',
      author: 'Anita Kusum',
      isVerified: true,
      rating: '4.8',
      duration: '30 mnt',
      ingredientsCount: '9 Bahan',
      portions: '4 Porsi',
      description: 'Asam segar pas dengan kacang tanah dan jagung manis.',
      isMine: true,
      isPublished: true,
      isBookmarked: false,
      likesCount: 39,
      savesCount: 24,
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
    Recipe(
      id: 'my-draft-3',
      imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8',
      category: 'Cepat 15 Menit',
      title: 'Telur Dadar Krispi Bawang Daun',
      author: 'Anita Kusum',
      isVerified: true,
      rating: '0.0',
      duration: '15 mnt',
      ingredientsCount: '5 Bahan',
      portions: '2 Porsi',
      description: 'Pinggiran renyah, bagian dalam tetap lembut.',
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
    Recipe(
      id: 'other-2',
      imageUrl: 'https://images.unsplash.com/photo-1626777552726-4a6b54c97e46',
      category: 'Pemula Ramah',
      title: 'Ayam Goreng Lengkuas Gurih',
      author: 'Chef Dimas',
      isVerified: true,
      rating: '4.8',
      duration: '40 mnt',
      ingredientsCount: '8 Bahan',
      portions: '4 Porsi',
      description: 'Ayam berbumbu kuning dengan serundeng lengkuas renyah.',
      isMine: false,
      isPublished: true,
      isBookmarked: false,
      likesCount: 88,
      savesCount: 61,
    ),
    Recipe(
      id: 'other-3',
      imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624',
      category: 'Tradisional',
      title: 'Soto Betawi Kuah Susu Gurih',
      author: 'Chef Juna',
      isVerified: true,
      rating: '4.9',
      duration: '90 mnt',
      ingredientsCount: '12 Bahan',
      portions: '4 Porsi',
      description: 'Kuah kaldu sapi berpadu susu murni lembut dan rempah wangi.',
      isMine: false,
      isPublished: true,
      isBookmarked: false,
      likesCount: 145,
      savesCount: 102,
    ),
    Recipe(
      id: 'other-4',
      imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c',
      category: 'Cepat 15 Menit',
      title: 'Tumis Kangkung Belacan Terasi',
      author: 'Mama Sari',
      isVerified: false,
      rating: '4.7',
      duration: '15 mnt',
      ingredientsCount: '6 Bahan',
      portions: '3 Porsi',
      description: 'Tumisan kilat dengan aroma terasi bakar yang menggugah selera.',
      isMine: false,
      isPublished: true,
      isBookmarked: false,
      likesCount: 54,
      savesCount: 37,
    ),
    Recipe(
      id: 'other-5',
      imageUrl: 'https://images.unsplash.com/photo-1543339308-43e59d6b73a6',
      category: 'Porsi Keluarga',
      title: 'Sayur Lodeh Labu Siam Santan',
      author: 'Ibu Siti',
      isVerified: true,
      rating: '4.8',
      duration: '35 mnt',
      ingredientsCount: '10 Bahan',
      portions: '5 Porsi',
      description: 'Kuah santan gurih ringan dengan labu siam, kacang panjang, dan tahu.',
      isMine: false,
      isPublished: true,
      isBookmarked: false,
      likesCount: 73,
      savesCount: 49,
    ),
    Recipe(
      id: 'other-6',
      imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999',
      category: 'Sayuran',
      title: 'Cah Brokoli Tahu Saus Tiram',
      author: 'Bunda Rina',
      isVerified: true,
      rating: '4.7',
      duration: '20 mnt',
      ingredientsCount: '8 Bahan',
      portions: '3 Porsi',
      description: 'Brokoli tetap renyah berbalut saus tiram gurih manis.',
      isMine: false,
      isPublished: true,
      isBookmarked: false,
      likesCount: 62,
      savesCount: 44,
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