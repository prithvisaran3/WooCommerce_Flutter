import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/order.dart';
import '../../../data/model/order_by.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/common/loading.dart';
import '../../widgets/common/text.dart';

import '../../widgets/orders/order_tile.dart';
import 'ordersdetails_screen.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortByOptions = [
      SortBy("any", "Any", "asc"),
      SortBy("processing", "Processing", "asc"),
      SortBy("completed", "Completed", "desc"),
      SortBy("cancelled", "Cancelled", "asc"),
      SortBy("failed", "Failed", "asc"),
      SortBy("pending", "Pending", "asc"),
      SortBy("refunded", "Refunded", "asc"),
      SortBy("on-hold", "On-Hold", "asc"),
    ];
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
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  OrderSearchBar(),
                  const SizedBox(
                    width: 15,
                  ),
                  OrderFilterBox(sortByOptions),
                  const SizedBox(
                    width: 10,
                  ),
                ],
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
                              itemCount: OrderController.to.orderDetails.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                print(
                                    "ORDER STATUS : ${OrderController.to.orderDetails[index]['status']}");
                                return OrdersTile(
                                  orderId:
                                      "${OrderController.to.orderDetails[index]['id']}",
                                  orderDate:
                                      "${OrderController.to.orderDetails[index]['date_created']}",
                                  orderAmount:
                                      "${OrderController.to.orderDetails[index]['total']}",
                                  orderStatus: OrderController
                                      .to.orderDetails[index]['status'],
                                  onTap: () {
                                    print(
                                        "ORDER STATUS : ${OrderController.to.orderDetails[index]['status']}");
                                    Get.to(() => OrderDetailsScreen(
                                          status:
                                              "${OrderController.to.orderDetails[index]['status']}",
                                          data: OrderController
                                              .to.orderDetails[index],
                                        ));
                                  },
                                );
                              }),
                        )),
            ],
          ),
        );
      },
    );
  }

  Flexible OrderSearchBar() {
    return Flexible(
      child: TextField(
        controller: OrderController.to.orderSearch,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "Search",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.0),
            ),
            fillColor: const Color(0xffe6e6ec),
            filled: true),
      ),
    );
  }

  Container OrderFilterBox(List<SortBy> sortByOptions) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          color: const Color(0xffe6e6ec)),
      child: PopupMenuButton(
        elevation: 5,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onSelected: (data) {
          if (data.text == "Pending") {
            OrderController.to.orderBy = "pending";
            OrderController.to.sort = "asc";
          } else if (data.text == "Processing") {
            OrderController.to.orderBy = "processing";
            OrderController.to.sort = "asc";
          } else if (data.text == "Any") {
            OrderController.to.orderBy = "any";
            OrderController.to.sort = "asc";
          } else if (data.text == "Completed") {
            OrderController.to.orderBy = "completed";
            OrderController.to.sort = "desc";
          } else if (data.text == "Cancelled") {
            OrderController.to.orderBy = "cancelled";
            OrderController.to.sort = "asc";
          } else if (data.text == "Refunded") {
            OrderController.to.orderBy = "refunded";
            OrderController.to.sort = "asc";
          } else if (data.text == "Failed") {
            OrderController.to.orderBy = "failed";
            OrderController.to.sort = "asc";
          } else if (data.text == "On-Hold") {
            OrderController.to.orderBy = "on-hold";
            OrderController.to.sort = "asc";
          }

          OrderController.to.getOrders();
        },
        itemBuilder: (context) {
          return sortByOptions.map((e) {
            return PopupMenuItem(value: e, child: Text(e.text));
          }).toList();
        },
        icon: const Icon(Icons.tune),
      ),
    );
  }
}
