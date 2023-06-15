import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steels/app/controller/coupon.dart';
import 'package:steels/app/ui/themes/colors.dart';
import 'package:steels/app/ui/themes/font_size.dart';
import 'package:steels/app/ui/widgets/common/text.dart';

class CouponTile extends StatelessWidget {
  const CouponTile(
      {Key? key,
      required this.couponCode,
      required this.onTap,
      required this.index})
      : super(key: key);
  final String couponCode;
  final Function() onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          width: Get.width,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: CouponController.to.onPressedCouponCode == index
                ? AppColors.primary
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primary,
            ),
          ),
          child: CommonText(
            text: couponCode,
            style: boldText(
              fontSize: 16,
              color: CouponController.to.onPressedCouponCode == index
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
