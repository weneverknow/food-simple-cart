import 'package:diyo_test/src/features/product_list/domain/entities/restaurant.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widget/red_card_wrapper.dart';

class RestaurantDescriptionCard extends StatelessWidget {
  const RestaurantDescriptionCard({required this.restaurant, super.key});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name!,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          Text(
            restaurant.type!,
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          Text(
            restaurant.address!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Divider(
            height: defaultPadding / 2,
            color: Colors.black54,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: defaultPadding / 4,
                  ),
                  Text(
                    "BUKA",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: primaryColor),
                  ),
                  const SizedBox(
                    width: defaultPadding / 4,
                  ),
                  Text(
                    "until 19.0 today",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              RedCardWrapper(
                  child: Text(
                "1.2 Km",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.white),
              ))
            ],
          )
        ],
      ),
    );
  }
}
