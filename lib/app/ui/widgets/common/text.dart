import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText(
      {Key? key,
      required this.text,
      required this.style,
      this.textAlign = TextAlign.center})
      : super(key: key);
  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: style,
    );
  }
}
