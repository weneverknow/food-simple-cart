import 'package:diyo_test/src/features/product_list/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final int? restaurantId;
  final Product? product;
  final int? qty;
  final String? note;

  const Cart({this.note, this.product, this.qty, this.restaurantId});
  Cart copyWith({
    int? qty,
    String? note,
  }) =>
      Cart(
        restaurantId: restaurantId,
        product: product,
        qty: qty ?? this.qty,
        note: note ?? this.note,
      );
  @override
  List<Object?> get props => [
        restaurantId,
        product,
        qty,
        note,
      ];
}
