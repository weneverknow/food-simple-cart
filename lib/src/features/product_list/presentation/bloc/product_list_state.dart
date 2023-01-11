part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {}

class ProductListInitial extends ProductListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductListLoaded extends ProductListState {
  final List<Restaurant> data;
  ProductListLoaded(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class ProductListLoading extends ProductListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductListFailed extends ProductListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
