import 'package:dartz/dartz.dart';
import 'package:product3/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class CreateProductUseCase implements UseCase<void, Product> {
  final ProductRepository repository;

  CreateProductUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Product product) async {
    final validationResult = _validateProduct(product);
    if (validationResult != null) {
      return Left(validationResult);
    }
    return await repository.createProduct(product);
  }

  Failure? _validateProduct(Product product) {
    if (product.name.isEmpty) {
      return const ValidationFailure('Product name cannot be empty');
    }
    if (product.price <= 0) {
      return const ValidationFailure('Product price must be greater than 0');
    }
    return null;
  }
}
