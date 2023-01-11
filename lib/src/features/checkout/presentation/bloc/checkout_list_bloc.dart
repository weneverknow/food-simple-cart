import 'package:bloc/bloc.dart';
import 'package:diyo_test/src/features/checkout/domain/usecase/fetch_checkout.dart';
import 'package:diyo_test/src/features/service_locator.dart';
import 'package:equatable/equatable.dart';

part 'checkout_list_event.dart';
part 'checkout_list_state.dart';

class CheckoutListBloc extends Bloc<CheckoutListEvent, CheckoutListState> {
  CheckoutListBloc() : super(CheckoutListInitial()) {
    on<CheckoutListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CheckoutListLoad>(_load);
  }

  final FetchCheckout fetchCheckout = sl<FetchCheckout>();

  _load(CheckoutListLoad event, Emitter<CheckoutListState> emit) async {
    final result = await fetchCheckout.fetch();
    result.fold((l) => emit(CheckoutListFailed(l.message)),
        (r) => emit(CheckoutListLoaded(r)));
  }
}
