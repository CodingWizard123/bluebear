import 'package:flutter/material.dart';

class Responsive {
  static double responsiveWidth(BuildContext context, double widthRatio) {
    return MediaQuery.of(context).size.width * widthRatio;
  }

  static double responsiveHeight(BuildContext context, double heightRatio) {
    return MediaQuery.of(context).size.height * heightRatio;
  }

  static double responsiveSize(BuildContext context, double sizeRatio) {
    return MediaQuery.of(context).size.height *
        MediaQuery.of(context).size.width *
        sizeRatio;
  }
}
