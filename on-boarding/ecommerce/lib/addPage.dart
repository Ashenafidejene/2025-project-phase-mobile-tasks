import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:product3/models/product.dart';
import 'package:product3/models/product_repositry.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  Category _selectedCategory = Category.leatherJackets;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final savedImage =
          await _saveImageToLocalDirectory(File(pickedFile.path));
      setState(() {
        _image = savedImage;
      });
    }
  }

  Future<File> _saveImageToLocalDirectory(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/images';
    final imageFolder = Directory(imagePath);

    if (!imageFolder.existsSync()) {
      imageFolder.createSync(recursive: true);
    }

    final fileName = imageFile.path.split('/').last;
    final savedImage = File('$imagePath/$fileName');
    return imageFile.copy(savedImage.path);
  }

  void _addProduct() {
    final String name = _nameController.text.trim();
    final double price = double.tryParse(_priceController.text.trim()) ?? 0;
    final String description = _descriptionController.text.trim();

    if (name.isEmpty || price <= 0 || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final product = Product(
      id: DateTime.now().millisecondsSinceEpoch,
      productName: name,
      images: [_image?.path ?? ""],
      level: 4,
      sizes: ["Default"],
      description: description,
      category: _selectedCategory,
      price: price,
    );

    ProductRepository.addProduct(product);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product added successfully")),
    );

    Navigator.pop(context, true); // Go back and notify home page of update
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            color: Color(0XFF3F51F3),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 190,
                decoration: BoxDecoration(
                  color: const Color(0XFFF3F3F3),
                  borderRadius: BorderRadius.circular(12),
                  image: _image != null
                      ? DecorationImage(
                          image: FileImage(_image!), fit: BoxFit.cover)
                      : null,
                ),
                child: _image == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_rounded,
                              size: 50, color: Colors.grey),
                          SizedBox(height: 8),
                          Text("Upload Image",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            const Text("Name"),
            _buildTextField(controller: _nameController),
            const SizedBox(height: 10),
            const Text("Category"),
            DropdownButton<Category>(
              isExpanded: true,
              value: _selectedCategory,
              onChanged: (Category? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                }
              },
              items: Category.values
                  .where(
                      (cat) => cat != Category.all) // Remove 'all' from options
                  .map((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name.toUpperCase().replaceAll("_", " ")),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            const Text("Price"),
            _buildTextField(
                controller: _priceController,
                suffixIcon: const Icon(Icons.attach_money)),
            const SizedBox(height: 10),
            const Text("Description"),
            _buildTextField(controller: _descriptionController, maxLines: 3),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFF3F51F3),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("ADD", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {TextEditingController? controller,
      int maxLines = 1,
      Widget? suffixIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
