import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product3/core/error/failures.dart';
import 'package:product3/features/ecommerce/domain/entities/product.dart';
import 'package:product3/features/ecommerce/domain/repositories/product_repository.dart';
import 'package:product3/features/ecommerce/domain/usecases/update_product_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late UpdateProductUseCase useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = UpdateProductUseCase(mockRepository);
  });

  final tProduct = Product(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test_url',
    price: 9.99,
  );

  test('should update product through repository', () async {
    // Arrange
    when(mockRepository.updateProduct(tProduct))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await useCase(tProduct);

    // Assert
    expect(result, const Right(null));
    verify(() => mockRepository.updateProduct(tProduct));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return ValidationFailure when id is empty', () async {
    // Arrange
    final invalidProduct = Product(
      id: '',
      name: 'Test',
      description: 'Test',
      imageUrl: 'test',
      price: 9.99,
    );

    // Act
    final result = await useCase(invalidProduct);

    // Assert
    expect(result, Left(const ValidationFailure('Product ID cannot be empty')));
    verifyZeroInteractions(mockRepository);
  });

  test('should return ValidationFailure when name is empty', () async {
    // Arrange
    final invalidProduct = Product(
      id: '1',
      name: '',
      description: 'Test',
      imageUrl: 'test',
      price: 9.99,
    );

    // Act
    final result = await useCase(invalidProduct);

    // Assert
    expect(
        result, Left(const ValidationFailure('Product name cannot be empty')));
    verifyZeroInteractions(mockRepository);
  });

  test('should return ValidationFailure when price is invalid', () async {
    // Arrange
    final invalidProduct = Product(
      id: '1',
      name: 'Test',
      description: 'Test',
      imageUrl: 'test',
      price: 0,
    );

    // Act
    final result = await useCase(invalidProduct);

    // Assert
    expect(result,
        Left(const ValidationFailure('Product price must be greater than 0')));
    verifyZeroInteractions(mockRepository);
  });

  test('should return Failure when repository fails', () async {
    // Arrange
    const failure = ServerFailure('Server error');
    when(mockRepository.updateProduct(tProduct))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(tProduct);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.updateProduct(tProduct));
    verifyNoMoreInteractions(mockRepository);
  });
}
