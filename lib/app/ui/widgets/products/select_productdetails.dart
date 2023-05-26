import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/product.dart';

import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/text.dart';

class ProductOptionsCard extends StatelessWidget {
  const ProductOptionsCard(
      {Key? key,
      required this.selectTitle,
      required this.onTap,
      required this.index})
      : super(key: key);
  final String selectTitle;
  final Function() onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          height: 32,
          width: Get.width * 0.24,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: ProductController.to.selectIndex == index
                ? AppColors.primary
                : AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.18),
                spreadRadius: 0,
                blurRadius: 2,
              ),
            ],
          ),
          child: CommonText(
            text: selectTitle,
            style: ProductController.to.selectIndex == index
                ? boldText(color: AppColors.white, fontSize: 15)
                : regularText(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
