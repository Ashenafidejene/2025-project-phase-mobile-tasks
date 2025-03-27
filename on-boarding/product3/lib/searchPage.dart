import 'package:flutter/material.dart';
import 'package:product3/supplemental/product_show.dart';

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
  RangeValues priceRange = const RangeValues(20, 100); // Initial range values

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
              Navigator.pop(context);
            },
            iconSize: 30,
            color: Colors.white,
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Leather',
                      suffixIcon: Icon(
                        Icons.arrow_forward,
                        color: Color(0XFF3F51F3),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() => searchQuery = value),
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
            Expanded(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const CardsDisplay();
                },
              ),
            ),
            const Text("Category",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
            TextField(
                decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            )),
            const Text(
              'Price',
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
                setState(() {
                  priceRange = values;
                });
              },
              activeColor: const Color(0XFF3F51F3), // Selected range color
              inactiveColor: Colors.grey.shade300, // Unselected range color
            ),
            ElevatedButton(
              onPressed: () {
                // Apply filter action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFF3F51F3),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Apply', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
