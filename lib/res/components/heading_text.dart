import 'package:flutter/material.dart';
import 'package:news_apps_bloc/config/colors/app_colors.dart';

class THeadingText extends StatelessWidget {
  final VoidCallback? onPress;
  final String title;
  final String subtitle;
  final bool show;
  const THeadingText({
    super.key,
    this.onPress,
    required this.title,
    this.subtitle = 'View all',
    this.show = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        if (show)
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,

              color: Colors.grey.shade600,
            ),
          ),
      ],
    );
  }
}
