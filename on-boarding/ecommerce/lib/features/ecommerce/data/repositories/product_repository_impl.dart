import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/product_local_data_source.dart';
import '../datasource/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProducts();
        return remoteProducts.fold(
          (failure) => Left(failure),
          (products) async {
            await localDataSource.cacheProducts(products);
            return Right(products.map((model) => model.toEntity()).toList());
          },
        );
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      final cachedProducts = await localDataSource.getCachedProducts();
      return cachedProducts.fold(
        (failure) => Left(failure),
        (products) => Right(products.map((model) => model.toEntity()).toList()),
      );
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProduct(id);
        return remoteProduct.fold(
          (failure) => Left(failure),
          (product) => Right(product.toEntity()),
        );
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      final cachedProducts = await localDataSource.getCachedProducts();
      return cachedProducts.fold(
        (failure) => Left(failure),
        (products) {
          final product = products.firstWhere(
            (p) => p.id == id,
            orElse: () => throw NotFoundException('Product not found in cache'),
          );
          return Right(product.toEntity());
        },
      );
    }
  }

  @override
  Future<Either<Failure, void>> createProduct(Product product) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure('No internet connection'));
    }

    final result = await remoteDataSource.createProduct(
      ProductModel.fromEntity(product),
    );
    return result.fold(
      (failure) => Left(failure),
      (_) async {
        // Refresh cache after creation
        await getProducts();
        return const Right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure('No internet connection'));
    }

    final result = await remoteDataSource.updateProduct(
      ProductModel.fromEntity(product),
    );
    return result.fold(
      (failure) => Left(failure),
      (_) async {
        // Refresh cache after update
        await getProducts();
        return const Right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure('No internet connection'));
    }

    final result = await remoteDataSource.deleteProduct(id);
    return result.fold(
      (failure) => Left(failure),
      (_) async {
        // Refresh cache after deletion
        await getProducts();
        return const Right(null);
      },
    );
  }
}
