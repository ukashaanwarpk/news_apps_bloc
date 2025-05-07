import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_apps_bloc/res/components/shimmer.dart';

class TCachedNetwrokImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double radius;
  const TCachedNetwrokImage({
    super.key,
    required this.imageUrl,
    this.radius = 12,
    this.height = 150,
    this.width = 150,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        placeholder:
            (context, url) =>
                TShimmer(height: height, width: width, radius: radius),
      ),
    );
  }
}
