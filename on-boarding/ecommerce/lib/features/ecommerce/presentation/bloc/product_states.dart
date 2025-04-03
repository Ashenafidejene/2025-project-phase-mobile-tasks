import 'package:product3/features/ecommerce/domain/entities/product.dart';

abstract class ProductState {
  const ProductState();
}

class InitialState extends ProductState {
  const InitialState();
}

class LoadingState extends ProductState {
  const LoadingState();
}

class LoadedAllProductsState extends ProductState {
  final List<Product> products;
  const LoadedAllProductsState(this.products);
}

class LoadedSingleProductState extends ProductState {
  final Product product;
  const LoadedSingleProductState(this.product);
}

class ErrorState extends ProductState {
  final String message;
  const ErrorState(this.message);
}

class ProductOperationSuccessState extends ProductState {
  final String message;
  const ProductOperationSuccessState(this.message);
}
