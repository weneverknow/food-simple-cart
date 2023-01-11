import 'package:diyo_test/src/features/add_to_cart/domain/entities/cart.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<List<Cart>> {
  CartCubit() : super([]);

  addToCart({
    required Product product,
    required int restaurantId,
    required int qty,
    String? note,
  }) {
    bool isExist = state.any((element) => element.product == product);
    if (state.any((element) => element.product == product)) {
      if ((state.firstWhere((element) => element.product == product).qty! +
              qty) ==
          0) {
        emit(state.where((element) => element.product != product).toList());
      } else {
        emit(state
            .map((cart) => cart.product == product
                ? cart.copyWith(
                    qty: qty + cart.qty!,
                    note: note,
                  )
                : cart)
            .toList());
      }
    } else {
      if (qty < 0) {
        emit([]);
      } else {
        emit(state +
            [
              Cart(
                restaurantId: restaurantId,
                product: product,
                qty: qty,
                note: note,
              )
            ]);
      }
    }

    //emit(state +);
  }

  changeNote({
    String? note,
    required Product product,
  }) {
    emit(state
        .map((e) => e.product == product ? e.copyWith(note: note) : e)
        .toList());
  }

  delete(Cart cart) {
    emit(state.where((element) => element != cart).toList());
  }

  clear() {
    emit([]);
  }
}
