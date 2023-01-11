import 'package:diyo_test/src/core/constants/constants.dart';
import 'package:diyo_test/src/core/widget/default_back_button.dart';
import 'package:diyo_test/src/features/add_to_cart/presentation/cubit/cart_cubit.dart';
import 'package:diyo_test/src/features/checkout/presentation/check_out_screen.dart';
import 'package:diyo_test/src/features/product_detail/presentation/components/list_menu_card.dart';
import 'package:diyo_test/src/features/product_detail/presentation/components/restaurant_description_card.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/restaurant.dart';
import 'package:diyo_test/src/features/tables/domain/entities/diyo_table.dart';
import 'package:diyo_test/src/features/tables/presentation/cubit/table_selected_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widget/default_bottom_button.dart';
import '../../add_to_cart/domain/entities/cart.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({required this.restaurant, super.key});
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            restaurant.image!,
            height: size.height * 0.3,
            width: size.width,
            fit: BoxFit.cover,
            //fit: BoxFit.fitWidth,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(size, context),
              RestaurantDescriptionCard(restaurant: restaurant),
              Flexible(
                  child: ListMenuCard(
                products: restaurant.products!,
                restaurantid: restaurant.id!,
              ))
            ],
          )
        ],
      ),
      bottomNavigationBar:
          BlocBuilder<CartCubit, List<Cart>>(builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }

        return DefaultBottomButton(
          qty: state.fold(
              0, (previousValue, element) => previousValue + element.qty!),
          price: state.fold(
              0,
              (previousValue, element) =>
                  previousValue + element.qty! * element.product!.price!),
          title: 'View Basket',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => CheckOutScreen()));
          },
        );
      }),
    );
  }

  Container _buildHeader(Size size, BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.33,
      //color: Colors.black12,
      child: Stack(
        children: [
          Positioned(
              right: defaultPadding / 4,
              bottom: 0,
              child: buildFavoriteIcon(context)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: defaultPadding),
                child: DefaultBackButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              _buildSelectedTable(context)
            ],
          ),
        ],
      ),
    );
  }

  Container buildFavoriteIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Icon(
        Icons.favorite,
        color: primaryColor,
      ),
    );
  }

  Widget _buildSelectedTable(BuildContext context) {
    DiyoTable? _table =
        context.select<TableSelectedCubit, DiyoTable?>((bloc) => bloc.state);
    return Container(
      margin: const EdgeInsets.only(
          bottom: defaultPadding * 1.5, left: defaultPadding / 2),
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 2, vertical: defaultPadding / 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: primaryColor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.table_bar_rounded,
            color: Colors.white,
          ),
          const SizedBox(
            width: defaultPadding / 2,
          ),
          Text(
            '${_table?.name}',
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
