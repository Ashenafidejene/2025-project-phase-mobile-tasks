import 'package:dartz/dartz.dart';
import 'package:product3/core/error/failures.dart';
import 'package:product3/core/usecases/usecase.dart';
import 'package:product3/features/ecommerce/domain/repositories/product_repository.dart';

class DeleteProductUseCase implements UseCase<void, String> {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String productId) async {
    if (productId.isEmpty) {
      return Left(const ValidationFailure('Product ID cannot be empty'));
    }
    return await repository.deleteProduct(productId);
  }
}
