import 'package:diyo_test/src/features/checkout/data/datasource/database/check_out_database.dart';

abstract class CheckoutDataSource {
  Future<List<Map<String, dynamic>>?> fetch();
}

class CheckoutDataSourceImpl implements CheckoutDataSource {
  @override
  Future<List<Map<String, dynamic>>?> fetch() async {
    try {
      final result = await CheckOutDatabase.get();
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
