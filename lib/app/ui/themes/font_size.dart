import 'package:flutter/material.dart';

import 'colors.dart';

headText(
    {Color color = AppColors.black,
    String fontFamily = 'medium',
    double fontSize = 18.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
  );
}

regularText(
    {Color color = AppColors.black,
    double fontSize = 14,
    bool lineThrough = false}) {
  return TextStyle(
      fontFamily: 'regular',
      fontSize: fontSize,
      color: color,
      decoration: lineThrough == true ? TextDecoration.lineThrough : null);
}

boldText({Color color = AppColors.black, double fontSize = 24}) {
  return TextStyle(fontSize: fontSize, fontFamily: 'bold', color: color);
}

mediumText({Color color = AppColors.black, double fontSize = 16}) {
  return TextStyle(fontSize: fontSize, fontFamily: 'medium', color: color);
}
