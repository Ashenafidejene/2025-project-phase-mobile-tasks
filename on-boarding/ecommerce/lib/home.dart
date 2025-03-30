import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product3/addPage.dart';
import 'package:product3/models/product_repositry.dart';
import 'package:product3/searchPage.dart';
import 'models/product.dart';
import 'supplemental/product_show.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Product> products; // Make products mutable

  @override
  void initState() {
    super.initState();
    products = ProductRepository.loadProducts(); // Initialize products
  }

  void _handleDelete(Product product) {
    setState(() => products.remove(product));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Product deleted successfully"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Card
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCCCCC),
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "July 14, 2023",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFFAAAAAA)),
                        ),
                        const SizedBox(height: 4),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: "Hello, ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                text: "Yohannes",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.notifications_none,
                          size: 18.84,
                        ),
                      ),
                      Positioned(
                        right: 9,
                        top: 9,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0XFF3F51F3),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Available Products",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/search');
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.search,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return CardsDisplay(
                    product: product,
                    onDeleteResult: (product, success) {
                      if (success) {
                        _handleDelete(product);
                      } else {
                        _handleDelete(product);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 79,
        height: 79,
        child: FloatingActionButton(
          onPressed: () {
            context.push('/add');
          },
          backgroundColor: const Color(0xFF3F51F3),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 36,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
