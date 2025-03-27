import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int selectedSize = 38;
  final List<int> sizes = [37, 38, 39, 40, 41, 42, 43, 44, 45];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Back Button using Stack
          Stack(
            children: [
              Image.asset(
                'images/image_2025-03-25_09-49-39.png',
                width: double.infinity,
                height: 300, // Adjust the height as needed
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 20, // Positioning from the top
                left: 10, // Positioning from the left
                child: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_left_outlined,
                      color: Color(0XFF3F51F3)),
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  iconSize: 30, // Adjust size for better visibility
                  color: Colors.white, // White color for better contrast
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title & Rating
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Men’s Shoe",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Color(0XFFFFD700), size: 18),
                          SizedBox(width: 4),
                          Text(
                            "(4.0)",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0XFFAAAAAA),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Derby Leather Shoes",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "\$120",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Size:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Scrollable Sizes
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 8,
                      children: sizes.map((size) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedSize == size
                                  ? const Color(0XFF3F51F3)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: const Color(0XFF3F51F3)),
                            ),
                            child: Text(
                              size.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                color: selectedSize == size
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Product Description
                  const Text(
                    "A derby leather shoe is a classic and  eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.",
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // DELETE Button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            color: Color(0XFFFF1313),
                            width: 2,
                          ),
                          minimumSize: const Size(152, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "DELETE",
                          style: TextStyle(
                            color: Color(0XFFFF1313),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      // UPDATE Button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF3F51F3),
                          minimumSize: const Size(152, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "UPDATE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
