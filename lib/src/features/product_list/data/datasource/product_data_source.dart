import 'package:diyo_test/src/core/exceptions/exceptions.dart';
import 'package:diyo_test/src/features/product_list/data/model/restaurant_model.dart';
import 'package:diyo_test/src/features/product_list/data/datasource/products.dart';

abstract class ProductDataSource {
  Future<List<RestaurantModel>> fetchProduct();
}

class ProductDataSourceImpl implements ProductDataSource {
  @override
  Future<List<RestaurantModel>> fetchProduct() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      return products.map((e) => RestaurantModel.fromJson(e)).toList();
    } catch (e) {
      throw DatabaseException('Error during fetch data');
    }
  }
}
