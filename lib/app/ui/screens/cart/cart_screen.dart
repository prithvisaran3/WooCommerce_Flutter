import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/controller/cart.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/cart/cart_item_container.dart';
import '../../widgets/common/common_rupee_text.dart';
import '../../widgets/common/text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 60),
          child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, int index) {
              return CartItemContainer(
                name: "Plate",
                amount: "522",
                image:
                    "https://rukminim1.flixcart.com/image/416/416/l4hcx3k0/plate-tray-dish/r/n/0/designer-heavy-gauge-4-dinner-plate-leroyal-original-imagfdqzptbz2zch.jpeg?q=70",
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: CommonText(
            textAlign: TextAlign.start,
            text: "My Cart",
            style: boldText(fontSize: 20),
          ),
        ),
        Positioned(
          bottom: -15,
          right: 0,
          left: 0,
          child: Container(
            margin: const EdgeInsets.all(15.0),
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary]),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                        text: "Total",
                        style:
                            mediumText(fontSize: 16, color: AppColors.white)),
                    CommonText(
                        text: "Total Qty",
                        style: mediumText(fontSize: 16, color: AppColors.white))
                  ],
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                        text: ":",
                        style:
                            mediumText(fontSize: 16, color: AppColors.white)),
                    CommonText(
                        text: ":",
                        style: mediumText(fontSize: 16, color: AppColors.white))
                  ],
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RupeeText(
                        amount: "1400",
                        color: AppColors.white,
                        fontSize: 16,
                        type: 'bold'),
                    CommonText(
                        text: "5",
                        style: mediumText(fontSize: 16, color: AppColors.white))
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    CartController.to.getCart();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        right: 20, left: 20, bottom: 10, top: 10),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.white),
                    child: CommonText(
                      text: "Pay",
                      style: mediumText(fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
