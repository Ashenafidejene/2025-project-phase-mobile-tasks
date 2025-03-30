import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product3/models/product_repositry.dart';
import 'package:product3/supplemental/product_show.dart';

import 'models/product.dart';

void main() => runApp(const ProductSearchApp());

class ProductSearchApp extends StatelessWidget {
  const ProductSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const ProductSearchScreen(),
    );
  }
}

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  String searchQuery = '';
  RangeValues priceRange = const RangeValues(0, 150); // Initial range values
  List<Product> filteredProducts =
      ProductRepository.loadProducts(); // All products initially

  void filterProducts() {
    setState(() {
      filteredProducts = ProductRepository.loadProducts().where((product) {
        final matchesCategory = searchQuery.isEmpty ||
            product.category.name
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
        final matchesPrice = product.price >= priceRange.start &&
            product.price <= priceRange.end;
        return matchesCategory && matchesPrice;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Product'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_outlined,
              color: Color(0XFF3F51F3)),
          onPressed: () {
            context.pop();
          },
          iconSize: 30,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar and Filter Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter category',
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0XFF3F51F3),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      filterProducts(); // Filter products on category input
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0XFF3F51F3),
                        ),
                        color: const Color(0XFF3F51F3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Price Range Slider
            const Text(
              'Price Range',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
            ),
            RangeSlider(
              values: priceRange,
              min: 0,
              max: 150,
              divisions: 10, // Optional for discrete steps
              labels: RangeLabels(
                '\$${priceRange.start.round()}',
                '\$${priceRange.end.round()}',
              ),
              onChanged: (RangeValues values) {
                priceRange = values;
                filterProducts(); // Filter products on price range change
              },
              activeColor: const Color(0XFF3F51F3), // Selected range color
              inactiveColor: Colors.grey.shade300, // Unselected range color
            ),
            const SizedBox(height: 16),
            // Product List
            Expanded(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return CardsDisplay(
                    product: product,
                    onDeleteResult: (product, isDeleted) {
                      if (isDeleted) {
                        filterProducts();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
