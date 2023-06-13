import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/controller/order.dart';
import 'package:template/app/ui/screens/orders/review_screen.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';
import 'package:template/app/ui/widgets/common/text.dart';
import 'package:template/app/ui/widgets/delivery_status_bar.dart';

import '../../themes/colors.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({Key? key, required this.status, required this.data})
      : super(key: key);
  final String status;

  dynamic data;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: status == 'processing'
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.white,
                      AppColors.processing2,
                    ],
                  )
                : status == 'delivered' || status == 'completed'
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
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                height: Get.height * 0.55,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                      Column(
                        children: [
                          OrderDateColumn(),
                          OrderDetailsBox(),
                          SizedBox(height: 10),
                          OrderAddressBox(),
                          SizedBox(height: 10),
                          Container(
                            width: Get.width,
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
                                    CommonText(
                                      text: "Payment Status "
                                          "",
                                      style: boldText(fontSize: 16),
                                    ),
                                    data['date_paid'] != null
                                        ? CommonText(
                                            text: "Paid",
                                            style: mediumText(fontSize: 16),
                                          )
                                        : CommonText(
                                            text: "Not Paid",
                                            style: mediumText(fontSize: 16),
                                          ),
                                  ],
                                ),
                                data['date_paid'] != null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CommonText(
                                            text: "Transaction ID ",
                                            style: boldText(fontSize: 16),
                                          ),
                                          CommonText(
                                            text: "${data['transaction_id']}",
                                            style: mediumText(fontSize: 16),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Spacer(),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  // height: Get.height * 0.40,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                            "\n #${data['id']}",
                        style: boldText(
                          fontSize: 35,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: 30),
                      DeliverStatusBar(
                        status: status,
                      ),
                      status == 'processing'
                          ? Container(
                              // height: 30,
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
                          : status == 'delivered' || status == 'completed'
                              ? GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => ReviewScreen(
                                        data: data['line_items'],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    // height: 30,
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
                      CommonText(
                        text: status == 'processing'
                            ? "We are processing your order :)"
                            : status == 'delivered'
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container OrderAddressBox() {
    return Container(
      width: Get.width,
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
                "${data["shipping"]["address_1"]},${data["shipping"]["city"]},${data["shipping"]["state"]}-${data["shipping"]["postcode"]}",
            style: regularText(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Container OrderDetailsBox() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
        children: [
          ListView.builder(
              itemCount: data['line_items'].length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      text: "${data['line_items'][index]["name"]}",
                      style: mediumText(fontSize: 16),
                    ),
                    Spacer(),
                    RupeeText(
                        amount:
                            "${data['line_items'][index]["price"].toString()}",
                        color: Colors.black,
                        fontSize: 16,
                        type: 'medium'),
                    SizedBox(width: 40),
                  ],
                );
              }),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CommonText(
                    text: "SubTotal",
                    style: regularText(fontSize: 16),
                  ),
                  CommonText(
                    text: "Shipping charges",
                    style: regularText(fontSize: 16),
                  ),
                  CommonText(
                    text: "Tax",
                    style: regularText(fontSize: 16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RupeeText(
                    amount: "${data['total']}",
                    color: Colors.black,
                    fontSize: 16,
                    type: 'regular',
                  ),
                  RupeeText(
                    amount: "${data['shipping_total']}",
                    color: Colors.black,
                    fontSize: 16,
                    type: 'regular',
                  ),
                  RupeeText(
                    amount: "${data['total_tax']}",
                    color: Colors.black,
                    fontSize: 16,
                    type: 'regular',
                  ),
                  SizedBox(height: 10),
                  CommonText(
                    text: "--------",
                    style: mediumText(),
                  ),
                  RupeeText(
                    amount: "${data['total']}",
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
    );
  }

  Column OrderDateColumn() {
    return Column(
      children: [
        CommonText(
          text: status == 'processing'
              ? "Expected Delivery "
              : status == 'delivered' || status == 'completed'
                  ? "Delivered"
                  : "Delivery Failed",
          style: boldText(
            color: status == 'processing'
                ? AppColors.processing
                : status == 'delivered' || status == 'completed'
                    ? AppColors.delivered
                    : AppColors.failed,
            fontSize: 25,
          ),
        ),
        CommonText(
          text: status == 'processing'
              ? "1st April"
              : status == 'delivered' || status == 'completed'
                  ? "3rd April"
                  : " 1st April (Expected)",
          style: boldText(
            color: Colors.black,
            fontSize: 38,
          ),
        ),
      ],
    );
  }
}
