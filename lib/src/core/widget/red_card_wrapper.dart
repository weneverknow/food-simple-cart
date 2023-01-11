import 'package:flutter/material.dart';

import '../constants/constants.dart';

class RedCardWrapper extends StatelessWidget {
  const RedCardWrapper({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 2, vertical: defaultPadding / 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: secondaryColor),
      child: child,
    );
  }
}
