import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, ProductModel>> getProduct(String id);
  Future<Either<Failure, void>> createProduct(ProductModel product);
  Future<Either<Failure, void>> updateProduct(ProductModel product);
  Future<Either<Failure, void>> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      // TODO: Implement actual API call
      // final response = await apiClient.get('/products');
      // return Right(response.data.map((e) => ProductModel.fromJson(e)).toList());

      // Mock implementation
      await Future.delayed(const Duration(milliseconds: 500));
      return const Right([]);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProduct(String id) async {
    try {
      // TODO: Implement actual API call
      // final response = await apiClient.get('/products/$id');
      // return Right(ProductModel.fromJson(response.data));

      // Mock implementation
      await Future.delayed(const Duration(milliseconds: 500));
      return Left(const NotFoundFailure('Product not found'));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createProduct(ProductModel product) async {
    try {
      // TODO: Implement actual API call
      // await apiClient.post('/products', data: product.toJson());

      // Mock implementation
      await Future.delayed(const Duration(milliseconds: 500));
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductModel product) async {
    try {
      // TODO: Implement actual API call
      // await apiClient.put('/products/${product.id}', data: product.toJson());

      // Mock implementation
      await Future.delayed(const Duration(milliseconds: 500));
      return const Right(null);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      // TODO: Implement actual API call
      // await apiClient.delete('/products/$id');

      // Mock implementation
      await Future.delayed(const Duration(milliseconds: 500));
      return const Right(null);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
