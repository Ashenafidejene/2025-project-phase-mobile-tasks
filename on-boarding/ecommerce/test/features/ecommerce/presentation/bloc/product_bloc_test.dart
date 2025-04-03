import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product3/core/error/failures.dart';
import 'package:product3/core/usecases/usecase.dart';
import 'package:product3/features/ecommerce/domain/entities/product.dart';
import 'package:product3/features/ecommerce/domain/usecases/create_product_usecase.dart';
import 'package:product3/features/ecommerce/domain/usecases/delete_product_usecase.dart';
import 'package:product3/features/ecommerce/domain/usecases/get_product_usecase.dart';
import 'package:product3/features/ecommerce/domain/usecases/get_products_usecase.dart';
import 'package:product3/features/ecommerce/domain/usecases/update_product_usecase.dart';
import 'package:product3/features/ecommerce/presentation/bloc/product_bloc.dart';
import 'package:product3/features/ecommerce/presentation/bloc/product_events.dart';
import 'package:product3/features/ecommerce/presentation/bloc/product_states.dart';

class MockGetAllProducts extends Mock implements GetProductsUseCase {}

class MockGetSingleProduct extends Mock implements GetProductUseCase {}

class MockUpdateProduct extends Mock implements UpdateProductUseCase {}

class MockDeleteProduct extends Mock implements DeleteProductUseCase {}

class MockCreateProduct extends Mock implements CreateProductUseCase {}

void main() {
  late ProductBloc productBloc;
  late MockGetAllProducts mockGetAllProducts;
  late MockGetSingleProduct mockGetSingleProduct;
  late MockUpdateProduct mockUpdateProduct;
  late MockDeleteProduct mockDeleteProduct;
  late MockCreateProduct mockCreateProduct;

  setUp(() {
    mockGetAllProducts = MockGetAllProducts();
    mockGetSingleProduct = MockGetSingleProduct();
    mockUpdateProduct = MockUpdateProduct();
    mockDeleteProduct = MockDeleteProduct();
    mockCreateProduct = MockCreateProduct();

    productBloc = ProductBloc(
      getAllProducts: mockGetAllProducts,
      getSingleProduct: mockGetSingleProduct,
      updateProduct: mockUpdateProduct,
      deleteProduct: mockDeleteProduct,
      createProduct: mockCreateProduct,
    );
  });

  tearDown(() {
    productBloc.close();
  });

  group('Initial state', () {
    test('should be InitialState', () {
      expect(productBloc.state, equals(const InitialState()));
    });
  });

  group('LoadAllProductsEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductsState] on success',
      build: () {
        when(mockGetAllProducts("1" as NoParams))
            .thenAnswer((_) async => const Right([]));
        return productBloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductsEvent()),
      expect: () => [
        const LoadingState(),
        isA<LoadedAllProductsState>(),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when fetching fails',
      build: () {
        when(mockGetAllProducts("1" as NoParams))
            .thenAnswer((_) async => Left(Exception('Error') as Failure));
        return productBloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductsEvent()),
      expect: () => [
        const LoadingState(),
        isA<ErrorState>(),
      ],
    );
  });

  group('GetSingleProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedSingleProductState] when successful',
      build: () {
        when(mockGetSingleProduct('1')).thenAnswer((_) async => Right(Product(
            id: '1',
            name: 'Test',
            imageUrl: 'url',
            price: 10,
            description: 'desc')));
        return productBloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent('1')),
      expect: () => [
        const LoadingState(),
        isA<LoadedSingleProductState>(),
      ],
    );
  });

  group('Edge cases', () {
    blocTest<ProductBloc, ProductState>(
      'emits ErrorState when loaded products list is empty',
      build: () {
        when(mockGetAllProducts("1" as NoParams))
            .thenAnswer((_) async => Right([]));
        return productBloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductsEvent()),
      expect: () => [
        const LoadingState(),
        isA<ErrorState>(),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits ErrorState when product data is invalid',
      build: () {
        when(mockCreateProduct({'invalid': 'data'} as Product))
            .thenThrow(FormatException('Invalid data'));
        return productBloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent({'invalid': 'data'})),
      expect: () => [
        const LoadingState(),
        isA<ErrorState>(),
      ],
    );
  });
}
