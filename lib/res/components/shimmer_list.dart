import 'package:flutter/material.dart';
import 'package:news_apps_bloc/res/components/shimmer.dart';

class TShimmerList extends StatelessWidget {
  final int itemCount;
  final double height;
  final double width;
  final double radius;
  const TShimmerList({
    super.key,
    this.itemCount = 6,
    this.height = 100,
    this.width = double.infinity,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 165,
            margin: EdgeInsets.symmetric(vertical: 10),

            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TShimmer(height: 165, width: width, radius: radius),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20, width: 60),
                      SizedBox(height: 20, width: 60),
                      SizedBox(height: 20, width: 60),
                      SizedBox(height: 10),
                      SizedBox(height: 20, width: 60),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
