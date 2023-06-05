import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/common_rupee_text.dart';
import '../common/text.dart';

class PayNowTile extends StatelessWidget {
  const PayNowTile({
    Key? key,
    required this.Tquantity,
    required this.Tcost,
    required this.onPayTap,
    required this.Tsaved,
  }) : super(key: key);
  final String Tquantity;
  final String Tcost;
  final String Tsaved;
  final Function() onPayTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      // height: 60,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  CommonText(
                    text: "Quantity",
                    style: regularText(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  CommonText(
                    text: "Price",
                    style: regularText(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  CommonText(
                    text: "Saved",
                    style: regularText(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 5),
                  CommonText(
                    text: "  :",
                    style: regularText(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  CommonText(
                    text: "  :",
                    style: regularText(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  CommonText(
                    text: "  :",
                    style: regularText(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  CommonText(
                    text: Tquantity,
                    style: regularText(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  RupeeText(
                    amount: Tcost,
                    color: Colors.white,
                    fontSize: 14,
                    type: 'b',
                  ),
                  RupeeText(
                    amount: Tsaved,
                    color: AppColors.secondary,
                    fontSize: 14,
                    type: 'bold',
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: onPayTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              child: CommonText(
                text: "Pay Now",
                style: boldText(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
