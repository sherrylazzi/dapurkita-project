
import 'package:flutter/material.dart';
import 'components/top_navbar.dart';
import 'components/bottom_navbar.dart';
import 'dashboard.dart';
import 'favorite.dart';

const Color primaryRed = Color(0xFFA83211);
const Color pageBackground = Color(0xFFFFF8F5);
const Color darkText = Color(0xFF30231F);
const Color mutedText = Color(0xFF927E75);

class ResepSayaScreen extends StatefulWidget {
  const ResepSayaScreen({super.key});

  @override
  State<ResepSayaScreen> createState() => _ResepSayaScreenState();
}

class _ResepSayaScreenState extends State<ResepSayaScreen> {
  int _selectedIndex = 2;
  int _selectedTab = 0;

  String _searchQuery = '';
  String _sortBy = 'Terbaru';

  final List<_MyRecipe> _publishedRecipes = [
    _MyRecipe(
      title: 'Pepes Tahu Kemangi Wangi',
      description: 'Harum kemangi dengan bumbu ulek medok',
      image: 'https://images.unsplash.com/photo-1547592180-85f173990554?w=400',
      duration: '35m',
      saved: 32,
      likes: 48,
    ),
    _MyRecipe(
      title: 'Gulai Cumi Isi Tahu Telur',
      description: 'Kuah kental gurih khas Minang otentik',
      image: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400',
      duration: '50m',
      saved: 58,
      likes: 64,
    ),
    _MyRecipe(
      title: 'Nasi Goreng Spesial Kampung',
      description: 'Nasi goreng dengan bumbu rempah pilihan',
      image: 'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=400',
      duration: '25m',
      saved: 24,
      likes: 39,
    ),
    _MyRecipe(
      title: 'Ayam Goreng Lengkuas',
      description: 'Ayam gurih dengan taburan lengkuas renyah',
      image: 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=400',
      duration: '40m',
      saved: 42,
      likes: 76,
    ),
    _MyRecipe(
      title: 'Soto Betawi Kuah Susu',
      description: 'Kuah creamy dengan daging sapi empuk',
      image: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400',
      duration: '90m',
      saved: 51,
      likes: 82,
    ),
    _MyRecipe(
      title: 'Sayur Asem Segar',
      description: 'Sayuran segar dengan kuah asam menyegarkan',
      image: 'https://images.unsplash.com/photo-1547592180-85f173990554?w=400',
      duration: '30m',
      saved: 18,
      likes: 27,
    ),
  ];

  final List<_MyRecipe> _draftRecipes = [
    _MyRecipe(
      title: 'Resep Ayam Bakar Madu',
      description: 'Resep ayam bakar dengan madu spesial',
      image: 'https://images.unsplash.com/photo-1532550907401-a500c9a57435?w=400',
      duration: '45m',
      saved: 0,
      likes: 0,
    ),
    _MyRecipe(
      title: 'Sup Ayam Sayuran',
      description: 'Sup hangat dengan sayuran pilihan',
      image: 'https://images.unsplash.com/photo-1547592180-85f173990554?w=400',
      duration: '30m',
      saved: 0,
      likes: 0,
    ),
  ];

  final TextEditingController _searchController =
      TextEditingController();

  List<_MyRecipe> get _currentRecipes {
    final source = _selectedTab == 0
        ? _publishedRecipes
        : _draftRecipes;

    final filtered = source.where((recipe) {
      return recipe.title.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
    }).toList();

    if (_sortBy == 'A-Z') {
      filtered.sort((a, b) => a.title.compareTo(b.title));
    } else if (_sortBy == 'Paling Disukai') {
      filtered.sort((a, b) => b.likes.compareTo(a.likes));
    }

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: primaryRed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipes = _currentRecipes;

    return Scaffold(
      backgroundColor: pageBackground,

      // TOP NAVBAR
      appBar: const TopNavBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================
            // PROFILE CARD
            // =========================
            Container(
              padding: const EdgeInsets.all(12),
              decoration: _cardDecoration(),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 27,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Anita Kusum',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: darkText,
                              ),
                            ),

                            const SizedBox(height: 2),

                            const Text(
                              '@dapuranita',
                              style: TextStyle(
                                fontSize: 10,
                                color: mutedText,
                              ),
                            ),

                            const SizedBox(height: 7),

                            Wrap(
                              spacing: 5,
                              children: const [
                                _ProfileStat('8 Resep'),
                                _ProfileStat('142 Disukai'),
                                _ProfileStat('4 Draf'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFBCEFC9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified,
                              size: 11,
                              color: Color(0xFF376C47),
                            ),
                            SizedBox(width: 3),
                            Text(
                              'Koki\nRumahan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF376C47),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 38,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showMessage(
                                'Halaman tulis resep baru akan dibuka',
                              );
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 15,
                            ),
                            label: const Text(
                              'Tulis Resep Baru',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryRed,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Container(
                        height: 38,
                        width: 38,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF9EAE4),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            _showMessage('Pengaturan resep');
                          },
                          icon: const Icon(
                            Icons.tune,
                            size: 17,
                            color: primaryRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 11),

            // =========================
            // TAB PUBLIKASI DAN DRAF
            // =========================
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFFF1E4DE),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  _buildTab(
                    'Dipublikasikan',
                    '6',
                    0,
                  ),
                  _buildTab(
                    'Draf & Pribadi',
                    '2',
                    1,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // =========================
            // SEARCH DAN SORT
            // =========================
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: const Color(0xFFF1E4DE),
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      style: const TextStyle(fontSize: 10),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          size: 16,
                          color: mutedText,
                        ),
                        hintText: 'Cari resep saya...',
                        hintStyle: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          bottom: 10,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 7),

