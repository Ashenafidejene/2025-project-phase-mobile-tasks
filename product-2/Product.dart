class Product {
  late String _name;
  late String _description;
  late double _price;

  Product(this._name, this._description, this._price);

  String get name => _name;

  set name(String newName) {
    if (newName.isNotEmpty) {
      _name = newName;
    } else {
      print("The name cannot be null or empty");
    }
  }

  String get description => _description;

  set description(String newDescription) {
    if (newDescription.isNotEmpty) {
      _description = newDescription;
    } else {
      print("The description cannot be null or empty");
    }
  }

  double get price => _price;

  set price(double newPrice) {
    if (newPrice >= 0) {
      _price = newPrice;
    } else {
      print("The price cannot be negative");
    }
  }

  void display() {
    print("Product: $_name");
    print("Description: $_description");
    print("Price: \$_$_price");
    print("---------------");
  }
}
