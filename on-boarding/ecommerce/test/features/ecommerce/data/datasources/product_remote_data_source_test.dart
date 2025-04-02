import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product3/core/error/exceptions.dart';
import 'package:product3/core/error/failures.dart';
import 'package:product3/features/ecommerce/data/datasource/product_remote_data_source.dart';
import 'package:product3/features/ecommerce/data/models/product_model.dart';

class MockApiClient extends Mock {
  Future<dynamic> get(String url);
  Future<dynamic> post(String url, {dynamic data});
  Future<dynamic> put(String url, {dynamic data});
  Future<dynamic> delete(String url);
}

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ProductRemoteDataSourceImpl();
  });

  final tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test_url',
    price: 9.99,
  );

  group('getProducts', () {
    test('should return list of products on success', () async {
      when(mockApiClient.get('/products'))
          .thenAnswer((_) async => [tProductModel.toJson()]);

      final result = await dataSource.getProducts();

      expect(result, Right([tProductModel]));
    });

    test('should return ServerFailure on exception', () async {
      when(mockApiClient.get('/products'))
          .thenThrow(ServerException('Server error'));

      final result = await dataSource.getProducts();

      expect(result, const Left(ServerFailure('Server error')));
    });
  });

  group('getProduct', () {
    test('should return product on success', () async {
      when(mockApiClient.get('/products/1'))
          .thenAnswer((_) async => tProductModel.toJson());

      final result = await dataSource.getProduct('1');

      expect(result, Right(tProductModel));
    });

    test('should return NotFoundFailure if product not found', () async {
      when(mockApiClient.get('/products/1'))
          .thenThrow(NotFoundException('Not found'));

      final result = await dataSource.getProduct('1');

      expect(result, const Left(NotFoundFailure('Not found')));
    });
  });

  group('createProduct', () {
    test('should return Right(null) on success', () async {
      when(mockApiClient.post('/products', data: tProductModel.toJson()))
          .thenAnswer((_) async => null);

      final result = await dataSource.createProduct(tProductModel);

      expect(result, const Right(null));
    });

    test('should return ServerFailure on error', () async {
      when(mockApiClient.post('/products', data: tProductModel.toJson()))
          .thenThrow(ServerException('Error'));

      final result = await dataSource.createProduct(tProductModel);

      expect(result, const Left(ServerFailure('Error')));
    });
  });

  group('updateProduct', () {
    test('should return Right(null) on success', () async {
      when(mockApiClient.put('/products/1', data: tProductModel.toJson()))
          .thenAnswer((_) async => null);

      final result = await dataSource.updateProduct(tProductModel);

      expect(result, const Right(null));
    });

    test('should return NotFoundFailure if product not found', () async {
      when(mockApiClient.put('/products/1', data: tProductModel.toJson()))
          .thenThrow(NotFoundException('Not found'));

      final result = await dataSource.updateProduct(tProductModel);

      expect(result, const Left(NotFoundFailure('Not found')));
    });
  });

  group('deleteProduct', () {
    test('should return Right(null) on success', () async {
      when(mockApiClient.delete('/products/1')).thenAnswer((_) async => null);

      final result = await dataSource.deleteProduct('1');

      expect(result, const Right(null));
    });

    test('should return NotFoundFailure if product not found', () async {
      when(mockApiClient.delete('/products/1'))
          .thenThrow(NotFoundException('Not found'));

      final result = await dataSource.deleteProduct('1');

      expect(result, const Left(NotFoundFailure('Not found')));
    });
  });
}
