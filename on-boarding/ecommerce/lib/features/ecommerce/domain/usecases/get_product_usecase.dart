import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductUseCase implements UseCase<Product, String> {
  final ProductRepository repository;

  GetProductUseCase(this.repository);

  @override
  Future<Either<Failure, Product>> call(String productId) async {
    if (productId.isEmpty) {
      throw ArgumentError('Product ID cannot be empty');
    }

    final product = await repository.getProduct(productId);
    if (product == null) {
      throw ProductNotFoundException();
    }
    return product;
  }
}

class ProductNotFoundException implements Exception {
  final String message = 'Product not found';

  @override
  String toString() => message;
}
