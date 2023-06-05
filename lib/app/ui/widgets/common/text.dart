import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText(
      {Key? key,
      required this.text,
      required this.style,
      this.textAlign = TextAlign.center, this.maxlines})
      : super(key: key);
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final int? maxlines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxlines,
      textAlign: textAlign,
      style: style,
    );
  }
}
