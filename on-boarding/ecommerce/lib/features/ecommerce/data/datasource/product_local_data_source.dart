import 'package:dartz/dartz.dart';
import 'package:product3/core/error/failures.dart';
import 'package:product3/features/ecommerce/data/models/product_model.dart';

import '../../../../core/error/exceptions.dart';

abstract class ProductLocalDataSource {
  Future<Either<Failure, List<ProductModel>>> getCachedProducts();
  Future<Either<Failure, void>> cacheProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final List<ProductModel> _cachedProducts = [];

  @override
  Future<Either<Failure, List<ProductModel>>> getCachedProducts() async {
    try {
      if (_cachedProducts.isEmpty) {
        throw CacheException('No products in cache');
      }
      return Right(_cachedProducts);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cacheProducts(
      List<ProductModel> products) async {
    try {
      _cachedProducts.clear();
      _cachedProducts.addAll(products);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
