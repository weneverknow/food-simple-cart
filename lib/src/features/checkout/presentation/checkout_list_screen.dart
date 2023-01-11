import 'package:diyo_test/src/core/constants/constants.dart';
import 'package:diyo_test/src/core/format/format.dart';
import 'package:diyo_test/src/features/checkout/presentation/bloc/checkout_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product_list/data/datasource/products.dart';
import '../../tables/data/datasource/table_data.dart';
import '../../../core/extensions/int_extension.dart';

class CheckoutListScreen extends StatelessWidget {
  const CheckoutListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: false,
        title: Text("Checkout History"),
      ),
      body: BlocBuilder<CheckoutListBloc, CheckoutListState>(
          builder: (context, state) {
        if (state is CheckoutListFailed) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: secondaryColor, fontSize: 18),
            ),
          );
        }

        if (state is CheckoutListLoaded) {
          List<Map<String, dynamic>> items = state.items;
          return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> item = items[index];
                return Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${products.firstWhere((element) => element['id'] == item["restaurant_id"])['name']}"),
                          const SizedBox(
                            width: defaultPadding / 4,
                          ),
                          Text(
                            Format.date(DateTime.fromMillisecondsSinceEpoch(
                                    item['created_date'])) +
                                " " +
                                Format.inHour(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        item['created_date'])),
                            style: Theme.of(context).textTheme.button?.copyWith(
                                  color: primaryColor,
                                ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: defaultPadding / 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${(products.firstWhere((element) => element['id'] == item['restaurant_id'])['products'] as List<Map<String, dynamic>>).firstWhere((element) => element['id'] == item['product_id'])['name']}",
                                style: Theme.of(context).textTheme.button,
                              ),
                              const SizedBox(
                                width: defaultPadding / 4,
                              ),
                              Text(
                                "(${item['qty']}x)",
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                          Text(
                            "${item['total']}",
                            style: Theme.of(context).textTheme.button,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              });
        }

        return const SizedBox.shrink();
      }),
    );
  }
}
