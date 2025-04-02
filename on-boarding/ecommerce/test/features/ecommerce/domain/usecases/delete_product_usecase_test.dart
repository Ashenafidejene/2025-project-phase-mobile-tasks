import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product3/core/error/failures.dart';
import 'package:product3/features/ecommerce/domain/repositories/product_repository.dart';
import 'package:product3/features/ecommerce/domain/usecases/delete_product_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late DeleteProductUseCase useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = DeleteProductUseCase(mockRepository);
  });

  const tProductId = '1';

  test('should delete product through repository', () async {
    // Arrange
    when(mockRepository.deleteProduct(tProductId))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await useCase(tProductId);

    // Assert
    expect(result, const Right(null));
    verify(() => mockRepository.deleteProduct(tProductId));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return ValidationFailure when product id is empty', () async {
    // Act & Assert
    expect(() => useCase(''), throwsA(isA<ValidationFailure>()));
    verifyZeroInteractions(mockRepository);
  });

  test('should return NotFoundFailure when product not found', () async {
    // Arrange
    when(mockRepository.deleteProduct(tProductId))
        .thenAnswer((_) async => Left(const NotFoundFailure('Not found')));

    // Act
    final result = await useCase(tProductId);

    // Assert
    expect(result, Left(const NotFoundFailure('Not found')));
    verify(() => mockRepository.deleteProduct(tProductId));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return ServerFailure when repository fails', () async {
    // Arrange
    const failure = ServerFailure('Server error');
    when(mockRepository.deleteProduct(tProductId))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(tProductId);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.deleteProduct(tProductId));
    verifyNoMoreInteractions(mockRepository);
  });
}
