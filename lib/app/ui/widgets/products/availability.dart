import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/controller/product.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';
import 'package:template/app/ui/widgets/common/text.dart';

import '../../themes/colors.dart';

class ProductAvailability extends StatelessWidget {
  const ProductAvailability({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Obx(
            () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectColorSection(),
            SizedBox(height: 10),
            PincodeSection(),
            SizedBox(height: 10),
            CouponSection(),
            // Coupon not applicable text

            // CommonText(
            //   text: "Your coupon is not applicable",
            //   style: mediumText(
            //     fontSize: 12,
            //     color: Colors.red,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Column CouponSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: "Enter Coupon Code",
          style: boldText(
            fontSize: 12,
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 40,
                margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.black,
                  ),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  ProductController.to.onPressedApplyCoupon = true;
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.black,
                    ),
                  ),
                  child: CommonText(
                    text: "Apply",
                    style: boldText(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        ProductController.to.onPressedApplyCoupon == true
            ? Column(
          children: [
            CommonText(
              text: "Your coupon is applied!",
              style: mediumText(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                  text: "Coupon savings amount: ",
                  style: regularText(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 5),
                RupeeText(
                  amount: "500",
                  color: AppColors.primary,
                  fontSize: 12,
                  type: 'bold',
                ),
              ],
            ),
          ],
        )
            : SizedBox(),
      ],
    );
  }

  Column SelectColorSection() {
    return Column(
      children: [
        CommonText(
          text: "Available Colors",
          style: boldText(
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
            itemCount: 5,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, int index) {
              return GestureDetector(
                onTap: () {
                  ProductController.to.onPressedColors = index;
                },
                child: Obx(
                      () => Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        margin:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purpleAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 2,
                              blurRadius: 2,
                            )
                          ],
                        ),
                      ),
                      CommonText(
                        text: "Deep Purple",
                        style: ProductController.to.onPressedColors == index
                            ? boldText(
                          fontSize: 14,
                        )
                            : regularText(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column PincodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: "Enter pincode to check availability",
          style: boldText(
            fontSize: 12,
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                  height: 40,
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.black,
                    ),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  )),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  ProductController.to.onPressedCheckPincode = true;
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.black,
                    ),
                  ),
                  child: CommonText(
                    text: "Check",
                    style: boldText(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        ProductController.to.onPressedCheckPincode == true
            ? Column(
          children: [
            CommonText(
              text: "Your pincode 638009 is available for delivery",
              style: regularText(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                  text: "Estimated Delivery Date :",
                  style: regularText(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 5),
                CommonText(
                  text: "24th June,2023",
                  style: boldText(
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        )
            : SizedBox(),
      ],
    );
  }
}