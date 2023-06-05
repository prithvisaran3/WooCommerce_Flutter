import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';

import '../../../controller/wish_list.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../cart_add_remove.dart';
import '../common/text.dart';

class BottomPriceBar extends StatelessWidget {
  const BottomPriceBar({Key? key, required this.amount, required this.onTap})
      : super(key: key);
  final String amount;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.secondary,
          gradient: LinearGradient(colors: [
            AppColors.primary,
            AppColors.secondary,
          ]),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SizedBox(width: 1),

          RupeeText(
            amount: amount,
            color: Colors.white,
            fontSize: 28,
            type: 'bold',
          ),
          // Spacer(),
          CartAddRemove(
              value: 0,
              lowerLimit: 0,
              upperLimit: 1000,
              stepValue: 1,
              iconSize: 22,
              onChanged: (data) {}),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.black,
              ),
              child: CommonText(
                text: "Add to Cart",
                style: mediumText(color: Colors.white),
              ),
            ),
          ),
          // SizedBox(width: 1),
        ],
      ),
    );
  }
}
