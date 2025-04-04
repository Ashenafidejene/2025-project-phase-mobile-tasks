import 'package:dartz/dartz.dart';
import 'package:product3/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
