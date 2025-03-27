enum Category { all, mens, womans, child }

class Product {
  const Product({
    required this.productName,
    required this.images,
    required this.level,
    required this.size,
    required this.description,
    required this.category,
    required this.id,
    required this.price,
  });
  final Category category;
  final String images;
  final int id;
  final String description;
  final List<int> size;
  final int level;
  final String productName;
  final double price;
}
