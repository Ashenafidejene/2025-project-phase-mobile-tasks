import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:product3/core/usecases/usecase.dart';
import 'package:product3/features/ecommerce/domain/entities/product.dart';
import 'package:product3/features/ecommerce/domain/usecases/delete_product_usecase.dart';
import 'package:product3/features/ecommerce/domain/usecases/get_product_usecase.dart';
import 'package:product3/features/ecommerce/domain/usecases/get_products_usecase.dart';
import 'package:product3/features/ecommerce/domain/usecases/update_product_usecase.dart';
import '../../domain/usecases/create_product_usecase.dart';
import './product_events.dart';
import './product_states.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getAllProducts;
  final GetProductUseCase getSingleProduct;
  final UpdateProductUseCase updateProduct;
  final DeleteProductUseCase deleteProduct;
  final CreateProductUseCase createProduct;

  ProductBloc({
    required this.getAllProducts,
    required this.getSingleProduct,
    required this.updateProduct,
    required this.deleteProduct,
    required this.createProduct,
  }) : super(const InitialState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is LoadAllProductsEvent) {
      yield* _mapLoadAllProductsToState();
    } else if (event is GetSingleProductEvent) {
      yield* _mapGetSingleProductToState(event);
    } else if (event is UpdateProductEvent) {
      yield* _mapUpdateProductToState(event);
    } else if (event is DeleteProductEvent) {
      yield* _mapDeleteProductToState(event);
    } else if (event is CreateProductEvent) {
      yield* _mapCreateProductToState(event);
    }
  }

  Stream<ProductState> _mapLoadAllProductsToState() async* {
    yield const LoadingState();
    try {
      final products = await getAllProducts(NoParams());
      yield LoadedAllProductsState(products as List<Product>);
    } catch (e) {
      yield ErrorState('Failed to load products: ${e.toString()}');
    }
  }

  Stream<ProductState> _mapGetSingleProductToState(
      GetSingleProductEvent event) async* {
    yield const LoadingState();
    try {
      final product = await getSingleProduct(event.productId);
      yield LoadedSingleProductState(product as Product);
    } catch (e) {
      yield ErrorState('Failed to load product: ${e.toString()}');
    }
  }

  Stream<ProductState> _mapUpdateProductToState(
      UpdateProductEvent event) async* {
    yield const LoadingState();
    try {
      await updateProduct(event.updateData as Product);
      yield const ProductOperationSuccessState('Product updated successfully');
      // Reload all products to reflect changes
      add(const LoadAllProductsEvent());
    } catch (e) {
      yield ErrorState('Failed to update product: ${e.toString()}');
    }
  }

  Stream<ProductState> _mapDeleteProductToState(
      DeleteProductEvent event) async* {
    yield const LoadingState();
    try {
      await deleteProduct(event.productId);
      yield const ProductOperationSuccessState('Product deleted successfully');
      // Reload all products to reflect changes
      add(const LoadAllProductsEvent());
    } catch (e) {
      yield ErrorState('Failed to delete product: ${e.toString()}');
    }
  }

  Stream<ProductState> _mapCreateProductToState(
      CreateProductEvent event) async* {
    yield const LoadingState();
    try {
      await createProduct(event.productData as Product);
      yield const ProductOperationSuccessState('Product created successfully');
      // Reload all products to show the new product
      add(const LoadAllProductsEvent());
    } catch (e) {
      yield ErrorState('Failed to create product: ${e.toString()}');
    }
  }
}
