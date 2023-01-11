import 'package:intl/intl.dart';

extension IntExtension on int {
  String toIdr() {
    return NumberFormat.currency(symbol: '', locale: 'id_IDR', decimalDigits: 0)
        .format(this);
  }
}
