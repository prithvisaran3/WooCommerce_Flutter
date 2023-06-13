import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/widgets/common/text.dart';

import '../../../controller/payment.dart';
import '../../themes/font_size.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile(
      {Key? key, required this.text, required this.onTap, required this.index})
      : super(key: key);
  final String text;
  final Function() onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
            () => Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: PaymentController.to.onPressedPaymentMethod == index
                ? AppColors.primary
                : Colors.white,
            border: Border.all(
              color: AppColors.primary,
            ),
          ),
          child: CommonText(
            text: text,
            style: PaymentController.to.onPressedPaymentMethod == index
                ? boldText(
              fontSize: 14,
              color: AppColors.white,
            )
                : regularText(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}