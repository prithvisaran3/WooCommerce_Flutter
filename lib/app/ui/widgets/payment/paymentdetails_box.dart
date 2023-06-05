import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      padding: EdgeInsets.all(8),
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
              itemCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {
                return Row(
                  children: [
                    CommonText(
                        text: "Steel Tile", style: regularText(fontSize: 14)),
                    Spacer(),
                    CommonText(
                        text: "Rs 1400.00", style: mediumText(fontSize: 14)),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                CommonText(
                  text: "GST (18%)",
                  style: regularText(fontSize: 15, color: AppColors.black),
                ),
                Spacer(),
                CommonText(
                  text: "Rs. 800.04",
                  style: mediumText(fontSize: 15, color: AppColors.black),
                ),
              ],
            ),
            Row(
              children: [
                CommonText(
                  text: "Discount",
                  style: regularText(fontSize: 15, color: AppColors.green),
                ),
                Spacer(),
                CommonText(
                  text: "Rs. 500",
                  style: mediumText(fontSize: 15, color: AppColors.green),
                ),
              ],
            ),
            Row(
              children: [
                CommonText(
                  text: "Delivery Fees",
                  style: regularText(
                    fontSize: 15,
                    color: AppColors.black,
                  ),
                ),
                Spacer(),
                CommonText(
                  text: "Free",
                  style: boldText(
                    fontSize: 15,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            Divider(
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
                      amount: "51,300.24",
                      color: AppColors.primary,
                      fontSize: 30,
                      type: "bold",
                    ),
                    CommonText(
                      text: "(inc of all taxes)",
                      style: mediumText(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
                width: Get.width,
                margin: EdgeInsets.all(10.0),
                child: CommonButton(text: "Pay", onTap: () {})),
          ],
        ),
      ),
    );
  }
}
