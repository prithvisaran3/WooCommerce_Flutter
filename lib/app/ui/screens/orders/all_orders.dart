import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard.dart';
import '../../../controller/order.dart';
import '../../../data/model/order_by.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/loading.dart';
import '../../widgets/common/text.dart';

import '../../widgets/orders/order_tile.dart';
import 'ordersdetails_screen.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortByOptions = [
      SortBy("any", "All", "asc"),
      SortBy("processing", "Processing", "asc"),
      SortBy("completed", "Completed", "desc"),
      SortBy("cancelled", "Cancelled", "asc"),
      SortBy("failed", "Failed", "asc"),
      SortBy("pending", "Pending", "asc"),
      SortBy("refunded", "Refunded", "asc"),
      SortBy("on-hold", "On-Hold", "asc"),
    ];
    return GetBuilder(
      init: OrderController(),
      initState: (_) {
        OrderController.to.getOrders();
        OrderController.to.status = "";
        OrderController.to.orderSearch.text = "";
        OrderController.to.orderSearch.addListener(() {
          if (OrderController.to.ordersEmpty != true) {
            OrderController.to.searchOrders();
          }
        });
      },
      builder: (_) {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return OrderController.to.getOrders();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                  child: CommonText(
                    textAlign: TextAlign.start,
                    text: "My Orders",
                    style: boldText(
                      color: AppColors.primary,
                      fontSize: 24,
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
                Obx(
                  () => OrderController.to.ordersEmpty == true
                      ? const SizedBox()
                      : OrderController.to.showSearchBar == false
                          ? const SizedBox()
                          : Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                orderSearchBar(),
                                const SizedBox(
                                  width: 15,
                                ),
                                orderFilterBox(sortByOptions),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    color: AppColors.grey.withOpacity(.5),
                                    size: 100,
                                  ),
                                  CommonText(
                                    text: "Orders Empty",
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
                            ),
                          )
                        : Flexible(
                            child: ListView.builder(
                                itemCount:
                                    OrderController.to.orderDetails.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
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
                                      debugPrint(
                                          "ORDER STATUS : ${OrderController.to.orderDetails[index]['status']}");
                                      Get.to(() => OrderDetailsScreen(
                                            status:
                                                "${OrderController.to.orderDetails[index]['status']}",
                                            data: OrderController
                                                .to.orderDetails[index],
                                          ));
                                    },
                                    deletePressed: () {
                                      OrderController.to.deleteOrders(
                                          id: "${OrderController.to.orderDetails[index]['id']}");
                                    },
                                  );
                                }),
                          )),
              ],
            ),
          ),
        );
      },
    );
  }

  Flexible orderSearchBar() {
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

  Container orderFilterBox(List<SortBy> sortByOptions) {
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
            OrderController.to.status = "pending";
            OrderController.to.sort = "asc";
          } else if (data.text == "Processing") {
            OrderController.to.status = "processing";
            OrderController.to.sort = "asc";
          } else if (data.text == "Any") {
            OrderController.to.status = "any";
            OrderController.to.sort = "desc";
          } else if (data.text == "Completed") {
            OrderController.to.status = "completed";
            OrderController.to.sort = "desc";
          } else if (data.text == "Cancelled") {
            OrderController.to.status = "cancelled";
            OrderController.to.sort = "asc";
          } else if (data.text == "Refunded") {
            OrderController.to.status = "refunded";
            OrderController.to.sort = "asc";
          } else if (data.text == "Failed") {
            OrderController.to.status = "failed";
            OrderController.to.sort = "asc";
          } else if (data.text == "On-Hold") {
            OrderController.to.status = "on-hold";
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
