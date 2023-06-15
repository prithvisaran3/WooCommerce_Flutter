import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steels/app/controller/review.dart';
import 'package:steels/app/ui/widgets/common/loading.dart';

import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/text.dart';
import 'individualreview_tile.dart';

class ProductReview extends StatelessWidget {
  ProductReview({Key? key, required this.id}) : super(key: key);
  dynamic id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '4.1',
                    style: TextStyle(fontFamily: 'medium', fontSize: 38),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.secondary,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColors.secondary,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColors.secondary,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColors.secondary,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColors.grey,
                            ),
                          ],
                        ),
                        ReviewController.to.reviewLoading == true
                            ? SizedBox()
                            : CommonText(
                                text: "${ReviewController.to.reviewCount}",
                                style: regularText(),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Obx(
            () => ReviewController.to.reviewLoading == true
                ? SimpleLoading()
                : ListView.builder(
                    itemCount: ReviewController.to.allReviewDetails.length,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                      ReviewController.to.allReviewDetails[index]
                                  ['product_id'] ==
                              id
                          ? ReviewController.to.reviewCount++
                          : null;

                      print("REVIEW COUNT: ${ReviewController.to.reviewCount}");

                      return ReviewController.to.allReviewDetails[index]
                                  ['product_id'] ==
                              id
                          ? IndividualReviewTile(
                              reviewer:
                                  "${ReviewController.to.allReviewDetails[index]['reviewer']}",
                              reviewerEmail:
                                  "${ReviewController.to.allReviewDetails[index]['reviewer_email']}",
                              review:
                                  "${ReviewController.to.allReviewDetails[index]['review']}",
                            )
                          : SizedBox();
                    },
                  ),
          ),
          ReviewController.to.reviewCount == 0
              ? CommonText(
                  text: "No Reviews found", style: regularText(fontSize: 18))
              : SizedBox(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
