import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product3/core/usecases/usecase.dart';
import 'package:product3/features/ecommerce/domain/entities/product.dart';
import 'package:product3/features/ecommerce/domain/repositories/product_repository.dart';
import 'package:product3/features/ecommerce/domain/usecases/get_products_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProductsUseCase useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = GetProductsUseCase(mockRepository);
  });

  final tProducts = [
    Product(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      imageUrl: 'test_url',
      price: 9.99,
    ),
  ];

  test('should get products from the repository', () async {
    // arrange
    when(mockRepository.getProducts())
        .thenAnswer((_) async => Right(tProducts));

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, Right(tProducts));
    verify(() => mockRepository.getProducts());
    verifyNoMoreInteractions(mockRepository);
  });
}
