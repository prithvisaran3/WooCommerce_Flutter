import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/text.dart';

import '../../../controller/wish_list.dart';
import '../common/button.dart';

class WishlistItemTile extends StatelessWidget {
  const WishlistItemTile(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.mrpCost,
      required this.saleCost,
      required this.onTap})
      : super(key: key);
  final String imageUrl;
  final String name;
  final String mrpCost;
  final String saleCost;
  final Function() onTap;

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
                      imageUrl,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(text: name, style: boldText(fontSize: 18)),
                    Row(
                      children: [
                        CommonText(
                            text: "Rs.", style: regularText(fontSize: 13)),
                        CommonText(
                            text: mrpCost,
                            style:
                                regularText(fontSize: 13, lineThrough: true)),
                        SizedBox(
                          width: 5,
                        ),
                        CommonText(
                            text: saleCost, style: boldText(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                alignment: Alignment.center,
                height: 35,
                child: CommonButton(
                  text: "Move to Cart",
                  onTap: onTap,
                ),
              )
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
