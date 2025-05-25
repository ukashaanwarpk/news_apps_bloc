import 'package:flutter/material.dart';
import 'package:news_apps_bloc/res/components/shimmer.dart';

class TShimmerList extends StatelessWidget {
  final int itemCount;
  final double height;
  final double width;
  final double radius;
  final bool isExpanded;
  const TShimmerList({
    super.key,
    this.itemCount = 6,
    this.height = 100,
    this.width = double.infinity,
    this.radius = 10,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return isExpanded ? Expanded(child: buildList()) : buildList();
  }

  Widget buildList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final size = MediaQuery.of(context).size;
        return Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TShimmer(
                height: size.width * 0.25,
                width: size.width * 0.25,
                radius: radius,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TShimmer(
                      height: 20,
                      width: size.width * 0.80,
                      radius: radius,
                    ),

                    const SizedBox(height: 10),
                    TShimmer(
                      height: 20,
                      width: size.width * 0.80,
                      radius: radius,
                    ),
                    const SizedBox(height: 10),
                    TShimmer(
                      height: 20,
                      width: size.width * 0.40,
                      radius: radius,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
