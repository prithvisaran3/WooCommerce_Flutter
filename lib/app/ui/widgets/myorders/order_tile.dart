import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/text.dart';

import '../../themes/colors.dart';
import '../common/common_rupee_text.dart';

class OrderPendingTile extends StatelessWidget {
  const OrderPendingTile(
      {Key? key,
      required this.orderId,
      required this.orderDate,
      required this.orderAmount,
      required this.onTap,
      required this.orderStatus})
      : super(key: key);
  final String orderId;
  final String orderDate;
  final String orderAmount;
  final String orderStatus;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
          gradient: orderStatus == "processing"
              ? LinearGradient(
                  colors: [
                    AppColors.processing,
                    AppColors.processing2,
                  ],
                )
              : orderStatus == "delivered"
                  ? LinearGradient(
                      colors: [
                        AppColors.delivered,
                        AppColors.delivered2,
                      ],
                    )
                  : LinearGradient(
                      colors: [
                        AppColors.failed,
                        AppColors.failed2,
                      ],
                    ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 1,
                    blurRadius: 1,
                  )
                ],
              ),
              child: orderStatus == "processing"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.timer_outline,
                          color: AppColors.processing,
                        ),
                        SizedBox(width: 5),
                        CommonText(
                          text: "Order processing",
                          style: boldText(
                            color: AppColors.processing,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  : orderStatus == "delivered"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Ionicons.checkmark_done,
                              color: AppColors.delivered,
                            ),
                            SizedBox(width: 5),
                            CommonText(
                              text: "Order delivered",
                              style: boldText(
                                color: AppColors.delivered,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      : orderStatus == "cancelled"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.close_circle,
                                  color: AppColors.failed,
                                ),
                                SizedBox(width: 5),
                                CommonText(
                                  text: "Order Cancelled",
                                  style: boldText(
                                    color: AppColors.failed,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.close_circle,
                                  color: AppColors.failed,
                                ),
                                SizedBox(width: 5),
                                CommonText(
                                  text: "Order Failed",
                                  style: boldText(
                                    color: AppColors.failed,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "Order ID",
                      style: boldText(
                        fontSize: 16,
                      ),
                    ),
                    CommonText(
                      text: "Order Date",
                      style: boldText(
                        fontSize: 16,
                      ),
                    ),
                    CommonText(
                      text: "Total Amount",
                      style: boldText(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: orderId,
                      style: mediumText(
                        fontSize: 16,
                      ),
                    ),
                    CommonText(
                      text: orderDate,
                      style: mediumText(
                        fontSize: 16,
                      ),
                    ),
                    RupeeText(
                      amount: orderAmount,
                      color: AppColors.black,
                      fontSize: 16,
                      type: 'medium',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Shimmer.fromColors(
              highlightColor: orderStatus == "processing"
                  ? AppColors.processing
                  : orderStatus == "delivered"
                      ? AppColors.delivered
                      : AppColors.failed,
              baseColor: Colors.black.withOpacity(0.5),
              child: CommonText(
                text: 'Click for more details',
                style: boldText(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
