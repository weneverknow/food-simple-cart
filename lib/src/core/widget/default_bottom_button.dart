import 'package:diyo_test/src/features/add_to_cart/domain/entities/cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import 'red_card_wrapper.dart';

class DefaultBottomButton extends StatelessWidget {
  const DefaultBottomButton({
    required this.qty,
    required this.price,
    super.key,
    this.onTap,
    required this.title,
  });

  final int qty;
  final int price;
  final Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 2,
          vertical: defaultPadding / 4,
        ),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RedCardWrapper(
                child: Text(
              "$qty",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: Colors.white),
            )),
            Text(
              "$title",
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: Colors.white),
            ),
            Text(
              NumberFormat.currency(
                      locale: 'id_IDR', symbol: '', decimalDigits: 0)
                  .format(price),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
