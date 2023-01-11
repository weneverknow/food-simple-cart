import 'package:diyo_test/src/core/exceptions/exceptions.dart';
import 'package:diyo_test/src/features/product_list/data/datasource/product_data_source.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/restaurant.dart';
import 'package:diyo_test/src/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:diyo_test/src/features/product_list/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;
  ProductRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Restaurant>>> fetchProduct() async {
    try {
      final response = await dataSource.fetchProduct();
      List<Restaurant> restaurants =
          response.map((model) => model.toEntities()).toList();
      print("[ProductRepositoryImpl] fetchProduct $restaurants");
      return right(restaurants);
    } on DatabaseException catch (e) {
      return left(FetchFailure(e.message));
    }
  }
}