                PopupMenuButton<String>(
                  onSelected: (value) {
                    setState(() {
                      _sortBy = value;
                    });
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Terbaru',
                      child: Text('Terbaru'),
                    ),
                    const PopupMenuItem(
                      value: 'A-Z',
                      child: Text('A-Z'),
                    ),
                    const PopupMenuItem(
                      value: 'Paling Disukai',
                      child: Text('Paling Disukai'),
                    ),
                  ],
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8ECE6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.swap_vert,
                          size: 14,
                          color: mutedText,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          _sortBy,
                          style: const TextStyle(
                            fontSize: 9,
                            color: darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 11),

            // =========================
            // DAFTAR RESEP
            // =========================
            if (recipes.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    'Resep tidak ditemukan.',
                    style: TextStyle(color: mutedText),
                  ),
                ),
              )
            else
              ...recipes.map(
                (recipe) => _buildRecipeCard(recipe),
              ),
          ],
        ),
      ),

      // FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryRed,
        elevation: 4,
        shape: const CircleBorder(),
        onPressed: () {
          _showMessage('Mulai menulis resep baru');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 27,
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

  // =========================
  // TAB WIDGET
  // =========================
  Widget _buildTab(String title, String count, int index) {
    final selected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: selected
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: selected ? primaryRed : darkText,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFFFE2D8)
                      : const Color(0xFFE7D8D0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count,
                  style: const TextStyle(
                    fontSize: 8,
                    color: primaryRed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // RECIPE CARD
  // =========================
  Widget _buildRecipeCard(_MyRecipe recipe) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(9),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GAMBAR
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.network(
                  recipe.image,
                  width: 61,
                  height: 61,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) {
                    return Container(
                      width: 61,
                      height: 61,
                      color: const Color(0xFFF1E4DE),
                      child: const Icon(
                        Icons.restaurant,
                        color: primaryRed,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 9),

              // INFORMASI RESEP
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedTab == 0
                            ? const Color(0xFFBCEFC9)
                            : const Color(0xFFFFE5C8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _selectedTab == 0 ? '● Publik' : '● Draf',
                        style: TextStyle(
                          fontSize: 8,
                          color: _selectedTab == 0
                              ? const Color(0xFF376C47)
                              : primaryRed,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      recipe.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: darkText,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      recipe.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        color: mutedText,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        const Icon(
                          Icons.bookmark,
                          size: 10,
                          color: primaryRed,
                        ),
                        Text(
                          ' ${recipe.saved} Disimpan',
                          style: const TextStyle(
                            fontSize: 8,
                            color: primaryRed,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.favorite,
                          size: 10,
                          color: Color(0xFFDB9B36),
                        ),
                        Text(
                          ' ${recipe.likes} Suka',
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFF9B6D25),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // MENU TITIK TIGA
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                iconSize: 17,
                icon: const Icon(
                  Icons.more_vert,
                  color: mutedText,
                ),
                onSelected: (value) {
                  _showMessage('$value: ${recipe.title}');
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'Edit resep',
                    child: Text('Edit resep'),
                  ),
                  PopupMenuItem(
                    value: 'Hapus resep',
                    child: Text('Hapus resep'),
                  ),
                  PopupMenuItem(
                    value: 'Bagikan',
                    child: Text('Bagikan'),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          // GARIS PEMISAH
          Container(
            height: 1,
            color: const Color(0xFFF4E9E3),
          ),

          const SizedBox(height: 7),

          // TOMBOL BAWAH
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      height: 29,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _showMessage(
                            'Edit ${recipe.title}',
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 11,
                        ),
                        label: const Text(
                          'Edit Resep',
                          style: TextStyle(fontSize: 9),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryRed,
                          backgroundColor: const Color(0xFFFFF2ED),
                          side: BorderSide.none,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),

                    Container(
                      height: 29,
                      width: 29,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8ECE6),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          _showMessage(
                            'Bagikan ${recipe.title}',
                          );
                        },
                        icon: const Icon(
                          Icons.share,
                          size: 13,
                          color: mutedText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Text(
                'Visibilitas',
                style: TextStyle(
                  fontSize: 8,
                  color: mutedText,
                ),
              ),

              const SizedBox(width: 3),

              SizedBox(
                height: 27,
                width: 39,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Switch(
                    value: recipe.isVisible,
                    thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.white; // Warna thumb saat aktif
                      }
                      return Colors.white; // Warna thumb saat tidak aktif
                    }),
                    // Menggunakan activeTrackColor dan inactiveTrackColor yang sudah benar
                    activeTrackColor: const Color(0xFF467C53),
                    inactiveTrackColor: Colors.grey.shade300,
                    onChanged: (value) {
                      setState(() {
                        recipe.isVisible = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================
  // CARD DECORATION
  // =========================
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.brown.withOpacity(0.06),
          blurRadius: 9,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}

// =========================
// PROFILE STAT
// =========================
class _ProfileStat extends StatelessWidget {
  final String label;

  const _ProfileStat(this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.circle,
          size: 4,
          color: Color(0xFF3A6848),
        ),
        const SizedBox(width: 3),
        Text(
          label,
          style: const TextStyle(
            fontSize: 8,
            color: Color(0xFF765D52),
          ),
        ),
      ],
    );
  }
}

// =========================
// MODEL RESEP SAYA
// =========================
class _MyRecipe {
  final String title;
  final String description;
  final String image;
  final String duration;
  final int saved;
  final int likes;

  bool isVisible;

  _MyRecipe({
    required this.title,
    required this.description,
    required this.image,
    required this.duration,
    required this.saved,
    required this.likes,
    this.isVisible = true,
  });
}