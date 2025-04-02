import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product3/core/error/failures.dart';
import 'package:product3/features/ecommerce/data/datasource/product_local_data_source.dart';
import 'package:product3/features/ecommerce/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  final tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test_url',
    price: 9.99,
  );

  final String cachedKey = 'CACHED_PRODUCTS';
  final List<ProductModel> testProducts = [tProductModel];
  final String encodedProducts =
      jsonEncode(testProducts.map((e) => e.toJson()).toList());

  group('getCachedProducts', () {
    test('should return cached products when cache is not empty', () async {
      // Arrange: Stub the `getString` method to return encoded products
      when(mockSharedPreferences.getString(cachedKey))
          .thenReturn(encodedProducts);

      // Act
      final result = await dataSource.getCachedProducts();

      // Assert
      expect(result, Right(testProducts));
      verify(mockSharedPreferences.getString(cachedKey));
    });

    test('should return CacheFailure when cache is empty', () async {
      // Arrange: Stub `getString` to return null (empty cache)
      when(mockSharedPreferences.getString(cachedKey)).thenReturn(null);

      // Act
      final result = await dataSource.getCachedProducts();

      // Assert
      expect(result, Left(CacheFailure('No products in cache')));
    });
  });

  group('cacheProducts', () {
    test('should cache the products list', () async {
      // Act: Call `cacheProducts`
      final cacheResult = await dataSource.cacheProducts(testProducts);

      // Assert: Ensure `setString` is called with correct data
      verify(mockSharedPreferences.setString(cachedKey, encodedProducts));
      expect(cacheResult, const Right(null));
    });

    test('should overwrite existing cache', () async {
      final newProduct = ProductModel(
        id: '2',
        name: 'New Product',
        description: 'New Description',
        imageUrl: 'new_url',
        price: 19.99,
      );

      final newEncodedProducts =
          jsonEncode([newProduct].map((e) => e.toJson()).toList());

      // Act
      await dataSource.cacheProducts([newProduct]);

      // Assert
      verify(mockSharedPreferences.setString(cachedKey, newEncodedProducts));
    });
  });
}
