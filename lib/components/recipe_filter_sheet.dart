
import 'package:flutter/material.dart';
import '../models/recipe_models.dart';

class RecipeFilterSheet {
  static const options = <String, String>{
    'default': 'Rekomendasi',
    'rating': 'Rating tertinggi',
    'fastest': 'Waktu tercepat',
    'az': 'Nama A–Z',
    'za': 'Nama Z–A',
  };

  static Future<String?> show(
    BuildContext context, {
    required String selected,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFFFCF8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: StatefulBuilder(
            builder: (context, setSheetState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20, 12, 20, 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Garis kecil bagian atas
                    Center(
                      child: Container(
                        width: 38,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.brown.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Judul
                    const Text(
                      'Filter & Urutkan',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF372F2A),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Pilih urutan resep yang ingin ditampilkan.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.brown.shade400,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Pilihan filter
                    ...options.entries.map((entry) {
                      return RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        activeColor: const Color(0xFFB94A23),
                        title: Text(
                          entry.value,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF372F2A),
                          ),
                        ),
                        value: entry.key,
                        groupValue: selected,
                        onChanged: (value) {
                          if (value != null) {
                            setSheetState(() {
                              selected = value;
                            });
                          }
                        },
                      );
                    }),

                    const SizedBox(height: 10),

                    // Tombol terapkan
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFB94A23),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context, selected);
                        },
                        child: const Text(
                          'Terapkan Filter',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// FUNGSI PENGURUTAN RESEP
List<Recipe> sortRecipes(
  List<Recipe> recipes,
  String sort,
) {
  final result = List<Recipe>.from(recipes);

  switch (sort) {
    // Rekomendasi (urutan awal)
    case 'default':
      break;

    // Rating tertinggi
    case 'rating':
      result.sort(
        (a, b) =>
            (double.tryParse(b.rating) ?? 0).compareTo(
          double.tryParse(a.rating) ?? 0,
        ),
      );
      break;

    // Waktu tercepat
    case 'fastest':
      int minutes(String value) {
        return int.tryParse(
              RegExp(r'\d+')
                      .firstMatch(value)
                      ?.group(0) ??
                  '',
            ) ??
            999999;
      }

      result.sort(
        (a, b) => minutes(a.duration).compareTo(
          minutes(b.duration),
        ),
      );
      break;

    // Nama A-Z
    case 'az':
      result.sort(
        (a, b) => a.title.toLowerCase().compareTo(
          b.title.toLowerCase(),
        ),
      );
      break;

    // Nama Z-A
    case 'za':
      result.sort(
        (a, b) => b.title.toLowerCase().compareTo(
          a.title.toLowerCase(),
        ),
      );
      break;
  }

  return result;
}
