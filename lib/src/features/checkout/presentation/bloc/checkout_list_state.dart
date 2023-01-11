part of 'checkout_list_bloc.dart';

abstract class CheckoutListState extends Equatable {
  // const CheckoutListState();

  // @override
  // List<Object> get props => [];
}

class CheckoutListInitial extends CheckoutListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CheckoutListLoaded extends CheckoutListState {
  final List<Map<String, dynamic>> items;

  CheckoutListLoaded(this.items);

  @override
  // TODO: implement props
  List<Object?> get props => [items];
}

class CheckoutListFailed extends CheckoutListState {
  final String message;
  CheckoutListFailed(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
