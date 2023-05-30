import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';

import '../../../controller/wish_list.dart';
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
          color: AppColors.secondary,
          gradient: LinearGradient(colors: [
            AppColors.primary,
            AppColors.secondary,
          ]),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Spacer(),
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
          Spacer(),
          Obx(
            () => GestureDetector(
              onTap: () {
                WishListController.to.isWishlistItem =
                    !WishListController.to.isWishlistItem;
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Icon(
                  WishListController.to.isWishlistItem == false
                      ? Icons.favorite_outline
                      : Icons.favorite_outlined,
                  color: WishListController.to.isWishlistItem == false
                      ? AppColors.white
                      : AppColors.red,
                ),
              ),
            ),
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
                text: "Add to Cart",
                style: mediumText(color: Colors.white),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
