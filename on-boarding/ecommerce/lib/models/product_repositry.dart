import 'product.dart';

List<String> sizes = ["39", "40", "41", "42", "43", "44"];

class ProductRepository {
  ProductRepository(all);
  static final List<Product> _allProducts = [
    Product(
      id: 1,
      productName: "Classic Leather Wallet",
      images: [],
      level: 4.5,
      sizes: ["10", "12"], // Dimensions in cm
      description: "A premium leather wallet with multiple compartments.",
      category: Category.leatherWallets,
      price: 49.99,
    ),
    const Product(
      id: 2,
      productName: "Men's Leather Belt",
      images: [],
      level: 4.7,
      sizes: ["30", "32", "34", "36", "38", "40"], // Waist sizes
      description: "A stylish and durable leather belt for all occasions.",
      category: Category.leatherBelts,
      price: 39.99,
    ),
    Product(
      id: 3,
      productName: "Women's Leather Handbag",
      images: [],
      level: 4.9,
      sizes: ["35", "25", "15"], // Length, Height, Width in cm
      description: "Elegant handbag made of genuine leather.",
      category: Category.leatherBags,
      price: 129.99,
    ),
    Product(
      id: 4,
      productName: "Leather Travel Duffel Bag",
      images: [],
      level: 4.8,
      sizes: ["50", "30", "25"],
      description: "A spacious and durable leather travel bag.",
      category: Category.leatherBags,
      price: 199.99,
    ),
    Product(
      id: 5,
      productName: "Brown Leather Formal Shoes",
      images: [],
      level: 4.6,
      sizes: ["40", "41", "42", "43", "44", "45"], // Shoe sizes
      description: "Handcrafted leather shoes for a professional look.",
      category: Category.leatherShoes,
      price: 89.99,
    ),
    Product(
      id: 6,
      productName: "Black Leather Chelsea Boots",
      images: [],
      level: 4.8,
      sizes: ["39", "40", "41", "42", "43", "44", "45"],
      description: "Classic Chelsea boots made from high-quality leather.",
      category: Category.leatherShoes,
      price: 119.99,
    ),
    Product(
      id: 7,
      productName: "Leather Motorcycle Jacket",
      images: [],
      level: 4.9,
      sizes: ["S", "M", "L", "XL", "XXL"], // Clothing sizes
      description: "A rugged and stylish leather jacket for bikers.",
      category: Category.leatherJackets,
      price: 249.99,
    ),
    Product(
      id: 8,
      productName: "Brown Leather Bomber Jacket",
      images: [],
      level: 4.7,
      sizes: ["S", "M", "L", "XL"],
      description: "A comfortable and trendy leather bomber jacket.",
      category: Category.leatherJackets,
      price: 199.99,
    ),
    Product(
      id: 9,
      productName: "Luxury Leather Office Bag",
      images: [],
      level: 4.6,
      sizes: ["40", "30", "12"],
      description: "A sleek office bag made from genuine leather.",
      category: Category.leatherBags,
      price: 159.99,
    ),
    Product(
      id: 10,
      productName: "Slim Leather Card Holder",
      images: [],
      level: 4.5,
      sizes: ["8", "10"],
      description: "A minimalist leather card holder for everyday use.",
      category: Category.leatherWallets,
      price: 29.99,
    ),
    Product(
      id: 11,
      productName: "Men's Leather Loafers",
      images: [],
      level: 4.8,
      sizes: ["40", "41", "42", "43", "44"],
      description: "Comfortable and stylish leather loafers.",
      category: Category.leatherShoes,
      price: 99.99,
    ),
    Product(
      id: 12,
      productName: "Leather Laptop Sleeve",
      images: [],
      level: 4.7,
      sizes: ["13", "15", "17"], // Laptop sizes
      description: "A premium leather sleeve to protect your laptop.",
      category: Category.leatherAccessories,
      price: 69.99,
    ),
    Product(
      id: 13,
      productName: "Leather Watch Strap",
      images: [],
      level: 4.6,
      sizes: ["18", "20", "22"], // Strap width in mm
      description: "A durable and stylish leather strap for watches.",
      category: Category.leatherAccessories,
      price: 24.99,
    ),
    Product(
      id: 14,
      productName: "Leather Passport Holder",
      images: [],
      level: 4.7,
      sizes: ["14", "10"], // Dimensions in cm
      description: "Keep your passport secure in a premium leather holder.",
      category: Category.leatherAccessories,
      price: 34.99,
    ),
    Product(
      id: 15,
      productName: "Handmade Leather Sandals",
      images: [],
      level: 4.5,
      sizes: ["38", "39", "40", "41", "42", "43"],
      description: "Comfortable and stylish handmade leather sandals.",
      category: Category.leatherShoes,
      price: 69.99,
    ),
    Product(
      id: 16,
      productName: "Vintage Leather Crossbody Bag",
      images: [],
      level: 4.8,
      sizes: ["28", "20", "10"],
      description: "A stylish vintage leather crossbody bag.",
      category: Category.leatherBags,
      price: 89.99,
    ),
    Product(
      id: 17,
      productName: "Leather Gym Duffle Bag",
      images: [],
      level: 4.6,
      sizes: ["55", "30", "25"],
      description: "A durable and spacious gym bag made of leather.",
      category: Category.leatherBags,
      price: 139.99,
    ),
    Product(
      id: 18,
      productName: "Casual Leather Slip-On Shoes",
      images: [],
      level: 4.6,
      sizes: ["40", "41", "42", "43", "44", "45"],
      description: "Easy-to-wear slip-on leather shoes for daily use.",
      category: Category.leatherShoes,
      price: 79.99,
    ),
    Product(
      id: 19,
      productName: "Premium Leather Gloves",
      images: [],
      level: 4.7,
      sizes: ["S", "M", "L", "XL"],
      description: "Soft and comfortable leather gloves for winter.",
      category: Category.leatherAccessories,
      price: 49.99,
    ),
    Product(
      id: 20,
      productName: "Leather Phone Case",
      images: [],
      level: 4.5,
      sizes: ["6", "6.5", "7"], // Phone screen sizes in inches
      description: "A stylish and protective leather phone case.",
      category: Category.leatherAccessories,
      price: 39.99,
    ),
  ];

  static List<Product> loadProducts() {
    return _allProducts;
  }

  static void addProduct(Product product) {
    _allProducts.add(product);
  }
}
