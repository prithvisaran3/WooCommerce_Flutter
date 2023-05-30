import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/cart/cart_item_tile.dart';
import 'package:template/app/ui/widgets/common/text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    textAlign: TextAlign.start,
                    text: "My Cart",
                    style: boldText(fontSize: 25),
                  ),
                  ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                      return CartItemTile();
                    },
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Container(
            margin: const EdgeInsets.all(15.0),
            height: 60,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
