import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  const TShimmer({
    super.key,
    this.height = 100,
    this.width = 200,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}
