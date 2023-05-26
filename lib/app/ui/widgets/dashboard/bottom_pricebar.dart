import 'package:flutter/material.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';

import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/text.dart';

class BottomPriceBar extends StatelessWidget {
  const BottomPriceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RupeeText(
                amount: "13,700",
                color: Colors.white,
                fontSize: 25,
                type: 'bold',
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.black,
              ),
              child: CommonText(
                text: "Add to Bag",
                style: mediumText(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
