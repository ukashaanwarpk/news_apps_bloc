import 'package:flutter/material.dart';
import 'package:news_apps_bloc/config/colors/app_colors.dart';

class TCircularIcon extends StatelessWidget {
  final double height;
  final double width;
  final Color bgColor;
  final IconData icon;
  const TCircularIcon({
    super.key,
    this.height = 40,
    this.width = 40,
    this.bgColor = AppColors.lightGreyColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(icon, size: 20, color: AppColors.blackColor),
    );
  }
}
