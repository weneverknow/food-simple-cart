import 'package:diyo_test/src/features/checkout/data/datasource/database/check_out_database.dart';

import '../../../core/extensions/int_extension.dart';
import 'package:diyo_test/src/core/constants/constants.dart';
import 'package:diyo_test/src/core/widget/dialog_widget.dart';
import 'package:diyo_test/src/core/widget/red_card_wrapper.dart';
import 'package:diyo_test/src/features/add_to_cart/presentation/cubit/cart_cubit.dart';
import 'package:diyo_test/src/features/product_list/presentation/product_list_screen.dart';
import 'package:diyo_test/src/features/tables/presentation/cubit/table_selected_cubit.dart';
import 'package:flutter/material.dart';
import '../../../core/widget/default_bottom_button.dart';
import '../../add_to_cart/domain/entities/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../tables/domain/entities/diyo_table.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Cart> carts =
        context.select<CartCubit, List<Cart>>((bloc) => bloc.state);
    DiyoTable? _table =
        context.select<TableSelectedCubit, DiyoTable?>((bloc) => bloc.state);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: primaryColor,
        title: Text(
          "Pesanan ${_table?.name}",
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: defaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pesananku",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.black),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding / 2,
                    vertical: defaultPadding / 4,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black26)),
                  child: Row(
                    children: [
                      RedCardWrapper(
                          child: Icon(
                        Icons.dinner_dining,
                        color: Colors.white,
                        size: 14,
                      )),
                      const SizedBox(
                        width: defaultPadding / 2,
                      ),
                      Text(
                        "Add Menu",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(color: primaryColor),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Flexible(
                child: ListView(
              children: [
                ...carts
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding / 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  RedCardWrapper(
                                      child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "${e.qty}X",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  )),
                                  const SizedBox(
                                    width: defaultPadding / 2,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(e.product?.name ?? ''),
                                      Text(
                                        e.note ?? '',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    e.product!.price!.toIdr(),
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  const SizedBox(
                                    width: defaultPadding / 2,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final confirmed =
                                          await showConfirmationDialog(context,
                                              title: "Confirmation",
                                              message:
                                                  "Anda yakin akan menghapus pesanan ini?");
                                      if (confirmed) {
                                        context.read<CartCubit>().delete(e);
                                      }
                                    },
                                    child: Icon(
                                      Icons.delete_rounded,
                                      size: 20,
                                      color: secondaryColor,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ))
                    .toList(),
                ...[
                  Divider(
                    height: 14,
                    color: Colors.black38,
                  ),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sub total"),
                      Text(carts
                          .fold(
                              0,
                              (previousValue, element) =>
                                  previousValue +
                                  element.qty! * element.product!.price!)
                          .toIdr())
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Divider(
                    thickness: 8,
                    color: Colors.black12,
                  ),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Kode Promo"), Text("Masukkan")],
                  ),
                ]
              ],
            ))
          ],
        ),
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
          title: 'Checkout',
          onTap: () async {
            List<Map<String, dynamic>> body = state
                .map((e) => {
                      "restaurant_id": e.restaurantId,
                      "product_id": e.product?.id,
                      "notes": e.note,
                      "qty": e.qty,
                      "total": e.qty! * e.product!.price!,
                      "table_no": _table?.name,
                      "created_date": DateTime.now().millisecondsSinceEpoch
                    })
                .toList();
            await CheckOutDatabase.insert(body);
            context.read<TableSelectedCubit>().clear();
            context.read<CartCubit>().clear();

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => ProductListScreen()),
                (Route<dynamic> route) => false);
          },
        );
      }),
    );
  }
}
