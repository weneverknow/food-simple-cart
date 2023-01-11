import 'package:diyo_test/src/core/constants/constants.dart';
import 'package:diyo_test/src/core/widget/cached_image_wrapper.dart';
import 'package:diyo_test/src/core/widget/default_back_button.dart';
import 'package:diyo_test/src/core/widget/default_bottom_button.dart';
import 'package:diyo_test/src/core/widget/image_wrapper.dart';

import 'package:diyo_test/src/features/add_to_cart/domain/entities/cart.dart';
import 'package:diyo_test/src/features/checkout/presentation/check_out_screen.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/extensions/int_extension.dart';
import 'cubit/cart_cubit.dart';

class MenuDetailScreen extends StatelessWidget {
  MenuDetailScreen({
    required this.restaurantId,
    required this.product,
    super.key,
  });

  final Product product;
  final int restaurantId;

  int _qty = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _qty = context.select<CartCubit, int>((bloc) => bloc.state
            .any((element) => element.product == product)
        ? bloc.state.firstWhere((element) => element.product == product).qty ??
            0
        : 0);
    return Scaffold(
        body: Column(
          children: [
            _buildHeader(size, context),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding / 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        "${product.name}",
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                      Text(
                        product.price!.toIdr(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: primaryColor),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding / 4),
                    child: Divider(
                      height: defaultPadding / 2,
                      color: primaryColor,
                      thickness: 1,
                    ),
                  ),
                  Text("Special Request"),
                  BlocBuilder<CartCubit, List<Cart>>(
                    builder: (context, state) {
                      bool isExist =
                          state.any((cart) => cart.product == product);
                      return TextField(
                        maxLines: 4,
                        minLines: 1,
                        readOnly: !isExist,
                        onChanged: (val) {
                          context
                              .read<CartCubit>()
                              .changeNote(product: product, note: val);
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: 'Catatan untuk restoran',
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      );
                    },
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCounterButton(Icons.remove, onPressed: () {
                        context.read<CartCubit>().addToCart(
                            product: product,
                            restaurantId: restaurantId,
                            qty: -1);
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding,
                        ),
                        child: BlocBuilder<CartCubit, List<Cart>>(
                          builder: (context, state) {
                            if (state
                                .any((element) => element.product == product)) {
                              _qty = state
                                      .firstWhere((element) =>
                                          element.product == product)
                                      .qty ??
                                  0;
                              return Text("$_qty");
                            }
                            return Text("$_qty");
                          },
                        ),
                      ),
                      _buildCounterButton(Icons.add, onPressed: () {
                        context.read<CartCubit>().addToCart(
                            product: product,
                            restaurantId: restaurantId,
                            qty: 1);
                      })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BlocBuilder<CartCubit, List<Cart>>(
          builder: (context, state) {
            if (!state.any((element) => element.product == product)) {
              return const SizedBox.shrink();
            }
            Cart _cart =
                state.firstWhere((element) => element.product == product);
            return DefaultBottomButton(
              qty: _cart.qty ?? 0,
              price: (_cart.qty ?? 0) * (_cart.product?.price ?? 0),
              title: 'Add to Basket',
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => CheckOutScreen()));
              },
            );
          },
        ));
  }

  Container _buildHeader(Size size, BuildContext context) {
    return Container(
      height: size.height * 0.3,
      width: size.width,
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //   image: NetworkImage(product.image!),
      //   fit: BoxFit.cover,
      // )),
      // padding: const EdgeInsets.only(top: defaultPadding * 1),
      alignment: Alignment.topLeft,
      child: Stack(
        children: [
          Hero(
            tag: "${product.id}",
            child: ImageWrapper(
              imageUrl: product.image!,
              width: size.width,
              height: size.height * 0.3,
            ),
            // child: CachedImageWrapper(
            //   imageUrl: product.image!,
            //   height: size.height * 0.3,
            //   width: size.width,
            // ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            child: DefaultBackButton(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton(IconData icon, {Function()? onPressed}) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(foregroundColor: primaryColor),
        onPressed: onPressed,
        child: Icon(
          icon,
          color: secondaryColor,
        ));
  }
}
