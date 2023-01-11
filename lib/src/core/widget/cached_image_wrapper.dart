import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImageWrapper extends StatelessWidget {
  const CachedImageWrapper({
    required this.imageUrl,
    super.key,
    this.height,
    this.width,
  });

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/no-image.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
