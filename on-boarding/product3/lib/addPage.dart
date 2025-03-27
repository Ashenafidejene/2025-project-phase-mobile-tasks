import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
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
            Container(
              width: 360,
              height: 190,
              decoration: BoxDecoration(
                color: Color(0XFFF3F3F3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_rounded, size: 50, color: Colors.grey),
                  SizedBox(height: 8),
                  Text("Upload Image", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text("Name"),
            _buildTextField(),
            Text("Category"),
            _buildTextField(),
            Text("Price"),
            _buildTextField(suffixIcon: const Icon(Icons.attach_money)),
            Text("Description"),
            _buildTextField(maxLines: 1),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFF3F51F3),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("ADD", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0XFFFF1313), width: 2),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("DELETE",
                  style: TextStyle(color: Color(0XFFFF1313))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({int maxLines = 1, Widget? suffixIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: TextField(
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
