import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/controller/auth.dart';
import 'package:template/app/controller/cart.dart';
import 'package:template/app/controller/dashboard.dart';
import 'package:template/app/controller/payment.dart';
import 'package:template/app/data/model/cart/req.dart';
import 'package:template/app/ui/widgets/common/button.dart';
import 'package:template/app/ui/widgets/common/loading.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/cart/cart_item_tile.dart';
import '../../widgets/common/common_rupee_text.dart';
import '../../widgets/common/text.dart';
import '../payment/payment.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  Product product = Product();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CartController(),
      initState: (_) {
        CartController.to.getCart();
      },
      builder: (_) {
        return Stack(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 60),
                child: Obx(
                  () => CartController.to.getCartLoading == true
                      ? const SimpleLoading()
                      : CartController.to.cartEmpty == true
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    color: AppColors.grey.withOpacity(.5),
                                    size: 100,
                                  ),
                                  CommonText(
                                    text: "Cart Empty",
                                    style: mediumText(
                                        fontSize: 16,
                                        color: AppColors.grey.withOpacity(.6)),
                                  ),
                                  const SizedBox(height: 10),
                                  CommonButton(
                                    text: "Got to Shop",
                                    onTap: () {
                                      HomeController.to.selectedIndex = 0;
                                    },
                                    fontColor: AppColors.white,
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: CartController.to.cartDetails.length,
                              shrinkWrap: true,
                              itemBuilder: (context, int index) {
                                cartTotal();

                                return CartItemContainer(
                                  name:
                                      "${CartController.to.cartDetails[index]['product_name']}",
                                  regularPrice:
                                      "${CartController.to.cartDetails[index]['product_regular_price']}",
                                  salePrice:
                                      "${CartController.to.cartDetails[index]['product_sale_price']}",
                                  image:
                                      "${CartController.to.cartDetails[index]['thumbnail']}",
                                  count: CartController.to.cartDetails[index]
                                      ['qty'],
                                  onChanged: (data) {
                                    CartController.to.updateQty(
                                        productId: CartController.to
                                            .cartDetails[index]['product_id'],
                                        qty: data);
                                  },
                                  deletePressed: () {
                                    CartController.to.addCart(
                                        productId: CartController.to
                                            .cartDetails[index]['product_id'],
                                        qty: 2,
                                        userId: 26);
                                  },
                                );
                              },
                            ),
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: CommonText(
                textAlign: TextAlign.start,
                text: "My Cart",
                style: boldText(fontSize: 20),
              ),
            ),
            Obx(
              () => CartController.to.cartEmpty == true
                  ? const SizedBox()
                  : Positioned(
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
                                    style: mediumText(
                                        fontSize: 16, color: AppColors.white)),
                                CommonText(
                                    text: "Total Qty",
                                    style: mediumText(
                                        fontSize: 16, color: AppColors.white))
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
                                    style: mediumText(
                                        fontSize: 16, color: AppColors.white)),
                                CommonText(
                                    text: ":",
                                    style: mediumText(
                                        fontSize: 16, color: AppColors.white))
                              ],
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RupeeText(
                                    amount: "${cartTotal()}",
                                    color: AppColors.white,
                                    fontSize: 16,
                                    type: 'bold'),
                                CommonText(
                                    text:
                                        "${CartController.to.cartDetails.length}",
                                    style: mediumText(
                                        fontSize: 16, color: AppColors.white))
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                // CartController.to.getCart();
                                Get.to(() => PaymentMethodScreen());
                                // PaymentController.to.getPaymentGateways();
                                // CartController.to.addCart(productId: 5737);
                                // CartController.to
                                //     .updateQty(productId: 5737, qty: 1);
                                // AuthController.to.login();
                                // CartController.to.addCart(
                                // //     productId: 5737, qty: 2, userId: "26");
                                // print(
                                //     "${CartController.to.cartDetails.map((e){
                                //       print("productId: ${e['product_id']}");
                                //       print("quantity: ${e['qty']}");
                                //       print("variationId: ${e['variation_id']}");
                                //
                                //     })}");
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
            )
          ],
        );
      },
    );
  }

  cartTotal() {
    dynamic amount;
    if (CartController.to.cartDetails.isNotEmpty) {
      if (CartController.to.cartDetails.map((e) => e['line_subtotal']).length >
          1) {
        amount = CartController.to.cartDetails
            .map((e) => e['line_subtotal'])
            .reduce((key, value) {
          return key + value;
        });
      } else {
        amount = CartController.to.cartDetails
            .map((e) => e['line_subtotal'])
            .reduce((key, value) {
          return value;
        });
      }

      debugPrint("Total amount is $amount");
      return amount;
    }
  }
}
