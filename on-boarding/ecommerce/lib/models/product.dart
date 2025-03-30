enum Gender { all, men, women, child }

enum Category {
  leather,
  leatherBags,
  leatherShoes,
  leatherJackets,
  leatherWallets,
  leatherBelts,
  leatherAccessories,
  all
}

class Product {
  const Product({
    required this.id,
    required this.productName,
    required this.images,
    required this.level,
    required this.sizes,
    required this.description,
    required this.category,
    required this.price,
  });

  final int id;
  final String productName;
  final List<String> images;
  final double level;
  final List<String> sizes;
  final String description;
  final Category category;
  final double price;
}
