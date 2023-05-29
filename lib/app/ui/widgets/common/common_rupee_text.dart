import 'package:flutter/material.dart';
import 'package:template/app/ui/widgets/common/text.dart';

import '../../themes/font_size.dart';

class RupeeText extends StatelessWidget {
  const RupeeText(
      {Key? key,
      required this.amount,
      required this.color,
      required this.fontSize,
      required this.type,
      this.textDecoration})
      : super(key: key);
  final String amount;
  final Color color;
  final double fontSize;
  final String type;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          type == 'bold' ? "\u20B9" : "\₹",
          style: TextStyle(
              decoration: textDecoration,
              color: color,
              fontSize: fontSize,
              fontWeight: type == 'regular'
                  ? FontWeight.normal
                  : type == 'medium'
                      ? FontWeight.w500
                      : FontWeight.bold),
        ),
        Text(
          amount,
          style: TextStyle(
              fontFamily: type == 'regular'
                  ? 'regular'
                  : type == 'medium'
                      ? 'medium'
                      : 'bold',
              decoration: textDecoration,
              color: color,
              fontSize: fontSize,
              fontWeight: type == 'regular'
                  ? FontWeight.normal
                  : type == 'medium'
                      ? FontWeight.w500
                      : FontWeight.bold),
        )
      ],
    );
  }
}
