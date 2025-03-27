import 'package:flutter/material.dart';
import 'package:product3/addPage.dart';
import 'package:product3/searchPage.dart';
import 'supplemental/product_show.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  // Rectangle Placeholder
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFCCCCCC),
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Date and Greeting Text
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

                  // Notification Button
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductSearchApp(),
                      ),
                    );
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
                itemCount: 4, // Number of items
                itemBuilder: (context, index) {
                  return const CardsDisplay();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 79, // Diameter (2 * 79 pixels)
        height: 79,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddProductPage(),
              ),
            );
          },
          backgroundColor: Color(0xFF3F51F3),
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
