import 'package:diyo_test/src/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:diyo_test/src/features/checkout/data/datasource/checkout_datasource.dart';
import 'package:diyo_test/src/features/checkout/domain/repository/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutDataSource dataSource;
  CheckoutRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> fetch() async {
    try {
      final result = await dataSource.fetch();
      if ((result ?? []).isEmpty) {
        return left(FetchFailure("Data not found"));
      }
      return right(result!);
    } catch (e) {
      return left(FetchFailure("error during fetch data"));
    }
  }
}
