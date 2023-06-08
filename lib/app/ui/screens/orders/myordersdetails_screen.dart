import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';
import 'package:template/app/ui/widgets/common/text.dart';
import 'package:template/app/ui/widgets/delivery_status_bar.dart';

import '../../../controller/myorders.dart';
import '../../themes/colors.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Container(
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: MyOrderController.to.orderStatus == 'p'
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.white,
                        AppColors.pending2,
                      ],
                    )
                  : MyOrderController.to.orderStatus == 'd'
                      ? LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.white,
                            AppColors.delivered2,
                          ],
                        )
                      : LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.white,
                            AppColors.failed2,
                          ],
                        ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 1,
                            blurRadius: 1,
                          )
                        ],
                      ),
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Ionicons.close)),
                    ),
                  ],
                ),
                Container(
                  height: Get.height * 0.47,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CommonText(
                          text: MyOrderController.to.orderStatus == 'p'
                              ? "Expected Delivery "
                              : MyOrderController.to.orderStatus == 'd'
                                  ? "Delivered"
                                  : "Delivery Failed",
                          style: boldText(
                            color: MyOrderController.to.orderStatus == 'p'
                                ? AppColors.pending
                                : MyOrderController.to.orderStatus == 'd'
                                    ? AppColors.delivered
                                    : AppColors.failed,
                            fontSize: 25,
                          ),
                        ),
                        CommonText(
                          text: MyOrderController.to.orderStatus == 'p'
                              ? "1st April"
                              : MyOrderController.to.orderStatus == 'd'
                                  ? "3rd April"
                                  : " 1st April (Expected)",
                          style: boldText(
                            color: Colors.black,
                            fontSize: 38,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      CommonText(
                                        text: "Steel plate",
                                        style: mediumText(),
                                      ),
                                      CommonText(
                                        text: "BenQ Gaming Monitor",
                                        style: mediumText(),
                                      ),
                                      SizedBox(height: 10),
                                      CommonText(
                                        text: "CGST (10%)",
                                        style: mediumText(),
                                      ),
                                      CommonText(
                                        text: "GST (10%)",
                                        style: mediumText(),
                                      ),
                                      CommonText(
                                        text: "Shipping charges",
                                        style: mediumText(),
                                      ),
                                      SizedBox(height: 30),
                                      CommonText(
                                        text: "Total",
                                        style: boldText(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RupeeText(
                                        amount: "2,000",
                                        color: Colors.black,
                                        fontSize: 16,
                                        type: 'medium',
                                      ),
                                      RupeeText(
                                        amount: "48,000",
                                        color: Colors.black,
                                        fontSize: 16,
                                        type: 'medium',
                                      ),
                                      SizedBox(height: 10),
                                      RupeeText(
                                        amount: "5,000",
                                        color: Colors.black,
                                        fontSize: 16,
                                        type: 'medium',
                                      ),
                                      RupeeText(
                                        amount: "5,000",
                                        color: Colors.black,
                                        fontSize: 16,
                                        type: 'medium',
                                      ),
                                      RupeeText(
                                        amount: "500",
                                        color: Colors.black,
                                        fontSize: 16,
                                        type: 'medium',
                                      ),
                                      SizedBox(height: 10),
                                      CommonText(
                                        text: "--------",
                                        style: mediumText(),
                                      ),
                                      RupeeText(
                                        amount: "60,500",
                                        color: Colors.black,
                                        fontSize: 16,
                                        type: 'bold',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Column(
                            children: [
                              CommonText(
                                text: "Delivery Address",
                                style: boldText(fontSize: 16),
                              ),
                              CommonText(
                                text:
                                    "485/1. Vadivu Nagar, Chettipalayam Road, Podanur, Coimbatore, Tamil Nadu 641023",
                                style: regularText(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(8),
                  // margin: EdgeInsets.all(8),
                  height: Get.height * 0.40,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 1,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      CommonText(
                        text: "Order Number"
                            "\n #123456",
                        style: boldText(
                          fontSize: 40,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: DeliverStatusBar(),
                      ),
                      MyOrderController.to.orderStatus == 'p'
                          ? Container(
                              height: 30,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: CommonText(
                                text: "Track your order",
                                style: regularText(fontSize: 16),
                              ),
                            )
                          : MyOrderController.to.orderStatus == 'd'
                              ? Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(2),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 70, vertical: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: CommonText(
                                    text: "Rate your order",
                                    style: regularText(fontSize: 16),
                                  ),
                                )
                              : Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(2),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 70, vertical: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: CommonText(
                                    text: "Order again",
                                    style: regularText(fontSize: 16),
                                  ),
                                ),
                      Spacer(),
                      CommonText(
                        text: MyOrderController.to.orderStatus == 'p'
                            ? "We are processing your order :)"
                            : MyOrderController.to.orderStatus == 'd'
                                ? "Thank you for shopping with us :)"
                                : "Delivery Unsuccessful :(",
                        style: mediumText(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonText(
                            text: "Need assistance?",
                            style: mediumText(),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {},
                            child: CommonText(
                              text: "Contact us",
                              style: boldText(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
