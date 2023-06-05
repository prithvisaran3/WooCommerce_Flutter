import 'package:flutter/material.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/text.dart';

class CommonOffer extends StatelessWidget {
  const CommonOffer({Key? key, required this.discount}) : super(key: key);
  final String discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 45,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.green,
          boxShadow: [
            BoxShadow(
              color: AppColors.green.withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 1,
            )
          ]),
      child: CommonText(
        text: discount,
        style: mediumText(fontSize: 12, color: Colors.white),
      ),
    );
  }
}
