import 'package:flutter/material.dart';
import 'components/app_styles.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk menangkap input form
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _portionsController = TextEditingController();

  // Pilihan Kategori dropdown (dibuat null agar wajib dipilih pengguna)
  String? _selectedCategory;
  final List<String> _categories = [
    'Porsi Keluarga',
    'Pemula Ramah',
    'Cepat 15 Menit',
    'Sayuran',
    'Tradisional',
    'Favorit',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    _portionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkCharcoal),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tambah Resep Baru',
          style: AppTextStyles.liberationBold.copyWith(
            fontSize: 16,
            color: AppColors.darkCharcoal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Bagian Upload Foto Resep (Opsional / Tidak wajib diisi)
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_a_photo_outlined,
                      size: 40,
                      color: AppColors.redPrimary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Unggah Foto Masakan (Opsional)',
                      style: AppTextStyles.jakartaSemiBold.copyWith(
                        fontSize: 14,
                        color: AppColors.redPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Format JPG, PNG (Maks. 5MB)',
                      style: AppTextStyles.jakartaRegular.copyWith(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 2. Judul Resep (Wajib)
              _buildLabel('Judul Resep *'),
              _buildTextField(
                controller: _titleController,
                hintText: 'Contoh: Rendang Sapi Minang',
                errorMessage: 'Judul resep wajib diisi',
              ),
              const SizedBox(height: 16),

              // 3. Nama Pembuat / Koki (Wajib)
              _buildLabel('Nama Pembuat (Koki) *'),
              _buildTextField(
                controller: _authorController,
                hintText: 'Contoh: Chef Hendra',
                errorMessage: 'Nama pembuat wajib diisi',
              ),
              const SizedBox(height: 16),

              // 4. Pilih Kategori (Wajib)
              _buildLabel('Kategori Masakan *'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  hint: Text(
                    'Pilih kategori masakan',
                    style: AppTextStyles.jakartaRegular.copyWith(
                      fontSize: 13,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: AppTextStyles.jakartaRegular.copyWith(
                          fontSize: 13,
                          color: AppColors.darkCharcoal,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kategori masakan wajib dipilih';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),

              // 5. Durasi & Porsi (Row - Keduanya Wajib)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Durasi (Waktu) *'),
                        _buildTextField(
                          controller: _durationController,
                          hintText: 'Cth: 45 mnt',
                          errorMessage: 'Durasi wajib diisi',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Porsi *'),
                        _buildTextField(
                          controller: _portionsController,
                          hintText: 'Cth: 4 Porsi',
                          errorMessage: 'Porsi wajib diisi',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 6. Deskripsi Singkat (Wajib)
              _buildLabel('Deskripsi / Catatan Resep *'),
              _buildTextField(
                controller: _descriptionController,
                hintText: 'Ceritakan kelezatan resep ini secara singkat...',
                maxLines: 3,
                errorMessage: 'Deskripsi resep wajib diisi',
              ),
              const SizedBox(height: 28),

              // 7. Tombol Simpan
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Aksi ketika tombol simpan diklik
                      print("Resep berhasil disimpa n: ${_titleController.text}");
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Simpan & Terbitkan Resep',
                    style: AppTextStyles.jakartaSemiBold.copyWith(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper untuk teks label di atas input
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: AppTextStyles.jakartaSemiBold.copyWith(
          fontSize: 13,
          color: AppColors.darkCharcoal,
        ),
      ),
    );
  }

  // Widget helper untuk TextField agar kodenya bersih
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String errorMessage = 'Bagian ini wajib diisi',
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: AppTextStyles.jakartaRegular.copyWith(
          fontSize: 13,
          color: AppColors.darkCharcoal,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.jakartaRegular.copyWith(
            fontSize: 13,
            color: Colors.grey.shade400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }
}
