import 'package:flutter/material.dart';
import 'package:product3/models/product.dart';

class DetailsPage extends StatefulWidget {
  final Product product;
  final Function(bool) onDeleteResult;
  const DetailsPage({
    super.key,
    required this.product,
    required this.onDeleteResult,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState(product: product);
}

class _DetailsPageState extends State<DetailsPage> {
  final Product product;
  _DetailsPageState({required this.product});
  String selectedSize = ""; // Updated to String
  late final List<String> sizes = product.sizes; // Use product's sizes

  @override
  void initState() {
    super.initState();
    if (sizes.isNotEmpty) {
      selectedSize = sizes.first; // Default to the first size
    }
  }

  void _handleDelete() async {
    final shouldDelete = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirm Delete"),
            content:
                const Text("Are you sure you want to delete this product?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child:
                    const Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;

    if (shouldDelete) {
      widget.onDeleteResult(true); // Return true if deleted
      Navigator.pop(context, true); // Close details page
    } else {
      widget.onDeleteResult(false);
      Navigator.pop(context, false); // Return false if cancelled
    }
  }

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
                'images/placeholder.png',
                width: double.infinity,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.category.name,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color(0XFFFFD700), size: 18),
                          const SizedBox(width: 4),
                          Text(
                            "(${product.level})",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color(0XFFAAAAAA),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.productName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                              size,
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
                  Text(
                    product.description,
                    style: const TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // DELETE Button
                      ElevatedButton(
                        onPressed: _handleDelete,
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
