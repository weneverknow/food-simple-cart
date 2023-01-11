import 'package:flutter/material.dart';

import '../constants/constants.dart';

class DefaultBackButton extends StatelessWidget {
  DefaultBackButton({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(defaultPadding / 2),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
