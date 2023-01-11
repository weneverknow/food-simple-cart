import 'package:bloc/bloc.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/restaurant.dart';
import 'package:diyo_test/src/features/product_list/domain/usecase/fetch_product.dart';
import 'package:diyo_test/src/features/service_locator.dart';
import 'package:equatable/equatable.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {
    on<ProductListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ProductListLoad>(_onLoad);
  }

  final FetchProduct fetchProduct = sl<FetchProduct>();

  Future<void> _onLoad(
      ProductListLoad event, Emitter<ProductListState> emit) async {
    emit(ProductListLoading());
    final result = await fetchProduct.fetch();
    result.fold(
        (l) => emit(ProductListFailed()), (r) => emit(ProductListLoaded(r)));
  }
}
