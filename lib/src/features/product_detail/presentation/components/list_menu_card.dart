import 'package:diyo_test/src/core/constants/constants.dart';
import 'package:diyo_test/src/core/widget/cached_image_wrapper.dart';
import 'package:diyo_test/src/core/widget/image_wrapper.dart';
import 'package:diyo_test/src/features/add_to_cart/presentation/add_to_cart_screen.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/product.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubit/tab_selected_cubit.dart';

class ListMenuCard extends StatelessWidget {
  const ListMenuCard(
      {required this.restaurantid, required this.products, super.key});

  final List<Product> products;
  final int restaurantid;

  @override
  Widget build(BuildContext context) {
    List<String> types = Product.getTypes(products);
    return BlocProvider(
      create: (context) => TabSelectedCubit(types[0]),
      child: Column(
        children: [
          Container(
              height: 30,
              margin: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: types.length,
                itemBuilder: (context, index) {
                  String type = types[index];
                  return BlocBuilder<TabSelectedCubit, String>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          context.read<TabSelectedCubit>().change(type);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2,
                              vertical: defaultPadding / 4),
                          margin: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          decoration: BoxDecoration(
                              color: state == type
                                  ? primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                          child: Text(
                            type,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    color: type == state ? Colors.white : null),
                          ),
                        ),
                      );
                    },
                  );
                },
              )),
          //Flexible(child: child)
          Flexible(
            child: BlocBuilder<TabSelectedCubit, String>(
              builder: (context, state) {
                List<Product> filteredProducts =
                    products.where((product) => product.type == state).toList();
                return ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    Product product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => MenuDetailScreen(
                                  product: product,
                                  restaurantId: restaurantid,
                                )));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            //horizontal: defaultPadding,
                            vertical: 0),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        margin: const EdgeInsets.symmetric(
                            vertical: defaultPadding / 2,
                            horizontal: defaultPadding),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: "${product.id}",
                              child: ImageWrapper(
                                imageUrl: product.image!,
                                width: 75,
                                height: 70,
                              ),
                              // child: ClipRRect(
                              //   borderRadius: BorderRadius.circular(8),
                              //   child: CachedImageWrapper(
                              //     imageUrl: product.image!,
                              //     height: 70,
                              //     width: 75,
                              //   ),
                              // ),
                            ),
                            const SizedBox(
                              width: defaultPadding / 2,
                            ),
                            Text(product.name!),
                            Flexible(
                                child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                product.price!.toIdr(),
                                style: Theme.of(context).textTheme.button,
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
