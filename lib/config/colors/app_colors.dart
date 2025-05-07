import 'package:flutter/material.dart';

class AppColors {
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF000000);

  static const Color blackColor = Color(0xff101010);

  static const Color greyColor = Color(0xFF808080);
  static const Color lightGreyColor = Color(0xFFF5F5F5);

  static const Color primaryColor = Color(0xFF592086);

  static LinearGradient get gradientColor => const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [textColor, primaryColor],
    stops: [0.0, 0.86],
  );
}
