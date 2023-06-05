import 'package:flutter/material.dart';
import 'package:template/app/controller/product.dart';

class ReadMoreText extends StatelessWidget {
  const ReadMoreText({Key? key, required this.textStyle, required this.onTap})
      : super(key: key);
  final TextStyle textStyle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        ProductController.to.isReadMore == true ? "Read less" : "Read more",
        style: textStyle,
      ),
    );
  }
}
