import 'package:get_it/get_it.dart';
import 'package:product3/core/network/network_info.dart';
import 'package:product3/features/ecommerce/data/datasource/product_local_data_source.dart';
import 'package:product3/features/ecommerce/data/datasource/product_remote_data_source.dart';
import 'package:product3/features/ecommerce/data/repositories/product_repository_impl.dart';
import 'package:product3/features/ecommerce/domain/repositories/product_repository.dart';
import 'package:product3/features/ecommerce/domain/usecases/create_product_usecase.dart';
import 'package:product3/features/ecommerce/domain/usecases/delete_product_usecase.dart';
import 'package:product3/features/ecommerce/domain/usecases/get_product_usecase.dart';
import 'package:product3/features/ecommerce/domain/usecases/get_products_usecase.dart';
import 'package:product3/features/ecommerce/domain/usecases/update_product_usecase.dart';
import 'package:product3/features/ecommerce/presentation/bloc/product_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  getIt.registerFactory(
    () => ProductBloc(
      createProduct: getIt(),
      deleteProduct: getIt(),
      getAllProducts: getIt(),
      getSingleProduct: getIt(),
      updateProduct: getIt(),
    ),
  );
  getIt.registerLazySingleton(() => GetProductsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProductUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateProductUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteProductUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateProductUseCase(getIt()));

  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl());
  getIt.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: getIt()));

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => sharedPreferences);
}
