import 'package:cached_network_image/cached_network_image.dart';
import 'package:diyo_test/src/core/widget/cached_image_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageWrapper extends StatelessWidget {
  const ImageWrapper(
      {required this.imageUrl, this.height = 25, this.width = 35, super.key});
  final double? height;
  final double? width;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            'assets/images/no-image.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Shimmer.fromColors(
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
            );
          },
        ),
        // child: CachedImageWrapper(
        //   imageUrl: imageUrl,
        //   width: double.infinity,
        //   height: double.infinity,
        // ),
      ),
    );
  }
}
