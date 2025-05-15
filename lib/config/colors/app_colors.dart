import 'package:flutter/material.dart';

class AppColors {
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF000000);

  static const Color blackColor = Color(0xff101010);

  static const Color greyColor = Color(0xFF808080);
  static const Color lightGreyColor = Color(0xFFF5F5F5);

  static const Color primaryColor = Colors.indigoAccent;

  static const Color primaryTextColor = Color.fromARGB(255, 101, 102, 104);

  static const Color secondaryTextColor = Color.fromARGB(255, 82, 81, 81);

  static LinearGradient get gradientColor => const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [textColor, primaryColor],
    stops: [0.0, 0.86],
  );
}
