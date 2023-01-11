import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:diyo_test/src/core/constants/constants.dart';
import 'package:diyo_test/src/features/checkout/presentation/bloc/checkout_list_bloc.dart';
import 'package:diyo_test/src/features/checkout/presentation/checkout_list_screen.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/restaurant.dart';
import 'package:diyo_test/src/features/product_list/presentation/components/product_list_card.dart';
import 'package:diyo_test/src/features/product_list/presentation/components/product_list_shimmer.dart';

import 'package:diyo_test/src/features/tables/data/datasource/table_data.dart';
import 'package:diyo_test/src/features/tables/presentation/cubit/table_selected_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bloc/product_list_bloc.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});

  final _listIcon = [
    Icons.home,
    Icons.history_rounded,
    //Icons.qr_code_scanner_rounded,
    Icons.favorite,
    Icons.person
  ];

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime ?? now) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "tekan back sekali lagi untuk keluar",
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black87,
          textColor: Colors.white);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await onWillPop();
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              color: primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('DIYO',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.white)),
                  GestureDetector(
                      onTap: () async {
                        context
                            .read<CheckoutListBloc>()
                            .add(CheckoutListLoad());
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => CheckoutListScreen()));
                      },
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: Text(
                'Semua Restoran',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Flexible(child: BlocBuilder<ProductListBloc, ProductListState>(
              builder: (context, state) {
                if (state is ProductListInitial) {
                  return const SizedBox.shrink();
                }
                if (state is ProductListLoading) {
                  return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ProductListShimmer();
                      });
                }
                if (state is ProductListFailed) {
                  return Center(
                    child: Text('Data not found'),
                  );
                }
                final List<Restaurant> items =
                    (state as ProductListLoaded).data;
                return ProductListCard(items: items);
              },
            ))
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () async {
            final result = await BarcodeScanner.scan(options: ScanOptions());
            if (tables.any((element) => element.id == result.rawContent)) {
              context.read<TableSelectedCubit>().addTable(tables
                  .firstWhere((element) => element.id == result.rawContent));
            }
          },
          child: Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: _listIcon,
          activeIndex: 0,
          onTap: (val) {},
          gapLocation: GapLocation.center,
          activeColor: primaryColor,
          notchSmoothness: NotchSmoothness.softEdge,
        ),
      ),
    );
  }
}
