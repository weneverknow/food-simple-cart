import 'package:dartz/dartz.dart';
import 'package:diyo_test/src/core/failure/failure.dart';
import 'package:diyo_test/src/features/checkout/domain/repository/checkout_repository.dart';

class FetchCheckout {
  final CheckoutRepository repository;
  FetchCheckout(this.repository);

  Future<Either<Failure, List<Map<String, dynamic>>>> fetch() async {
    return await repository.fetch();
  }
}
