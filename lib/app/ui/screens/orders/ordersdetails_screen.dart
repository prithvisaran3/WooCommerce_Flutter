import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/controller/order.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';
import 'package:template/app/ui/widgets/common/text.dart';
import 'package:template/app/ui/widgets/delivery_status_bar.dart';

import '../../themes/colors.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen(
      {Key? key, required this.status, required this.index})
      : super(key: key);
  final String status;
  final int index;

  @override
  Widget build(BuildContext context) {
    var OrderList = <dynamic>[];
    return GetBuilder(
        init: OrderController(),
        initState: (_) {
          OrderController.to.getOrders();
          OrderList = OrderController.to.orderDetails[index]['line_items'];
          print("ORDER LIST ${OrderList}");
        },
        builder: (_) {
          return SafeArea(
            child: Scaffold(
              body: Obx(
                () => Container(
                  height: Get.height,
                  width: Get.width,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: OrderController.to.orderStatus == 'processing'
                        ? LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.white,
                              AppColors.processing2,
                            ],
                          )
                        : OrderController.to.orderStatus == 'delivered'
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
                        // height: Get.height * 0.45,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CommonText(
                                text: OrderController.to.orderStatus ==
                                        'processing'
                                    ? "Expected Delivery "
                                    : OrderController.to.orderStatus ==
                                            'delivered'
                                        ? "Delivered"
                                        : "Delivery Failed",
                                style: boldText(
                                  color: OrderController.to.orderStatus ==
                                          'processing'
                                      ? AppColors.processing
                                      : OrderController.to.orderStatus ==
                                              'delivered'
                                          ? AppColors.delivered
                                          : AppColors.failed,
                                  fontSize: 25,
                                ),
                              ),
                              CommonText(
                                text: OrderController.to.orderStatus ==
                                        'processing'
                                    ? "1st April"
                                    : OrderController.to.orderStatus ==
                                            'delivered'
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
                                    ListView.builder(
                                        itemCount: OrderList.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, int index) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CommonText(
                                                text:
                                                    "${OrderList[index]["name"]}",
                                                style: mediumText(fontSize: 16),
                                              ),
                                              Spacer(),
                                              RupeeText(
                                                  amount:
                                                      "${OrderList[index]["price"].toString()}",
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  type: 'medium'),
                                              SizedBox(width: 40),
                                            ],
                                          );
                                        }),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RupeeText(
                                              amount:
                                                  "${OrderController.to.orderDetails[index]['total_tax']}",
                                              color: Colors.black,
                                              fontSize: 16,
                                              type: 'regular',
                                            ),
                                            RupeeText(
                                              amount:
                                                  "${OrderController.to.orderDetails[index]['shipping_total']}",
                                              color: Colors.black,
                                              fontSize: 16,
                                              type: 'regular',
                                            ),
                                            RupeeText(
                                              amount:
                                                  "${OrderController.to.orderDetails[index]['total_tax']}",
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
                                              amount:
                                                  "${OrderController.to.orderDetails[index]['total']}",
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
                                          "${OrderController.to.orderDetails[index]["shipping"]["address_1"]},${OrderController.to.orderDetails[index]["shipping"]["city"]},${OrderController.to.orderDetails[index]["shipping"]["state"]}-${OrderController.to.orderDetails[index]["shipping"]["postcode"]}",
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
                                  "\n #${OrderController.to.orderDetails[index]['id']}",
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
                            OrderController.to.orderStatus == 'processing'
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
                                : OrderController.to.orderStatus == 'delivered'
                                    ? Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(2),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 70, vertical: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                              text:
                                  OrderController.to.orderStatus == 'processing'
                                      ? "We are processing your order :)"
                                      : OrderController.to.orderStatus ==
                                              'delivered'
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
        });
  }
}
