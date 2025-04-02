import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product3/core/error/failures.dart';
import 'package:product3/features/ecommerce/domain/entities/product.dart';
import 'package:product3/features/ecommerce/domain/repositories/product_repository.dart';
import 'package:product3/features/ecommerce/domain/usecases/get_product_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProductUseCase useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = GetProductUseCase(mockRepository);
  });

  final tProduct = Product(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test_url',
    price: 9.99,
  );

  test('should get product from repository when exists', () async {
    // Arrange
    when(mockRepository.getProduct('1'))
        .thenAnswer((_) async => Right(tProduct));

    // Act
    final result = await useCase('1');

    // Assert
    expect(result, Right(tProduct));
    verify(() => mockRepository.getProduct('1'));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return NotFoundFailure when product not found', () async {
    // Arrange
    when(mockRepository.getProduct('1'))
        .thenAnswer((_) async => Left(const NotFoundFailure('Not found')));

    // Act
    final result = await useCase('1');

    // Assert
    expect(result, Left(const NotFoundFailure('Not found')));
    verify(() => mockRepository.getProduct('1'));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return ValidationFailure when product id is empty', () async {
    // Act & Assert
    expect(() => useCase(''), throwsA(isA<ValidationFailure>()));
    verifyZeroInteractions(mockRepository);
  });

  test('should return ServerFailure when repository fails', () async {
    // Arrange
    const failure = ServerFailure('Server error');
    when(mockRepository.getProduct('1')).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase('1');

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.getProduct('1'));
    verifyNoMoreInteractions(mockRepository);
  });
}
