import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:steels/app/ui/themes/colors.dart';
import 'package:steels/app/ui/themes/font_size.dart';
import 'package:steels/app/ui/widgets/common/common_rupee_text.dart';
import 'package:steels/app/ui/widgets/common/text.dart';

import '../../../controller/wish_list.dart';
import '../common/button.dart';

class WishlistItemTile extends StatelessWidget {
  const WishlistItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
              color: AppColors.grey.withOpacity(.3),
              spreadRadius: 1,
              blurRadius: 1)
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.grey.withOpacity(.3),
                          spreadRadius: 1,
                          blurRadius: 1)
                    ],
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://rukminim1.flixcart.com/image/416/416/l4hcx3k0/plate-tray-dish/r/n/0/designer-heavy-gauge-4-dinner-plate-leroyal-original-imagfdqzptbz2zch.jpeg?q=70"))),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                        text: "Steel Plate", style: boldText(fontSize: 18)),
                    Row(
                      children: [
                        CommonText(
                            text: "Rs.", style: regularText(fontSize: 13)),
                        CommonText(
                            text: "1100",
                            style:
                                regularText(fontSize: 13, lineThrough: true)),
                        SizedBox(
                          width: 5,
                        ),
                        CommonText(
                            text: "Rs. 1530", style: boldText(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  height: 35,
                  child: CommonButton(text: "Move to Cart", onTap: () {}))
            ],
          ),
          Obx(
            () => Positioned(
              right: 5,
              top: 5,
              child: GestureDetector(
                onTap: () {
                  WishListController.to.isWishlistItem =
                      !WishListController.to.isWishlistItem;
                },
                child: Icon(
                  WishListController.to.isWishlistItem == false
                      ? Icons.favorite_outline
                      : Icons.favorite_outlined,
                  color: WishListController.to.isWishlistItem == false
                      ? AppColors.primary
                      : AppColors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
