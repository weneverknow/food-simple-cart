import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:diyo_test/src/features/product_detail/presentation/product_detail_screen.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/restaurant.dart';

import 'package:diyo_test/src/features/tables/presentation/cubit/table_selected_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widget/image_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../tables/data/datasource/table_data.dart';
import '../../../tables/domain/entities/diyo_table.dart';

class ProductListCard extends StatelessWidget {
  const ProductListCard({required this.items, super.key});

  final List<Restaurant> items;

  @override
  Widget build(BuildContext context) {
    DiyoTable? _table =
        context.select<TableSelectedCubit, DiyoTable?>((bloc) => bloc.state);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        Restaurant item = items[index];
        return GestureDetector(
          onTap: () async {
            if (_table != null) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(restaurant: item)));
            } else {
              final result = await BarcodeScanner.scan();
              if (tables.any((element) => element.id == result.rawContent)) {
                context.read<TableSelectedCubit>().addTable(tables
                    .firstWhere((element) => element.id == result.rawContent));
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(restaurant: item)));
              }
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => QrCodeScanner(
              //           restaurant: item,
              //         )));
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 90,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(defaultPadding / 4),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          )),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timelapse,
                            size: 12,
                          ),
                          const SizedBox(
                            width: defaultPadding / 4,
                          ),
                          Text(
                            '5 min',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(fontSize: 9),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(defaultPadding / 2,
                      defaultPadding / 2, 0, defaultPadding / 2),
                  //color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ImageWrapper(
                        imageUrl: item.image!,
                        height: 75,
                        width: 70,
                      ),
                      const SizedBox(
                        width: defaultPadding / 2,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              item.name!,
                              style: Theme.of(context).textTheme.headline6,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              item.address!,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              item.type!,
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontSize: 8,
                                      ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
