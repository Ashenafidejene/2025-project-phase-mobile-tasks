import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product3/core/error/failures.dart';
import 'package:product3/core/network/network_info.dart';
import 'package:product3/features/ecommerce/data/datasource/product_local_data_source.dart';
import 'package:product3/features/ecommerce/data/datasource/product_remote_data_source.dart';
import 'package:product3/features/ecommerce/data/models/product_model.dart';
import 'package:product3/features/ecommerce/data/repositories/product_repository_impl.dart';
import 'package:product3/features/ecommerce/domain/entities/product.dart';

class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MockLocalDataSource extends Mock implements ProductLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ProductRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test_url',
    price: 9.99,
  );

  final tProduct = Product(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test_url',
    price: 9.99,
  );

  group('getProducts', () {
    test('should check if device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProducts())
          .thenAnswer((_) async => Right([tProductModel]));
      when(mockLocalDataSource.cacheProducts([tProductModel]))
          .thenAnswer((_) async => const Right(null));

      // Act
      await repository.getProducts();

      // Assert
      verify(() => mockNetworkInfo.isConnected);
    });

    group('should check if the device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when call is successful', () async {
        // Arrange
        when(mockRemoteDataSource.getProducts())
            .thenAnswer((_) async => Right([tProductModel]));
        when(mockLocalDataSource.cacheProducts([tProductModel]))
            .thenAnswer((_) async => const Right(null));

        // Act
        final result = await repository.getProducts();

        // Assert
        verify(() => mockRemoteDataSource.getProducts());
        expect(result, Right([tProduct]));
      });

      test('should cache data locally when remote call is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getProducts())
            .thenAnswer((_) async => Right([tProductModel]));
        when(mockLocalDataSource.cacheProducts([tProductModel]))
            .thenAnswer((_) async => const Right(null));

        // Act
        await repository.getProducts();

        // Assert
        verify(() => mockLocalDataSource.cacheProducts([tProductModel]));
      });

      test('should return server failure when remote call fails', () async {
        // Arrange
        when(mockRemoteDataSource.getProducts())
            .thenAnswer((_) async => Left(ServerFailure('Server error')));
        when(mockLocalDataSource.getCachedProducts())
            .thenAnswer((_) async => Left(CacheFailure('Cache error')));

        // Act
        final result = await repository.getProducts();

        // Assert
        verifyNever(() => mockLocalDataSource.cacheProducts([tProductModel]));
        expect(result, Left(ServerFailure('Server error')));
      });
    });

    group('device is  offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when available', () async {
        // Arrange
        when(mockLocalDataSource.getCachedProducts())
            .thenAnswer((_) async => Right([tProductModel]));

        // Act
        final result = await repository.getProducts();

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, Right([tProduct]));
      });

      test('should return cache failure when no cached data exists', () async {
        // Arrange
        when(mockLocalDataSource.getCachedProducts())
            .thenAnswer((_) async => Left(CacheFailure('No cache')));

        // Act
        final result = await repository.getProducts();

        // Assert
        expect(result, Left(CacheFailure('No cache')));
      });
    });
  });

  group('getProduct', () {
    const tId = '1';

    test('should check if device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProduct(tId))
          .thenAnswer((_) async => Right(tProductModel));

      // Act
      await repository.getProduct(tId);

      // Assert
      verify(() => mockNetworkInfo.isConnected);
    });

    group('when online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when call is successful', () async {
        // Arrange
        when(mockRemoteDataSource.getProduct(tId))
            .thenAnswer((_) async => Right(tProductModel));

        // Act
        final result = await repository.getProduct(tId);

        // Assert
        verify(() => mockRemoteDataSource.getProduct(tId));
        expect(result, Right(tProduct));
      });

      test('should return server failure when remote call fails', () async {
        // Arrange
        when(mockRemoteDataSource.getProduct(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server error')));

        // Act
        final result = await repository.getProduct(tId);

        // Assert
        expect(result, Left(ServerFailure('Server error')));
      });
    });

    group('when offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached product when available', () async {
        // Arrange
        when(mockLocalDataSource.getCachedProducts())
            .thenAnswer((_) async => Right([tProductModel]));

        // Act
        final result = await repository.getProduct(tId);

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, Right(tProduct));
      });

      test('should return not found failure when product not in cache',
          () async {
        // Arrange
        when(mockLocalDataSource.getCachedProducts())
            .thenAnswer((_) async => Right([tProductModel]));

        // Act
        final result = await repository.getProduct('2'); // Different ID

        // Assert
        expect(result, Left(NotFoundFailure('Product not found in cache')));
      });
    });
  });

  group('createProduct', () {
    test('should return network failure when offline', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.createProduct(tProduct);

      // Assert
      expect(result, Left(NetworkFailure('No internet connection')));
    });

    test('should call remote data source when online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.createProduct(tProductModel))
          .thenAnswer((_) async => const Right(null));
      when(mockRemoteDataSource.getProducts())
          .thenAnswer((_) async => const Right([]));

      // Act
      await repository.createProduct(tProduct);

      // Assert
      verify(() => mockRemoteDataSource.createProduct(tProductModel));
    });

    test('should refresh cache after successful creation', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.createProduct(tProductModel))
          .thenAnswer((_) async => const Right(null));
      when(mockRemoteDataSource.getProducts())
          .thenAnswer((_) async => const Right([]));
      when(mockLocalDataSource.cacheProducts([tProductModel]))
          .thenAnswer((_) async => const Right(null));

      // Act
      await repository.createProduct(tProduct);

      // Assert
      verify(() => mockRemoteDataSource.getProducts());
      verify(() => mockLocalDataSource.cacheProducts([]));
    });
  });

  // Similar tests for updateProduct and deleteProduct
  // (Follow the same pattern as createProduct tests)
  group('updateProduct', () {
    test('should return network failure when offline', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.updateProduct(tProduct);

      // Assert
      expect(result, Left(NetworkFailure('No internet connection')));
      verifyNever(() => mockRemoteDataSource.updateProduct(tProductModel));
    });

    test('should call remote data source when online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateProduct(tProductModel))
          .thenAnswer((_) async => const Right(null));
      when(mockRemoteDataSource.getProducts())
          .thenAnswer((_) async => const Right([]));

      // Act
      await repository.updateProduct(tProduct);

      // Assert
      verify(() => mockRemoteDataSource.updateProduct(tProductModel));
    });

    test('should refresh cache after successful update', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateProduct(tProductModel))
          .thenAnswer((_) async => const Right(null));
      when(mockRemoteDataSource.getProducts())
          .thenAnswer((_) async => Right([tProductModel]));
      when(mockLocalDataSource.cacheProducts([tProductModel]))
          .thenAnswer((_) async => const Right(null));

      // Act
      await repository.updateProduct(tProduct);

      // Assert
      verifyInOrder([
        () => mockRemoteDataSource.updateProduct(tProductModel),
        () => mockRemoteDataSource.getProducts(),
        () => mockLocalDataSource.cacheProducts([tProductModel])
      ]);
    });

    test('should return server failure when update fails', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateProduct(tProductModel))
          .thenAnswer((_) async => Left(ServerFailure('Update failed')));

      // Act
      final result = await repository.updateProduct(tProduct);

      // Assert
      expect(result, Left(ServerFailure('Update failed')));
      verifyNever(() => mockRemoteDataSource.getProducts());
      verifyNever(() => mockLocalDataSource.cacheProducts([tProductModel]));
    });
  });

  group('deleteProduct', () {
    const tProductId = '1';

    test('should return network failure when offline', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.deleteProduct(tProductId);

      // Assert
      expect(result, Left(NetworkFailure('No internet connection')));
      verifyNever(() => mockRemoteDataSource.deleteProduct("1"));
    });

    test('should call remote data source when online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteProduct("1"))
          .thenAnswer((_) async => const Right(null));
      when(mockRemoteDataSource.getProducts())
          .thenAnswer((_) async => const Right([]));

      // Act
      await repository.deleteProduct(tProductId);

      // Assert
      verify(() => mockRemoteDataSource.deleteProduct(tProductId));
    });

    test('should refresh cache after successful deletion', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteProduct("1"))
          .thenAnswer((_) async => Right(null));
      when(mockRemoteDataSource.getProducts())
          .thenAnswer((_) async => const Right([]));
      when(mockLocalDataSource.cacheProducts([tProductModel]))
          .thenAnswer((_) async => const Right(null));

      // Act
      await repository.deleteProduct(tProductId);

      // Assert
      verifyInOrder([
        () => mockRemoteDataSource.deleteProduct(tProductId),
        () => mockRemoteDataSource.getProducts(),
        () => mockLocalDataSource.cacheProducts([])
      ]);
    });

    test('should return not found failure when product doesnt exist', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteProduct("1"))
          .thenAnswer((_) async => Left(NotFoundFailure('Product not found')));

      // Act
      final result = await repository.deleteProduct(tProductId);

      // Assert
      expect(result, Left(NotFoundFailure('Product not found')));
      verifyNever(() => mockRemoteDataSource.getProducts());
      verifyNever(() => mockLocalDataSource.cacheProducts([tProductModel]));
    });

    test('should return server failure when deletion fails', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteProduct("1"))
          .thenAnswer((_) async => Left(ServerFailure('Deletion failed')));

      // Act
      final result = await repository.deleteProduct(tProductId);

      // Assert
      expect(result, Left(ServerFailure('Deletion failed')));
      verifyNever(() => mockRemoteDataSource.getProducts());
      verifyNever(() => mockLocalDataSource.cacheProducts([tProductModel]));
    });
  });
}
