import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steels/app/controller/coupon.dart';
import 'package:steels/app/controller/product.dart';
import 'package:steels/app/ui/themes/font_size.dart';
import 'package:steels/app/ui/widgets/common/alert.dart';
import 'package:steels/app/ui/widgets/common/common_rupee_text.dart';
import 'package:steels/app/ui/widgets/common/loading.dart';
import 'package:steels/app/ui/widgets/common/text.dart';
import 'package:steels/app/ui/widgets/common/toast.dart';

import '../../../utility/utility.dart';
import '../../themes/colors.dart';

class ProductAvailability extends StatelessWidget {
  const ProductAvailability({Key? key, required this.productPrice})
      : super(key: key);
  final double productPrice;

  @override
  Widget build(BuildContext context) {
    debugPrint("PRODUCT PRICE IS $productPrice");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // selectColorSection(),
          const SizedBox(height: 10),
          // pincodeSection(),
          const SizedBox(height: 10),
          couponSection(context),
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
    );
  }

  Column couponSection(BuildContext context) {
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
                margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.black,
                  ),
                ),
                child: Form(
                  key: CouponController.to.couponKey,
                  child: TextFormField(
                    controller: CouponController.to.couponCode,
                    validator: (data) {
                      if (data!.isEmpty || data == "") {
                        return commonToast(msg: "Please enter coupon");
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  if (CouponController.to.couponKey.currentState!.validate()) {
                    CouponController.to.couponMatch = 0;
                    CouponController.to.getAllCoupons();
                    CouponController.to.allCouponDetails.forEach(
                      (e) {
                        if (e['code'] == CouponController.to.couponCode.text) {
                          e['code'] == CouponController.to.couponCode.text
                              ? CouponController.to.getCouponByID(id: e['id'])
                              : debugPrint("ID mismatch");
                          Future.delayed(
                            const Duration(seconds: 2),
                            () {
                              CouponController.to.couponAppliedAmount =
                                  calculateCouponPrice(
                                      price: productPrice,
                                      couponDiscount: CouponController
                                          .to.couponByIDdetails['amount']);
                            },
                          );
                        } else {
                          CouponController.to.isCouponInvalid = true;
                        }
                      },
                    );

                    debugPrint(
                        "Coupon match count: ${CouponController.to.couponMatch}");
                  }
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 10),
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
        Center(
          child: GestureDetector(
            onTap: () async {
              CouponController.to.getAllCoupons();

              await couponAlertDialog(
                context,
                content: "Available coupons",
                confirmButtonPressed: () {
                  Get.back();
                },
              );
            },
            child: CommonText(
              text: "Click to check for available coupons",
              style: boldText(
                fontSize: 13,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () => CouponController.to.couponLoading == true
              ? SimpleLoading()
              : CouponController.to.isCouponApplied == true
                  ? Column(
                      children: [
                        CommonText(
                          text:
                              "Your coupon ${CouponController.to.couponByIDdetails['code']} is applied!",
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
                            const SizedBox(width: 5),
                            RupeeText(
                              amount: "${CouponController.to.afterCouponPrice}",
                              color: AppColors.primary,
                              fontSize: 12,
                              type: 'bold',
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            CouponController.to.isCouponApplied = false;
                            CouponController.to.couponCode.text = "";
                          },
                          child: CommonText(
                            text: "Remove coupon",
                            style:
                                mediumText(color: AppColors.red, fontSize: 14),
                          ),
                        ),
                      ],
                    )
                  : CouponController.to.couponMatch == 0
                      ? CommonText(
                          text: "Invalid Coupon",
                          style: regularText(color: AppColors.red),
                        )
                      : const SizedBox(),
        ),
        Obx(() => CouponController.to.isCouponInvalid == true
            ? Center(
              child: CommonText(
                  text: "Invalid Coupon",
                  style: regularText(color: AppColors.red),
                ),
            )
            : SizedBox())
      ],
    );
  }

  Column selectColorSection() {
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
            physics: const BouncingScrollPhysics(),
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
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

  Column pincodeSection() {
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
                  margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.black,
                    ),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
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
                  margin: const EdgeInsets.symmetric(vertical: 10),
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
                      const SizedBox(width: 5),
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
            : const SizedBox(),
      ],
    );
  }
}
