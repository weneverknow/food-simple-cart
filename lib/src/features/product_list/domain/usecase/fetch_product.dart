import 'package:dartz/dartz.dart';
import 'package:diyo_test/src/core/failure/failure.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/restaurant.dart';
import 'package:diyo_test/src/features/product_list/domain/repository/product_repository.dart';

class FetchProduct {
  final ProductRepository repository;
  FetchProduct(this.repository);

  Future<Either<Failure, List<Restaurant>>> fetch() async {
    return await repository.fetchProduct();
  }
}
