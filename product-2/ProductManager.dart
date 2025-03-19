import 'Product.dart';

class ProductManager {
  List<Product> _products = [];
  void addProduct(String name, String description, double price) {
    _products.add(Product(name, description, price));
    print("Product '$name' added successfully.");
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print("No products available.");
      return;
    }
    print("All Products:");
    for (var product in _products) {
      product.display();
    }
  }

  void viewProduct(String name) {
    var product = _products.firstWhere(
        (element) => element.name.toLowerCase() == name.toLowerCase(),
        orElse: () => Product("", "", 0));
    if (product.name.isNotEmpty) {
      product.display();
    } else {
      print("Error : Product '$name' not found");
    }
  }

  void editProduct(
      String oldName, String newName, String newDescription, double newPrice) {
    for (var product in _products) {
      if (product.name.toLowerCase() == oldName.toLowerCase()) {
        product.name = newName;
        product.description = newDescription;
        product.price = newPrice;
        print("Product '$oldName' updated successfully.");
        return;
      }
    }
    print("Error : Product '$oldName' not found");
  }

  void deleteProduct(String name) {
    // Check if the product exists
    bool productExists = _products
        .any((product) => product.name.toLowerCase() == name.toLowerCase());

    if (productExists) {
      _products.removeWhere(
          (product) => product.name.toLowerCase() == name.toLowerCase());
      print("Product '$name' deleted successfully.");
    } else {
      print("Error: Product '$name' not found. Cannot delete.");
    }
  }
}
