class Recipe {
  final String imageUrl;
  final String category;
  final String title;
  final String author;
  final bool isVerified;
  final String rating;
  final String duration;
  final String ingredientsCount;
  bool isBookmarked;

  Recipe({
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.author,
    this.isVerified = true,
    required this.rating,
    required this.duration,
    required this.ingredientsCount,
    this.isBookmarked = false,
  });
}