import 'package:diyo_test/src/core/failure/failure.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/restaurant.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Restaurant>>> fetchProduct();
}
