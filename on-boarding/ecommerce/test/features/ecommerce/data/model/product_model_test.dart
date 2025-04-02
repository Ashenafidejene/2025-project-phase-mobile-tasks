import 'package:flutter_test/flutter_test.dart';
import 'package:product3/features/ecommerce/data/models/product_model.dart';
import 'package:product3/features/ecommerce/domain/entities/product.dart';

void main() {
  final tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test_url',
    price: 9.99,
  );

  const tProductJson = {
    'id': '1',
    'name': 'Test Product',
    'description': 'Test Description',
    'imageUrl': 'test_url',
    'price': 9.99,
  };

  final tProductEntity = Product(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test_url',
    price: 9.99,
  );

  group('ProductModel', () {
    test('should be a subclass of Product entity', () {
      expect(tProductModel, isA<Product>());
    });

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Act
        final result = ProductModel.fromJson(tProductJson);

        // Assert
        expect(result, tProductModel);
      });

      test('should handle empty sizes list when not provided', () {
        // Arrange
        final json = Map<String, dynamic>.from(tProductJson)..remove('id');

        // Act
        final result = ProductModel.fromJson(json);

        // Assert
        expect(result.id, isEmpty);
      });

      test('should handle default rating when not provided', () {
        // Arrange
        final json = Map<String, dynamic>.from(tProductJson)..remove('price');

        // Act
        final result = ProductModel.fromJson(json);

        // Assert
        expect(result.price, 0.0);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tProductModel.toJson();

        // Assert
        expect(result, tProductJson);
      });
    });

    group('fromEntity', () {
      test('should convert Product entity to ProductModel', () {
        // Act
        final result = ProductModel.fromEntity(tProductEntity);

        // Assert
        expect(result, tProductModel);
      });
    });

    group('toEntity', () {
      test('should convert ProductModel to Product entity', () {
        // Act
        final result = tProductModel.toEntity();

        // Assert
        expect(result, tProductEntity);
      });
    });

    group('equality', () {
      test('should be equal when properties are same', () {
        // Arrange
        final productModel2 = ProductModel(
          id: '1',
          name: 'Test Product',
          description: 'Test Description',
          imageUrl: 'test_url',
          price: 9.99,
        );

        // Assert
        expect(tProductModel, productModel2);
      });

      test('should not be equal when properties are different', () {
        // Arrange
        final productModel2 = ProductModel(
          id: '2', // Different ID
          name: 'Test Product',
          description: 'Test Description',
          imageUrl: 'test_url',
          price: 9.99,
        );

        // Assert
        expect(tProductModel, isNot(productModel2));
      });
    });
  });
}
