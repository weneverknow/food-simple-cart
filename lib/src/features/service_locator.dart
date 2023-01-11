import 'package:diyo_test/src/features/checkout/data/datasource/checkout_datasource.dart';
import 'package:diyo_test/src/features/checkout/data/repository/checkout_repository_impl.dart';
import 'package:diyo_test/src/features/checkout/domain/repository/checkout_repository.dart';
import 'package:diyo_test/src/features/checkout/domain/usecase/fetch_checkout.dart';
import 'package:diyo_test/src/features/product_list/data/datasource/product_data_source.dart';
import 'package:diyo_test/src/features/product_list/data/repository/product_repository_impl.dart';
import 'package:diyo_test/src/features/product_list/domain/repository/product_repository.dart';
import 'package:diyo_test/src/features/product_list/domain/usecase/fetch_product.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

setupServiceLocator() {
  /** 
   * setUp datasource
  */
  sl.registerLazySingleton<ProductDataSource>(() => ProductDataSourceImpl());
  sl.registerLazySingleton<CheckoutDataSource>(() => CheckoutDataSourceImpl());

  /**
   * setUp repository
   */
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl<ProductDataSource>()));
  sl.registerLazySingleton<CheckoutRepository>(
      () => CheckoutRepositoryImpl(sl<CheckoutDataSource>()));

  /**
   * setUp usecase
   */
  sl.registerLazySingleton<FetchProduct>(
      () => FetchProduct(sl<ProductRepository>()));
  sl.registerLazySingleton<FetchCheckout>(
      () => FetchCheckout(sl<CheckoutRepository>()));
}
