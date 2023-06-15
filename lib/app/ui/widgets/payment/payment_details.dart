import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/widgets/common/toast.dart';
import '../../../controller/cart.dart';
import '../../../controller/payment.dart';
import '../../../payment/razorpay.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/button.dart';
import '../common/common_rupee_text.dart';
import '../common/text.dart';

class PaymentDetailsBox extends StatelessWidget {
  const PaymentDetailsBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      width: Get.width,
      padding: const EdgeInsets.all(8),
      // margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            CommonText(text: "Price Details", style: mediumText(fontSize: 16)),
            ListView.builder(
              itemCount: CartController.to.cartDetails.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {
                return Row(
                  children: [
                    CommonText(
                        text:
                            "${CartController.to.cartDetails[index]['product_name']}",
                        style: regularText(fontSize: 14)),
                    const Spacer(),
                    CommonText(
                        text:
                            "Rs ${CartController.to.cartDetails[index]['product_sale_price']}",
                        style: mediumText(fontSize: 14)),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            // Row(
            //   children: [
            //     CommonText(
            //       text: "GST (18%)",
            //       style: regularText(fontSize: 15, color: AppColors.black),
            //     ),
            //     Spacer(),
            //     CommonText(
            //       text: "Rs. 800.04",
            //       style: mediumText(fontSize: 15, color: AppColors.black),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     CommonText(
            //       text: "Discount",
            //       style: regularText(fontSize: 15, color: AppColors.green),
            //     ),
            //     Spacer(),
            //     CommonText(
            //       text: "Rs. 500",
            //       style: mediumText(fontSize: 15, color: AppColors.green),
            //     ),
            //   ],
            // ),
            Row(
              children: [
                CommonText(
                  text: "Delivery Fees",
                  style: regularText(
                    fontSize: 15,
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
                CommonText(
                  text: "Free",
                  style: boldText(
                    fontSize: 15,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: AppColors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CommonText(
                  text: "TOTAL",
                  style: boldText(
                    color: Colors.black,
                  ),
                ),
                // SizedBox(width: 10),
                CommonText(
                  text: ":",
                  style: mediumText(
                    color: Colors.black,
                  ),
                ),
                // SizedBox(width: 10),
                Column(
                  children: [
                    RupeeText(
                      amount: "Rs ${CartController.to.cartTotalAmount}",
                      color: AppColors.primary,
                      fontSize: 24,
                      type: "bold",
                    ),
                    CommonText(
                      text: "(inc of all taxes)",
                      style: mediumText(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
                width: Get.width,
                margin: const EdgeInsets.all(10.0),
                child: CommonButton(
                    text: "Pay",
                    onTap: () {
                      if (PaymentController.to.paymentMethod == "razorpay") {
                        RazorPaymentService payment = RazorPaymentService();
                        payment.initPaymentGateway();
                        payment.getPayment(context,
                            amount: CartController.to.cartTotalAmount,
                            name: PaymentController.to.bFName.text,
                            email: PaymentController.to.bEmail.text,
                            phone: PaymentController.to.bPhone.text);
                      } else if (PaymentController.to.paymentMethod ==
                          "wallet") {
                        commonToast(msg: "Wallet option now disabled");
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
