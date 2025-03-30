import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product3/detailspage.dart';
import 'package:product3/models/product.dart';
// Import your Product model

class CardsDisplay extends StatelessWidget {
  final Product product; // Accepts a Product object

  final Function(Product, bool) onDeleteResult; // Now takes Product + bool

  const CardsDisplay({
    super.key,
    required this.product,
    required this.onDeleteResult,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/details', extra: product).then((result) {
          if (result != null && result is bool) {
            onDeleteResult(product, result);
          }
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white,
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  product.images.isNotEmpty
                      ? product.images.first
                      : 'images/placeholder.png', // Show first image or placeholder
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        product.productName, // Product Name
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "\$${product.price.toStringAsFixed(2)}", // Product Price
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.category.name, // Product Category
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0XFFFFD700),
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(${product.level})", // Product Rating
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color(0XFFAAAAAA),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
