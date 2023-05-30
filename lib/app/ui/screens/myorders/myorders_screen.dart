import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/controller/myorders.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/text.dart';
import 'package:template/app/ui/widgets/myorders/order_pending_tile.dart';

import '../../widgets/myorders/order_delivered_tile.dart';
import '../../widgets/myorders/order_failed_tile.dart';
import 'myordersdetails_screen.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        children: [
          //heading
          CommonText(
            textAlign: TextAlign.start,
            text: "My Orders",
            style: boldText(
              color: AppColors.primary,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 10),
          //myordertile
          OrderPendingTile(
            orderId: '123456',
            orderDate: '26th July,2023',
            orderAmount: '24,000',
            onTap: () {
              MyOrderController.to.orderStatus = 'p';
              Get.to(() => OrderDetailsScreen());
            },
          ),
          OrderDeliveredTile(
            orderId: '123456',
            orderDate: '26th July,2023',
            orderAmount: '24,000',
            onTap: () {
              MyOrderController.to.orderStatus = 'd';
              Get.to(() => OrderDetailsScreen());
            },
          ),
          OrderFailedTile(
            orderId: '123456',
            orderDate: '26th July,2023',
            orderAmount: '24,000',
            onTap: () {
              MyOrderController.to.orderStatus = 'f';
              Get.to(() => OrderDetailsScreen());
            },
          ),
        ],
      ),
    );
  }
}
