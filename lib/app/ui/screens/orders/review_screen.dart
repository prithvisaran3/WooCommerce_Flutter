import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/controller/profile.dart';
import 'package:template/app/controller/review.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/button.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';
import 'package:template/app/ui/widgets/common/text.dart';
import 'package:template/app/ui/widgets/common/common_ratingbar.dart';

import '../../widgets/common/common_textform.dart';

class ReviewScreen extends StatelessWidget {
  ReviewScreen({Key? key, required this.data}) : super(key: key);
  dynamic data;

  @override
  Widget build(BuildContext context) {
    ProfileController.to.getProfile();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Ionicons.arrow_back,
                      color: AppColors.primary,
                    ),
                  ),
                  Spacer(),
                  CommonText(
                    text: "Rate your order",
                    style: boldText(color: AppColors.primary),
                  ),
                  Spacer(),
                ],
              ),
              ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: "${data[index]['name']}",
                                  style: mediumText(fontSize: 16),
                                ),
                                SizedBox(height: 5),
                                Column(
                                  children: [
                                    CommonRatingBar(
                                      index: index,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            RupeeText(
                              amount: "${data[index]['total']}",
                              color: Colors.black,
                              fontSize: 30,
                              type: 'bold',
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                        Obx(
                          () => ReviewController.to.onPressedRatingBar ==
                                      true &&
                                  index == ReviewController.to.activateReviewBar
                              ? Column(
                                  children: [
                                    CommonTextFormField(
                                      maxLines: 6,
                                      inputType: TextInputType.multiline,
                                      hintText: "Enter your review",
                                      controller:
                                          ReviewController.to.reviewDescription,
                                      validator: (data) {
                                        if (data == null || data == "") {
                                          return 'Please enter Review Description';
                                        }
                                        return null;
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print(
                                            "PRODUCT ID ${data[index]['product_id']}");
                                        ReviewController.to.sendReview(
                                          productId: data[index]['product_id'],
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 8),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.primary,
                                        ),
                                        child: CommonText(
                                          text: "Submit review",
                                          style: mediumText(
                                              fontSize: 12,
                                              color: AppColors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
