import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steels/app/controller/coupon.dart';
import 'package:steels/app/ui/widgets/common/loading.dart';
import 'package:steels/app/ui/widgets/coupon/coupon_tile.dart';

import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import 'common_textform.dart';
import 'text.dart';

commonAlertDialog(BuildContext context,
    {required String content, required Function() confirmButtonPressed}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Container(
      height: 30,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: AppColors.red),
      child: Center(
        child: CommonText(
          text: "Cancel",
          style: regularText(color: AppColors.white),
        ),
      ),
    ),
    onPressed: () {
      if (kDebugMode) {
        print("print");
      }
      Get.back();
    },
  );
  Widget continueButton = TextButton(
    onPressed: confirmButtonPressed,
    child: Container(
      height: 30,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: AppColors.green),
      child: Center(
        child: CommonText(
          text: "Confirm",
          style: regularText(color: AppColors.white),
        ),
      ),
    ),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    actionsAlignment: MainAxisAlignment.center,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    ),
    // backgroundColor: Colors.white.withOpacity(0.4),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        CommonText(
          text: "Alert",
          style: boldText(
            fontSize: 24,
            color: AppColors.black,
          ),
        )
      ],
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonText(
          text: content,
          style: regularText(
            fontSize: 16,
            color: AppColors.black,
          ),
        ),
      ],
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

couponAlertDialog(BuildContext context,
    {required String content, required Function() confirmButtonPressed}) {
  CouponController.to.onPressedCouponCode = 100;

  var media = MediaQuery.of(context).size;
  Widget continueButton = TextButton(
    onPressed: confirmButtonPressed,
    child: Container(
      // height: 30,
      width: media.width,
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        // gradient: LinearGradient(colors: [
        //   AppColors.primary,
        //   AppColors.secondary,
        // ])
      ),
      child: Center(
        child: CommonText(
          text: "Confirm",
          style: boldText(fontSize: 16, color: Colors.white),
        ),
      ),
    ),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    ),
    backgroundColor: Colors.grey.shade300,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonText(
              text: content,
              style: boldText(fontSize: 20, color: AppColors.black),
            )
          ],
        ),
        SizedBox(
          height: media.width * 0.02,
        ),
        SizedBox(
          height: Get.height / 4,
          width: Get.width,
          child: Obx(
            () => CouponController.to.couponLoading == true
                ? SimpleLoading()
                : CouponController.to.isCouponEmpty == false
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: CouponController.to.allCouponDetails.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, int index) {
                          return CouponTile(
                            couponCode: CouponController
                                .to.allCouponDetails[index]['code'],
                            onTap: () {
                              CouponController.to.onPressedCouponCode = index;
                              CouponController.to.couponCode.text =
                                  CouponController.to.allCouponDetails[index]
                                      ['code'];
                              print(
                                  "X Selected is: ${CouponController.to.couponCode.text}");
                            },
                            index: index,
                          );
                        },
                      )
                    : Center(
                        child: CommonText(
                            text: "No coupons found",
                            style: boldText(fontSize: 18))),
          ),
        ),
      ],
    ),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
