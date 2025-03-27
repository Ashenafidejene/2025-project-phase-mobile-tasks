import 'product.dart';

List<int> sizes = [39, 40, 41, 42, 43, 44];

class ProductRepository {
  static List<Product> loadProducts(Category category) {
    const allProducts = <Product>[
      Product(
          productName: "Derby Leather",
          level: 4,
          images: "image_2025-03-25_09-49-39.png",
          size: [39, 40, 41, 42, 43, 44],
          description:
              "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.",
          category: Category.mens,
          id: 0,
          price: 120.0),
      Product(
          productName: "Derby Leather",
          level: 4,
          images: "image_2025-03-25_09-49-39.png",
          size: [39, 40, 41, 42, 43, 44],
          description:
              "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.",
          category: Category.mens,
          id: 0,
          price: 120.0),
      Product(
          productName: "Derby Leather",
          level: 4,
          images: "image_2025-03-25_09-49-39.png",
          size: [39, 40, 41, 42, 43, 44],
          description:
              "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.",
          category: Category.mens,
          id: 0,
          price: 120.0)
    ];
    if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}
