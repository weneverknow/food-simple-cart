import 'package:dartz/dartz.dart';
import 'package:diyo_test/src/core/failure/failure.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, List<Map<String, dynamic>>>> fetch();
}
