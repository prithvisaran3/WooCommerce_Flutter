import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/order.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/common/loading.dart';
import '../../widgets/common/text.dart';
import '../../widgets/myorders/order_tile.dart';
import 'ordersdetails_screen.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderController.to.getOrders();
    return GetBuilder(
        init: OrderController(),
        initState: (_) {
          OrderController.to.getOrders();
        },
        builder: (_) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CommonText(
                    textAlign: TextAlign.start,
                    text: "My Orders",
                    style: boldText(
                      color: AppColors.primary,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Obx(() => OrderController.to.getOrdersLoading == true
                    ? const SimpleLoading()
                    : OrderController.to.ordersEmpty == true
                        ? Padding(
                            padding: EdgeInsets.only(top: Get.height / 4),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.hourglass_empty_outlined,
                                    size: 80,
                                    color: AppColors.primary.withOpacity(.3),
                                  ),
                                  CommonText(
                                      text: "Orders Empty",
                                      style: regularText(fontSize: 16))
                                ],
                              ),
                            ),
                          )
                        : Flexible(
                            child: ListView.builder(
                                itemCount:
                                    OrderController.to.orderDetails.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  print(
                                      "ORDER STATUS : ${OrderController.to.orderDetails[index]['status']}");
                                  return OrderPendingTile(
                                    orderId:
                                        "${OrderController.to.orderDetails[index]['id']}",
                                    orderDate:
                                        "${OrderController.to.orderDetails[index]['date_created']}",
                                    orderAmount:
                                        "${OrderController.to.orderDetails[index]['total']}",
                                    orderStatus: OrderController
                                        .to.orderDetails[index]['status'],
                                    onTap: () {
                                      Get.to(() => OrderDetailsScreen(
                                            status:
                                                "${OrderController.to.orderDetails[index]['status']}",
                                            index: index,
                                          ));
                                    },
                                  );
                                }),
                          )),
                //myordertile

                // OrderDeliveredTile(
                //   orderId: '123456',
                //   orderDate: '26th July,2023',
                //   orderAmount: '24,000',
                //   onTap: () {
                //     MyOrderController.to.orderStatus = 'd';
                //     Get.to(() => OrderDetailsScreen());
                //   },
                // ),
                // OrderFailedTile(
                //   orderId: '123456',
                //   orderDate: '26th July,2023',
                //   orderAmount: '24,000',
                //   onTap: () {
                //     MyOrderController.to.orderStatus = 'f';
                //     Get.to(() => OrderDetailsScreen());
                //   },
                // ),
              ],
            ),
          );
        });
  }
}
