class Recipe {
  final String id;
  final String imageUrl;
  final String category;
  final String title;
  final String author;
  final bool isVerified;
  final String rating;
  final String duration;
  final String ingredientsCount;
  final String portions;
  final String description;

  final bool isMine;
  bool isPublished;
  bool isBookmarked;
  int likesCount;
  int savesCount;

  Recipe({
    required this.id,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.author,
    this.isVerified = true,
    this.rating = '0.0',
    required this.duration,
    this.ingredientsCount = '0 Bahan',
    this.portions = '1 Porsi',
    this.description = '',
    this.isMine = false,
    this.isPublished = true,
    this.isBookmarked = false,
    this.likesCount = 0,
    this.savesCount = 0,
  });
}