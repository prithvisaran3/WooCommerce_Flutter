import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steels/app/controller/dashboard.dart';
import 'package:steels/app/ui/widgets/common/loading.dart';
import '../../../controller/cart.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../cart_add_remove.dart';
import '../common/common_rupee_text.dart';
import '../common/text.dart';

class BottomPriceBar extends StatelessWidget {
  const BottomPriceBar(
      {Key? key,
      required this.amount,
      required this.productId,
      required this.isOutOfStock})
      : super(key: key);
  final String amount;
  final String productId;
  final String isOutOfStock;

  @override
  Widget build(BuildContext context) {
    dynamic quantity;
    return Container(
      margin: const EdgeInsets.all(15),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => RupeeText(
                    amount: CartController.to.quantityUpdateAmount != 0
                        ? "${CartController.to.quantityUpdateAmount}"
                        : amount,
                    color: Colors.white,
                    fontSize: 25,
                    type: 'bold',
                  ))
            ],
          ),
          const Spacer(),
          CartAddRemove(
            lowerLimit: 0,
            upperLimit: 1000,
            stepValue: 1,
            iconSize: 22,
            value: 1,
            onChanged: (data) {
              quantity = data;
              CartController.to.quantityUpdateAmount = data * int.parse(amount);
            },
          ),
          const Spacer(),
          isOutOfStock == "outofstock"
              ? CommonText(
                  text: "OUT OF STOCK",
                  style: boldText(color: AppColors.white, fontSize: 14),
                )
              : Obx(
                  () => CartController.to.addToCartLoading == true
                      ? SimpleLoading(
                          color: AppColors.white,
                        )
                      : GestureDetector(
                          onTap: CartController.to.isMoveToCart == true
                              ? () {
                                  Get.back();
                                  HomeController.to.selectedIndex = 1;
                                }
                              : () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  var id = pref.getString('userId');
                                  await CartController.to.addCartMap.addAll({
                                    "user_id": "$id",
                                    "products": [
                                      {
                                        'product_id': productId,
                                        'quantity': quantity ?? 1
                                      }
                                    ]
                                  });
                                  debugPrint(
                                      "add product details : ${CartController.to.addCartMap}");
                                  debugPrint(
                                      "Product amount is : ${CartController.to.quantityUpdateAmount == 0 ? amount : CartController.to.quantityUpdateAmount}");
                                  CartController.to.addCart();
                                },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.black,
                            ),
                            child: CommonText(
                              text: CartController.to.isMoveToCart == false
                                  ? "Add to Cart"
                                  : "Move to Cart",
                              style: mediumText(color: Colors.white),
                            ),
                          ),
                        ),
                ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
